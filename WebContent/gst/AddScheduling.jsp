<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Scheduling</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico">
		<link rel="stylesheet" href="../picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="../picker/cs/bootstrap-timepicker.min.css" />
        <!-- App css -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css2/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="../assets/css/select2.min.css" />
        <link rel="stylesheet" href="../assets/css/render.css">
        <link href="../plugins/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
        <script src="../assets/js/modernizr.min.js"></script>
        <style type="text/css">
        	.error{
        		color: red;
        	}
        </style>

    </head>

    <body>

        <!-- Navigation Bar-->
        	<%@ include file="../header.jsp" %>
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
                                    <li class="breadcrumb-item"><a href="#">Customer &amp; Purchase Order</a></li>
                                    <li class="breadcrumb-item"><a href="#">Scheduling</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Scheduling</a></li>
                                </ol>
                            </div>
                           
                             <h4 class="page-title">Scheduling</h4>
                            	
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="SchedulingList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Scheduling List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
          
             	<div class="row">
                  <div class="col-sm-12">
                   	<form class="" action="../SchedulingControllerTest?action=InsertorUpdate" method="post" id="scheduling-form">
                        <div class="card-box row col-sm-12">
                           	<div class="col-sm-6">
                           		<div class="form-group">
                                   <label>Plant <span class="text-danger">*</span></label>
                                   
                                   <sql:query var="plant" dataSource="jdbc/rmc">
	                                    	select * from plant where plant_id like if(?=0,'%%',?)
	                                    	<sql:param value="${bean.plant_id}"/>
	                                    	<sql:param value="${bean.plant_id}"/>
	                               </sql:query>
	                               <input type="hidden" name="scheduling_id" value="0" id="scheduling_id"/>
                                   <select class="select2" name="plant_id" id="plant">
                                   		<c:if test="${bean.plant_id==0}">
                                   			<option value="0">All Plant</option>
                                   		</c:if>
                                  		<c:forEach var="plant" items="${plant.rows}">
											<option value="${plant.plant_id}" ${(plant.plant_id==invento.plant_id)?'selected':''}>${plant.plant_name}</option>
										</c:forEach>
                                    </select>
                                </div>
                                
                                <div class="form-group">
                                    <label>Scheduling Date <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                        	<input type="hidden" name="user_id" value="${bean.user_id}" id="user_id"/>
                                            <input type="text" name="scheduling_date" class="form-control date-picker scheduling_date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                            <div class="input-group-append picker">
                                                <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                            </div>
                                        </div>
                                        <label id="id-date-picker-1-error" class="error" for="id-date-picker-1"></label>
                                    </div>
                                </div>
                                 
                           	   <div class="form-group">
                                    <label>Customer <span class="text-danger">*</span></label>
                                    <sql:query var="customer" dataSource="jdbc/rmc">
                                    	select * from test_customer where customer_status='active' order by customer_name asc
                                    </sql:query>
									<select id="customer_id"  name="customer_id"    class="select2"  data-placeholder="Choose Customer">
										<option value="">&nbsp;</option>
										<c:forEach var="customer" items="${customer.rows}">
										<option value="${customer.customer_id}">${customer.customer_name}</option>
										</c:forEach>
									</select>
                                </div>
                                
                                <div class="form-group">
                                    <label>Site Name<span class="text-danger">*</span></label>
									<select id="site_id"  name="site_id" class="select2"  data-placeholder="Choose Site">
										
									</select>
                                </div>
                                
                                
                                <div class="form-group">
                                    <label>Start Time <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                            <input type="text" name="start_time" class="form-control" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label>End Time <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                            <input type="text" name="end_time" class="form-control" placeholder="HH:MM:SS" id="timepicker2" data-date-format="yyyy-mm-dd">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Pump1 <span class="text-danger">*</span></label>
                                    <sql:query var="pump" dataSource="jdbc/rmc">
                                    	select * from pump where type='pump'
                                    </sql:query>
									<select id="pump1"  name="pump1"    class="select2"  data-placeholder="Choose Pump1">
										<option value="">DUMPING</option>
										<c:forEach var="pump" items="${pump.rows}">
										<option value="${pump.pump_name}">${pump.pump_name}</option>
										</c:forEach>
									</select>
                                </div>
                                
                                <div class="form-group">
                                    <label>Pump2 <span class="text-danger">*</span></label>
                                    <sql:query var="pump" dataSource="jdbc/rmc">
                                    	select * from pump where type='pump'
                                    </sql:query>
									<select id="pump2"  name="pump2"    class="select2"  data-placeholder="Choose Pump2">
										<option value="">DUMPING</option>
										<c:forEach var="pump" items="${pump.rows}">
										<option value="${pump.pump_name}">${pump.pump_name}</option>
										</c:forEach>
									</select>
                                </div>
                                
                                <div class="col-sm-12">
                                	<label id="plant-error" class="error" for="plant"></label>
                                	<input type="hidden" name="count" value="0"/>
                                	<table class="table table-bordered" id="schedule_item">
                                		<thead>
                                			<tr style="background-color: #ea6e10;color: white;">
	                                			<th class="text-center">Grade</th>
	                                			<th class="text-center">Po Qty</th>
	                                			<th class="text-center">Inv Qty</th>
	                                			<th class="text-center">Bal Qty</th>
	                                			<th class="text-center">Quantity</th>
	                                		</tr>
                                		</thead>
                                		<tbody>
	                                		
	                                	</tbody>
                                	</table>
                                </div>
                             </div>
                             <div class="col-sm-12 text-center">
                               	<div class="form-group">
                                    <div>
                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
                                            Submit
                                        </button>
                                        <button type="reset" class="btn btn-light waves-effect m-l-5">
                                            Cancel
                                        </button>
                                    </div>
                                </div>
                              </div>
                       	  </div>
                       </form>
                   </div>
               </div>
                	
                <!-- end row -->

            </div> <!-- end container -->
        </div>
        <!-- Footer -->
       <%@ include file="../footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/popper.min.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/waves.js"></script>
        <script src="../assets/js/jquery.slimscroll.js"></script>
        <script type="text/javascript" src="js/Scheduling/AddScheduling.js"></script>
        <script type="text/javascript" src="../plugins/bootstrap-select/js/bootstrap-select.js"></script>
		<script type="text/javascript" src="../validation/jquery.validate.js"></script>
        <!-- App js -->
        <script src="../assets/js/jquery.core.js"></script>
        <script src="../assets/js/jquery.app.js"></script>
        <script src="../assets/js/select2.min.js"></script>
		<script src="../picker/js/bootstrap-datepicker.min.js"></script>
		<script src="../assets/js/bootstrap-timepicker.min.js"></script>
		<script src="../picker/js/moment.min.js"></script>
    </body>
</html>