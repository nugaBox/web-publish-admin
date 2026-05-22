/**
 * script.js — 전역 공통 스크립트
 * CMS JS 항목에 이 파일 전체 내용을 등록합니다.
 */

/* ── data-include 로더 (로컬 개발용) ──────────────────────── */
document.addEventListener("DOMContentLoaded", () => {
  const includes = document.querySelectorAll("[data-include]");

  Promise.all(
    [...includes].map((el) =>
      fetch(el.dataset.include)
        .then((res) => {
          if (!res.ok) throw new Error(`${el.dataset.include} 로드 실패`);
          return res.text();
        })
        .then((html) => {
          el.outerHTML = html;
        })
        .catch((err) => console.warn(err))
    )
  );

  initAdminTheme();
  initLoginPage();
});

/* ── 테마 (대시보드 · 로그인 공통) ───────────────────────── */
function setAdminTheme(t) {
  document.documentElement.setAttribute("data-theme", t);
  const themeIcon = document.getElementById("themeIcon");
  if (themeIcon) {
    themeIcon.className = t === "dark" ? "fa-solid fa-sun" : "fa-solid fa-moon";
  }
  try {
    localStorage.setItem("admin-theme", t);
  } catch (e) {}
}

function initAdminTheme() {
  const themeBtn = document.getElementById("themeToggle");
  if (!themeBtn || themeBtn.dataset.themeBound) return;
  themeBtn.dataset.themeBound = "1";

  themeBtn.addEventListener("click", () => {
    const cur = document.documentElement.getAttribute("data-theme") || "light";
    setAdminTheme(cur === "dark" ? "light" : "dark");
  });

  try {
    const saved = localStorage.getItem("admin-theme");
    if (saved) setAdminTheme(saved);
  } catch (e) {}
}

/* ── 로그인 페이지 ────────────────────────────────────────── */
function initLoginPage() {
  const form = document.getElementById("loginForm");
  if (!form) return;

  const idInput = document.getElementById("loginId");
  const remember = document.getElementById("rememberId");
  const storageKey = "admin-saved-id";

  try {
    const saved = localStorage.getItem(storageKey);
    if (saved && idInput) {
      idInput.value = saved;
      if (remember) remember.checked = true;
    }
  } catch (e) {}

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    try {
      if (remember?.checked && idInput?.value) {
        localStorage.setItem(storageKey, idInput.value);
      } else {
        localStorage.removeItem(storageKey);
      }
    } catch (err) {}

    const btn = form.querySelector(".login-btn-primary");
    if (!btn) return;

    const original = btn.textContent;
    btn.disabled = true;
    btn.textContent = "확인 중…";

    window.setTimeout(() => {
      btn.textContent = "✓ 로그인 성공";
      window.setTimeout(() => {
        window.location.href = "index.html";
      }, 600);
    }, 700);

    window.setTimeout(() => {
      if (btn.disabled && btn.textContent === "확인 중…") {
        btn.textContent = original;
        btn.disabled = false;
      }
    }, 5000);
  });
}
