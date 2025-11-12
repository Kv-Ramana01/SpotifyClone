<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String playlistId = request.getParameter("playlist_id");

    if (playlistId != null) {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spotify_clone", "root", "Charlotte@1707");

            // JOIN Query: Get Song Details for a specific Playlist
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
                // We wrap the row in 'card' class or add attributes so our player can read it later
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
                    <div class="col-album">Single</div> <div class="col-clock">--:--</div> </div>
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