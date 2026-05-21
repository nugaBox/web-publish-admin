/**
 * build.js
 * src/ → dist/ 빌드 스크립트
 *
 * 수행 작업:
 *  1. dist/ 초기화 후 src/ 전체 복사
 *  2. HTML 파일의 data-include를 실제 header/footer로 인라인 처리
 *  3. CSS 파일의 로컬 웹폰트 경로를 CMS 변수로 치환
 *  4. HTML/CSS 파일의 이미지 경로를 CMS 변수로 치환
 *
 * 실행: npm run build
 */

const fs = require("fs");
const path = require("path");

const ROOT = path.resolve(__dirname, "..");
const SRC  = path.join(ROOT, "src");
const DIST = path.join(ROOT, "dist");

// ── CMS 경로 변수 설정 ────────────────────────────────────────
// CMS가 런타임에 치환하는 변수명입니다. 필요에 따라 수정하세요.
const CMS = {
  root:     "${rootDirectory}",
  img:      "${imgDirectory}",
  imgHtml:  "${path.images}",
  font:     "${fontDirectory}",
};
// ─────────────────────────────────────────────────────────────

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
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      walkFiles(fullPath, predicate, results);
      continue;
    }
    if (predicate(fullPath)) results.push(fullPath);
  }

  return results;
}

/** url() 안의 로컬 웹폰트 경로를 CMS 변수로 치환 */
function replaceWebfontPaths(css) {
  // ../fonts/ → ${fontDirectory} (나머지 경로는 유지)
  return css.replace(/url\((['"]?)\.\.\/fonts\//g, `url($1${CMS.font}`);
}

/** CSS 내 이미지 경로를 CMS 변수로 치환 */
function replaceImgPaths(content) {
  return content.replace(/assets\/images\//g, CMS.img);
}

/** HTML 내 이미지 경로를 CMS 변수로 치환 */
function replaceImgPathsHtml(content) {
  return content.replace(/assets\/images\//g, CMS.imgHtml);
}

/** HTML 파일의 data-include 태그를 실제 파일 내용으로 인라인 */
function inlineIncludes(html, baseDir = DIST) {
  return html.replace(
    /<div[^>]*data-include=["']([^"']+)["'][^>]*><\/div>/g,
    (match, includePath) => {
      const full = includePath.startsWith("/")
        ? path.join(DIST, includePath.slice(1))
        : path.resolve(baseDir, includePath);
      if (!fs.existsSync(full)) {
        console.warn(`  ⚠️  include 파일 없음: ${includePath} (기준: ${path.relative(DIST, baseDir) || "."})`);
        return match;
      }

      const content = fs.readFileSync(full, "utf-8").trim();
      return inlineIncludes(content, path.dirname(full));
    }
  );
}

// ── 빌드 ─────────────────────────────────────────────────────

console.log("\n🏗️  빌드 시작...\n");

// 1. dist/ 초기화
if (fs.existsSync(DIST)) {
  fs.rmSync(DIST, { recursive: true });
}
copyRecursive(SRC, DIST);
console.log("✅  src/ → dist/ 복사 완료");

// 2. HTML 처리: include 인라인 + 이미지 경로 치환
const htmlFiles = walkFiles(
  DIST,
  (filePath) => filePath.endsWith(".html") && !filePath.includes(`${path.sep}include${path.sep}`)
);

for (const filePath of htmlFiles) {
  const label = path.relative(DIST, filePath);
  let html = fs.readFileSync(filePath, "utf-8");

  html = inlineIncludes(html, path.dirname(filePath));
  html = replaceImgPathsHtml(html);

  fs.writeFileSync(filePath, html, "utf-8");
  console.log(`✅  ${label} — include 인라인, 이미지 경로 치환`);
}

// 3. CSS 처리: 웹폰트 경로 + 이미지 경로 치환
const cssDir = path.join(DIST, "assets", "css");
const cssFiles = walkFiles(cssDir, (filePath) => filePath.endsWith(".css"));

for (const filePath of cssFiles) {
  let css = fs.readFileSync(filePath, "utf-8");

  const before = css;
  css = replaceWebfontPaths(css);
  css = replaceImgPaths(css);

  if (css !== before) {
    fs.writeFileSync(filePath, css, "utf-8");
    console.log(`✅  ${path.relative(DIST, filePath)} — 경로 치환`);
  }
}

console.log("\n✨ 빌드 완료: dist/\n");
