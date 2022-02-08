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
                                    <li class="breadcrumb-item active">Dashboard</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Dashboard</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                
                <div class="row">
                    <div class="col-12">
                        <div class="card-box">
                            <h4 class="header-title mb-4">TODAY CONSUMPTION OVERVIEW(IN KG)</h4>
                            
                           <c:catch var="e">
                           		 <sql:query var="cons" dataSource="jdbc/rmc">
	                            	select date(timestamp),round(sum(AGG1_VALUE_VAL0),2) as s1,round(sum(AGG2_VALUE_VAL0),2) as s2,round(sum(AGG3_VALUE_VAL0),2) as s3,
	                            	round(sum(AGG4_VALUE_VAL0),2) as s4,round(sum(CEMTWT_VAL0),2) as s5,
	                            	round(sum(CEMTWT1_VAL0),2) as s6,round(sum(CEMTWT2_VAL0),2) as s7,round(sum(WTRWT_VAL0),2) as s8,
	                            	round(sum(ADDWT_VAL0),2) as s9
	                            	from indus1 where date(timestamp)=curdate();
	                            </sql:query>
                           </c:catch>
                            
                            <c:forEach items="${cons.rows}" var="cons">
                            	<c:set value="${cons}" var="con"/>
                            </c:forEach>
							<div class="text-center mt-4 mb-4">
                                <div class="row">
                                    <div class="col-xs-3 col-sm-1">
                                        <div class="card-box widget-flat   text-white" style="background-color: #8e67f7;">
                                            <h5 class="m-b-4">${(empty con.s1)?0:con.s1}</h5>
                                            <p class="text-uppercase m-b-5 font-13 font-600">12MM</p>
                                        </div>
                                    </div>
                                    <div class="col-xs-3 col-sm-1">
                                        <div class="card-box widget-flat  text-white" style="background-color: #f75d68;">
                                            <h5 class="m-b-4">${(empty con.s2)?0:con.s2}</h5>
                                            <p class="text-uppercase m-b-5 font-13 font-600">MSAND</p>
                                        </div>
                                    </div>
                                    
                                    <div class="col-xs-6 col-sm-1">
                                        <div class="card-box widget-flat  text-white" style="background-color: #8e67f7;">
                                            <h5 class="m-b-4">${(empty con.s3)?0:con.s3}</h5>
                                            <p class="text-uppercase m-b-5 font-13 font-600">MSAND</p>
                                        </div>
                                    </div>
                                    
                                    <div class="col-xs-6 col-sm-1">
                                        <div class="card-box  widget-flat  text-white" style="background-color: #f75d68;">
                                            <h5 class="m-b-4">${(empty con.s4)?0:con.s4}</h5>
                                            <p class="text-uppercase m-b-5 font-13 font-600">20MM</p>
                                        </div>
                                    </div>
                                    <div class="col-xs-3 col-sm-1">
                                        <div class="card-box widget-flat   text-white" style="background-color: #8e67f7;">
                                            <h5 class="m-b-4">${(empty con.s5)?0:con.s5}</h5>
                                            <p class="text-uppercase m-b-5 font-13 font-600">12MM</p>
                                        </div>
                                    </div>
                                    <div class="col-xs-3 col-sm-1">
                                        <div class="card-box widget-flat  text-white" style="background-color: #f75d68;">
                                            <h5 class="m-b-4">${(empty con.s6)?0:con.s6}</h5>
                                            <p class="text-uppercase m-b-5 font-13 font-600">CEM1</p>
                                        </div>
                                    </div>
                                    
                                    <div class="col-xs-6 col-sm-1">
                                        <div class="card-box widget-flat  text-white" style="background-color: #8e67f7;">
                                            <h5 class="m-b-4">${(empty con.s7)?0:con.s7}</h5>
                                            <p class="text-uppercase m-b-5 font-13 font-600">CEM2</p>
                                        </div>
                                    </div>
                                    
                                    <div class="col-xs-6 col-sm-1">
                                        <div class="card-box  widget-flat  text-white" style="background-color: #f75d68;">
                                            <h5 class="m-b-4">${(empty con.s8)?0:con.s8}</h5>
                                            <p class="text-uppercase m-b-5 font-13 font-600">CEM3</p>
                                        </div>
                                    </div>
                                    <div class="col-xs-3 col-sm-1">
                                        <div class="card-box widget-flat   text-white" style="background-color: #8e67f7;">
                                            <h5 class="m-b-4">${(empty con.s9)?0:con.s9}</h5>
                                            <p class="text-uppercase m-b-5 font-13 font-600">WATER</p>
                                        </div>
                                    </div>
                                    <div class="col-xs-3 col-sm-1">
                                        <div class="card-box widget-flat  text-white" style="background-color: #f75d68;">
                                            <h5 class="m-b-4">${(empty con.s9)?0:con.s9}</h5>
                                            <p class="text-uppercase m-b-5 font-13 font-600">ADMIX</p>
                                        </div>
                                    </div>
                                    
                                    <div class="col-xs-6 col-sm-1">
                                        <div class="card-box widget-flat  text-white" style="background-color: #8e67f7;">
                                            <h5 class="m-b-4">0</h5>
                                            <p class="text-uppercase m-b-5 font-13 font-600">NIL</p>
                                        </div>
                                    </div>
                                    
                                    <div class="col-xs-6 col-sm-1">
                                        <div class="card-box  widget-flat  text-white" style="background-color: #f75d68;">
                                            <h5 class="m-b-4">0</h5>
                                            <p class="text-uppercase m-b-5 font-13 font-600">NIL</p>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                            
                            <!-- end row -->
                        </div>
                    </div>
                </div>
                <!-- end row -->
                


                <div class="row">
                    <div class="col-lg-6">
                        <div class="card-box">
                            <h4 class="m-t-0 header-title">TODAY MANUAL BATCHING</h4>
							<div class="table-responsive">
                                <table class="table table-hover table-centered m-0">
                                    <thead>
	                                    <tr class="text-center" style="background-color: #26c9e2;color: white;">
	                                        <th>Inventory Name</th>
	                                        <th>Consumption Quantity(MT)</th>
	                                        <th>Plant Name</th>
	                                    </tr>
                                    </thead>
                                    <sql:query var="incon" dataSource="jdbc/rmc">
                                    	select TRUNCATE(sum(i.consumption_quantity/100),3)  as total_quantity,p.plant_name,it.inventory_name
                                    	from inventory_outgoing i LEFT JOIN (inventory_item it,plant p)
                                    	ON i.inv_item_id=it.inv_item_id 
                                    	and i.plant_id=p.plant_id
                                    	where i.consumption_date=curdate() 
                                    	and i.plant_id like if(?='','%%',?)
                                    	group by p.plant_name,it.inventory_name
                                    	<sql:param value="${bean.plant_id}"/>
                                    	<sql:param value="${bean.plant_id}"/>
                                    </sql:query>
                                    <tbody>
                                    		<c:forEach items="${incon.rows}" var="incon">
                                    			<tr class="text-center">
			                                        <td>
			                                        	${incon.inventory_name}
			                                        </td>
			
			                                        <td>
			                                        	${incon.total_quantity }
			                                        </td>
			                                        
			                                        <td>
			                                        	${incon.plant_name}
			                                        </td>
			                                    </tr>
                                    		</c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="card-box">
                            <h4 class="header-title">TODAY INVENTORY OVERVIEW</h4>
							<div class="table-responsive">
                                <table class="table table-hover table-centered m-0">
                                    <thead>
	                                    <tr class="text-center" style="background-color: #26c9e2;color: white;">
	                                        <th>Inventory</th>
	                                        <th>Supplier Name</th>
	                                        <th>Total Load(TONN)</th>
	                                        <th>Plant Name</th>
	                                    </tr>
                                    </thead>
                                    <sql:query var="inventory" dataSource="jdbc/rmc">
                                    	select truncate(sum(i.loaded_weight/1000),2) as total_load,s.supplier_name,it.inventory_name,pl.plant_name
                                    	from inventory i LEFT JOIN(inventory_item it,supplier s,plant pl)
                                    	ON i.inv_item_id=it.inv_item_id
                                    	and i.supplier_id=s.supplier_id
                                    	and i.plant_id=pl.plant_id
                                    	where i.date=curdate()
                                    	and i.plant_id like if(0=?,'%%',?)
                                    	group by it.inventory_name,s.supplier_name,pl.plant_name
                                    	<sql:param value="${bean.plant_id}"/>
                                    	<sql:param value="${bean.plant_id}"/>
                                    </sql:query>
                                    <tbody>
	                                    <c:forEach items="${inventory.rows}" var="inventory">
	                                    	<tr class="text-center">
		                                        <td>
													${inventory.inventory_name}
		                                        </td>
		
		                                        <td>
		                                           ${inventory.supplier_name}
		                                        </td>
		
		                                        <td>
		                                            ${inventory.total_load}
		                                        </td>
		                                        <td>
		                                            ${inventory.plant_name}
		                                        </td>
		                                    </tr>
	                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end row -->

                <div class="row">
                    <div class="col-lg-8">
                        <div class="card-box">
                            <h4 class="header-title mb-3">INCOMING SCHEDULING DETAIL'S</h4>

                            <div class="table-responsive">
                                <table class="table table-hover table-centered m-0">

                                    <thead>
	                                    <tr class="text-center" style="background-color: #26c9e2;color: white;">
	                                        <th>Customer</th>
	                                        <th>Site</th>
	                                        <th>Plant</th>
	                                        <th>Start Time</th>
	                                        <th>End Time</th>
	                                        <th>Quantity</th>
	                                    </tr>
                                    </thead>
                                    <sql:query var="sch" dataSource="jdbc/rmc">
										 select si.*,sc.*,c.customer_name,s.site_name,p.product_name,
										 (select plant_name from plant where plant_id=sc.plant_id) as plant_name
										 from scheduling_item si LEFT JOIN(scheduling sc,customer c,site_detail s,product p)
										 ON si.scheduling_id=sc.scheduling_id
										 and si.product_id=p.product_id
										 and sc.customer_id=c.customer_id
										 and sc.site_id=s.site_id
										 where sc.scheduling_date=curdate()
										 and sc.plant_id like if(0=?,'%%',?)
										 and si.production_quantity>0
										 <sql:param value="${bean.plant_id}"/>
										 <sql:param value="${bean.plant_id}"/>
									</sql:query>
                                    <tbody>
                                    	<c:set value="0" var="tquant"/>
	                                    <c:forEach items="${sch.rows}" var="sch">
	                                    	<c:set value="${tquant+sch.production_quantity}" var="tquant"/>
	                                    	<tr class="text-center">
		                                        <td>
		                                            ${sch.customer_name}
		                                        </td>
		
		                                        <td>
													${sch.site_name}
		                                        </td>
		
		                                        <td>
													${(empty sch.plant_name)?'All Plant':sch.plant_name}
		                                        </td>
		
		                                        <td>
		                                            ${sch.start_time}
		                                        </td>
		
		                                        <td>
		                                            ${sch.end_time}
		                                        </td>
		
		                                        <td>
													${sch.production_quantity}
		                                        </td>
		                                    </tr>
	                                    </c:forEach>
	                                    	<tr style="background-color: #39db84;color: white;">
	                                    		<td colspan="6">TOTAL QUANTITY FOR PRODUCTION : ${tquant}</td>
	                                    	</tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                    </div>

                    <div class="col-lg-4">
                        <div class="card-box">
                            <h4 class="m-t-0 header-title">TODAY VEHICLE DISEL CONSUMPTION</h4>
							<div class="table-responsive">
                                <table class="table table-hover table-centered m-0">
                                    <thead>
	                                    <tr class="text-center" style="background-color: #26c9e2;color: white;">
	                                        <th>Vehicle No</th>
	                                        <th>Consumption Quantity</th>
	                                    </tr>
                                    </thead>
                                    <sql:query var="diesel" dataSource="jdbc/rmc">
                                    	select sum(quantity) as total_quantity,vehicle_no
                                    	from disel_cons_date
                                    	where date=curdate() 
                                    	group by vehicle_no
                                    </sql:query>
                                    <tbody>
                                    		<c:forEach items="${diesel.rows}" var="diesel">
                                    			<tr class="text-center">
			                                        <td>
			                                        	${diesel.vehicle_no}
			                                        </td>
			
			                                        <td>
			                                        	${diesel.total_quantity }
			                                        </td>
			                                    </tr>
                                    		</c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end row -->

            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->


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
    </body>
</html>