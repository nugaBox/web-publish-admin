# NUGABOX Web Publishing Template — Agent Guide (v1.2.0)

## Commands
| cmd | output | note |
|---|---|---|
| `npm run dev` | `dist/` | Full Build → browser-sync + src/ watch |
| `npm run build` | `dist/` | include inline. no CMS vars. direct deploy |
| `npm run build:siiru` | `dist-siiru/` | layout strip + section-only + CMS vars |
| `npm run preview` | `dist/` | serve dist/ |

## Directory
```
src/
└── admin/
    ├── assets/css/   admin.css (전역 변수 + 레이아웃 + 컴포넌트 통합)
    ├── assets/js/    admin.js (공통 + 대시보드 스크립트 통합)
    ├── assets/fonts/ bootstrap-icons/ pretendard/ fontawesome/
    ├── assets/images/
    ├── include/
    │   ├── header.html     ← sub shell: DOCTYPE+head+CSS+body-open
    │   ├── footer.html     ← sub shell: JS scripts+body-close
    │   └── sidebar_XXX.html
    ├── sub/            fragment pages
    │   └── _partials/  include-only snippets (excluded from build output)
    ├── boardpage/{name}/list.html   fragment, data-include the skin
    ├── board/basic/{list,view,write}.html      shared skin
    ├── board/multimedia/{list,view,write}.html shared skin
    └── index.html      full HTML doc (not fragment)

reference/board/{basic,multimedia}/*.jsp   SiiRU CMS server-side reference (read-only)
reference/skin/*.jsp                       member feature JSP reference (read-only)
```

## URL 구조
모든 관리자 페이지는 `/admin/` 하위에서 서비스됩니다.
- 대시보드: `/admin/index.html`
- 서브 페이지: `/admin/sub/*.html`
- 게시판 페이지: `/admin/boardpage/{name}/*.html`
- 에셋: `/admin/assets/...`

## Page Types

**index.html** — full HTML. has its own `<head>`, loads admin.css, admin.js directly.

**sub/ and boardpage/** — **fragment** (no DOCTYPE/head/body). header.html provides CSS, footer.html provides JS.
```
depth src/admin/sub/        → ../include/
depth src/admin/boardpage/* → ../../include/  ../../board/
```

Sub page structure:
```html
<div data-include="../include/header.html"></div>
<main id="main-content">
  <div class="sub-layout">
    <div data-include="../include/sidebar_XXX.html"></div>
    <section><div class="content">...</div></section>
  </div>
</main>
<div data-include="../include/footer.html"></div>
```

## include/ Sharing Rule
`header.html` / `footer.html` / `sidebar_XXX.html` are shared by all pages using them.
Edit one file → all pages reflect immediately after build.
- sidebar links: root-absolute only (`/admin/sub/page.html`), never relative
- `class="on"` never hardcoded in HTML — set at runtime by admin.js (local) or CMS/JSP (prod)

## board/ + boardpage/ Sharing Rule
`board/` = shared skin (UI template). `boardpage/` = instances that `data-include` the skin.
Editing `board/basic/list.html` updates **all boardpage instances using that skin**.

```html
<!-- boardpage/notice/list.html -->
<div data-include="../../board/basic/list.html"></div>
```

## Build Behavior

**Full Build** (`build`):
- All `data-include` inlined
- `.sidebar-mob` auto-injected before `.sub-layout` (mobile nav)
- Image paths kept as-is (no CMS var substitution)

**SiiRU Export** (`build:siiru`):
- `header.html` / `footer.html` replaced with `""` (layout stripped)
- `admin/sub/` + `admin/boardpage/` pages: only content inside `.sub-layout > section` is output
- CMS var substitution: `assets/images/`→`${path.images}` (HTML), `${imgDirectory}` (CSS), `../fonts/`→`${fontDirectory}`
- `admin/include/` and `admin/sub/_partials/` removed from output

**CMS section rule**: `<section>` inside `.sub-layout` must have **no class/id**.
Scope classes go on the immediate child div:
```html
<section><div class="my-page">...</div></section>  ✓
<section class="my-page">...</section>              ✗
```

## CSS Rules

### ⛔ 절대 금지 — 인라인 스타일
**인라인 `style=""` 속성은 절대 사용하지 않는다.**
모든 스타일은 반드시 `admin.css`에 클래스로 작성한다.
```html
<div style="height:32px;font-size:13px;">  ✗  절대 금지
<div class="btn-crumb-dash">               ✓
```

### ⛔ 절대 금지 — CSS 다중 선언 한 줄 작성
**한 선택자에 두 개 이상의 선언을 한 줄에 쓰지 않는다.**
선언은 반드시 한 항목당 한 줄로 작성한다.
```css
.foo { display: flex; align-items: center; }   ✗  절대 금지
.foo {                                         ✓
  display: flex;
  align-items: center;
}
```
단, 단일 선언 한 줄은 허용한다:
```css
.brand:hover { opacity: .7; }   ✓  단일 선언이므로 한 줄 허용
```

### 기타 CSS 규칙
- 모든 CSS 변수는 `admin.css :root`에 정의. 하드코딩 색상값 금지.
- `admin.css`는 `header.html`과 `index.html` 양쪽에서 로드됨 (단일 파일).
- Breakpoints: tablet `max-width:1024px` / mobile `max-width:768px`

## JS Rules

### ⛔ 절대 금지 — 인라인 스크립트
**HTML 내 `<script>` 태그 인라인 코드는 절대 작성하지 않는다.**
모든 스크립트 로직은 반드시 `admin.js`에 작성한다.
```html
<script>/* 여기에 로직 작성 */</script>   ✗  절대 금지
```
예외: `<script src="...">` 외부 파일 로드는 허용.

### 기타 JS 규칙
- `admin.js`: data-include 로더 + 사이드바/테마 토글 + 대시보드 전용 스크립트 통합 파일.
  - index.html: `chart.min.js` → `bootstrap.bundle.min.js` → `admin.js` 순서로 로드
  - sub/boardpage: footer.html이 `bootstrap.bundle.min.js` → `admin.js` 로드
- 대시보드 전용 코드는 null 체크로 가드하여 서브 페이지에서 오류 없이 동작해야 함.

## Image Path Rules (in src/)
Use real paths in source. Build handles CMS substitution.
```html
<img src="/admin/assets/images/logo.png">     ✓
<img src="../assets/images/logo.png">         ✓
```
```css
url('../images/bg.jpg')       ✓
url('assets/images/bg.jpg')   ✓
```

## reference/ Folder
SiiRU CMS JSP skins. **Read-only reference**, do not edit.
CMS vars used in JSP: `${path.images}` `${rootDirectory}` `${imgDirectory}` `${fontDirectory}` `${path.context}`

## Checklist (new sub/boardpage page)
- [ ] fragment — no DOCTYPE/head/body
- [ ] first line: header.html include / last line: footer.html include
- [ ] sidebar via `data-include`, links root-absolute (`/admin/...`), no `.on` hardcoded
- [ ] section in `.sub-layout` has no class/id
- [ ] CSS vars only, no hardcoded colors
- [ ] **인라인 style="" 없음** — 모든 스타일은 admin.css 클래스로
- [ ] **인라인 `<script>` 없음** — 모든 스크립트는 admin.js로
- [ ] placeholder images: `<div class="placeholder">PHOTO PLACEHOLDER</div>`
- [ ] new menu → update header.html (GNB) + sidebar_XXX.html both
- [ ] verify: `npm run build` → dist/ ✓ / `npm run build:siiru` → section content only ✓
