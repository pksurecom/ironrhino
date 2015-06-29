<!DOCTYPE html>
<#escape x as x?html><html>
<head>
<title>${action.getText('login')}</title>
<meta name="body_class" content="welcome" />
<#assign notlogin = false>
<@authorize ifAllGranted="ROLE_BUILTIN_ANONYMOUS">
<#assign notlogin = true>
</@authorize>
<#if !notlogin>
<meta name="decorator" content="simple" />
<meta http-equiv="refresh" content="0; url=<@url value=targetUrl!'/'/>" />
</#if>
</head>
<body>
<#if notlogin>
<div class="row">
	<div class="span6 offset3">
	<h2 class="caption">${action.getText('login')}</h2>
	<div class="hero-unit">
	<@s.form id="login" action="${actionBaseUrl}" method="post" class="ajax focus form-horizontal well">
		<@s.hidden id="targetUrl" name="targetUrl" />
		<@s.textfield label="%{getText('username')}" name="username" class="required span2"/>
		<@s.password label="%{getText('password')}" name="password" class="required span2 input-pattern submit"/>
		<@s.checkbox label="%{getText('rememberme')}" name="rememberme" class="custom"/>
		<@captcha/>
		<@s.submit value="%{getText('login')}" class="btn-primary">
		<#if getSetting??&&'true'==getSetting('signup.enabled')>
		<@s.param name="after"> <a class="btn" href="${getUrl('/signup')}">${action.getText('signup')}</a></@s.param>
		</#if>
		</@s.submit>
	</@s.form>
	</div>
	</div>
</div>
<#if getSetting??&&'true'==getSetting('signup.enabled')&&'true'==getSetting('oauth.enabled')>
<div class="ajaxpanel" data-url="<@url value="/oauth/connect"/>">
</div>
</#if>
<#else>
<div class="modal">
	<div class="modal-body">
		<div class="progress progress-striped active">
			<div class="bar" style="width: 50%;"></div>
		</div>
	</div>
</div>
</#if>
</body>
</html></#escape>
