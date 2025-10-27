<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign Up and listen to unlimited music!</title>
    <link rel="stylesheet" href="style.css" />
    <link rel="stylesheet" href="utility.css" />

    <style>
      .signup-container {
        max-width: 100vw;
        height: 100vh;
        max-height: 100vh;
        display: flex;
        flex-direction: column;
        /* justify-content: center; */
        padding: 100px;
        align-items: center;
        background-color: #121212;
        gap: 10px;
      }

      .logo {
        color: white;
        width: 100px;
        height: 100px;
        text-align: center;
        margin-bottom: 20px;
      }

      .heading{
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
        }

        .terms-text {
            font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
            color: #888;
            font-size: 0.9em;
            text-align: center;
        }

        .terms-text a {
            color: white;
            text-decoration: underline;
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
        <h1>Sign Up to start listening.</h1>
      </div>
      <div class="signup-box">
        <form action="signup.jsp" method="post" class="signup-form">
          <label for="username">Username</label>
          <input type="txt" name="username" placeholder="Username" required />

          <label for="email">Email</label>
          <input type="email" name="email" placeholder="Email" required />

          <label for="password">Password</label>
          <input
            type="password"
            name="password"
            placeholder="Password"
            required
          />

          <button type="submit" class="signup-button">Sign Up</button>
        </form>
        <p class="terms-text">
          By signing up, you agree to our <a href="#">Terms & Conditions</a>.
        </p>
        <p class="login-text">
          Already have an account?
        </p>
        <p class="login">
            <a href="login.jsp">Log In</a>
        </p>
      </div>
    </div>
  </body>
</html>
