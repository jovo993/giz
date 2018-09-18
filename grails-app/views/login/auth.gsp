<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title><g:message code='giz.application.title'/></title>
    <style type="text/css" media="screen">

    *, *::before, *::after {
        box-sizing: border-box;
    }

    body {
        background-color: #f6f5f3;
        padding: 40px 0;
        min-height: 100vh;
        color: #536171;
        font-family: sans-serif;
        -webkit-font-smoothing: subpixel-antialiased;
    }

    .fieldset {
        margin: 20px;
        color: #9e9e9e;
        max-width: 100%;
        padding: 16px;
        border: 1px solid #c0d9f7;
        -moz-border-radius: 8px;
        -webkit-border-radius: 8px;
        border-radius: 8px;
    }

    .split {
        height: 100%;
        width: 50%;
        position: fixed;
        z-index: 10;
        top: 0;
        overflow-x: hidden;
        padding-top: 20px;
    }

    .left {
        background-color: #FFFF;
        left: 200px;
    }

    .right {
        background-color: #FFFF;
        right: 200px;
        width: 25%;
    }

    .login-box {
        width: 300px;
        margin: 0 auto;
        background-color: white;
        border-radius: 3px;
        box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.08), inset 0 0 0 1px #DBE3E7;
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

    .links {
        border-radius: 3px;
        display: inline-block;
        line-height: 1;
        text-align: center;
        white-space: nowrap;
        font-size: 16px;
        width: 100%;
        background: #2f5786;
        background-size: 100% 200%;
        border: none;
        color: white;
        font-weight: 400;
        -webkit-appearance: button;
    }

    </style>

</head>

<body>
<div style="width: 1200px; margin: auto;">
    <div class="split left">
        <table>
            <th><h1 style="color: #3d3d3f">Novosti, informacije, obavještenja</h1></th>
            <tbody>
            <g:each in="${clanci}" var="bean" status="i">
                <tr>
                    <td>
                        <fieldset class="fieldset">
                            <legend style="width: 69%; text-align: center; color: #3d3d3f"><h3>${bean.naslov} - ${bean.autor} - <g:formatDate>${bean.datumObjave}</g:formatDate></h3></legend>
                            ${bean.sadrzaj}
                        </fieldset>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="split right">
        <div class="login-box">
            <div class="login-box-inner">
                <span><asset:image src="logo_fond.ico" style="width: 64px"/></span>

                <div class="login-subheadline"><g:message code='giz.application.title'/></div>

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
                        <label for="remember_me" class="login-form-label login-form-label--inline"><g:message code='giz.login.rememberme.label'/></label>
                    </div>

                    <button type="submit" name="login" id="submit" class="login-form-button"><g:message code='giz.login.submit.label'/></button>
                    <g:if test="${flash.message}">
                        <div class="login_message">${flash.message}</div>
                    </g:if>
                </form>
            </div>
        </div>
        <div style="padding-top: 30px; width: 300px; margin: auto;">
            <table class="login-box">
                <th class="links">
                    <h3>Linkovi</h3>
                </th>
                <tr>
                    <td style="padding: 1em;"><a style="color: #3d3d3f" href="http://www.ekofondrs.org/" target="_blank">Fond za zaštitu životne sredine i energetsku efikasnost Republike Srpske</a></td>
                </tr>
                <tr>
                    <td style="padding: 1em;"><a style="color: #3d3d3f" href="http://www.vladars.net/sr-SP-Cyrl/Vlada/Ministarstva/mgr/"
                           target="_blank">Ministarstvo za prostorno uređenje,građevinarstvo i ekologiju Republike Srpske</a></td>
                </tr>
            </table>
        </div>
        <div style="padding-top: 30px; width: 300px; margin: auto;">
            <a href="https://www.accuweat; her.com/sr/ba/banja-luka/35546/weather-forecast/35546" class="aw-widget-legal"></a>

            <div id="awcc1536874518036" class="aw-widget-current" data-locationkey="" data-unit="c" data-language="sr" data-useip="true" data-uid="awcc1536874518036"></div><script
                type="text/javascript" src="https://oap.accuweather.com/launch.js"></script>
        </div>
    </div>
</div>
<script>
  (function() {
    document.forms['loginForm'].elements['${usernameParameter ?: 'username'}'].focus();
  })();
</script>
</body>
</html>
