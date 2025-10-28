<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="java.nio.charset.StandardCharsets" %>

<%!
    // --- DECLARATION BLOCK ---
    // This MUST be the *exact same function* as in your signup.jsp
    // to ensure the hashes match.
    public String hashPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
        BigInteger number = new BigInteger(1, hash);
        StringBuilder hexString = new StringBuilder(number.toString(16));
        
        while (hexString.length() < 64) {
            hexString.insert(0, '0');
        }
        return hexString.toString();
    }
%>

<% 
    if(request.getMethod().equalsIgnoreCase("POST")){

        String dbUrl = "jdbc:mysql://localhost:3306/spotify_clone";
        String dbUser = "root";
        String dbPass = "Charlotte@1707";

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String hashedPasswordAttempt = hashPassword(password);

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(dbUrl,dbUser,dbPass);

            String sql = "SELECT * FROM users WHERE username = ?";

            ps = con.prepareStatement(sql);
            ps.setString(1,username);

            rs = ps.executeQuery();

            if(rs.next()){
                //means user exists

                String storedHashedPassword = rs.getString("password_hash");

                if(storedHashedPassword.equals(hashedPasswordAttempt)){
                    //if password matches we create a session and store their info

                    session.setAttribute("username",username);
                    session.setAttribute("user_id",rs.getInt("id"));

                    response.sendRedirect("index.jsp");
                }else{
                    out.println("<script>alert('Incorrect password.')</script>");
                }
            }else{
                out.println("<script>alert('Incorrect username or password.');</script>");
            }

        }catch(Exception e){
            out.println("<script>alert('An error occured: "+ e.getMessage()+ "');</script>");
            e.printStackTrace();
        }finally{
            if(con!=null) {try{ con.close(); }catch (SQLException e){}}
            if(rs!=null) {try{ rs.close(); }catch (SQLException e){}}
            if(ps!=null) {try{ ps.close(); }catch (SQLException e){}}
        }
    }


%>



<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Log in to Spotify</title>
    <!-- <link rel="stylesheet" href="style.css" /> -->
    <link rel="stylesheet" href="utility.css" />

    <style>
        
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box ;
        }
      .signup-container {
        width: 100%;
        min-height: 100vh;
        /* max-height: 100%; */
        display: flex;
        padding: 20px 20px;
        flex-direction: column;
        /* justify-content: center; */
        /* padding: 100px; */
        align-items: center;
        background-color: #121212;
        gap: 10px;
        box-sizing: border-box;
      }
      .logo {
        color: white;
        width: 100px;
        height: 100px;
        text-align: center;
        margin-bottom: 20px;
      }
      .heading {
        display: flex;
        justify-content: center;
        align-items: center;
        text-align: center;
        flex-wrap: wrap;
        width: 400px;
      }
      .heading h1 {
        font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
        color: white;
        font-size: 3.5em;
        font-weight: 1000;
      }
      .signup-form {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        gap: 15px;
        width: 380px;
      }
      .signup-box {
        display: flex;
        width: auto;
        flex-direction: column;
        align-items: center;
        padding: 40px;
        gap: 20px;
      }
      .signup-form label {
        font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
        color: white;
        font-size: 1.3em;
        font-weight: 600;
        margin-right: auto;
      }
      .signup-form input {
            padding: 10px;
            border-radius: 5px;
            border: 2px solid transparent;
            outline: 1px solid #888;
            background-color: #121212;
            width: 380px;
            height: 50px;
            color: white;
      }
      .signup-form button {
            padding: 10px;
            border-radius: 20px;
            background-color: rgb(57, 235, 66);
            color: black;
            font-weight: 800;
            font-size: 1.2em;
            width: 200px;
            height: 50px;
            cursor: pointer;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
      }

      .signup-form button:hover{
        transform: scale(1.07);
      }

      .login-text {
            font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
            color: #888;
            font-size: 1em;
            text-align: center;
      }
      .login a {
            font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
            color: white;
            font-size: 1em;
            text-align: center;
            text-decoration: underline;
            cursor: pointer;
      }
    </style>
  </head>
  <body>
    <div class="signup-container">
      <div class="logo">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 168 168"
          width="50"
          height="50"
          fill="currentColor"
          role="img"
          aria-hidden="true"
        >
          <path
            d="M84 0C37.6 0 0 37.6 0 84s37.6 84 84 84 84-37.6 84-84S130.4 0 84 0zm38.8 121.6c-1.6 2.6-4.8 3.4-7.4 1.8-20.2-12.4-45.6-15.2-75.6-8.4-3 0.6-5.8-1.4-6.4-4.4s1.4-5.8 4.4-6.4c33-7 61.2-4 84 9 2.6 1.6 3.4 4.8 1.8 7.4zm10.2-20.6c-1.8 2.8-5.2 3.6-8 1.8-23.2-14-58.4-18-85.2-9.8-3 0.8-6.2-0.8-7-3.8s0.8-6.2 3.8-7c29.2-8.4 66-4.2 91 11.2 2.8 1.6 3.6 5.2 1.8 8zm0-20.6c-27-16-71.6-17.4-96-9-3.6 1.2-7.4-0.8-8.6-4.4s0.8-7.4 4.4-8.6c27.2-8.6 74-6.6 103.6 11.4 3.2 1.8 4 6 2.2 8.8z"
          />
        </svg>
      </div>

      <div class="heading">
        <h1>Log in to your account.</h1>
      </div>
      <div class="signup-box">
        <form action="login.jsp" method="post" class="signup-form">
          <label for="username">Username</label>
          <input type="text" name="username" placeholder="Username" required />

          <label for="password">Password</label>
          <input
            type="password"
            name="password"
            placeholder="Password"
            required
          />

          <button type="submit" class="signup-button">Log In</button>
        </form>
        
        <p class="login-text">
          Don't have an account?
        </p>
        <p class="login">
            <a href="signup.jsp">Sign up</a>
        </p>
      </div>
    </div>
  </body>
</html>