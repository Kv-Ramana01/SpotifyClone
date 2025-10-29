
//adding the event listener to dom so that js runs only after all the content of dom has loaded
//or it might crash
document.addEventListener("DOMContentLoaded", () => {
  const searchInput = document.querySelector('.search-bar input[type="text"]');
  const homeButton = document.querySelector(".home-button");
  const defaultView = document.querySelector("#default-view");
  const searchView = document.querySelector("#search-view");
  const search_closebtn = document.querySelector("#search-close-button")

  function showSearchView() {
    defaultView.classList.remove("active");
    searchView.classList.add("active");
    search_closebtn.classList.add("active");
  }

  function showDefaultView() {
    defaultView.classList.add("active");
    searchView.classList.remove("active");
    search_closebtn.classList.remove("active");
  }

  searchInput.addEventListener("focus", showSearchView);
  homeButton.addEventListener("click", showDefaultView);
  search_closebtn.addEventListener("click", () => {
    searchInput.value = "";
    showDefaultView();
  });

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


  const rightContainer = document.querySelector(".right");
  let scrollTimer; // This variable will hold our timer

  rightContainer.addEventListener("scroll", () => {
    
    // 1. Add the class to show the scrollbar
    rightContainer.classList.add("is-scrolling");

    // 2. Clear any existing timer.
    // This stops the scrollbar from fading out while you're still scrolling.
    clearTimeout(scrollTimer);

    // 3. Set a new timer to remove the class after 1 second (1000ms)
    // This runs 1 second after you've *stopped* scrolling.
    scrollTimer = setTimeout(() => {
      rightContainer.classList.remove("is-scrolling");
    }, 1000); // 1-second delay
  });

  const hamburger = document.querySelector(".ham-icon");
  const mobileNav = document.querySelector(".mobile-nav-panel");

  if(hamburger && mobileNav){
    hamburger.addEventListener("click",function(){
      hamburger.classList.toggle("active");
      mobileNav.classList.toggle("active");
    })
  }

  // const hamburger = document.querySelector(".hamburger-menu");
  // const mobileNav = document.querySelector(".mobile-nav-panel");

  // if (hamburger && mobileNav) {
  //   hamburger.addEventListener("click", function() {
  //     // Toggle the 'active' class on both the hamburger and the nav panel
  //     hamburger.classList.toggle("active");
  //     mobileNav.classList.toggle("active");
  //   });
  // }


  
});
