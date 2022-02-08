<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>BUILD RMC LOGIN</title>
	<link rel="stylesheet" href="assets/css/auth.css">
	<link rel="shortcut icon" href="assets/images/favicon.ico">
</head>

<body style="background-image: url('image/login.jpg');">
	<div class="lowin">
		<div class="lowin-brand">
			<h2 style="color:#3259e5;"><b>BUILD RMC</b></h2>
		</div>
		<div class="lowin-wrapper">
			<div class="lowin-box lowin-login">
				<div class="lowin-box-inner">
					<form action="LoginController?button=login" method="post">
						<p style="font-size: 18px;">${initParam.company_name}</p>
						<div class="lowin-group">
							<label>Username <a href="#" class="login-back-link">Sign in?</a></label>
							<input type="email" required="required" autocomplete="username" name="username" class="lowin-input" style="font-weight: bold;">
						</div>
						<div class="lowin-group password-group">
							<label>Password <a href="#" class="foargot-link">Forgot Password?</a></label>
							<input type="password" required="required" name="password" autocomplete="current-password" class="lowin-input">
						</div>
						<button type="submit" class="lowin-btn">
							Sign In
						</button>

						<div class="text-foot">
							<span style="color: red;">${error}</span>
							<c:remove var="error"/>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script src="assets/js/auth.js"></script>
</body>
</html>