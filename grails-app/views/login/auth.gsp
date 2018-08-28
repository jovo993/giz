<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title></title>
  <style type="text/css" media="screen">

  *, *::before, *::after {
    box-sizing: border-box;
  }

  body {
    background-color: #F7F9FA;
    padding: 40px 0;
    min-height: 100vh;
    color: #536171;
    font-family: sans-serif;
    -webkit-font-smoothing: subpixel-antialiased;
  }

  .login-box {
    width: 500px;
    margin: 0 auto;
    background-color: white;
    border-radius: 3px;
    box-shadow: 0 1px 2px 0 rgba(0,0,0,0.08), inset 0 0 0 1px #DBE3E7;
    color: #536171;
    display: block;
    position: relative;
  }

  .login-box-inner {
    padding: 40px 40px 30px;
  }

  .login-message {
    background-color: #fef8c1;
    border: 1px solid #f7e7b7;
    border-radius: 3px;
    color: #76674E;
    display: block;
    font-size: 14px;
    line-height: 1.5;
    padding: 8px 10px;
    margin: 0 0 30px 0;
  }

  .login-form-item {
    margin-bottom: 20px;
    position: relative;
  }

  .login-title {
    text-align: center;
    margin: 40px auto;
  }

  .login-headline {
    font-size: 40px;
    line-height: 1.2;
    font-weight: 500;
    color: #2A3039;
    margin: 0;
  }

  .login-subheadline {
    color: #8091A5;
    font-weight: 500;
    line-height: 1.4;
    font-size: 20px;
    margin-bottom: 30px;
  }

  .login-form-label {
    color: #2A3039;
    display: block;
    font-weight: 300;
    position: relative;
    height: 20px;
    margin-bottom: 10px;
  }

  .login-form-label--inline {
    display: inline;
    font-weight: 300;
  }

  .login-form-input {
    background-color: #F7F9FA;
    border: 1px solid #DBE3E7;
    border-radius: 3px;
    color: #536171;
    display: block;
    font-size: 14px;
    width: 100%;
    height: 38px;
    padding: 0 10px;
    margin-bottom: 10px;
  }

  .login-form-button {
    border-radius: 3px;
    cursor: pointer;
    display: inline-block;
    line-height: 1;
    text-align: center;
    white-space: nowrap;
    font-size: 16px;
    padding: 12px 18px;
    width: 100%;
    background: #2f5786;
    background-size: 100% 200%;
    border: none;
    color: white;
    font-weight: 400;
    -webkit-appearance: button;
  }

  .login-form-button:hover {
    background-position: 0 100%;
  }

  .login-form-button:active {
    -webkit-transform: translateY(1px);
    transform: translateY(1px);
  }
  </style>
</head>

<body>
<div class="login-title">
  <i class="fa grails-icon">
    <asset:image src="logo_fond.png"/>
  </i>
  <h1 class="login-headline">rODS - Registar operatora, distributera i snabdjevača energijom</h1>
</div>
<div class="login-box">
  <div class="login-box-inner">
    <div class="login-subheadline"></div>

    <form action="${postUrl ?: '/login/authenticate'}" method="POST" autocomplete="off">
      <div class="login-form-item">
        <label for="username" class="login-form-label"><g:message code='giz.login.usename.label'/>:</label>
        <input type="text" name="${usernameParameter ?: 'username'}" id="username" autofocus="autofocus" class="login-form-input"/>
      </div>

      <div class="login-form-item">
        <label for="password" class="login-form-label"><g:message code='giz.login.password.label'/>:</label>
        <input type="password" name="${passwordParameter ?: 'password'}" id="password" class="login-form-input"/>
      </div>

      <div class="login-form-item">
        <input type="checkbox" name="remember_me" id="remember_me"/>
        <label for="remember_me"class="login-form-label login-form-label--inline"><g:message code='giz.login.rememberme.label'/></label>
      </div>

      <button type="submit" name="login" id="submit" class="login-form-button"><g:message code='giz.login.submit.label'/></button>
      <g:if test="${flash.message}">
        <div class="login_message">${flash.message}</div>
      </g:if>
    </form>
  </div>
</div>
<script>

  (function() {
    document.forms['loginForm'].elements['${usernameParameter ?: 'username'}'].focus();
  })();
</script>
</body>
</html>
