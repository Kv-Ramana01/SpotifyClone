
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
  String username = null;

  if(session.getAttribute("username")!=null){
    username = (String) session.getAttribute("username");
  }

%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Spotify Clone</title>
    <link rel="stylesheet" href="style.css" />
    <link rel="stylesheet" href="utility.css" />
  </head>
  <body>
    <div class="main-container">

      <!-- <div class="search-bar">
          <img src="svgs/search.svg" alt="" />
          <input type="text" placeholder="What do you want to play?" />
          <span>|</span>
          <button>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              width="30"
              height="30"
              fill="currentColor"
              role="img"
              aria-hidden="true"
            >
              <path
                d="M15 15.5c0 1.105-1.343 2-3 2s-3-.895-3-2 1.343-2 3-2 3 .895 3 2"
              ></path>
              <path
                d="M1.513 9.37A1 1 0 0 1 2.291 9h19.418a1 1 0 0 1 .979 1.208l-2.339 11a1 1 0 0 1-.978.792H4.63a1 1 0 0 1-.978-.792l-2.339-11a1 1 0 0 1 .201-.837zM3.525 11l1.913 9h13.123l1.913-9zM4 2a1 1 0 0 1 1-1h14a1 1 0 0 1 1 1v4h-2V3H6v3H4z"
              ></path>
            </svg>
          </button>
        </div> -->
      <nav class="navigation-bar">
        <div class="logo">
          <img src="logo.svg" alt="" />
        </div>
        <button class = "playlist-sidebar">
           <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="32" height="32" color="#ffffff" fill="none">
          <path d="M3 15C3 12.1911 3 10.7866 3.67412 9.77772C3.96596 9.34096 4.34096 8.96596 4.77772 8.67412C5.78661 8 7.19108 8 10 8H14C16.8089 8 18.2134 8 19.2223 8.67412C19.659 8.96596 20.034 9.34096 20.3259 9.77772C21 10.7866 21 12.1911 21 15C21 17.8089 21 19.2134 20.3259 20.2223C20.034 20.659 19.659 21.034 19.2223 21.3259C18.2134 22 16.8089 22 14 22H10C7.19108 22 5.78661 22 4.77772 21.3259C4.34096 21.034 3.96596 20.659 3.67412 20.2223C3 19.2134 3 17.8089 3 15Z" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
          <path d="M12.5 16.5C12.5 17.3284 11.8284 18 11 18C10.1716 18 9.5 17.3284 9.5 16.5C9.5 15.6716 10.1716 15 11 15C11.8284 15 12.5 15.6716 12.5 16.5ZM12.5 16.5V11.5C12.5 11.5 12.9 13.2333 14.5 13.5" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
          <path d="M19 8C18.9821 6.76022 18.89 6.05733 18.4182 5.58579C17.8321 5 16.8888 5 15.0022 5H8.99783C7.11118 5 6.16786 5 5.58176 5.58579C5.10996 6.05733 5.01794 6.76022 5 8" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
          <path d="M17 5C17 4.06812 17 3.60218 16.8478 3.23463C16.6448 2.74458 16.2554 2.35523 15.7654 2.15224C15.3978 2 14.9319 2 14 2H10C9.06812 2 8.60218 2 8.23463 2.15224C7.74458 2.35523 7.35523 2.74458 7.15224 3.23463C7 3.60218 7 4.06812 7 5" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
          </svg>
        </button>
        <button class="home-button"><img src="svgs/home.svg" alt="" /></button>
        <div class="search-bar">
          <img src="svgs/search.svg" alt="" />
          <input type="text" placeholder="What do you want to play?" />
          <button id="search-close-button">
            <svg 
            xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              width="30"
              height="30"
              fill="currentColor"
              role="img"
              aria-hidden="true"
            >
            <path d="M3.293 3.293a1 1 0 0 1 1.414 0L12 10.586l7.293-7.293a1 1 0 1 1 1.414 1.414L13.414 12l7.293 7.293a1 1 0 0 1-1.414 1.414L12 13.414l-7.293 7.293a1 1 0 0 1-1.414-1.414L10.586 12 3.293 4.707a1 1 0 0 1 0-1.414"></path>
            </svg>
          </button>
          <span>|</span>
          <button>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              width="30"
              height="30"
              fill="currentColor"
              role="img"
              aria-hidden="true"
            >
              <path
                d="M15 15.5c0 1.105-1.343 2-3 2s-3-.895-3-2 1.343-2 3-2 3 .895 3 2"
              ></path>
              <path
                d="M1.513 9.37A1 1 0 0 1 2.291 9h19.418a1 1 0 0 1 .979 1.208l-2.339 11a1 1 0 0 1-.978.792H4.63a1 1 0 0 1-.978-.792l-2.339-11a1 1 0 0 1 .201-.837zM3.525 11l1.913 9h13.123l1.913-9zM4 2a1 1 0 0 1 1-1h14a1 1 0 0 1 1 1v4h-2V3H6v3H4z"
              ></path>
            </svg>
          </button>
        </div>
        <div class="navigation-tools">
          <a href="">Premium</a>
          <a href="">Support</a>
          <a href="">Download</a>
        </div>
        <div class="nav-divider">
          <span>|</span>
        </div>

        <div class="sign-up">
          <a class="install" href=""
            ><svg
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 16 16"
              width="20"
              height="20"
              fill="currentColor"
              role="img"
              aria-hidden="true"
            >
              <path
                d="M4.995 8.745a.75.75 0 0 1 1.06 0L7.25 9.939V4a.75.75 0 0 1 1.5 0v5.94l1.195-1.195a.75.75 0 1 1 1.06 1.06L8 12.811l-.528-.528-.005-.005-2.472-2.473a.75.75 0 0 1 0-1.06"
              ></path>
              <path
                d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-6.5a6.5 6.5 0 1 0 0 13 6.5 6.5 0 0 0 0-13"
              ></path></svg
            >Install App</a
          >

          <%
            if(username!=null){
          %>
          <a href="#">Welcome, <%= username %></a>
          <button>
            <a href="logout.jsp">Log out</a>
          </button>
          <%
            }else{
          %>
          <a href="signup.jsp">Sign up</a>
          <button>
            <a href="login.jsp">Log in</a>
          </button>

          <%
            }
          %>
        </div>

        <div class="ham-icon">
        <button>
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="35" height="35" fill="none">
          <path d="M4 5L20 5" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
          <path d="M4 12L20 12" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
          <path d="M4 19L20 19" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
          </svg>
        </button>
      </div>
        
        
      </nav>

      <div class="mobile-nav-panel">
        <a href="">Premium</a>
        <a href="">Support</a>
        <a href="">Download</a>
        <a href="">Install app</a>

        <hr>

        <%
          if(username!= null){
        %>

        <a href="#">Welcome, <%= username %></a>
        <button>
          <a href="logout.jsp" class="mobile-nav-button">Log out</a>
        </button>
        <%
          }else{
        %>
        <a href="signup.jsp">Sign up</a>
        <button>
          <a href="login.jsp" class="mobile-nav-button">Log in</a>
        </button>
        <%
          }
        %>
      </div>
      
      <div class="secondary-container">
        <div class="left">
          <div class="lib-title">
            Your Library
            <button class="lib-button">
              <img src="svgs/plusicon.svg" alt="" />
            </button>
          </div>
          <div class="playlist-card">
            <p>Create your first playlist</p>
            <span>It's easy, we'll help you</span>
            <button class="playlist-button">Create Playlist</button>
          </div>
          <div class="podcast-card">
            <p>Let's find some podcasts to follow</p>
            <span>We'll keep you updated on new episodes</span>
            <button class="podcast-button">Browse Podcasts</button>
          </div>
          <div class="links">
            <div class="first">
              <a href="">Legal</a>
              <a href="">Safety&Privacy Center</a>
              <a href="">Privacy Policy</a>
              <a href="">Cookies</a>
              <a href="">About Ads</a>
              <a href="">Accessibility</a>
            </div>
            <div class="second"><a href="">Cookies</a></div>

            <button><img src="svgs/globe.svg" alt="" />English</button>
          </div>
        </div>
        <div class="right">
          <div id="default-view" class="main-content-view active">
            <div class="Right-Header">
            <h2 style="font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;">Trending songs</h2>
            </div>

            <div class="music-list">
              <div class="card">
                <div class="image">
                  <img aria-hidden="false" draggable="false" loading="lazy" src="https://i.scdn.co/image/ab67616d00001e02e60418359b299f1e237ee7da" data-testid="card-image" alt="" class="LBM25IAoFtd0wh7k3EGM Z3N2sU3PRuY4NgvdEz55 DlkUu3oBOxXLc2LtOd3N PgTMmU2Gn7AESFMYhw4i">
                  <button class="play-button">
                  <svg role="img" height="24" width="24" aria-hidden="true" viewBox="0 0 24 24">
                  <path d="M7.05 3.606l13.49 7.788a.7.7 0 010 1.212L7.05 20.394A.7.7 0 016 19.788V4.212a.7.7 0 011.05-.606z"></path>
                  </svg>
                  </button>
                </div>
                <h3><a class="card-link" href="">Kufar</a></h3>
                <p><a class="card-link" href="">Diljit Dosanjh</a>, <a class="card-link" href="">MixSingh</a>, <a class="card-link" href="">Raj Ranjodh</a></p>
              </div>


              <!-- <div class="music-list">
    <%
        // 1. Database Connection
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spotify_clone", "root", "Charlotte@1707");

            // 2. Fetch all songs
            String sql = "SELECT * FROM Songs";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            // 3. Loop through results and create a card for each song
            while (rs.next()) {
                String title = rs.getString("title");
                String artist = rs.getString("artist");
                String imageUrl = rs.getString("image_url");
                String songUrl = rs.getString("song_url");
    %>

    <div class="card" data-song-url="<%= songUrl %>">
        <div class="image">
            <img aria-hidden="false" draggable="false" loading="lazy" src="<%= imageUrl %>" alt="<%= title %>">
            <button class="play-button">
                <svg role="img" height="24" width="24" aria-hidden="true" viewBox="0 0 24 24">
                    <path d="M7.05 3.606l13.49 7.788a.7.7 0 010 1.212L7.05 20.394A.7.7 0 016 19.788V4.212a.7.7 0 011.05-.606z"></path>
                </svg>
            </button>
        </div>
        <h3><a class="card-link" href=""><%= title %></a></h3>
        <p><a class="card-link" href=""><%= artist %></a></p>
    </div>

    <%
            } // End of while loop
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 4. Clean up
            if (rs != null) try { rs.close(); } catch (SQLException e) { }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { }
            if (conn != null) try { conn.close(); } catch (SQLException e) { }
        }
    %>
</div> -->
              <div class="card">
                <div class="image">
                  <img aria-hidden="false" draggable="false" loading="lazy" src="https://i.scdn.co/image/ab67616d00001e02a32964acd7f1f9d64ea59ff7" data-testid="card-image" alt="" class="LBM25IAoFtd0wh7k3EGM Z3N2sU3PRuY4NgvdEz55 DlkUu3oBOxXLc2LtOd3N PgTMmU2Gn7AESFMYhw4i"> <button class="play-button">
                    <svg role="img" height="24" width="24" aria-hidden="true" viewBox="0 0 24 24">
                      <path d="M7.05 3.606l13.49 7.788a.7.7 0 010 1.212L7.05 20.394A.7.7 0 016 19.788V4.212a.7.7 0 011.05-.606z"></path>
                  </svg>
                  </button>
                </div>
                <h3><a class="card-link" href="">JACKBOYS 2</a></h3>
                <p><a class="card-link" href="">JACKBOYS</a>, <a class="card-link" href="">Travis Scott</a></p>
              </div>

              <div class="card">
                <div class="image">
                  <img aria-hidden="false" draggable="false" loading="lazy" src="https://i.scdn.co/image/ab67616d00001e02e9553ca116b587c8d3f59967" data-testid="card-image" alt="" class="LBM25IAoFtd0wh7k3EGM Z3N2sU3PRuY4NgvdEz55 DlkUu3oBOxXLc2LtOd3N PgTMmU2Gn7AESFMYhw4i">
                  <button class="play-button">
                  <svg role="img" height="24" width="24" aria-hidden="true" viewBox="0 0 24 24">
                  <path d="M7.05 3.606l13.49 7.788a.7.7 0 010 1.212L7.05 20.394A.7.7 0 016 19.788V4.212a.7.7 0 011.05-.606z"></path>
                  </svg>
                  </button>
              
                </div>
                <h3><a class="card-link" href="">Sapphire</a></h3>
                <p>2025 <a class="card-link" href="">Saquib Alam</a></p>
              </div>
              
              <div class="card">
                <div class="image">
                  <img aria-hidden="false" draggable="false" loading="lazy" src="https://i.scdn.co/image/ab67616d00001e02b8a4fa0168c52aa15ca9f882" data-testid="card-image" alt="" class="LBM25IAoFtd0wh7k3EGM Z3N2sU3PRuY4NgvdEz55 DlkUu3oBOxXLc2LtOd3N PgTMmU2Gn7AESFMYhw4i">
                  <button class="play-button">
                  <svg role="img" height="24" width="24" aria-hidden="true" viewBox="0 0 24 24">
                  <path d="M7.05 3.606l13.49 7.788a.7.7 0 010 1.212L7.05 20.394A.7.7 0 016 19.788V4.212a.7.7 0 011.05-.606z"></path>
                  </svg>
                  </button>
                </div>
                <h3><a class="card-link" href="">Montagem Supersonic</a></h3>
                <p>2025 <a class="card-link" href="">KHAOS</a>, <a class="card-link" href="">Jmilton</a>, <a class="card-link" href="">Mc Jajau</a></p>
              </div>

              <div class="card">
                <div class="image">
                  <img aria-hidden="false" draggable="false" loading="lazy" src="https://i.scdn.co/image/ab67616d00001e02fba856252bdd84adf5025ba1" data-testid="card-image" alt="" class="LBM25IAoFtd0wh7k3EGM Z3N2sU3PRuY4NgvdEz55 DlkUu3oBOxXLc2LtOd3N PgTMmU2Gn7AESFMYhw4i">
                  <button class="play-button">
                  <svg role="img" height="24" width="24" aria-hidden="true" viewBox="0 0 24 24">
                  <path d="M7.05 3.606l13.49 7.788a.7.7 0 010 1.212L7.05 20.394A.7.7 0 016 19.788V4.212a.7.7 0 011.05-.606z"></path>
                  </svg>
                  </button>
                </div>
                <h3><a class="card-link" href="">MONTAGEM SAMUS</a></h3>
                <p>2025 <a class="card-link" href="">Kobe Mane</a>, <a class="card-link" href="">shvnxe</a></p>
              </div>
              <div class="card">
                <div class="image">
                  <img aria-hidden="false" draggable="false" loading="lazy" src="https://i.scdn.co/image/ab67616d00001e02e60418359b299f1e237ee7da" data-testid="card-image" alt="" class="LBM25IAoFtd0wh7k3EGM Z3N2sU3PRuY4NgvdEz55 DlkUu3oBOxXLc2LtOd3N PgTMmU2Gn7AESFMYhw4i">
                  <button class="play-button">
                  <svg role="img" height="24" width="24" aria-hidden="true" viewBox="0 0 24 24">
                  <path d="M7.05 3.606l13.49 7.788a.7.7 0 010 1.212L7.05 20.394A.7.7 0 016 19.788V4.212a.7.7 0 011.05-.606z"></path>
                  </svg>
                  </button>
                </div>
                <h3><a class="card-link" href="">Kufar</a></h3>
                <p><a class="card-link" href="">Diljit Dosanjh</a>, <a class="card-link" href="">MixSingh</a>, <a class="card-link" href="">Raj Ranjodh</a></p>
              </div>
              <div class="card">
                <div class="image">
                  <img aria-hidden="false" draggable="false" loading="lazy" src="https://i.scdn.co/image/ab67616d00001e02a32964acd7f1f9d64ea59ff7" data-testid="card-image" alt="" class="LBM25IAoFtd0wh7k3EGM Z3N2sU3PRuY4NgvdEz55 DlkUu3oBOxXLc2LtOd3N PgTMmU2Gn7AESFMYhw4i"> <button class="play-button">
                    <svg role="img" height="24" width="24" aria-hidden="true" viewBox="0 0 24 24">
                      <path d="M7.05 3.606l13.49 7.788a.7.7 0 010 1.212L7.05 20.394A.7.7 0 016 19.788V4.212a.7.7 0 011.05-.606z"></path>
                  </svg>
                  </button>
                </div>
                <h3><a class="card-link" href="">JACKBOYS 2</a></h3>
                <p><a class="card-link" href="">JACKBOYS</a>, <a class="card-link" href="">Travis Scott</a></p>
              </div>

              <div class="card">
                <div class="image">
                  <img aria-hidden="false" draggable="false" loading="lazy" src="https://i.scdn.co/image/ab67616d00001e02e9553ca116b587c8d3f59967" data-testid="card-image" alt="" class="LBM25IAoFtd0wh7k3EGM Z3N2sU3PRuY4NgvdEz55 DlkUu3oBOxXLc2LtOd3N PgTMmU2Gn7AESFMYhw4i">
                  <button class="play-button">
                  <svg role="img" height="24" width="24" aria-hidden="true" viewBox="0 0 24 24">
                  <path d="M7.05 3.606l13.49 7.788a.7.7 0 010 1.212L7.05 20.394A.7.7 0 016 19.788V4.212a.7.7 0 011.05-.606z"></path>
                  </svg>
                  </button>
              
                </div>
                <h3><a class="card-link" href="">Sapphire</a></h3>
                <p>2025 <a class="card-link" href="">Saquib Alam</a></p>
              </div>
              
              <div class="card">
                <div class="image">
                  <img aria-hidden="false" draggable="false" loading="lazy" src="https://i.scdn.co/image/ab67616d00001e02b8a4fa0168c52aa15ca9f882" data-testid="card-image" alt="" class="LBM25IAoFtd0wh7k3EGM Z3N2sU3PRuY4NgvdEz55 DlkUu3oBOxXLc2LtOd3N PgTMmU2Gn7AESFMYhw4i">
                  <button class="play-button">
                  <svg role="img" height="24" width="24" aria-hidden="true" viewBox="0 0 24 24">
                  <path d="M7.05 3.606l13.49 7.788a.7.7 0 010 1.212L7.05 20.394A.7.7 0 016 19.788V4.212a.7.7 0 011.05-.606z"></path>
                  </svg>
                  </button>
                </div>
                <h3><a class="card-link" href="">Montagem Supersonic</a></h3>
                <p>2025 <a class="card-link" href="">KHAOS</a>, <a class="card-link" href="">Jmilton</a>, <a class="card-link" href="">Mc Jajau</a></p>
              </div>

              <div class="card">
                <div class="image">
                  <img aria-hidden="false" draggable="false" loading="lazy" src="https://i.scdn.co/image/ab67616d00001e02fba856252bdd84adf5025ba1" data-testid="card-image" alt="" class="LBM25IAoFtd0wh7k3EGM Z3N2sU3PRuY4NgvdEz55 DlkUu3oBOxXLc2LtOd3N PgTMmU2Gn7AESFMYhw4i">
                  <button class="play-button">
                  <svg role="img" height="24" width="24" aria-hidden="true" viewBox="0 0 24 24">
                  <path d="M7.05 3.606l13.49 7.788a.7.7 0 010 1.212L7.05 20.394A.7.7 0 016 19.788V4.212a.7.7 0 011.05-.606z"></path>
                  </svg>
                  </button>
                </div>
                <h3><a class="card-link" href="">MONTAGEM SAMUS</a></h3>
                <p>2025 <a class="card-link" href="">Kobe Mane</a>, <a class="card-link" href="">shvnxe</a></p>
              </div>
              
            </div>
          </div>

          <div id="search-view" class="main-content-view">
            <nav class="filter-nav">
              <button class="filter-button active" data-target="all-content">
                All
              </button>
              <button class="filter-button" data-target="artists-content">
                Artists
              </button>
              <button class="filter-button" data-target="songs-content">
                Songs
              </button>
              <button class="filter-button" data-target="profiles-content">
                Profiles
              </button>
            </nav>

            <div class="content-area">
              <div id="all-content" class="content-section active">
                <h3>Top Result</h3>
                <p>( 'Top Result' goes here...)</p>
                <hr />
                <h3>Artists</h3>
                <p>( 'Artists' row goes here...)</p>
                <hr />
                <h3>Songs</h3>
                <p>( 'Songs' list goes here...)</p>
              </div>
              <div id="artists-content" class="content-section">
                <h3>Artists</h3>
                <p>artists row---></p>
              </div>
              <div id="songs-content" class="content-section">
                <h3>Songs</h3>
                <p>songs row go here --></p>
              </div>
              <div id="profiles-content" class="content-section">
                <h3>Profiles</h3>
                <p>profiles row go here</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <%

      if(username == null){

      %>
      <footer>
        <div>
          <div><p>Preview of Spotify</p></div>
          <div>
            <span
              >Sign up to get unlimited songs and podcasts with occasional ads.
              No credit card needed.</span
            >
          </div>
        </div>
        <!-- <p>This page was loaded on: <%= new java.util.Date() %></p> -->
        <button><a href="signup.jsp">Sign up</a></button>
      </footer>

      <% 
        }

      %>
    </div>
  </body>
  <script src="script.js"></script>
</html>

<!-- <nav class="filter-nav">
            <button class="filter-button active" data-target="all-content">
              All
            </button>
            <button class="filter-button" data-target="artists-content">
              Artists
            </button>
            <button class="filter-button" data-target="songs-content">
              Songs
            </button>
            <button class="filter-button" data-target="profiles-content">
              Profiles
            </button>
          </nav>

          <div class="content-area">
            <div id="all-content" class="content-section active">
              <h3>Top Result</h3>
              <p>(Your 'Top Result' component goes here...)</p>
              <hr />
              <h3>Artists</h3>
              <p>(Your 'Artists' row component goes here...)</p>
              <hr />
              <h3>Songs</h3>
              <p>(Your 'Songs' list component goes here...)</p>
            </div>

            <div id="artists-content" class="content-section">
              <h3>Artists</h3>
              <p>(Your 'Artists' row component goes here...)</p>
            </div>

            <div id="songs-content" class="content-section">
              <h3>Songs</h3>
              <p>(Your 'Songs' list component goes here...)</p>
            </div>

            <div id="profiles-content" class="content-section">
              <h3>Profiles</h3>
              <p>(Your 'Profiles' list component goes here...)</p>
            </div>
          </div> -->
