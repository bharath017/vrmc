<%@ include file="Session.jsp" %>
<!DOCTYPE html>
<html>
    
<!-- Mirrored from coderthemes.com/highdmin/horizontal/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 18 Mar 2018 15:53:37 GMT -->
<head>
        <meta charset="utf-8" />
        <title>Follow Up Report ${initParam.company_name}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">

        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />

        <script src="assets/js/modernizr.min.js"></script>

    </head>

    <body>

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
                                    <li class="breadcrumb-item"><a href="#">Customer &amp; PO</a></li>
                                    <li class="breadcrumb-item active">Follow Up Report</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Follow Up Report</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
				
                <div class="row">
                    <div class="col-12">
                        <div class="card-box">
                        	${result}
                        	<c:remove var="result"/>
							<div class="text-center mt-4 mb-4">
							
								<br>
								
                                <div class="row">
                                
                                <sql:query var="leave" dataSource="jdbc/rmc">
                               		SELECT count(e.follow_up_report_id) as count FROM follow_up_report e WHERE e.status="active" and e.date < CURRENT_DATE
								</sql:query>	
								
									<c:forEach var="leave" items="${leave.rows}">                                
                                     <div class="col-xs-6 col-sm-3">
                                    	<a href="PendingList.jsp?status=pending">
                                        <div class="card-box bg-primary widget-flat border-primary text-white">
                                            <i class="fi-archive"></i>
                                            <h3 class="m-b-10">Pending Report</h3>
                                            <p class="text-uppercase m-b-5 font-13 font-600">${(empty leave.count) ? 0:leave.count}</p>
                                        </div>
                           				</a>             
                                    </div>
                                    </c:forEach>
                                    
                                <sql:query var="resignaion" dataSource="jdbc/rmc">
                               		SELECT count(e.follow_up_report_id) as count FROM follow_up_report e WHERE e.status="active"  and e.date=CURRENT_DATE
								</sql:query>
								
                                    <c:forEach var="resignaion" items="${resignaion.rows}"> 
                                    <div class="col-xs-6 col-sm-3">
                                    	<a href="PendingList.jsp?status=active">
                                        <div class="card-box widget-flat border-success bg-success text-white">
                                            <i class="fi-help"></i>
                                            <h3 class="m-b-10">Active Report</h3>
                                            <p class="text-uppercase m-b-5 font-13 font-600">${(empty resignaion.count) ? 0:resignaion.count}</p>
                                        </div>
                                        </a>
                                    </div>
                                   </c:forEach> 
                                    
<!--                                     <div class="col-xs-6 col-sm-3"> -->
<!--                                     	<a href="paySlip.jsp"> -->
<!--                                         <div class="card-box widget-flat border-custom bg-custom text-white"> -->
<!--                                             <i class=" fa fa-money"></i> -->
<!--                                             <h3 class="m-b-10">PAYSLIP</h3> -->
<!--                                             <p class="text-uppercase m-b-5 font-13 font-600">GET YOUR PAYSLIP HERE</p> -->
<!--                                         </div> -->
<!--                                         </a> -->
<!--                                     </div> -->
                                <sql:query var="reliving" dataSource="jdbc/rmc">
                               		SELECT count(e.follow_up_report_id) as count FROM follow_up_report e WHERE e.status="approved" 
								</sql:query>
                                  
                                  <c:forEach var="reliving" items="${reliving.rows}">   
                                    <div class="col-xs-6 col-sm-3">
                                    	<a href="PendingList.jsp?status=approved">
                                        <div class="card-box widget-flat border-custom bg-custom text-white">
                                            <i class=" fa fa-money"></i>
                                            <h3 class="m-b-10">Approved Report</h3>
                                            <p class="text-uppercase m-b-5 font-13 font-600">${(empty reliving.count) ? 0:reliving.count}</p>
                                        </div>
                                        </a>
                                    </div>
                                   </c:forEach>
                                   
                                <sql:query var="hike" dataSource="jdbc/rmc">
                                SELECT count(e.follow_up_report_id) as count FROM follow_up_report e WHERE e.status="pending"
                               		
								</sql:query>
                                    
                                   <c:forEach var="hike" items="${hike.rows}">  
                                    <div class="col-xs-6 col-sm-3">
                                    	<a href="HikeLetterList.jsp">
                                        <div class="card-box widget-flat border-custom bg-custom text-white">
                                            <i class=" fa fa-money"></i>
                                            <h3 class="m-b-10">Credit Pending Report</h3>
                                            <p class="text-uppercase m-b-5 font-13 font-600">${(empty hike.count) ? 0:hike.count}</p>
                                        </div>
                                        </a>
                                    </div>
                                   </c:forEach>
                                    
                                </div>
                            </div>
                            
                            <!-- end row -->
                        </div>
                    </div>
                </div>
                <!-- end row -->

            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->

		<%-- <div>
			<form action="AttendanceController?action=CheckInOut" method="post" id="ClockInOut-form">
				<input type="hidden" name="e_id" value="${bean.user_id}"/>
				<input type="hidden" name="longitude" id="longitude"/>
				<input type="hidden" name="latitude" id="latitude"/>
				<c:choose>
					<c:when test="${attcount>0}">
						<input type="hidden" name="status" id="status" value="out"/>
					</c:when>
					<c:when test="${attcount==0}">
						<input type="hidden" name="status" id="status" value="in"/>
					</c:when>
				</c:choose>
				
			</form>
		</div> --%>
		<div id="map"></div>
		
		
        <!-- Footer -->
       <!-- PUT HEADER.JSP HERE -->
       <%@ include file="footer.jsp" %>
        <!-- End Footer -->

<!-- SELECT count(hike_id) as count FROM hike_letter l,reporting_manager r WHERE l.hike_date=CURRENT_DATE and l.e_id=r.e_id -->
        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>

        <!-- Flot chart -->
        <script src="plugins/flot-chart/jquery.flot.min.js"></script>
        <script src="plugins/flot-chart/jquery.flot.time.js"></script>
        <script src="plugins/flot-chart/jquery.flot.tooltip.min.js"></script>
        <script src="plugins/flot-chart/jquery.flot.resize.js"></script>
        <script src="plugins/flot-chart/jquery.flot.pie.js"></script>
        <script src="plugins/flot-chart/jquery.flot.crosshair.js"></script>
        <script src="plugins/flot-chart/curvedLines.js"></script>
        <script src="plugins/flot-chart/jquery.flot.axislabels.js"></script>

        <!-- KNOB JS -->
        <!--[if IE]>
        <script type="text/javascript" src="../plugins/jquery-knob/excanvas.js"></script>
        <![endif]-->
        <script src="plugins/jquery-knob/jquery.knob.js"></script>
        <!-- Dashboard Init -->
        <script src="assets/pages/jquery.dashboard.init.js"></script>
        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC6EUUQ9DSc3iyu0uNEcTYTYJbX-K5XA3Q&callback=initMap"
    async defer></script>
       <script type="text/javascript">
    // Note: This example requires that you consent to location sharing when
       // prompted by your browser. If you see the error "The Geolocation service
       // failed.", it means you probably did not give permission for the browser to
       // locate you.
       var map, infoWindow;
       function initMap() {
         map = new google.maps.Map(document.getElementById('map'), {
           center: {lat: -34.397, lng: 150.644},
           zoom: 10
         });
         infoWindow = new google.maps.InfoWindow;

         // Try HTML5 geolocation.
         if (navigator.geolocation) {
           navigator.geolocation.getCurrentPosition(function(position) {
             var pos = {
               lat: position.coords.latitude,
               lng: position.coords.longitude
             };
             $('#longitude').val(pos.lng);
             $('#latitude').val(pos.lat);
             var marker = new google.maps.Marker({position: pos, map: map});

             //infoWindow.setPosition(pos);
            // infoWindow.setContent('Location found.');
             infoWindow.open(map);
             map.setCenter(pos);
           }, function() {
             handleLocationError(true, infoWindow, map.getCenter());
           });
         } else {
           // Browser doesn't support Geolocation
           handleLocationError(false, infoWindow, map.getCenter());
         }
         
         
       }

       function handleLocationError(browserHasGeolocation, infoWindow, pos) {
         infoWindow.setPosition(pos);
         infoWindow.setContent(browserHasGeolocation ?
                               'Error: The Geolocation service failed.' :
                               'Error: Your browser doesn\'t support geolocation.');
         infoWindow.open(map);
       }
       </script>
       
       <script type="text/javascript">
       		$(document).ready(function(){
       			$('#do-att').on('click',function(){
       				$('#do-att').prop('disabled',true);
       				$('#ClockInOut-form').submit();
       			});
       		});
       </script>
    </body>
</html>