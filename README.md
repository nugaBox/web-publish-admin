# NUGABOX 웹 퍼블리싱 (템플릿 프로젝트)

## 개요

NUGABOX의 웹 퍼블리싱을 위한 보일러플레이트 코드입니다.
새 프로젝트 시작 시 이 템플릿을 사용하여 시작합니다.

---

## 명령어

```bash
# 최초 설치 (새 프로젝트 시작 시)
npm install && npm run setup

# 개발 서버 시작 (http://localhost:3000)
npm run dev

# dist 빌드 (배포용)
npm run build

# setup 재적용 (Bootstrap/Pretendard/Swiper 파일 재복사)
npm run setup

# 패키지 버전 업그레이드 예시
npm install bootstrap@latest bootstrap-icons@latest pretendard@latest swiper@latest
npm run setup
```

---

## 디렉토리 구조

```
web-publish-{site}/
├── src/                              ← 개발 루트 (browser-sync 서버 루트)
│   ├── assets/
│   │   ├── css/
│   │   │   ├── bootstrap.min.css         ← Bootstrap 5 (setup.js 자동 복사)
│   │   │   ├── bootstrap-icons.min.css   ← Bootstrap Icons (setup.js 자동 복사)
│   │   │   ├── pretendard.css            ← Pretendard (setup.js 자동 복사)
│   │   │   ├── swiper-bundle.min.css     ← Swiper (setup.js 자동 복사)
│   │   │   ├── fontawesome.min.css       ← Font Awesome Pro (수동 배치)
│   │   │   ├── style.css                 ← 전역 공통 스타일
│   │   │   ├── main.css                  ← index.html 전용 스타일
│   │   │   └── sub.css                   ← sub.html 전용 스타일
│   │   ├── js/
│   │   │   ├── bootstrap.bundle.min.js   ← Bootstrap JS + Popper (setup.js 자동 복사)
│   │   │   ├── swiper-bundle.min.js      ← Swiper (setup.js 자동 복사)
│   │   │   ├── script.js                 ← 전역 공통 스크립트
│   │   │   ├── main.js                   ← index.html 전용 스크립트
│   │   │   └── sub.js                    ← sub.html 전용 스크립트
│   │   ├── images/
│   │   └── fonts/
│   │       ├── bootstrap-icons/          ← Bootstrap Icons webfonts (setup.js 자동 복사)
│   │       ├── pretendard/               ← Pretendard woff/woff2 (setup.js 자동 복사)
│   │       └── fontawesome/              ← Font Awesome Pro webfonts (수동 배치)
│   ├── include/
│   │   ├── header.html                   ← 공통 헤더 (data-include로 로드)
│   │   └── footer.html                   ← 공통 푸터 (data-include로 로드)
│   ├── index.html                        ← main 페이지
│   └── sub.html                          ← sub 페이지 (예시)
├── dist/                             ← 빌드 결과물 (npm run build 생성, Git 제외)
├── scripts/
│   ├── setup.js                      ← 로컬 파일 복사 스크립트
│   └── build.js                      ← dist 빌드 스크립트
├── package.json
├── .gitignore
└── README.md
```

---

## 시작하기

### 1. 의존성 설치 및 로컬 파일 복사

```bash
npm install
npm run setup
```

`npm run setup`은 `scripts/setup.js`가 실행되어 `node_modules`에서 패키지 파일을 `src/assets/` 폴더로 복사하고 자동 패치합니다.
현재 기본 지원 대상은 Bootstrap, Bootstrap Icons, Pretendard, Swiper입니다.

### 2. 개발 서버 실행

```bash
npm run dev
```

브라우저가 자동으로 열리며, `src/` 내 HTML/CSS/JS 파일 저장 시 자동 새로고침됩니다.
- 기본 주소: `http://localhost:3000`

### 3. 배포용 빌드

```bash
npm run build
```

`src/` → `dist/` 로 빌드합니다. 아래 작업이 자동으로 수행됩니다.

| 처리 항목 | 내용 |
|---|---|
| `data-include` 인라인 | header/footer HTML이 각 페이지에 직접 삽입됨 |
| 하위 폴더 HTML 처리 | `src/` 아래 모든 HTML을 재귀적으로 빌드 |
| 상대경로 include 지원 | `./`, `../`, `/include/...` 형태의 `data-include` 처리 |
| 웹폰트 경로 치환 | CSS의 `../fonts/...` → `${fontDirectory}...` |
| 이미지 경로 치환 | CSS는 `assets/images/` → `${imgDirectory}`, HTML은 `assets/images/` → `${path.images}` |

CMS 변수명은 `scripts/build.js` 상단의 `CMS` 객체에서 수정할 수 있습니다.

```js
const CMS = {
  root:    "${rootDirectory}",
  img:     "${imgDirectory}",
  imgHtml: "${path.images}",
  font:    "${fontDirectory}",
};
```

### 4. 새 프로젝트 생성

```bash
# GitHub에서 'Use this template'으로 새 레포지토리 생성 후
git clone https://github.com/nugabox/web-publish-{site}
cd web-publish-{site}
npm install && npm run setup
npm run dev
```

---

## 코딩 컨벤션

### CSS/JS 작성 원칙

- **`style.css`**: 전역 공통 스타일. Bootstrap 유틸리티 클래스를 최대한 활용하고, 커스텀 클래스는 이 파일에 작성. CMS CSS 항목에 등록됨
- **`script.js`**: 전역 공통 스크립트. 모든 페이지에서 동작해야 하는 코드만 작성. CMS JS 항목에 등록됨
- **`main.js` / `sub.js` 등**: 페이지 단위 스크립트. 해당 페이지(`index.html`, `sub.html` 등)에서만 로드
- CSS 변수(`:root`)를 통해 컬러/간격을 일관되게 관리

```css
/* style.css에서 브랜드 컬러 변경 예시 */
:root {
  --color-primary: #e63946;   /* 브랜드 메인 컬러 */
  --color-accent: #457b9d;    /* 포인트 컬러 */
}
```

```html
<!-- index.html: 전역 script.js 로드 후 페이지 전용 main.js 추가 로드 -->
<script src="assets/js/script.js"></script>
<script src="assets/js/main.js"></script>

<!-- sub.html: 전역 script.js 로드 후 페이지 전용 sub.js 추가 로드 -->
<script src="assets/js/script.js"></script>
<script src="assets/js/sub.js"></script>
```

### 섹션 구조 패턴

```html
<section class="section">
  <div class="container">
    <div class="text-center mb-5">
      <h2 class="section-title">섹션 제목</h2>
      <p class="section-subtitle">섹션 설명</p>
    </div>
    <!-- 콘텐츠 -->
  </div>
</section>
```

### 새 페이지 추가

`index.html`을 복사하여 새 파일명으로 저장 후 `<main>` 내부와 페이지 전용 CSS/JS 파일명만 변경하세요.
header/footer는 그대로 유지됩니다.

---

## AI 디자인 프롬프트 가이드

이 보일러플레이트 구조에 맞게 AI에게 디자인을 요청할 때 사용하는 프롬프트입니다.

---

### 기본 컨텍스트 프롬프트 (모든 요청 앞에 붙여 사용)

```
아래는 내가 사용하는 HTML 퍼블리싱 보일러플레이트 구조야.
이 구조에 맞게 디자인을 작업해줘.

[보일러플레이트 구조]
- Bootstrap 5.3 기반 (로컬 파일 사용, CDN 아님)
- Bootstrap Icons 아이콘 사용 가능 (<i class="bi bi-{아이콘명}">)
- Font Awesome Pro 아이콘 사용 가능 (<i class="fa-solid fa-{아이콘명}"> 등)
- 웹폰트: Pretendard (로컬, 한국어 최적화 subset)
- 전역 CSS: assets/css/style.css (이미 기본 변수와 유틸리티 클래스 포함)
- 전역 JS: assets/js/script.js
- 페이지별 JS: assets/js/main.js (index.html), assets/js/sub.js (sub.html) 등
- 헤더: include/header.html (id="site-header" 포함)
- 푸터: include/footer.html (id="site-footer" 포함)
- 메인 페이지: index.html

[style.css에 정의된 주요 CSS 변수]
--color-primary: #0d6efd
--color-text: #212529
--color-bg: #ffffff
--color-bg-soft: #f8f9fa
--color-bg-dark: #212529
--spacing-section: 80px
--font-base: "Pretendard", "Apple SD Gothic Neo", "Noto Sans KR", sans-serif
--radius-md: 8px
--transition-base: 0.2s ease

[style.css에 정의된 주요 유틸리티 클래스]
.section          → 상하 padding: var(--spacing-section)
.section-sm       → 상하 padding 절반
.section-soft     → 배경색 var(--color-bg-soft)
.section-dark     → 배경색 var(--color-bg-dark), 텍스트 밝게
.section-title    → 섹션 h2 제목 스타일
.section-subtitle → 섹션 설명 텍스트 스타일

[작업 규칙]
1. Bootstrap 유틸리티 클래스를 최대한 활용해
2. 스타일을 추가하거나 수정할 때는 <style> 태그나 인라인 스타일을 사용하지 말고 반드시 css 폴더 아래에 CSS 블록으로 제공해줘
3. CDN 링크는 절대 사용하지 마. Bootstrap, Bootstrap Icons, Font Awesome Pro, Pretendard는 이미 로컬에 있어
4. 외부 폰트(Google Fonts 등)가 필요하면 별도로 알려줘
5. 외부 JS 라이브러리가 필요하면 npm 설치 방법과 함께 알려줘
6. CMS에 붙여넣을 수 있도록 <main> 태그 내부 HTML만 결과물로 줘
   (header, footer, <head>는 별도 파일이라 수정 불필요)
7. 페이지 전용 JS가 필요하면 script.js가 아닌 해당 페이지명의 JS 파일(예: main.js, sub.js)에 작성해줘
```

---

### 페이지 디자인 요청 프롬프트

```
[기본 컨텍스트 프롬프트 붙여넣기]

다음 조건으로 {페이지명} 페이지의 <main> 내부 HTML을 작성해줘.

- 페이지 목적: {ex. 회사 소개, 서비스 안내, 포트폴리오 목록 등}
- 주요 섹션: {ex. 히어로, 회사 연혁, 팀 소개, CTA}
- 분위기/톤: {ex. 신뢰감 있는, 젊고 활기찬, 고급스러운, 친근한}
- 색상 방향: {ex. 기존 변수 그대로, 또는 메인 컬러를 #00C4A7으로 변경}
- 특이사항: {ex. 애니메이션 있었으면 좋겠음, 카드 레이아웃 3열, 모바일 우선}
```

---

### 컴포넌트 단위 요청 프롬프트

```
[기본 컨텍스트 프롬프트 붙여넣기]

다음 컴포넌트 HTML 코드를 작성해줘.

- 컴포넌트: {ex. 히어로 배너, 카드 리스트, 탭 메뉴, 모달, 폼}
- 내용: {ex. 배경 이미지 위에 텍스트, 버튼 2개}
- 스타일 방향: {ex. 미니멀, 풍성한, 텍스트 중심}
- 반응형: 필요함 / 불필요 (기본: 필요함)
```

---

### CSS 수정 요청 프롬프트

```
[기본 컨텍스트 프롬프트 붙여넣기]

아래 CSS를 style.css에 추가/수정해줘.

현재 style.css 관련 내용:
{수정이 필요한 클래스 또는 변수 코드 붙여넣기}

요청 사항:
{ex. 버튼 hover 색상 변경, 섹션 간격 줄이기, 카드 그림자 강조}
```

---

### header/footer 수정 요청 프롬프트

```
[기본 컨텍스트 프롬프트 붙여넣기]

아래는 현재 {header.html / footer.html} 파일 내용이야.
다음과 같이 수정해줘.

현재 파일 내용:
{파일 내용 붙여넣기}

수정 요청:
{ex. 네비게이션 항목 추가, 드롭다운 메뉴 추가, 로고 이미지 태그로 변경}
```
