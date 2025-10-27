
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
    <title>ProjectClass</title>
    <link rel="stylesheet" href="style.css" />
    <link rel="stylesheet" href="utility.css" />
  </head>
  <body>
    <div class="main-container">
      <nav class="navigation-bar flex">
        <div class="logo">
          <img src="logo.svg" alt="" />
        </div>
        <button class="home-button"><img src="svgs/home.svg" alt="" /></button>
        <div class="search-bar">
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
      </nav>
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
            <h2>Trending Songs</h2>
            <p>
              Lorem ipsum dolor sit amet consectetur adipisicing elit. Sed qui
              sequi sit nisi beatae, quas, sint consequatur, labore tempora
              error voluptas porro molestias.
            </p>
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
