<%@tag description="Overall site template" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@attribute name="title" fragment="true" %>
<%@attribute name="header" fragment="true" %>
<!doctype html>
<html>
	<head>
		<title><jsp:invoke fragment="title"/></title>
		<meta charset="utf-8" />
		
		<!-- Stylesheets -->
		<link rel="stylesheet" href="<c:url value="/resources/css/reset.css" />" />
		<link rel="stylesheet" href="<c:url value="/resources/css/screen.css" />" />
		
		<!-- Scripts -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js"></script>
		
		<jsp:invoke fragment="header"/>
	
		<!--[if IE 6]>
		<script src="<c:url value="/resources/js/DD_belatedPNG_0.0.8a-min.js" />"></script>
		<script>
		  /* EXAMPLE */
		  DD_belatedPNG.fix('.button');
		  
		  /* string argument can be any CSS selector */
		  /* .png_bg example is unnecessary */
		  /* change it to what suits you! */
		</script>
		<![endif]-->
	</head>
	<body>
		<jsp:doBody/>
		
		<script>
		    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
		
		    ga('create', 'UA-42864823-2', 'granth.am');
		    ga('send', 'pageview');
		</script>
	</body>
</html>