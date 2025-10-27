<%
    session.invalidate(); // this will destroy the user session
    response.sendRedirect("index.jsp"); 
%>