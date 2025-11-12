document.addEventListener("DOMContentLoaded", () => {

  // =========================================
  // 1. GLOBAL VARIABLES & SELECTORS
  // =========================================
  
  // Login Status
  const loginStatusElement = document.getElementById("login-status");
  const isLoggedIn = loginStatusElement && loginStatusElement.value === "true";
  console.log("User Logged In status:", isLoggedIn);

  // Navigation Elements
  const searchInput = document.querySelector('.search-bar input[type="text"]');
  const homeButton = document.querySelector(".home-button");
  const searchCloseBtn = document.querySelector("#search-close-button");
  const playlistSidebarBtn = document.querySelector(".playlist-sidebar");
  const allViews = document.querySelectorAll(".main-content-view"); // Selects Default, Search, and Playlist views

  // Player Elements
  const musicPlayer = document.getElementById("music-player");
  const allCardPlayButtons = document.querySelectorAll(".play-button");
  const nowPlayingBar = document.querySelector(".now-playing-bar");
  
  // Footer Controls
  const footerPlayBtn = document.getElementById("footer-play-btn");
  const playIcon = document.getElementById("play-icon");
  const pauseIcon = document.getElementById("pause-icon");
  const footerImg = document.getElementById("current-song-img");
  const footerTitle = document.getElementById("current-song-title");
  const footerArtist = document.getElementById("current-song-artist");
  
  // Sliders & Time
  const songProgressBar = document.querySelector(".playback-bar .progress-bar");
  const volumeProgressBar = document.querySelector(".volume-controls .progress-bar");
  const volumeIcon = document.querySelector("#volume-icon");
  const currTimeDisplay = document.querySelector(".time.current");
  const totTimeDisplay = document.querySelector(".time.total");

  // Playlist Creation Elements
  const userPlusBtn = document.querySelector(".lib-button");    // Logged In "+"
  const guestCreateBtn = document.querySelector(".playlist-button"); // Guest "Create" button
  const modalOverlay = document.getElementById("playlist-modal");
  const closeModalBtn = document.getElementById("close-modal-btn");

  // Sidebar Playlist Items
  const sidebarPlaylists = document.querySelectorAll(".playlist-item");
  const playlistHeaderTitle = document.getElementById("playlist-header-title");


  // =========================================
  // 7. RIGHT CLICK "ADD TO PLAYLIST" LOGIC
  // =========================================
  
  const contextMenu = document.getElementById("song-context-menu");
  const contextList = document.getElementById("context-playlist-list");
  const allCards = document.querySelectorAll(".card");
  let selectedSongId = null;

  // Close menu when clicking anywhere else
  document.addEventListener("click", () => {
      if(contextMenu) contextMenu.style.display = "none";
  });

  // Add Right-Click Event to ALL Cards
  allCards.forEach(card => {
      card.addEventListener("contextmenu", (e) => {
          e.preventDefault(); // Stop browser default menu
          
          if(!isLoggedIn) return; // Only for users

          // 1. Store which song was clicked
          selectedSongId = card.getAttribute("data-song-id");
          console.log("Right clicked song ID:", selectedSongId);
          
          // 2. Position Menu
          if(contextMenu) {
              contextMenu.style.top = `${e.clientY}px`;
              contextMenu.style.left = `${e.clientX}px`;
              contextMenu.style.display = "block";
          
              // 3. Populate Menu with Playlists from Sidebar
              if(contextList) {
                  contextList.innerHTML = ""; // Clear old
                  
                  const sidebarItems = document.querySelectorAll(".playlist-item");
                  
                  if(sidebarItems.length === 0) {
                      contextList.innerHTML = "<div class='menu-option'>No Playlists found</div>";
                  }

                  sidebarItems.forEach(item => {
                      const pName = item.getAttribute("data-name");
                      const pId = item.getAttribute("data-playlist-id");
                      
                      const div = document.createElement("div");
                      div.className = "menu-option playlist-option";
                      div.innerText = pName;
                      
                      // 4. Handle Click on Playlist Option
                      div.addEventListener("click", () => {
                          console.log(`Adding Song ${selectedSongId} to Playlist ${pId}`);
                          
                          // Send to Backend via AJAX
                          fetch(`add_to_playlist.jsp?song_id=${selectedSongId}&playlist_id=${pId}`)
                            .then(response => response.text())
                            .then(data => {
                                if(data.trim() === "success") {
                                    alert(`Added to ${pName}!`);
                                } else if (data.trim() === "exists") {
                                    alert("Song already in playlist.");
                                } else {
                                    alert("Error adding song.");
                                    console.error(data);
                                }
                            });
                      });
                      
                      contextList.appendChild(div);
                  });
              }
          }
      });
  });


  // =========================================
  // 2. NAVIGATION LOGIC (Switch Views)
  // =========================================

  function switchView(targetId) {
    // 1. Hide ALL views
    allViews.forEach(view => {
      view.classList.remove("active");
    });

    // 2. Show TARGET view
    const targetView = document.getElementById(targetId);
    if (targetView) {
      targetView.classList.add("active");
    }

    // 3. Handle Search Close Button Visibility
    if (searchCloseBtn) {
      if (targetId === "search-view") {
        searchCloseBtn.classList.add("active");
      } else {
        searchCloseBtn.classList.remove("active");
      }
    }
  }

  // Event Listeners for Navigation
  if(homeButton) homeButton.addEventListener("click", () => switchView("default-view"));
  if(searchInput) searchInput.addEventListener("focus", () => switchView("search-view"));
  
  if(searchCloseBtn) {
    searchCloseBtn.addEventListener("click", () => {
      searchInput.value = "";
      switchView("default-view");
    });
  }

  // Filter Buttons Logic (Inside Search View)
  const allFilterButtons = document.querySelectorAll(".filter-button");
  const allContentSection = document.querySelectorAll(".content-section");

  allFilterButtons.forEach((button) => {
    button.addEventListener("click", () => {
      const target_id = button.getAttribute("data-target");
      const target_content = document.getElementById(target_id);

      allFilterButtons.forEach(btn => btn.classList.remove("active"));
      allContentSection.forEach(section => section.classList.remove("active"));

      button.classList.add("active");
      if(target_content) target_content.classList.add("active");
    });
  });


  // =========================================
  // 3. PLAYLIST CREATION MODAL
  // =========================================

  function openModal() {
    if (!isLoggedIn) {
      alert("Log in to create playlists!");
      window.location.href = "signup.jsp";
      return;
    }
    if (modalOverlay) modalOverlay.classList.add("active");
  }

  if (userPlusBtn) userPlusBtn.addEventListener("click", openModal);
  if (guestCreateBtn) guestCreateBtn.addEventListener("click", openModal);
  
  if (closeModalBtn) {
    closeModalBtn.addEventListener("click", () => {
      if (modalOverlay) modalOverlay.classList.remove("active");
    });
  }


  // =========================================
  // 4. SIDEBAR PLAYLIST CLICK (View Playlist)
  // =========================================

  
  const playlistSongsList = document.getElementById("playlist-songs-list"); // Container in playlist view

  sidebarPlaylists.forEach((item) => {
    item.addEventListener("click", () => {
      const name = item.getAttribute("data-name");
      const id = item.getAttribute("data-playlist-id");

      // 1. Update Header Info
      if(playlistHeaderTitle) playlistHeaderTitle.innerText = name;
      
      // 2. Switch to View
      switchView("playlist-view");

      // 3. FETCH SONGS FOR THIS PLAYLIST
      if (playlistSongsList) {
          playlistSongsList.innerHTML = "<div style='padding:20px;'>Loading tracks...</div>";
          
          fetch(`get_playlist_songs.jsp?playlist_id=${id}`)
            .then(response => response.text())
            .then(html => {
                playlistSongsList.innerHTML = html;
                attachClickToPlaylistTracks(); // Make them playable (See Step 3)
            })
            .catch(err => console.error("Error fetching playlist:", err));
      }
    });
  });


  // =========================================
  // 5. MUSIC PLAYER LOGIC
  // =========================================

  function updatePlayPauseUI(isPlaying) {
    if (!playIcon || !pauseIcon) return;
    if (isPlaying) {
      playIcon.style.display = "none";
      pauseIcon.style.display = "block";
    } else {
      playIcon.style.display = "block";
      pauseIcon.style.display = "none";
    }
  }

  function formatTime(seconds) {
    if (isNaN(seconds)) return "0:00";
    const min = Math.floor(seconds / 60);
    const sec = Math.floor(seconds % 60);
    return `${min}:${sec < 10 ? "0" + sec : sec}`;
  }

  // A. Handle Card Play Button Clicks
  console.log("Found " + allCardPlayButtons.length + " play buttons.");

  allCardPlayButtons.forEach((button) => {
    button.addEventListener("click", (e) => {
      e.stopPropagation(); // Prevent bubbling

      if (!isLoggedIn) {
        alert("You must sign up or log in to play music!");
        window.location.href = "signup.jsp";
        return;
      }

      // Slide up the player bar
      if (nowPlayingBar) nowPlayingBar.classList.add("active");

      // Get Data from Card
      const card = button.closest(".card");
      const songUrl = card.getAttribute("data-song-url");
      const title = card.querySelector("h3 a").innerText;
      const artist = card.querySelector("p a").innerText;
      const img = card.querySelector(".image img").src;

      // Update Footer UI
      if(footerImg) footerImg.src = img;
      if(footerTitle) footerTitle.innerText = title;
      if(footerArtist) footerArtist.innerText = artist;

      // Play the Audio
      if (musicPlayer) {
        musicPlayer.src = songUrl;
        musicPlayer.play()
          .then(() => updatePlayPauseUI(true))
          .catch(err => console.error("Playback error:", err));
      }
    });
  });

  // B. Handle Footer Play/Pause Toggle
  if (footerPlayBtn) {
    footerPlayBtn.addEventListener("click", () => {
      if (musicPlayer.paused) {
        musicPlayer.play();
        updatePlayPauseUI(true);
      } else {
        musicPlayer.pause();
        updatePlayPauseUI(false);
      }
    });
  }

  // C. Progress Bar & Time Update
  if (musicPlayer && songProgressBar) {
    // Update slider as song plays
    musicPlayer.addEventListener("timeupdate", () => {
      if (musicPlayer.duration) {
        const progressPercent = (musicPlayer.currentTime / musicPlayer.duration) * 100;
        songProgressBar.value = progressPercent;
        
        currTimeDisplay.innerText = formatTime(musicPlayer.currentTime);
        totTimeDisplay.innerText = formatTime(musicPlayer.duration);
      }
    });

    // Seek when slider is dragged
    songProgressBar.addEventListener("input", () => {
      const seekTime = (songProgressBar.value / 100) * musicPlayer.duration;
      musicPlayer.currentTime = seekTime;
    });

    // Set duration when song loads
    musicPlayer.addEventListener("loadedmetadata", () => {
      totTimeDisplay.innerText = formatTime(musicPlayer.duration);
      songProgressBar.max = 100; 
    });
  }

  // D. Volume Control
  const volPaths = {
    high: '<path d="M9.741.85a.75.75 0 0 1 .375.65v13a.75.75 0 0 1-1.125.65l-6.925-4a3.642 3.642 0 0 1-1.33-4.967 3.639 3.639 0 0 1 1.33-4.967l6.925-4a.75.75 0 0 1 .75 0zm-6.924 5.3a2.139 2.139 0 0 0 0 3.7l5.8 3.35V2.8l-5.8 3.35zm8.683 4.29V5.56a2.75 2.75 0 0 1 0 4.88z"></path><path d="M11.5 13.614a5.752 5.752 0 0 0 0-11.228v1.55a4.252 4.252 0 0 1 0 8.127v1.55z"></path>',
    low:  '<path d="M9.741.85a.75.75 0 0 1 .375.65v13a.75.75 0 0 1-1.125.65l-6.925-4a3.642 3.642 0 0 1-1.33-4.967 3.639 3.639 0 0 1 1.33-4.967l6.925-4a.75.75 0 0 1 .75 0zm-6.924 5.3a2.139 2.139 0 0 0 0 3.7l5.8 3.35V2.8l-5.8 3.35zm8.683 6.087a4.502 4.502 0 0 0 0-8.474v1.65a2.999 2.999 0 0 1 0 5.175v1.649z"></path>',
    mute: '<path d="M13.86 5.47a.75.75 0 0 0-1.061 0l-1.47 1.47-1.47-1.47A.75.75 0 0 0 8.8 6.53L10.269 8l-1.47 1.47a.75.75 0 1 0 1.06 1.06l1.47-1.47 1.47 1.47a.75.75 0 0 0 1.06-1.06L12.39 8l1.47-1.47a.75.75 0 0 0 0-1.06z"></path><path d="M10.116 1.5A.75.75 0 0 0 8.991.85l-6.925 4a3.642 3.642 0 0 0-1.33 4.967 3.639 3.639 0 0 0 1.33 4.967l6.925 4a.75.75 0 0 0 1.125-.649v-1.906a4.73 4.73 0 0 1-1.5-.694v1.3L2.817 9.852a2.141 2.141 0 0 1-.781-2.92c.187-.324.456-.594.78-.782l5.8-3.352v1.3c.45-.313.956-.55 1.5-.694V1.5z"></path>'
  };

  if (volumeProgressBar && musicPlayer) {
    volumeProgressBar.addEventListener("input", () => {
      const value = volumeProgressBar.value;
      const volume = value / 100;
      musicPlayer.volume = volume;

      if (value == 0) {
        volumeIcon.innerHTML = volPaths.mute;
      } else if (value < 50) {
        volumeIcon.innerHTML = volPaths.low;
      } else {
        volumeIcon.innerHTML = volPaths.high;
      }
    });
  }


  // =========================================
  // 6. MISC UI LOGIC (Sidebar Toggle & Scroll)
  // =========================================

  // Mobile Sidebar Toggle
  const hamburger = document.querySelector(".ham-icon");
  const mobileNav = document.querySelector(".mobile-nav-panel");

  if(hamburger && mobileNav){
    hamburger.addEventListener("click", function(){
      hamburger.classList.toggle("active");
      mobileNav.classList.toggle("active");
    });
  }

  if(playlistSidebarBtn){
    playlistSidebarBtn.addEventListener("click", ()=>{
      document.querySelector(".left").classList.toggle("active");
    });
  }

  // Custom Scrollbar Fade Effect
  const rightContainer = document.querySelector(".right");
  let scrollTimer; 

  if(rightContainer) {
      rightContainer.addEventListener("scroll", () => {
        rightContainer.classList.add("is-scrolling");
        clearTimeout(scrollTimer);
        scrollTimer = setTimeout(() => {
          rightContainer.classList.remove("is-scrolling");
        }, 1000); 
      });
  }

  // Helper: Make dynamic playlist rows clickable to play music
  function attachClickToPlaylistTracks() {
      const tracks = document.querySelectorAll(".playlist-track");
      
      tracks.forEach(track => {
          track.addEventListener("click", () => {
              const url = track.getAttribute("data-song-url");
              const title = track.getAttribute("data-title");
              const artist = track.getAttribute("data-artist");
              const img = track.getAttribute("data-img");

              // Update Footer
              if(footerImg) footerImg.src = img;
              if(footerTitle) footerTitle.innerText = title;
              if(footerArtist) footerArtist.innerText = artist;

              // Play
              if(musicPlayer) {
                  musicPlayer.src = url;
                  musicPlayer.play().then(() => updatePlayPauseUI(true));
              }
              
              // Show Bar
              if (nowPlayingBar) nowPlayingBar.classList.add("active");
          });
      });
  }
// =========================================
  // 8. SEARCH LOGIC (With Filters)
  // =========================================
  
  const searchBrowseContent = document.getElementById("search-browse-content");
  const searchResultsContainer = document.getElementById("search-results-container");
  const searchFilterButtons = document.querySelectorAll("#search-filter-nav .filter-button");
  
  let currentSearchQuery = "";
  let currentSearchType = "all"; // Default

  // Function to perform the actual fetch
  function performSearch() {
      if (currentSearchQuery.length === 0) {
          // Show Browse, Hide Results
          searchBrowseContent.style.display = "block";
          searchResultsContainer.style.display = "none";
          searchResultsContainer.innerHTML = "";
          return;
      }

      // Show Results, Hide Browse
      searchBrowseContent.style.display = "none";
      searchResultsContainer.style.display = "block";
      searchResultsContainer.innerHTML = "<div style='color:gray; padding:20px;'>Searching...</div>";

      // Send Query AND Type to backend
      fetch(`search_songs.jsp?q=${encodeURIComponent(currentSearchQuery)}&type=${currentSearchType}`)
        .then(response => response.text())
        .then(html => {
            searchResultsContainer.innerHTML = html;
            
            // RE-ATTACH CLICK LISTENERS (Important!)
            // We check if the function exists (it's defined in your Music Player section)
            if (typeof attachClickToPlaylistTracks === "function") {
                attachClickToPlaylistTracks();
            } else {
                // Fallback if function isn't global (Copy of logic)
                const tracks = document.querySelectorAll(".playlist-track");
                tracks.forEach(track => {
                    track.addEventListener("click", () => {
                        const url = track.getAttribute("data-song-url");
                        const title = track.getAttribute("data-title");
                        const artist = track.getAttribute("data-artist");
                        const img = track.getAttribute("data-img");
                        
                        if(footerImg) footerImg.src = img;
                        if(footerTitle) footerTitle.innerText = title;
                        if(footerArtist) footerArtist.innerText = artist;
                        
                        if(musicPlayer) {
                            musicPlayer.src = url;
                            musicPlayer.play().then(() => updatePlayPauseUI(true));
                        }
                        if(nowPlayingBar) nowPlayingBar.classList.add("active");
                    });
                    // Re-attach Context Menu
                    track.addEventListener("contextmenu", (e) => {
                       e.preventDefault();
                       if(!isLoggedIn) return;
                       
                       selectedSongId = track.getAttribute("data-song-id");
                       if(contextMenu) {
                           contextMenu.style.top = `${e.clientY}px`;
                           contextMenu.style.left = `${e.clientX}px`;
                           contextMenu.style.display = "block";
                           
                           // Repopulate context menu list (Reuse existing logic)
                           if(contextList && contextList.children.length === 0) {
                               // Trigger sidebar population manually or just alert
                               // For now, sidebar logic populates it.
                           }
                       }
                    });
                });
            }
        });
  }

  // A. Handle Typing
  if (searchInput) {
      searchInput.addEventListener("input", (e) => {
          currentSearchQuery = e.target.value.trim();
          switchView("search-view"); // Ensure we are on search page
          performSearch();
      });
  }

  // B. Handle Filter Tabs (All, Artist, Songs)
  searchFilterButtons.forEach(btn => {
      btn.addEventListener("click", () => {
          // UI: Highlight active button
          searchFilterButtons.forEach(b => b.classList.remove("active"));
          btn.classList.add("active");

          // Logic: Set type and search
          currentSearchType = btn.getAttribute("data-type");
          performSearch();
      });
  });
  
  // Helper to make dynamic rows clickable (Global scope)
  window.attachClickToPlaylistTracks = function() {
      const tracks = document.querySelectorAll(".playlist-track");
      tracks.forEach(track => {
          track.addEventListener("click", () => {
              const url = track.getAttribute("data-song-url");
              const title = track.getAttribute("data-title");
              const artist = track.getAttribute("data-artist");
              const img = track.getAttribute("data-img");

              if(footerImg) footerImg.src = img;
              if(footerTitle) footerTitle.innerText = title;
              if(footerArtist) footerArtist.innerText = artist;

              if(musicPlayer) {
                  musicPlayer.src = url;
                  musicPlayer.play().then(() => updatePlayPauseUI(true));
              }
              if (nowPlayingBar) nowPlayingBar.classList.add("active");
          });
          
          // Add Context Menu Logic to these dynamic rows too!
          track.addEventListener("contextmenu", (e) => {
              e.preventDefault();
              if(!isLoggedIn) return;
              selectedSongId = track.getAttribute("data-song-id");
              
              if(contextMenu) {
                  contextMenu.style.top = `${e.clientY}px`;
                  contextMenu.style.left = `${e.clientX}px`;
                  contextMenu.style.display = "block";
                  
                  // Check if we need to rebuild the list (reuse logic from sidebar)
                  const sidebarItems = document.querySelectorAll(".playlist-item");
                  contextList.innerHTML = "";
                  sidebarItems.forEach(item => {
                      const pName = item.getAttribute("data-name");
                      const pId = item.getAttribute("data-playlist-id");
                      const div = document.createElement("div");
                      div.className = "menu-option playlist-option";
                      div.innerText = pName;
                      div.addEventListener("click", () => {
                          fetch(`add_to_playlist.jsp?song_id=${selectedSongId}&playlist_id=${pId}`)
                            .then(r=>r.text())
                            .then(d=> alert(d.trim() === 'success' ? 'Added!' : 'Already exists/Error'));
                          contextMenu.style.display = "none";
                      });
                      contextList.appendChild(div);
                  });
              }
          });
      });
  }

});