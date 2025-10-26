
//adding the event listener to dom so that js runs only after all the content of dom has loaded
//or it might crash
document.addEventListener("DOMContentLoaded", () => {
  const searchInput = document.querySelector('.search-bar input[type="text"]');
  const homeButton = document.querySelector(".home-button");
  const defaultView = document.querySelector("#default-view");
  const searchView = document.querySelector("#search-view");

  function showSearchView() {
    defaultView.classList.remove("active");
    searchView.classList.add("active");
  }

  function showDefaultView() {
    defaultView.classList.add("active");
    searchView.classList.remove("active");
  }

  searchInput.addEventListener("focus", showSearchView);
  homeButton.addEventListener("click", showDefaultView);

  //state management for filter buttons

  const allFilterButtons = document.querySelectorAll(".filter-button");
  const allContentSection = document.querySelectorAll(".content-section");

  allFilterButtons.forEach((button) => {
    button.addEventListener("click", () => {
      const target_id = button.getAttribute("data-target");
      const target_content = document.getElementById(target_id);

      allFilterButtons.forEach((btn) => {
        btn.classList.remove("active");
      });

      allContentSection.forEach((section) => {
        section.classList.remove("active");
      });

      button.classList.add("active");
      target_content.classList.add("active");
    });
  });
});
