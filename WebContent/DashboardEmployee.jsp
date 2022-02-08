<%@ include file="Session.jsp" %>
<!DOCTYPE html>
<html>
    
<!-- Mirrored from coderthemes.com/highdmin/horizontal/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 18 Mar 2018 15:53:37 GMT -->
<head>
        <meta charset="utf-8" />
        <title>Dashboard-${initParam.company_name}</title>
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
                                    <li class="breadcrumb-item"><a href="#">Build RMC</a></li>
                                    <li class="breadcrumb-item active">Employee Menu</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Main Menu</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
				
				
				
				
				
				
				
				
				
				   <div class="row">
                    <div class="col-lg-8">
                        <div class="card-box">
                            <h4 class="header-title">TODAY SALES VISIT</h4>
							<div class="table-responsive">
                            <table id="example" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                                <thead>
	                                <tr style="background-color: #26c9e2;color: white;">
										<th class="text-center">Client Name</th>
										<th class="text-center">Time</th>
										<th class="text-center">Description</th>
										<th class="text-center">Comment</th>
										<th class="text-center">Amount</th>
										<th class="text-center">Status</th>
									</tr>
                                </thead>
                                
								<sql:query var="sch" dataSource="jdbc/rmc">
									select f.*,m.mp_name from follow_up_report f left join ( marketing_person m) on f.user_id=m.mp_id where f.user_id=? and date=curdate() order by follow_up_report_id desc
									<sql:param value="${bean.user_id}"/>
								
								</sql:query>
                                <tbody>
                                <c:forEach var="sch" items="${sch.rows}">
									<tr>
										<td class="text-center">${sch.mp_name}</td>
										<td class="text-center">${sch.client}</td>
										<td class="text-center">
											${sch.time}
										</td>
										<td class="text-center">
											${sch.description}
										</td>
										<td class="text-center">
											${sch.comment}
										</td>
										<td class="text-center">
											${sch.amount}
										</td>
										<td class="text-center">
											${sch.status}
										</td>
									</tr>
									</c:forEach>
                                </tbody>
                            </table>
                            </div>
                        </div>
                    </div>

<c:choose>
<c:when test="${bean.usertype=='marketing_head'}">

                    <div class="col-lg-4">
                        <div class="card-box">
                            <h4 class="header-title">Your Team</h4>
							<div class="table-responsive">
                             	<table class="table table-hover table-centered m-0" id="invoictable">
                                	<sql:query var="invoice" dataSource="jdbc/rmc">
                                		select mp_name from marketing_person where mp_head=?                              		
										<sql:param value="${bean.user_id}"/>
                                	</sql:query>
                                    <thead>
	                                    <tr class="text-center" style="background-color: #26c9e2;color: white;">
	                                        <th>Sales Person</th>
	                                       
	                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="invoice" items="${invoice.rows}">
                                    	
	                                    <tr class="text-center">
	                                        <td>
	                                            ${invoice.mp_name}
	                                        </td>
	                                    </tr>
                                    </c:forEach>
                                    </tbody>
                                   
                                </table>
                            </div>
                        </div>
                    </div>
              
				    
			</c:when>	    
		</c:choose>		    
				  </div>    
                         <div class="row">
                           <div class="col-xs-6">
                             <div class="card-box table-responsive">
                            <h4>Today Quotations</h4>
                            <c:remove var="res"/>
                            <table id="example" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                                 <thead>
	                                <tr style="background-color: #26c9e2;color: white;">
										<th class="center">
											Quotation Id
										</th>
										<th class="text-center">Customer Name</th>
										<th class="text-center">Site Address</th>
										<th class="text-center">Customer Phone</th>
										<th class="text-center">status</th>
										<th class="text-center" style="width: 25%;">
											Grade Details
											<table class="table table-condensed table-bordered table-white">
												<tr style="background-color: #26c9e2;color: white;">
													<th>Grade Id</th>
													<th>Grade Name</th>
													<th>Quantity</th>
													<th>Cost/M<sup>3</sup> (OPC)</th>
			                                		<th>Cost/M<sup>3</sup> (OPC + GGBS)</th>
												</tr>
											</table>
										</th>
									</tr>
                                </thead>
                                
                                <c:set value="${(empty param.quotation_id)?'':param.quotation_id}" var="quotation_id"/>
                                <c:set value="${(empty param.customer_name)?'':param.customer_name}" var="customer_name"/>
                                <c:set value="${(empty param.from_date)?'':param.from_date}" var="from_date"/>
                                	<c:set value="${(empty param.to_date)?'':param.to_date}" var="to_date"/>
								<sql:query var="po" dataSource="jdbc/rmc">
									select * from customer_quotation
									where mp_id=? and date(quotation_date)=curdate()
									order by quotation_id desc
									limit 200;
		                           	<sql:param value="${bean.user_id}"/>
								</sql:query>
								
                                <tbody>
                                <c:forEach var="po" items="${po.rows}">
									<tr class="${(po.status=='pending')?'bg-warning':(po.status=='cancelled')?'bg-danger':''}" >
										<td class="text-center">${po.quotation_id}</td>
										<td class="text-center">${po.customer_name}</td>
										
										<td class="text-center">
											${po.site_address}
										</td>
										<td class="text-center">
											${po.customer_phone}
										</td>
										<td class="text-center">
											${po.status}
										</td>
										<td class="text-center">
											<sql:query var="poi" dataSource="jdbc/rmc">
												select * from customer_quotation_item where quotation_id=?
												
												<sql:param value="${po.quotation_id}"/>												
											</sql:query>
											<table class="table table-light table-bordered">
												<c:forEach var="poi" items="${poi.rows}">
													<tr>
														<td>${poi.grade_id}</td>
														<td>${poi.grade_name}</td>
														<td>${poi.quantity}</td>
														<td>${poi.grade_price}</td>
														<td>${poi.ggbs_price}</td>
													</tr>
												</c:forEach>
											</table>
										</td>
									</tr>
									</c:forEach>
                                </tbody>
                            </table>
                        </div>
                       </div>
               
                <!-- end row -->
				  </div> 
				   <div class="row">
				     <div class="col-lg-4">
                        <div class="card-box">
                            <h4 class="header-title">Today's Schedule</h4>
							<div class="table-responsive">
                            <table id="example" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                                <thead>
	                                <tr style="background-color: #26c9e2;color: white;">
										<th class="text-center">Client Name</th>
									</tr>
                                </thead>
                                
								<sql:query var="sch" dataSource="jdbc/rmc">
									select f.*,m.mp_name from follow_up_report f left join ( marketing_person m) on f.user_id=m.mp_id where f.user_id=? and f.follow_up_date=curdate() order by follow_up_report_id desc
									<sql:param value="${bean.user_id}"/>
								
								</sql:query>
                                <tbody>
                                <c:forEach var="sch" items="${sch.rows}">
									<tr>
										<td class="text-center">${sch.client}</td>
									</tr>
									</c:forEach>
                                </tbody>
                            </table>
                            </div>
                        </div>
                    </div>
				  </div>
				  
            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->
		<div>
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
		</div>
		<div id="map"></div>
		
		
        <!-- Footer -->
       <!-- PUT HEADER.JSP HERE -->
       <%@ include file="footer.jsp" %>
        <!-- End Footer -->


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