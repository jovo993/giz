<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title><g:message code='giz.application.title'/></title>
    <asset:link rel="icon" href="logo_fond.ico" type="image/x-ico"/>
    <style type="text/css" media="screen">

    body {
        background: url("/assets/bulb.jpg");
        background-size: cover;
        font-family: sans-serif;
        -webkit-font-smoothing: subpixel-antialiased;
    }

    .fieldset {
        margin: 1%;
        color: #9e9e9e;
        max-width: 100%;
        padding: 16px;
        border: 1px solid #c0d9f7;
        -moz-border-radius: 8px;
        -webkit-border-radius: 8px;
        border-radius: 8px;
    }

    .column {
        position: relative;
        float: left;
        background-color: transparent;
        height: 100%;
    }

    .left {
        width: 95%;
        position: absolute;
    }

    .right {
        width: 20%;
    }

    .login-box {
        width: 100%;
        margin: 0 auto;
        background-color: white;
        border-radius: 3px;
        box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.08), inset 0 0 0 1px #DBE3E7;
        color: #536171;
        position: relative;
    }

    .login-box-inner {
        padding: 20px 40px 30px;
    }

    .login-form-item {
        margin-bottom: 20px;
        position: relative;
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
<div style="width: 1800px; margin: auto;">
    <div class="row">
        <div class="column left">
            <h2 style="color: whitesmoke; text-align: center" >Novosti, informacije, obavještenja</h2>
            <table style="margin-left: 30%">
                <tbody>
                <g:each in="${clanci}" var="bean">
                    <tr>
                        <td>
                            <fieldset class="fieldset" style="background-color: #ebf4f9; color: #3d3d3f; text-align: justify;">
                                <legend style="padding-top: 20px; width: 69%; text-align: center; color: #3d3d3f"><h3>${bean.naslov} - ${bean.autor} - <g:formatDate>${bean.datumObjave}</g:formatDate></h3>
                                </legend>
                                <span style="color: black; font-family: Helvetica">${bean.sadrzaj}</span>
                            </fieldset>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <div class="column right">
            <div style="padding-top: 30px; margin: auto;">
                <div class="login-box">
                    <div class="login-box-inner">
                        <span style="text-align: center"><asset:image src="logo_fond.ico" style="width: 64px"/></span>

                        <form action="${postUrl ?: '/login/authenticate'}" method="POST" autocomplete="off">
                            <div class="login-form-item">
                                <label for="username" class="login-form-label"><g:message code='giz.login.username.label'/>:</label>
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
            </div>

            <div style="padding-top: 30px; margin: auto;">
                <table class="login-box">
                    <th class="links">
                        <h3>O aplikaciji</h3>
                    </th>
                    <tr>
                        <td style="padding: 1em;">Web aplikacija "rODS - Registar operatora, distributera i snabdjevača energijom" realizovana je uz pomoć Njemačke organizacije za međunarodnu saradnju GIZ.</td>
                    </tr>
                    <tr>
                        <td style="padding: 1em;"><asset:image src="giz-saradnja.png" style="width: 100%"/></td>
                    </tr>
                </table>
            </div>

            <div style="padding-top: 30px; margin: auto;">
                <table class="login-box">
                    <th class="links">
                        <h3>Linkovi</h3>
                    </th>
                    <tr>
                        <td style="padding: 1em;"><a style="color: #3d3d3f" href="http://www.ekofondrs.org/"
                                                     target="_blank">Fond za zaštitu životne sredine i energetsku efikasnost Republike Srpske</a></td>
                    </tr>
                    <tr>
                        <td style="padding: 1em;"><a style="color: #3d3d3f" href="http://www.vladars.net/sr-SP-Cyrl/Vlada/Ministarstva/mgr/"
                                                     target="_blank">Ministarstvo za prostorno uređenje,građevinarstvo i ekologiju Republike Srpske</a></td>
                    </tr>
                </table>
            </div>
        </div>
        <script>
          (function() {
            document.forms['loginForm'].elements['${usernameParameter ?: 'username'}'].focus();
          })();
        </script>
    </div>
</div>
</body>
</html>
