<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html ng-app="myApp">
<head>
        <meta charset="utf-8" />
        <title>Track Vehicle</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">
        <script type="text/javascript" src="angular/angular.min.js"></script>

        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />

        <script src="assets/js/modernizr.min.js"></script>

    </head>

    <body ng-controller="myController">

        <!-- Navigation Bar-->
       	<!-- PUT HEADER.JSP HERE -->
       <%@ include file="header.jsp" %>
        <!-- End Navigation Bar-->


        <div class="wrapper">
            <div class="container-fluid">

                <!-- Page-Title -->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="page-title-box">
                            <div class="btn-group pull-right">
                                <ol class="breadcrumb hide-phone p-0 m-0">
                                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                                    <li class="breadcrumb-item"><a href="#">Vehicle &amp; Driver</a></li>
                                    <li class="breadcrumb-item"><a href="#">Track Vehicle</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Track Vehicles</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

				<sql:query var="in" dataSource="jdbc/rmc">
					select longitude,latitude from employee_attendance where attendance_date=? and e_id=? and status='in'
					<sql:param value="${param.attendance_date}"/>
					<sql:param value="${param.e_id}"/>
				</sql:query>
				
				<sql:query var="out" dataSource="jdbc/rmc">
					select longitude,latitude from employee_attendance where attendance_date=? and e_id=? and status='out'
					<sql:param value="${param.attendance_date}"/>
					<sql:param value="${param.e_id}"/>
				</sql:query>
				
                <div class="row">
                    <div class="col-md-12">
                        <div class="card-box">
                        	<div class="text-center">
                        		<input type="hidden" id="type" value="${param.type}"/>
                        		<c:forEach items="${in.rows}" var="in">
									<a class="btn ${(param.type=='in')?'btn-primary':'btn-danger'}" href="Locate.jsp?attendance_date=${param.attendance_date}&e_id=${param.e_id}&type=in" id="in">Clock In</a> 
									<input type="hidden" id="in-longitude" value="${in.longitude}"/>                       			
									<input type="hidden" id="in-latitude" value="${in.latitude}"/>
                        		</c:forEach>
                        		
                        		<c:forEach items="${out.rows}" var="out">
									<a class="btn ${(param.type=='out')?'btn-primary':'btn-danger'}" href="Locate.jsp?attendance_date=${param.attendance_date}&e_id=${param.e_id}&type=out" id="out">Clock Out</a> 
									<input type="hidden" id="out-longitude" value="${out.longitude}"/>                       			
									<input type="hidden" id="out-latitude" value="${out.latitude}"/>
                        		</c:forEach>
                        	</div>
                            <h4 class="mb-3 header-title">TRACK VEHICLE</h4>
                            <div id="map" style="height: 600px;" class="gmaps"></div>
                            <input type="hidden" ng-model="att_id" value="3"  id="attendance_id" ng-init="getData(${param.attendance_id})"/>
                        </div>
                    </div>
                </div>

                
                <!-- end row -->

            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->


        <!-- Footer -->
        <%@ include file="footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC6EUUQ9DSc3iyu0uNEcTYTYJbX-K5XA3Q&callback=initMap"
    	async defer></script>
    
    	<script type="text/javascript">
    	function initMap() {
    		  // The location of Uluru
    		  var type=$('#type').val();
    		  var longitude=parseFloat($('#'+type+'-longitude').val());
    		  var latitude=parseFloat($('#'+type+'-latitude').val());
    		  var pos = {
    	               lat: latitude,
    	               lng: longitude
    	      
    		  };
    		  var marker = new google.maps.Marker({position: pos, map: map});
    		  var map = new google.maps.Map(
    		      document.getElementById('map'), {zoom: 12, center: pos});
    		  // The marker, positioned at Uluru
    		  var marker = new google.maps.Marker({position: pos, map: map});
    	}
    	</script>
        
        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
    </body>
</html>