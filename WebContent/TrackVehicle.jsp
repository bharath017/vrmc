<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Track Vehicle</title>
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

                <div class="row">
                    <div class="col-md-12">
                        <div class="card-box">
                            <h4 class="mb-3 header-title">TRACK VEHICLE</h4>
                            <div id="map" style="height: 600px;" class="gmaps"></div>
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
    		function initMap(){
    			var option={
    					zoom:8,
    					center:{lat:12.9716,lng:77.5946},
    					mapTypeId: google.maps.MapTypeId.ROADMAP
    			}
    			
    			var map=new google.maps.Map(document.getElementById('map'),option);
    			
    			
    			//add marker
    			
    			/* var marker=new google.maps.Marker({
    				position:{lat:13.1200876,lng:77.6171018},
    				map:map,
    				icon:'image/icons8-truck-20.png',
    				infowindow_content:'My Plce'
    			}) */
    			
    			function getMyVehicleDetails(key){
    				//Change 1
    				jQuery.support.cors = true;
    					$.ajax({
    						type:'GET',
    						url:'http://api.traako.com/history_api',
    						data: { imei : key,
    				         		 from : "09/02/2018 12:00 AM",
    				         		 to : "09/02/2018 05:50 PM"	
    				         	 },
    						headers:{
    							Accept:"application/json;charset=utf-8",
    							"Content-Type":"application/json;charset=utf-8"
    							
    						},
    						beforeSend: function(xhr){xhr.setRequestHeader('x-access-token', 'N2xjwhqtdBdG2dZBZUXJQlrscZPc7an3');},
    						success:function(res){
    							//call marker here
    							var lati=res[0].lat;
    							var lngi=res[0].long;
    							var  vall='{"lat":'+lati+',"lng":'+lngi+'}';
    							var content="<h1>Address : "+res[0].fulladdress+"</h1>"
    							addMarker(vall,content);
    							
    							//add marker here
								function addMarker(prop,content){
    								prop=JSON.parse(prop);
    								alert(prop);
    								var marker=new google.maps.Marker({
    									position:prop,
    									map:map,
    									icon:'image/icons8-truck-20.png'
    								})
    							}   							
    							
    						}
    			        });
    			}
    			
    			getMyVehicleDetails("867861030124728");
    		}
    	
    	</script>
        
        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>

    </body>
</html>