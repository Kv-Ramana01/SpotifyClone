<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String query = request.getParameter("q");
    String type = request.getParameter("type");
    if (type == null) type = "all";

    if (query != null && !query.trim().isEmpty()) {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spotify_clone", "root", "Charlotte@1707");

            String sql = "";
            if (type.equals("song")) sql = "SELECT * FROM Songs WHERE title LIKE ?";
            else if (type.equals("artist")) sql = "SELECT * FROM Songs WHERE artist LIKE ?";
            else sql = "SELECT * FROM Songs WHERE title LIKE ? OR artist LIKE ?";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            String pattern = "%" + query + "%";
            
            if (type.equals("all")) {
                pstmt.setString(1, pattern);
                pstmt.setString(2, pattern);
            } else {
                pstmt.setString(1, pattern);
            }
            
            ResultSet rs = pstmt.executeQuery();
            boolean found = false;
            int count = 1;

            // 1. Container and Header (Using CSS classes now)
            out.println("<div class='playlist-songs-container'>");
            out.println("<h2 style='color:white; margin-bottom:20px; font-family: \"Franklin Gothic Medium\", sans-serif;'>Search Results</h2>");
            
            out.println("<div class='song-header-row'>");
            out.println("<div class='col-hash'>#</div><div class='col-title'>Title</div><div class='col-album'>Artist</div><div class='col-clock'>Time</div>");
            out.println("</div>");
            out.println("<hr class='divider'>");

            while(rs.next()) {
                found = true;
                String title = rs.getString("title");
                String artist = rs.getString("artist");
                String img = rs.getString("image_url");
                String url = rs.getString("song_url");
                String duration = rs.getString("duration"); // Uses DB column
                int id = rs.getInt("song_id");

                // Fallbacks
                if(duration == null) duration = "--:--";
                if(img == null || img.isEmpty()) img = "logo.svg"; 
                else if (!img.startsWith("http")) img = "https://i.scdn.co/image/" + img;
%>
                <div class="song-row playlist-track" 
                     data-song-url="<%= url %>" 
                     data-title="<%= title %>" 
                     data-artist="<%= artist %>" 
                     data-img="<%= img %>"
                     data-song-id="<%= id %>">
                     
                    <div class="col-hash"><%= count++ %></div>
                    
                    <div class="col-title">
                        <img src="<%= img %>" alt="Art">
                        <div class="song-name-artist">
                            <span class="s-name"><%= title %></span>
                            <span class="s-artist"><%= artist %></span>
                        </div>
                    </div>
                    
                    <div class="col-album"><%= artist %></div>
                    <div class="col-clock"><%= duration %></div>
                </div>
<%
            }
            out.println("</div>"); // End Container

            if(!found) {
                out.println("<h3 style='color:#b3b3b3; padding:20px; font-family: \"Franklin Gothic Medium\", sans-serif;'>No matches found for \"" + query + "\"</h3>");
            }
            conn.close();
        } catch (Exception e) {
            out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
        }
    }
%>