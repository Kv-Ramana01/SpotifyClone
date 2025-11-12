<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String username = (String) session.getAttribute("username");
    
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String playlistName = request.getParameter("playlist_name");

    if (playlistName != null && !playlistName.trim().isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spotify_clone", "root", "Charlotte@1707");

           
            int userId = -1;
            String idSql = "SELECT id FROM users WHERE username = ?";
            pstmt = conn.prepareStatement(idSql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            
            if(rs.next()){
                userId = rs.getInt("id");
            }
            pstmt.close(); // Close to reuse

            if (userId != -1) {
                String insertSql = "INSERT INTO PLaylists (user_id, name) VALUES (?, ?)";
                pstmt = conn.prepareStatement(insertSql);
                pstmt.setInt(1, userId);
                pstmt.setString(2, playlistName);
                pstmt.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    }
    response.sendRedirect("index.jsp");
%>