/**
 * dev.js — 개발 서버
 *
 * 1. 최초 Full Build 실행 (dist/ 생성)
 * 2. browser-sync로 dist/ 서빙
 * 3. src/ 변경 감지 → 자동 재빌드 → 브라우저 리로드
 *
 * 실행: npm run dev
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const browserSync = require('browser-sync').create();

const ROOT = path.resolve(__dirname, '..');
const SRC = path.join(ROOT, 'src');
const DIST = path.join(ROOT, 'dist');
const BUILD = () => execSync('node scripts/build.js', { cwd: ROOT, stdio: 'inherit' });
const BS_PORT = 3000;

/** CMS·운영 URL처럼 확장자 없는 경로 → dist 내 .html 파일로 연결 */
function htmlExtensionMiddleware(req, _res, next) {
  const raw = req.url || '/';
  const qIndex = raw.indexOf('?');
  const pathname = (qIndex >= 0 ? raw.slice(0, qIndex) : raw).replace(/\/$/, '') || '/';
  const query = qIndex >= 0 ? raw.slice(qIndex) : '';

  if (path.extname(pathname)) {
    next();
    return;
  }

  if (pathname === '/') {
    next();
    return;
  }

  const rel = pathname.replace(/^\//, '');
  const asFile = path.join(DIST, rel + '.html');
  if (fs.existsSync(asFile)) {
    req.url = '/' + rel + '.html' + query;
    next();
    return;
  }

  const asIndex = path.join(DIST, rel, 'index.html');
  if (fs.existsSync(asIndex)) {
    req.url = '/' + rel + '/index.html' + query;
  }

  next();
}

// ── 최초 빌드 ─────────────────────────────────────────────────
console.log('\n🔨  초기 빌드...\n');
try {
  BUILD();
} catch (e) {
  process.exit(1);
}

// ── browser-sync 시작 ─────────────────────────────────────────
browserSync.init({
  server: {
    baseDir: DIST,
    middleware: [htmlExtensionMiddleware],
  },
  port: BS_PORT,
  notify: false,
  open: false,
  files: [path.join(DIST, '**/*')],
});

// ── src/ 감시 + 재빌드 ─────────────────────────────────────────
let rebuildTimer = null;

fs.watch(SRC, { recursive: true }, (_event, filename) => {
  if (!filename) return;
  clearTimeout(rebuildTimer);
  rebuildTimer = setTimeout(() => {
    console.log(`\n📁  변경 감지: ${filename} — 재빌드 중...`);
    try {
      BUILD();
    } catch (_) {}
  }, 150);
});

process.on('SIGINT', () => {
  browserSync.exit();
  process.exit(0);
});
process.on('SIGTERM', () => {
  browserSync.exit();
  process.exit(0);
});
