/**
 * build.js — 빌드 스크립트
 *
 * 모드는 환경변수 BUILD_MODE로 지정합니다.
 *
 * ┌──────────────────────────────────────────────────────────────┐
 * │ 모드   │ 명령어              │ 출력폴더    │ 특징            │
 * ├──────────────────────────────────────────────────────────────┤
 * │ full   │ npm run build       │ dist/       │ 모든 include    │
 * │        │                     │             │ 인라인화.       │
 * │        │                     │             │ CMS 변수        │
 * │        │                     │             │ 치환 없음.      │
 * │        │                     │             │ 서버 직배포용.  │
 * ├──────────────────────────────────────────────────────────────┤
 * │ siiru  │ npm run build:siiru │ dist-siiru/ │ 레이아웃        │
 * │        │                     │             │ (header/footer) │
 * │        │                     │             │ 제외. sub/      │
 * │        │                     │             │ boardpage/는    │
 * │        │                     │             │ section 자식만. │
 * │        │                     │             │ CMS 변수        │
 * │        │                     │             │ 치환 적용.      │
 * └──────────────────────────────────────────────────────────────┘
 */

const fs   = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const SRC  = path.join(ROOT, 'src');

// ── 모드 설정 ─────────────────────────────────────────────────
const MODE = (process.env.BUILD_MODE || 'full').toLowerCase();

const MODES = {
  full: {
    label:      'Full Build',
    outDir:     path.join(ROOT, 'dist'),
    skipLayout: false,
    applyCms:   false,
  },
  siiru: {
    label:      'SiiRU CMS Export',
    outDir:     path.join(ROOT, 'dist-siiru'),
    skipLayout: true,
    applyCms:   true,
  },
};

if (!MODES[MODE]) {
  console.error(`❌  알 수 없는 BUILD_MODE: "${MODE}" (full | siiru)`);
  process.exit(1);
}

const { label, outDir: DIST, skipLayout, applyCms } = MODES[MODE];

// ── CMS 경로 변수 (siiru 모드에서만 사용) ────────────────────
const CMS = {
  root:    '${rootDirectory}',
  img:     '${imgDirectory}',
  imgHtml: '${path.images}',
  font:    '${fontDirectory}',
};

// ── 레이아웃 include 파일명 (skipLayout 대상) ─────────────────
const LAYOUT_FILES = new Set(['header.html', 'footer.html']);

// ── 유틸 ─────────────────────────────────────────────────────

function copyRecursive(src, dest) {
  fs.mkdirSync(dest, { recursive: true });
  for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
    const s = path.join(src, entry.name);
    const d = path.join(dest, entry.name);
    entry.isDirectory() ? copyRecursive(s, d) : fs.copyFileSync(s, d);
  }
}

function walkFiles(dir, predicate, results = []) {
  if (!fs.existsSync(dir)) return results;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) { walkFiles(full, predicate, results); continue; }
    if (predicate(full)) results.push(full);
  }
  return results;
}

/** url() 안의 로컬 웹폰트 경로를 CMS 변수로 치환 */
function replaceWebfontPaths(css) {
  return css.replace(/url\((['"]?)\.\.\/fonts\//g, `url($1${CMS.font}`);
}

/** CSS 내 이미지 경로를 CMS 변수로 치환 */
function replaceImgPathsCss(css) {
  return css
    .replace(/assets\/images\//g, CMS.img)
    .replace(/url\((['"]?)\.\.\/images\//g, `url($1${CMS.img}`);
}

/** HTML 내 이미지 경로를 CMS 변수로 치환 */
function replaceImgPathsHtml(html) {
  return html.replace(/(?:(?:\.\.\/)+|\/)?assets\/images\//g, CMS.imgHtml);
}

/**
 * HTML 파일의 data-include 태그를 실제 파일 내용으로 인라인.
 * skipLayout=true 일 때 header.html / footer.html 은 빈 문자열로 대체
 * (레이아웃 제거 → 본문만 추출).
 */
function inlineIncludes(html, baseDir) {
  return html.replace(
    /<div[^>]*data-include=["']([^"']+)["'][^>]*><\/div>/g,
    (match, includePath) => {
      const full = includePath.startsWith('/')
        ? path.join(DIST, includePath.slice(1))
        : path.resolve(baseDir, includePath);

      if (skipLayout && LAYOUT_FILES.has(path.basename(full))) return '';

      if (!fs.existsSync(full)) {
        console.warn(`  ⚠️  include 없음: ${includePath}`);
        return match;
      }

      const content = fs.readFileSync(full, 'utf-8').trim();
      return inlineIncludes(content, path.dirname(full));
    }
  );
}

/**
 * 서브·게시판 페이지: 인라인된 aside(sidebar include)를 .sub-layout 앞
 * .sidebar-mob 에 한 번 더 배치 — 모바일 섹션 네비.
 */
function injectMobileSidebar(html) {
  if (html.includes('sidebar-mob') || !html.includes('sub-layout')) return html;

  const asideMatch = html.match(/<aside>[\s\S]*?<\/aside>/);
  if (!asideMatch) return html;

  const layoutMatch = SUB_LAYOUT_OPEN_RE.exec(html);
  if (!layoutMatch) return html;

  const mobileBlock =
    `<div class="sidebar-mob" aria-label="섹션 메뉴">\n${asideMatch[0]}\n</div>\n\n`;

  return html.slice(0, layoutMatch.index) + mobileBlock + html.slice(layoutMatch.index);
}

const SUB_LAYOUT_OPEN_RE = /<div\s+class="sub-layout"[^>]*>/i;

/** div 여는 태그 위치에서 짝 맞는 </div> 위치 반환 */
function findMatchingCloseDiv(html, divOpenIndex) {
  const tagEnd = html.indexOf('>', divOpenIndex);
  if (tagEnd === -1) return -1;

  let depth = 1;
  let i = tagEnd + 1;

  while (i < html.length) {
    const nextOpen = html.indexOf('<div', i);
    const nextClose = html.indexOf('</div>', i);
    if (nextClose === -1) return -1;

    if (nextOpen !== -1 && nextOpen < nextClose && /^<div[\s>]/.test(html.slice(nextOpen))) {
      depth += 1;
      i = html.indexOf('>', nextOpen) + 1;
    } else {
      depth -= 1;
      if (depth === 0) return nextClose;
      i = nextClose + '</div>'.length;
    }
  }

  return -1;
}

/** .sub-layout 블록 안 사이드바 </aside> 다음 CMS용 <section> 시작 위치 */
function findCmsSectionStart(html) {
  const layoutMatch = SUB_LAYOUT_OPEN_RE.exec(html);
  if (!layoutMatch) return -1;

  const layoutOpen = layoutMatch.index;
  const contentStart = layoutOpen + layoutMatch[0].length;
  const layoutClose = findMatchingCloseDiv(html, layoutOpen);
  const blockEnd = layoutClose === -1 ? html.length : layoutClose;
  const block = html.slice(contentStart, blockEnd);

  let searchFrom = 0;
  const sidebarAsideClose = block.indexOf('</aside>');
  if (sidebarAsideClose !== -1) {
    searchFrom = sidebarAsideClose + '</aside>'.length;
  }

  const sectionInBlock = block.indexOf('<section', searchFrom);
  if (sectionInBlock === -1) return -1;

  return contentStart + sectionInBlock;
}

/** .sub-layout 직하위 section 한 개의 내부 HTML만 반환 (section 태그 제외) */
function extractSectionInner(html, sectionOpenIndex) {
  const tagEnd = html.indexOf('>', sectionOpenIndex);
  if (tagEnd === -1) return null;

  const contentStart = tagEnd + 1;
  let depth = 1;
  let i = contentStart;

  while (i < html.length) {
    const nextOpen = html.indexOf('<section', i);
    const nextClose = html.indexOf('</section>', i);
    if (nextClose === -1) return null;

    if (nextOpen !== -1 && nextOpen < nextClose) {
      depth += 1;
      i = html.indexOf('>', nextOpen) + 1;
    } else {
      depth -= 1;
      if (depth === 0) return html.slice(contentStart, nextClose).trim();
      i = nextClose + '</section>'.length;
    }
  }

  return null;
}

const SIIRU_LAYOUT_MARKERS = [
  'sub-layout',
  '<main id="main-content"',
  'data-include',
];

function siiruOutputLooksLikeLayout(html) {
  return SIIRU_LAYOUT_MARKERS.some(marker => html.includes(marker));
}

/**
 * SiiRU CMS용: sub·boardpage 페이지는 .sub-layout 내 section 자식만 출력.
 * (히어로·사이드바·section 태그 자체는 CMS 레이아웃에 포함됨)
 */
function extractSiiruCmsSectionContent(html, relPath) {
  const sectionIdx = findCmsSectionStart(html);
  if (sectionIdx === -1) {
    console.warn(`  ⚠️  CMS section 추출 실패 (${relPath}): .sub-layout 또는 <section> 없음`);
    return html;
  }

  const inner = extractSectionInner(html, sectionIdx);
  if (inner === null) {
    console.warn(`  ⚠️  CMS section 추출 실패 (${relPath}): </section> 짝 불일치`);
    return html;
  }

  return inner;
}

/** CMS 본문 추출 대상 페이지 여부 (sub/, boardpage/ 하위) */
function isSiiruCmsPage(relPath) {
  const norm = relPath.split(path.sep).join('/');
  return norm.startsWith('sub/') || norm.startsWith('boardpage/');
}

/** 빌드 처리에서 제외할 HTML 파일 여부 */
function shouldSkipHtmlFile(relPath) {
  const norm = relPath.split(path.sep).join('/');
  return norm.includes('include/') || norm.includes('_partials/');
}

// ── 빌드 실행 ─────────────────────────────────────────────────

console.log(`\n🏗️  [${label}] 빌드 시작...\n`);

// 1. 출력 디렉터리 초기화 + 소스 복사
if (fs.existsSync(DIST)) fs.rmSync(DIST, { recursive: true });
copyRecursive(SRC, DIST);
console.log(`✅  src/ → ${path.relative(ROOT, DIST)}/ 복사 완료`);

// 2. HTML 처리
const htmlFiles = walkFiles(DIST, p => {
  if (!p.endsWith('.html')) return false;
  const rel = path.relative(DIST, p);
  return !shouldSkipHtmlFile(rel);
});

for (const filePath of htmlFiles) {
  const rel = path.relative(DIST, filePath);
  let html = fs.readFileSync(filePath, 'utf-8');

  html = inlineIncludes(html, path.dirname(filePath));
  if (!skipLayout) html = injectMobileSidebar(html);
  if (applyCms) {
    html = replaceImgPathsHtml(html);
    if (isSiiruCmsPage(rel)) {
      html = extractSiiruCmsSectionContent(html, rel);
      if (siiruOutputLooksLikeLayout(html)) {
        console.warn(`  ⚠️  CMS 본문에 레이아웃 잔존 (${rel}) — src 마크업 확인`);
      }
    }
  }

  fs.writeFileSync(filePath, html, 'utf-8');
  console.log(`✅  ${rel}`);
}

// siiru 전용: 조각·include 템플릿은 출력에서 제거
if (skipLayout) {
  for (const relDir of ['sub/_partials', 'include']) {
    const dir = path.join(DIST, ...relDir.split('/'));
    if (fs.existsSync(dir)) fs.rmSync(dir, { recursive: true });
  }
}

// 3. CSS 처리 (siiru 모드에서만 경로 치환)
if (applyCms) {
  const cssFiles = walkFiles(
    path.join(DIST, 'assets', 'css'),
    p => p.endsWith('.css')
  );
  for (const filePath of cssFiles) {
    let css = fs.readFileSync(filePath, 'utf-8');
    const before = css;
    css = replaceWebfontPaths(css);
    css = replaceImgPathsCss(css);
    if (css !== before) {
      fs.writeFileSync(filePath, css, 'utf-8');
      console.log(`✅  ${path.relative(DIST, filePath)} — CSS 경로 치환`);
    }
  }
}

console.log(`\n✨  빌드 완료 → ${path.relative(ROOT, DIST)}/\n`);
