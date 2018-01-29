<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page session="false" %>

<t:site>
	<jsp:attribute name="title">Beau Grantham | Track | Trips</jsp:attribute>

	<jsp:body>	
		<div id="wrapper" class="container_12 clearfix">
	
			<!-- Text Logo -->
			<h1 id="logo" class="grid_4"><a href="<c:url value="/" />" style="color: #000000;">track</a><!-- | trips--></h1>
			
			<!-- Navigation Menu -->
			<ul id="navigation" class="grid_8">
				<li><a href="<c:url value="/trips" />" class="current"><span class="meta">Past adventures</span><br />Trips</a></li>
				<li><a href="<c:url value="/" />"><span class="meta">Homepage&nbsp;&nbsp;</span><br />Home</a></li>
			</ul>
			
			<div class="hr grid_12 clearfix">&nbsp;</div>
				
			<!-- Catch Line and Link -->
				<h2 class="grid_12 caption clearfix">Past trips and distant adventures.</h2>
			
			<div class="pr grid_12 clearfix">&nbsp;</div>
			
			<!-- Portfolio Items -->
			
			<!-- Section 1 -->
			
			<!-- Section 3 -->
			<div class="catagory_1 clearfix">
				<c:forEach var="category" items="${categoryTripMap}" varStatus="index">
					<!-- Row <c:out value="${index.index + 1}" /> -->
					<div class="grid_3 textright" >
						<span class="meta"><c:out value="${category.key.keywords}" /></span>
						<h4 class="title "><c:out value="${category.key.title}" /></h4>
						<div class="hr clearfix dotted">&nbsp;</div>
						<p><c:out value="${category.key.description}" /></p>
					</div>
					<div class="grid_9">
						<c:forEach var="trip" items="${category.value}" varStatus="status">
                            <c:if test="${status.index % 3 == 0}"><br /></c:if>
							<a class="portfolio_item float alpha" href="<c:url value="/trips/${trip.slug}" />">
								<span><c:out value="${trip.shortName}" /></span>
								<img class="" src="<c:url value="/trips/${trip.slug}.jpg" />"  alt=""/>
							</a>
						</c:forEach>
					</div>

                    <c:if test="${not index.last}">
                        <div class="hr grid_12 dotted clearfix">&nbsp;</div>
                    </c:if>
				</c:forEach>
			</div>
				
	        <div class="hr grid_12 cleanfix quicknavhr">&nbsp;</div>
	        <div class="hr grid_12 clearfix">&nbsp;</div>
			
			<!-- Footer -->
			<p class="grid_12 footer clearfix">
				<span class="float"><b>&copy; Copyright</b> <a href="http://www.granth.am/">Beau Grantham (granth.am)</a></span>
				<a class="float right" href="#">top</a>
			</p>
			
		</div><!--end wrapper-->
	</jsp:body>
</t:site>