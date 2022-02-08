<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Delivery Challan</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">
		<link rel="stylesheet" href="picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="picker/cs/bootstrap-timepicker.min.css" />
        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="assets/css/select2.min.css" />
        <link rel="stylesheet" href="assets/css/render.css">
        
        <style type="text/css">
        	.change{
        		background-color:#469399;
        		color: white;
        	}
        	
        	.nochange{
        		background-color: #d7dfe0;
        	}
        	
        	.error{
        		color:red;
        		font-weight: bold;
        	}
        </style>

        <script src="assets/js/modernizr.min.js"></script>

    </head>

    <body>

        <!-- Navigation Bar-->
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
                                    <li class="breadcrumb-item"><a href="#">Billing</a></li>
                                    <li class="breadcrumb-item"><a href="#">Delivery Challan</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Delivery Challan</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Add DC</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="DeliveryChallanList.jsp" class="btn btn-custom waves-effect waves-light mb-4" 
                        		 data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>DC List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
              	<div class="row">
                    <div class="col-sm-8">
                    	<form class="" id="myform" action="DCController?action=InsertDC"  method="post">
	                        <div class="card-box row col-sm-12">
	                           	<div class="col-sm-6">
	                           		<div class="form-group">
	                                    <label>DC No<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="text" class="form-control"   readonly="readonly"   required="required"   id="invoice_no" name="invoice_no"/>
	                                    </div>
	                                </div>
	                           	</div>	
	                           	
	                           	<div class="col-sm-6">
	                            	<div class="form-group">
	                                    <label>Plant <span class="text-danger">*</span></label>
	                                   <sql:query var="plant" dataSource="jdbc/rmc">
											select plant_id,plant_name from plant
											where business_id like if(0=?,'%%',?)
											<sql:param value="${bean.business_id}"/>
											<sql:param value="${bean.business_id}"/>
										</sql:query>
										<select id="plant_id" name="plant_id" class="form-control">
											<c:forEach items="${plant.rows}" var="plant">
												<option value="${plant.plant_id}">${plant.plant_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                            </div>
	                           	
	                            <div class="col-sm-6">    
	                           	   <div class="form-group">
	                                    <label>Customer <span class="text-danger">*</span></label>
	                                    <sql:query var="customer" dataSource="jdbc/rmc">
	                                    	select customer_id,customer_name from customer
	                                        where customer_status='active'
	                                        and business_id like if(0=?,'%%',?)
	                                        order by customer_name asc 
	                                        <sql:param value="${bean.business_id}"/>
	                                        <sql:param value="${bean.business_id}"/>
	                                    </sql:query>
										<select id="customer"  name="customer_id" required="required"   class="select2"  data-placeholder="Choose Customer">
											<option value="">&nbsp;</option>
											<c:forEach var="customer" items="${customer.rows}">
											<option value="${customer.customer_id}">${customer.customer_name}</option>
											</c:forEach>
										</select>
										<label id="customer-error" class="error" for="customer"></label>
	                                </div>   
	                             </div> 
	                             <div class="col-sm-6">
	                              <div class="form-group">
                                        <label>DC Date <span class="text-danger"></span> </label>
                                        <div>
                                            <div class="input-group">
                                                <input type="text" name="dc_date" class="form-control date-picker invoice_date" 
                                                		required="required" placeholder="dd/mm/yyyy" id="id-date-picker-1" readonly style="background-color: white;" data-date-format="dd/mm/yyyy">
                                                <div class="input-group-append picker">
                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                   </div>
	                            </div>
	                            <div class="col-sm-6">    
	                                <div class="form-group">
	                                    <label>Site Name<span class="text-danger">*</span></label>
										<select id="site_id"  name="site_id" required="required"   class="select2"
													  data-placeholder="Choose Site">
											
										</select>
										<label id="site_id-error" class="error" for="site_id"></label>
	                                </div>
	                            </div>
	                            <div class="col-sm-6">    
	                                <div class="form-group">
	                                    <label>DC Time <span class="text-danger">*</span> </label>
	                                    <div>
	                                        <div class="input-group">
	                                            <input type="text" name="dc_time" class="form-control" required="required"
	                                            			 placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
	                                            <div class="input-group-append">
	                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                             <div class="col-sm-4">   
	                                <div class="form-group">
	                                    <label>Item Name<span class="text-danger">*</span></label>
	                                    <sql:query var="product" dataSource="jdbc/rmc">
	                                    	select product_id,product_name
	                                    	from product 
	                                    	where business_id like if(0=?,'%%',?)
	                                    	and product_status='active'
	                                    	<sql:param value="${bean.business_id}"/>
	                                    	<sql:param value="${bean.business_id}"/>
	                                    </sql:query>
										<select id="product_id"  name="product_id" required="required" 
													 class="select2"  data-placeholder="Choose Product">
											<c:forEach items="${product.rows}" var="product">
												<option value="${product.product_id}">${product.product_name}</option>
											</c:forEach>											
										</select>
	                                </div>
	                             </div>
	                             <div class="col-sm-4">    
	                                <div class="form-group">
	                                    <label>Vehicle No <span class="text-danger">*</span></label>
	                                    <sql:query var="vehicle" dataSource="jdbc/rmc">
	                                    	select * from vehicle
	                                    </sql:query>
										<select id="vehicle_no"  name="vehicle_no" required="required"  class="select2"  data-placeholder="Choose Vehicle">
											<option value="">&nbsp;</option>
											<c:forEach var="vehicle" items="${vehicle.rows}">
											<option value="${vehicle.vehicle_no}">${vehicle.vehicle_no}</option>
											</c:forEach>
										</select>
										<label id="vehicle_no-error" class="error" for="vehicle_no"></label>
	                                </div>
	                             </div>
	                             
	                             <div class="col-sm-4">    
	                                <div class="form-group">
	                                    <label>Driver Name : </label>
	                                    <sql:query var="driver" dataSource="jdbc/rmc">
	                                    	select * from driver
	                                    </sql:query>
										<select id="driver_name"  name="driver_name"   class="select2"  data-placeholder="Choose Driver">
											<option value="">&nbsp;</option>
											<c:forEach var="driver" items="${driver.rows}">
											<option value="${driver.driver_name}">${driver.driver_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                             </div>
	                           
	                             <div class="col-sm-4">   
	                                <div class="form-group">
	                                    <label>Empty Weight<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="text" class="form-control" pattern="[^'&quot;:]*$"   required="required"  id="empty_weight" name="empty_weight"/>
	                                    </div>
	                                </div>
	                             </div>
	                             
	                            
	                            <div class="col-sm-4">    
	                                <div class="form-group">
	                                    <label>Loaded Weight<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="text" class="form-control"  pattern="[^'&quot;:]*$"   required="required"  id="loaded_weight" name="loaded_weight"/>
	                                    </div>
	                                </div>  
	                            </div>
	                            
	                            
	                            
	                           <div class="col-sm-4">     
	                                <div class="form-group">
	                                    <label>Net Weight<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="text" class="form-control"  pattern="[^'&quot;:]*$"   required="required"  id="net_weight" name="net_weight"/>
	                                    </div>
	                                </div>
	                           </div>
								  <!-- write all hidden data here -->
                                <div class="col-sm-12 text-center">
                                	<div class="form-group">
	                                    <div>
	                                    	<input type="hidden" name="dcPhoto" id="dcPhoto"/>
	                                    	<input type="hidden" name="ticket_id" id="ticket_id"/>
	                                        <button type="submit" id="savebtn" name="savebtn" class="btn btn-custom waves-effect waves-light">
	                                            Submit
	                                        </button>
	                                        <button type="reset" class="btn btn-light waves-effect m-l-5" id="noview">
	                                            Cancel
	                                        </button>
	                                        <img src="image/loader/loader.gif" width="50" height="50" id="loader" style="display: none;"/>
	                                    </div>
	                                </div>
                                </div>
                        	</div>
                        </form>
                    </div>
                    <div class="col-sm-4">
                    	  <div class="col-sm-12" id="clicked">
                              	<table class="table table-bordered" id="Table1">
                              		<thead>
                              			<tr id="show-error">
                              				
                              			</tr>
                              		</thead>
                              		<tbody>
                              			<tr>
	                               			<td class="change" style="width: 30%;">Customer Name : </td>
	                               			<td class="nochange" colspan="2" id="show_customer"></td>
	                               		</tr>
	                               		<tr>
	                               			<td class="change">Customer Address : </td>
                               				<td class="nochange" colspan="2" id="show_customer_address"></td>
	                               		</tr>
	                               		<tr>
	                               			<td class="change">Site Name : </td>
	                               			<td class="nochange" colspan="2" id="show_site_name"></td>
	                               		</tr>
	                               		<tr>
	                               			<td class="change">Site Address : </td>
	                               			<td class="nochange" colspan="2" id="show_site_address"></td>
	                               		</tr>
                              		</tbody>
                              	</table>
                              	<div class="col-sm-12" id="camera">
                        	
                        		</div>
                        </div>
                        
                    </div>
                </div>
                <!-- end row -->
            </div> <!-- end container -->
        </div>
        

        <!-- Footer -->
       <%@ include file="footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="js/DC/add_dc.js"></script>
		<script type="text/javascript" src="js/Pickers/dateTimeValidator.js"></script>
		<script type="text/javascript" src="validation/jquery.validate.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/webcamjs/1.0.26/webcam.min.js" ></script>
		<script src="assets/js/ace.min.js"></script>
		
    </body>
</html>