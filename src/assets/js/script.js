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
});
