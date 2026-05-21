# NUGABOX Web Publishing Template — Agent Guide (v1.1.0)

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
├── assets/css/   style.css(global) main.css(index only) sub.css(sub+board)
├── assets/js/    script.js(prod+dev) dev.js(dev only) main.js sub.js
├── assets/fonts/ bootstrap-icons/ pretendard/ fontawesome/
├── assets/images/
├── include/
│   ├── header.html     ← sub shell: DOCTYPE+head+CSS+body-open
│   ├── footer.html     ← sub shell: JS scripts+body-close  ※ dev.js loads here only
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

## Page Types

**index.html** — full HTML. has its own `<head>`, loads main.css, main.js directly.

**sub/ and boardpage/** — **fragment** (no DOCTYPE/head/body). header.html provides CSS, footer.html provides JS.
```
depth src/sub/        → ../include/
depth src/boardpage/* → ../../include/  ../../board/
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
- sidebar links: root-absolute only (`/sub/page.html`), never relative
- `class="on"` never hardcoded in HTML — set at runtime by dev.js (local) or CMS/JSP (prod)

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
- `sub/` + `boardpage/` pages: only content inside `.sub-layout > section` is output
- CMS var substitution: `assets/images/`→`${path.images}` (HTML), `${imgDirectory}` (CSS), `../fonts/`→`${fontDirectory}`
- `include/` and `sub/_partials/` removed from output

**CMS section rule**: `<section>` inside `.sub-layout` must have **no class/id**.
Scope classes go on the immediate child div:
```html
<section><div class="my-page">...</div></section>  ✓
<section class="my-page">...</section>              ✗
```

## CSS Rules
- All CSS variables defined in `style.css :root`. No hardcoded color values anywhere.
- `style.css` loaded by `header.html`. `main.css` loaded by `index.html` directly. `sub.css` loaded by `header.html`.
- Breakpoints: tablet `max-width:1024px` / mobile `max-width:768px`

## JS Rules
- `script.js`: prod+dev共通. GNB, `data-include` loader, dispatches `includes-ready` event on load complete.
- `dev.js`: local preview only. Loaded in `footer.html`. Never ship to CMS/JSP server.
  - `markActiveSidebar()` — sets `.on` based on current URL after `includes-ready`
  - `mountMobileSidebar()` — clones sidebar into `.sidebar-mob`
- `sub.js`: `.tab-wrap > .group-tabs[data-tab]` ↔ `.tab-panel[data-panel]` tab switching

## Image Path Rules (in src/)
Use real paths in source. Build handles CMS substitution.
```html
<img src="/assets/images/logo.png">     ✓
<img src="../assets/images/logo.png">   ✓
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
- [ ] sidebar via `data-include`, links root-absolute, no `.on` hardcoded
- [ ] section in `.sub-layout` has no class/id
- [ ] CSS vars only, no hardcoded colors
- [ ] placeholder images: `<div class="placeholder">PHOTO PLACEHOLDER</div>`
- [ ] new menu → update header.html (GNB+drawer) + sidebar_XXX.html both
- [ ] verify: `npm run build` → dist/ ✓ / `npm run build:siiru` → section content only ✓
