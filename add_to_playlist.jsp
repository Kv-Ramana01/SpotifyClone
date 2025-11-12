<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String songId = request.getParameter("song_id");
    String playlistId = request.getParameter("playlist_id");

    if(songId != null && playlistId != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spotify_clone", "root", "Charlotte@1707");
            
            // Insert into Playlist_Songs
            // We use IGNORE so if the song is already there, it doesn't crash
            String sql = "INSERT IGNORE INTO Playlist_Songs (playlist_id, song_id) VALUES (?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(playlistId));
            pstmt.setInt(2, Integer.parseInt(songId));
            
            int rows = pstmt.executeUpdate();
            
            if(rows > 0) {
                out.print("success");
            } else {
                out.print("exists"); // Song was already in playlist
            }

        } catch(Exception e) {
            e.printStackTrace();
            out.print("error: " + e.getMessage());
        } finally {
            if(pstmt != null) try { pstmt.close(); } catch(SQLException e){}
            if(conn != null) try { conn.close(); } catch(SQLException e){}
        }
    } else {
        out.print("missing_params");
    }
%>