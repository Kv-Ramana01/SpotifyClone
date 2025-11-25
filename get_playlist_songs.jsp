<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String playlistId = request.getParameter("playlist_id");

    if (playlistId != null) {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spotify_clone", "root", "Charlotte@1707");

            String sql = "SELECT s.song_id, s.title, s.artist, s.image_url, s.song_url " +
                         "FROM Songs s " +
                         "JOIN Playlist_Songs ps ON s.song_id = ps.song_id " +
                         "WHERE ps.playlist_id = ? " +
                         "ORDER BY ps.date_added ASC";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(playlistId));
            ResultSet rs = pstmt.executeQuery();

            int count = 1;
            boolean hasSongs = false;

            while (rs.next()) {
                hasSongs = true;
                String title = rs.getString("title");
                String artist = rs.getString("artist");
                String img = rs.getString("image_url");
                String url = rs.getString("song_url");
                int songId = rs.getInt("song_id");
%>
                <div class="song-row playlist-track" 
                     data-song-url="<%= url %>" 
                     data-title="<%= title %>" 
                     data-artist="<%= artist %>" 
                     data-img="<%= img %>">
                     
                    <div class="col-hash"><%= count++ %></div>
                    <div class="col-title">
                        <img src="<%= img %>" alt="">
                        <div class="song-name-artist">
                            <span class="s-name"><%= title %></span>
                            <span class="s-artist"><%= artist %></span>
                        </div>
                    </div>
                    <div class="col-album">Single</div>
                    <div class="col-clock">--:--</div>
                    
                    <div class="col-action">
                        <button class="delete-track-btn" 
                                data-song-id="<%= songId %>" 
                                data-playlist-id="<%= playlistId %>"
                                title="Remove from Playlist">
                            <svg role="img" height="16" width="16" viewBox="0 0 16 16" fill="currentColor">
                                <path d="M5.25 3v-.25a.75.75 0 0 1 .75-.75h4a.75.75 0 0 1 .75.75V3h4.25c.414 0 .75.336.75.75v1a.75.75 0 0 1-.75.75H1.25A.75.75 0 0 1 .5 4.75v-1c0-.414.336-.75.75-.75H5.25zm.75.75h4v-1h-4v1zM2.75 6.5h10.5a.75.75 0 0 1 .75.75v7a1.75 1.75 0 0 1-1.75 1.75H3.75A1.75 1.75 0 0 1 2 14.25v-7a.75.75 0 0 1 .75-.75z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
<%
            }
            
            if (!hasSongs) {
                out.println("<div style='padding:20px; color:#b3b3b3;'>No songs added yet. Right-click a song to add it!</div>");
            }

            conn.close();
        } catch (Exception e) {
            out.println("Error loading songs.");
            e.printStackTrace();
        }
    }
%>