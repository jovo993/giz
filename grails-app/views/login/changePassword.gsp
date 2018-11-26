<html>
<head>
    <meta name='layout' content='main'/>
    <style type='text/css' media='screen'>
    #login {
        margin: 15px 0px;
        padding: 0px;
        text-align: center;
    }

    #login .inner {
        width: 560px;
        padding-bottom: 6px;
        margin: 60px auto;
        text-align: left;
        border: 1px solid #aab;
        background-color: #f0f0fa;
        -moz-box-shadow: 2px 2px 2px #eee;
        -webkit-box-shadow: 2px 2px 2px #eee;
        -khtml-box-shadow: 2px 2px 2px #eee;
        box-shadow: 2px 2px 2px #eee;
    }

    #login .inner .fheader {
        padding: 18px 26px 14px 26px;
        background-color: #f7f7ff;
        margin: 0px 0 14px 0;
        color: #2e3741;
        font-size: 18px;
        font-weight: bold;
    }

    #login .inner .cssform p {
        clear: left;
        margin: 0;
        padding: 4px 0 3px 0;
        padding-left: 105px;
        margin-bottom: 20px;
        height: 1%;
    }

    #login .inner .cssform input[type='text'] {
        width: 300px;
    }

    #login .inner .cssform label {
        font-weight: bold;
        float: left;
        text-align: right;
        margin-left: -105px;
        width: 200px;
        padding-top: 3px;
        padding-right: 10px;
    }

    #login #remember_me_holder {
        padding-left: 120px;
    }

    #login #submit {
        margin-left: 110px;
    }

    #login #remember_me_holder label {
        float: none;
        margin-left: 0;
        text-align: left;
        width: 200px
    }

    #login .inner .login_message {
        padding: 6px 25px 20px 25px;
        color: #c33;
    }

    #login .inner .text_ {
        width: 300px;
    }

    #login .inner .chk {
        height: 12px;
    }
    </style>
</head>

<body>
<div id='login'>
    <div class='inner'>
        <div class='fheader'><g:message code='changepassword.naslov'/></div>
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${this.changePasswordDTO}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.changePasswordDTO}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
        </g:hasErrors>
        <g:form controller='login' method = 'post' class='cssform' autocomplete='off'>
            <p>
                <label for='password'><g:message code='changepassword.staralozinka'/></label>
                <g:passwordField name='password' class='text_' id='password' />
            </p>
            <p>
                <label for='password'><g:message code='changepassword.novalozinka'/></label>
                <g:passwordField name='newPassword' class='text_' />
            </p>
            <p>
                <label for='password' ><g:message code='changepassword.ponovo'/></label>
                <g:passwordField name='confirmNewPassword' class='text_' />
            </p>
                <g:actionSubmit id='submit' resource="${this.changePasswordDTO}" action="updatePassword" value="${message(code: 'giz.changePassword.saveButton', default: 'Save')}" style="width: 20%"/>
        </g:form>
    </div>
</div>
<script type='text/javascript'>
    (function() {
        document.forms[0].elements['password'].focus();
    })();
</script>
</body>
</html>
