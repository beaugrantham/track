<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page session="false" %>

<t:site>
	<jsp:attribute name="title">Beau Grantham | Track</jsp:attribute>

	<jsp:attribute name="header">
		<script src="<c:url value="/resources/js/jquery.roundabout-1.0.min.js" />"></script> 
		<script src="<c:url value="/resources/js/jquery.easing.1.3.js" />"></script>
		<script>		
			$(document).ready(function() { //Start up our Featured Project Carosuel
				$('#featured ul').roundabout({
					easing: 'easeOutInCirc',
					duration: 600
				});
			});
		</script>
	</jsp:attribute>

	<jsp:body>
		<div id="wrapper" class="container_12 clearfix">
	
			<!-- Text Logo -->
			<h1 id="logo" class="grid_4"><a href="<c:url value="/" />" style="color: #000000;">track</a></h1>
			
			<!-- Navigation Menu -->
			<ul id="navigation" class="grid_8">
				<li><a href="<c:url value="/trips" />"><span class="meta">Past adventures</span><br />Trips</a></li>
				<li><a href="<c:url value="/" />" class="current"><span class="meta">Homepage&nbsp;&nbsp;</span><br />Home</a></li>
			</ul>
			
			<div class="hr grid_12">&nbsp;</div>
			<div class="clear"></div>
			
			<!-- Featured Image Slider -->
			<div id="featured" class="clearfix grid_12">
				<ul> 
					<c:forEach var="trip" items="${trips}">
						<li>
							<a href="<c:url value="/trips/${trip.slug}" />">
								<span><c:out value="${trip.name}" /></span>
								<img src="<c:url value="/trips/${trip.slug}.jpg" />" alt="" />
							</a>
						</li>  
					</c:forEach>
				</ul> 
			</div>
			<div class="hr grid_12 clearfix">&nbsp;</div>
				
			<!-- Caption Line -->
			<h2 class="grid_12 caption clearfix" style="text-align: center;">Welcome! This is where you can follow Beau Grantham on his travel adventures.</h2>
			<div class="hr grid_12 clearfix">&nbsp;</div>
			
			<!-- Section 3 -->
			<div class="catagory_1 clearfix">
				<!-- Row 1 -->
				<div class="grid_3 textright" >
					<span class="meta"><c:out value="${category.keywords}" /></span>
					<h4 class="title "><c:out value="${category.title}" /></h4>
					<div class="hr clearfix dotted">&nbsp;</div>
					<p><c:out value="${category.description}" /></p>
				</div>
				<div class="grid_9">
					<c:forEach var="trip" items="${trips}" varStatus="status">
                        <c:if test="${status.index % 3 == 0}"><br /></c:if>
						<a class="portfolio_item float alpha" href="<c:url value="/trips/${trip.slug}" />">
							<span><c:out value="${trip.shortName}" /></span>
							<img class="" src="<c:url value="/trips/${trip.slug}.jpg" />"  alt=""/>
						</a>
					</c:forEach>
				</div>
			</div>
	
			<div class="hr grid_12 clearfix quicknavhr">&nbsp;</div>
	
			<div class="hr grid_12 clearfix">&nbsp;</div>
			<!-- Footer -->
	        <p class="grid_12 footer clearfix">
				<!-- <span class="float"><b>&copy; Copyright</b> <a href="">QwibbleDesigns</a> - remove upon purchase.</span> -->
				<span class="float"><b>&copy; Copyright</b> <a href="http://www.granth.am/">Beau Grantham (granth.am)</a>.</span>
				<a class="float right" href="#">top</a>
			</p>
	
		</div><!--end wrapper-->
	</jsp:body>
</t:site>