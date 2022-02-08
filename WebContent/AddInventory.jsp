<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Inventory</title>
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
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <script src="assets/js/modernizr.min.js"></script>
        
        <style type="text/css">
        	.change{
        		background-color:#469399;
        		color: white;
        	}
        	
        	.nochange{
        		background-color: #d7dfe0;
        		
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
                                    <li class="breadcrumb-item"><a href="#">Inventory</a></li>
                                    <li class="breadcrumb-item"><a href="#">Inventory</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Inventory</a></li>
                                </ol>
                            </div>
                            <c:choose>
			                  	<c:when test="${param.action=='update'}">
			                  		<h4 class="page-title">Update Inventory </h4>
			                  	</c:when>
			                  	<c:otherwise>
			                  		<h4 class="page-title">Add Inventory </h4>
			                  	</c:otherwise>
			                </c:choose>
			                <p class="text-success" style="font-size: 16px;">${res}</p>
			                <c:remove var="res"/>
                        </div>
                    </div>
                </div>
                
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="InventoryList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Inventory List</a>
                    </div>
                    <div class="col-sm-4">
                        <a href="#cancel-model" data-animation="blur" data-plugin="custommodal"  data-overlaySpeed="100" data-overlayColor="#36404a" class="btn btn-success waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Add Vehicle</a>
                    </div>
                    <div class="col-sm-4">
                        <a href="#" data-toggle="modal" data-target="#update-vehicle" class="btn btn-primary waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Update Loaded Weight</a>
                    </div>
                    <!-- end col -->
                </div>
                <!-- end row -->
               
                <c:choose>
              	<c:when test="${param.action=='update'}">
              		<sql:query var="inv" dataSource="jdbc/rmc">
              			select * from inventory where inventory_id=?
              			<sql:param value="${param.inventory_id}"/>
              		</sql:query> 
                 <c:set var="res"/>
                 <c:forEach items="${inv.rows}" var="invento">
                		
              	<div class="row">
                    <div class="col-sm-12">
                    	<form class="" id="myform" action="InventoryController?action=UpdateInventory" method="post">
	                        <div class="card-box row col-sm-12">
	                           	<div class="col-sm-6">
	                           		<div class="form-group">
	                                    <label>Plant <span class="text-danger">*</span></label>
	                                    <sql:query var="plant" dataSource="jdbc/rmc">
	                                    	select plant_id,plant_name
	                                        from plant where plant_id like if(?=0,'%%',?)
	                                        and busiess_id like if(?=0,'%%',?)
	                                    	<sql:param value="${bean.plant_id}"/>
	                                    	<sql:param value="${bean.plant_id}"/>
	                                    	<sql:param value="${bean.business_id}"/>
	                                    	<sql:param value="${bean.business_id}"/>
	                                    </sql:query>
	                                    <input type="hidden" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  value="${invento.inventory_id}" required="required"  id="inventory_id" name="inventory_id"/>
										<select id="plant_id"  name="plant_id" required="required"   class="select2"  data-placeholder="Choose Plant">
											<c:forEach var="plant" items="${plant.rows}">
											<option value="${plant.plant_id}"
												 ${(plant.plant_id==invento.plant_id)?'selected':''}>${plant.plant_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                                
	                           	   <div class="form-group">
	                                    <label>Item Name<span class="text-danger">*</span></label>
	                                    <sql:query var="inv_item" dataSource="jdbc/rmc">
	                                    	select * from inventory_item order by inventory_name asc
	                                    </sql:query>
										<select id="inv_item_id"  name="inv_item_id" required="required"   class="select2"  data-placeholder="Choose Inventory Item">
											<option value="">&nbsp;</option>
											<c:forEach var="inv" items="${inv_item.rows}">
											<option value="${inv.inv_item_id}" ${(inv.inv_item_id==invento.inv_item_id)?'selected':''}>${inv.inventory_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                                
	                                <!--   <div class="form-group">
	                                    <label>Vehicle<span class="text-danger">*</span></label>
	                                    <sql:query var="vehicle" dataSource="jdbc/rmc">
	                                    	select * from temp_vehicle
	                                    </sql:query>
										<select id="vehicle_no"  name="vehicle_no" required="required" class="select2"  data-placeholder="Choose Vehicle">
											<option value="">&nbsp;</option>
											<c:forEach var="vehicle" items="${vehicle.rows}">
											<option value="${vehicle.vehicle_no}" ${(vehicle.vehicle_no==invento.vehicle_no)?'selected':''}>${vehicle.vehicle_no}</option>
											</c:forEach>
										</select>
	                                </div>-->
	                                
	                                <div class="form-group">
	                                    <label>Vehicle No :  </label>
	                                    <div>
	                                       <input type="text" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  value="${invento.vehicle_no}"   id="vehicle_no" name="vehicle_no"/>
	                                    </div>
	                                </div>
	                                
	                                
	                                <div class="form-group">
	                                    <label>Loaded Weight <span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  value="${invento.loaded_weight}" required="required" onkeyup="calculateNetWeight();"  id="loaded_weight" name="loaded_weight"/>
	                                    </div>
	                                </div>
	                                
	                                 <div class="form-group">
	                                    <label>Empty Weight <span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  value="${invento.empty_weight}" required="required" onkeyup="calculateNetWeight();"  id="empty_weight" name="empty_weight"/>
	                                    </div>
	                                </div>
									<div class="form-group">
	                                    <label>Net Weight <span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control"  value="${invento.net_weight}"
	                                         pattern="[^'&quot;:]*$" step="0.01"  required="required" onkeyup="calculateNetWeight();"   id="net_weight" name="net_weight"/>
	                                    </div>
	                                </div>
	                                 <div class="form-group">
	                                    <label>Moisture Percentage :  </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  value="${invento.moisture_percent}"  id="moisture_percent" onkeyup="calculateMoisture();"  name="moisture_percent"/>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                    <label>Weight after Moisture Deduction <span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01" readonly="readonly"   value="${invento.after_weight}" id="after_weight" name="after_weight"/>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                    <label>Unit :  </label>
	                                    <div>
	                                      <select name="unit" id="unit_value" class="form-control" required="required">
	                                      		<option value="KG" ${(invento.unit=='KG')?'selected':''}>KG</option>
	                                      		<option value="CFT" ${(invento.unit=='CFT')?'selected':''}>CFT</option>
	                                      		<option value="TONN" ${(invento.unit=='TONN')?'selected':''}>TONN</option>
	                                      		<option value="LITRE" ${(invento.unit=='LITRE')?'selected':''}>LITRE</option>
	                                      </select>
	                                    </div>
	                                </div>
	                                
	                            </div>
	                            <div class="col-sm-6">
	                              <div class="form-group">
                                        <label>Inventory Date <span class="text-danger"></span> </label>
                                        <div>
                                            <div class="input-group">
                                                <input type="text" name="inventory_date"  value="${invento.date}" class="form-control date-picker invoice_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                <div class="input-group-append">
                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                   </div>
	                                
	                                <div class="form-group">
	                                    <label>Inventory Time <span class="text-danger">*</span> </label>
	                                    <div>
	                                        <div class="input-group">
	                                            <input type="text" name="inventory_time" value="${invento.time}" class="form-control" required="required" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
	                                            <div class="input-group-append">
	                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Supplier Name <span class="text-danger">*</span></label>
	                                    <sql:query var="supplier" dataSource="jdbc/rmc">
	                                    	select * from supplier
	                                    </sql:query>
										<select id="supplier_id"  name="supplier_id" class="select2"  data-placeholder="Choose Supplier">
											<option value="">&nbsp;</option>
											<c:forEach var="sup" items="${supplier.rows}">
											<option value="${sup.supplier_id}" ${(sup.supplier_id==invento.supplier_id)?'selected':''}>${sup.supplier_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Supplier Weight <span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control"  value="${invento.supplier_weight}"
	                                         pattern="[^'&quot;:]*$" step="0.01"  required="required" id="supplier_weight" name="supplier_weight"/>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                    <label>Bill No <span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="text" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  value="${invento.bill_no}"  required="required"  id="bill_no" name="bill_no"/>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                    <label>Gate pass No :  </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  value="${invento.gatepass_no}"  id="gatepass_no" name="gatepass_no"/>
	                                    </div>
	                                </div>
	                                 <div class="form-group">
	                                    <label>Royalty No </label>
	                                    <div>
	                                       <input type="text" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  value="${invento.royalty_no}"   id="royalty_no" name="royalty_no"/>
	                                    </div>
	                                </div>
	                                 <div class="form-group">
	                                    <label>Comment: <span class="text-danger">*</span></label>
	                                    <div>
	                                       <input type="text" class="form-control" pattern="[^'&quot;:]*$" step="0.01"  required="required"  id="comment" name="modification_comment"/>
	                                    </div>
	                                </div>
	                                
	                                <sql:query var="delivery_address" dataSource="jdbc/rmc">
	                                	select * from plant_delivery_address where plant_id=?
	                                	<sql:param value="${invento.plant_id}"/>
	                                </sql:query>
	                                
	                                <div class="form-group">
	                                    <label>Delivery Address <span class="text-danger">*</span></label>
	                                    <div>
	                                      <select name="pl_delivery_address_id" id="pl_delivery_address_id" class="form-control" required="required">
	                                      		<c:forEach items="${delivery_address.rows}" var="da">
	                                      			<option value="${da.pl_delivery_add_id}" ${(da.pl_delivery_add_id==invento.pl_delivery_address_id)?'selected':''}>${da.delivery_address}</option>
	                                      		</c:forEach>
	                                      </select>
	                                    </div>
	                                </div>
	                             </div>
	                             
                                <div class="col-sm-12 text-center">
                                	<div class="form-group">
	                                    <div>
	                                        <button type="submit" id="savebtn" class="btn btn-custom waves-effect waves-light">
	                                            Update
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
               </c:forEach>
         	</c:when>
         
      		<c:otherwise>
              	<div class="row">
                    <div class="col-sm-12">
                    	<form class="" id="myform" action="InventoryController?action=InsertInventory" method="post">
	                        <div class="card-box row col-sm-12">
	                           	<div class="col-sm-6">
	                           		<div class="form-group">
	                                    <label>Plant <span class="text-danger">*</span></label>
	                                    <sql:query var="plant" dataSource="jdbc/rmc">
	                                    	select plant_id,plant_name
	                                        from plant where plant_id like if(?=0,'%%',?)
	                                        and business_id like if(0=?,'%%',?)
	                                    	<sql:param value="${bean.plant_id}"/>
	                                    	<sql:param value="${bean.plant_id}"/>
	                                    	<sql:param value="${bean.business_id}"/>
	                                    	<sql:param value="${bean.business_id}"/>
	                                    </sql:query>
										<select id="plant_id"  name="plant_id" required="required"   class="select2"  data-placeholder="Choose Plant">
											<c:forEach var="plant" items="${plant.rows}">
											<option value="${plant.plant_id}">${plant.plant_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                                
	                           	   <div class="form-group">
	                                    <label>Item Name<span class="text-danger">*</span></label>
	                                    <sql:query var="inv_item" dataSource="jdbc/rmc">
	                                    	select * from inventory_item order by inventory_name asc
	                                    </sql:query>
										<select id="inv_item_id"  name="inv_item_id" required="required"   class="select2"  data-placeholder="Choose Inventory Item">
											<option value="">&nbsp;</option>
											<c:forEach var="inv" items="${inv_item.rows}">
											<option value="${inv.inv_item_id}">${inv.inventory_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                                <!--<div class="form-group">
	                                    <label>Vehicle<span class="text-danger">*</span></label>
	                                    <sql:query var="vehicle" dataSource="jdbc/rmc">
	                                    	select * from temp_vehicle
	                                    </sql:query>
										<select id="vehicle_no"  name="vehicle_no" required="required" class="select2"  data-placeholder="Choose Vehicle">
											<option value="">&nbsp;</option>
											<c:forEach var="vehicle" items="${vehicle.rows}">
											<option value="${vehicle.vehicle_no}">${vehicle.vehicle_no}</option>
											</c:forEach>
										</select>
	                                </div>-->
	                                <div class="form-group">
	                                    <label>Vehicle No :  </label>
	                                    <div>
	                                       <input type="text" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"    id="vehicle_no" name="vehicle_no"/>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Loaded Weight <span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  required="required" onkeyup="calculateNetWeight();"   id="loaded_weight" name="loaded_weight"/>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Empty Weight <span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  required="required" onkeyup="calculateNetWeight();"   id="empty_weight" name="empty_weight"/>
	                                    </div>
	                                </div>
									<div class="form-group">
	                                    <label>Net Weight <span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01" readonly="readonly" required="required" onkeyup="calculateNetWeight();"   id="net_weight" name="net_weight"/>
	                                    </div>
	                                </div>
	                                 <div class="form-group">
	                                    <label>Supplier Weight <span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  required="required" onkeyup="checkWeightDiff();" id="supplier_weight" name="supplier_weight"/>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                    <label>Weight Difference<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  required="required" readonly="readonly" id="weight_diff" name="weight_diff"/>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="col-sm-6">
	                            <div class="form-group">
	                                    <label>Gate pass No :  </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"    id="gatepass_no" name="gatepass_no"/>
	                                    </div>
	                                </div>
	                              <div class="form-group">
                                        <label>Inventory Date <span class="text-danger"></span> </label>
                                        <div>
                                            <div class="input-group">
                                                <input type="text" name="inventory_date" class="form-control date-picker invoice_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                <div class="input-group-append">
                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                   </div>
	                                
	                                <div class="form-group">
	                                    <label>Inventory Time <span class="text-danger">*</span> </label>
	                                    <div>
	                                        <div class="input-group">
	                                            <input type="text" name="inventory_time" class="form-control" required="required" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
	                                            <div class="input-group-append">
	                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Supplier Name <span class="text-danger">*</span></label>
	                                    <sql:query var="supplier" dataSource="jdbc/rmc">
	                                    	select * from supplier
	                                    </sql:query>
										<select id="supplier_id"  name="supplier_id" class="select2"  required data-placeholder="Choose Supplier">
											<option value="">&nbsp;</option>
											<c:forEach var="sup" items="${supplier.rows}">
											<option value="${sup.supplier_id}">${sup.supplier_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                                 <div class="form-group">
	                                    <label>Bill No <span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="text" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  required="required"  id="bill_no" name="bill_no"/>
	                                    </div>
	                                </div>
	                                 <div class="form-group">
	                                    <label>Royalty No </label>
	                                    <div>
	                                       <input type="text" class="form-control" 
	                                         pattern="[^'&quot;:]*$"  id="royalty_no" name="royalty_no"/>
	                                    </div>
	                                </div>
	                               
	                                <div class="form-group">
	                                    <label>Unit :  </label>
	                                    <div>
	                                      <select name="unit" id="unit_value" class="form-control" required="required">
	                                      		<option value="KG">KG</option>
	                                      		<option value="CFT">CFT</option>
	                                      		<option value="TONN">TONN</option>
	                                      		<option value="LITRE">LITRE</option>
	                                      </select>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Delivery Address <span class="text-danger">*</span>  </label>
	                                    <div>
	                                      <select name="pl_delivery_address_id" id="pl_delivery_address_id" class="form-control" required="required">
	                                      		
	                                      </select>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                	<label for="bill_exist">
	                                		<input type="checkbox" name="bill_exist" id="bill_exist" class="checkbox"/> Is Bill Exist ?
	                                		
	                                	</label>
	                                </div>
	                             </div>
	                             
                                <div class="col-sm-12 text-center">
                                	<div class="form-group">
	                                    <div>
	                                        <button type="submit" id="savebtn" class="btn btn-custom waves-effect waves-light">
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
                </c:otherwise>
                </c:choose>
                <!-- end row -->
                
                <!-- MODAL FOR INSERT VEHICLE  -->
				<div id="cancel-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #055f77;">Add Inventory Vehicle</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" method="post" action="InventoryController?action=InsertInventoryVehicle">
		                	<div class="form-group">
                                 <label class="pull-left" for="username">Vehicle No<span class="text-danger">*</span></label>
                                 <input type="text" class="form-control" pattern="[^'&quot;:]*$"  id="vehicle_no" name="vehicle_no" required="required" placeholder="Enter Vehicle No."/>
                            </div>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">Add Vehicle</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
		        
		        <!-- Update Site Details Here-->
				<div id="update-vehicle"  class="modal fade"  role="dialog" aria-labelledby="" aria-hidden="true" style="display: none;">
                      <div class="modal-dialog" >
                          <div class="modal-content" style="width: 100%;">

                              <div class="modal-body" >
                                  <h2 class="text-uppercase text-center m-b-30 text-success">
                                    Update Vehicle &amp; Pump 
                                  </h2>

                                  <form class="form-horizontal" name="update_vehicle" action="InventoryController?action=UpdateLoadedWeight" method="post">

	                                
	                                <div class="form-group">
	                                    <label>Vehicle<span class="text-danger">*</span></label>
	                                    <sql:query var="vehicle" dataSource="jdbc/rmc">
	                                    	select * from temp_vehicle
	                                    </sql:query>
										<select id="vehicle_no"  name="vehicle_no" required="required" class="select2"  data-placeholder="Choose Vehicle">
											<option value="">&nbsp;</option>
											<c:forEach var="vehicle" items="${vehicle.rows}">
											<option value="${vehicle.vehicle_no}">${vehicle.vehicle_no}</option>
											</c:forEach>
										</select>
	                                </div>
	                                
                                      
                                      <div class="form-group">
                                           <label for="username">Loaded Weight</label>
                                           <input type="number" class="form-control" step="0.01" pattern="[^'&quot;:]*$"   name="loaded_weight" required="required" placeholder="Enter Loaded Weight"/>
                                      </div>
                                      
                                      
                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                               <button type="submit" onclick="addCompWeight();" id="comp_save" class="btn btn-custom waves-effect waves-light">
			                                            Submit
			                                        </button>
			                                        <button type="reset" data-dismiss="modal" aria-hidden="true" class="btn btn-light waves-effect m-l-5">
			                                            Cancel
			                                        </button>
	                                          </div>
	                                      </div>
                                      </div>
                                  </form>
                              </div>
                          </div><!-- /.modal-content -->
                      </div><!-- /.modal-dialog -->
                  </div><!-- /.modal -->
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

        <!-- Parsley js -->
        <script type="text/javascript" src="plugins/parsleyjs/parsley.min.js"></script>
        
        <!-- Modal-Effect -->
        <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="js/AddPurchaseOrder.js"></script>
		<script src="assets/js/ace.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				/*TIME PICKER START'S HERE*/
				$('#timepicker1').timepicker({
					minuteStep: 1,
					showSeconds: true,
					showMeridian: false,
					disableFocus: true,
					icons: {
						up: 'fa fa-chevron-up',
						down: 'fa fa-chevron-down'
					}
				}).on('focus', function() {
					$('#timepicker1').timepicker('showWidget');
				}).next().on(ace.click_event, function(){
					$(this).prev().focus();
				});
			});
		</script>
		
		
		
<script>

function calculateNetWeight(){
	
 var loaded_weight = document.getElementById('loaded_weight').value;
 var empty_weight = document.getElementById('empty_weight').value;
    
    var net_weight = loaded_weight - empty_weight;
    net_weight = net_weight.toFixed(2);
    
    if(net_weight>0){
        document.getElementById('net_weight').value=net_weight;
    }else{
    	document.getElementById('net_weight').value='';
    }
}

</script>

<script>

function calculateMoisture(){
	
 var net_weight = document.getElementById('net_weight').value;
 var moisture_percent = document.getElementById('moisture_percent').value;
    
    var reduction_weight = (net_weight*moisture_percent)/100;
    var after_reduction= net_weight-reduction_weight;
    document.getElementById('after_weight').value=after_reduction;
}

</script>

<script type="text/javascript">
	function checkWeightDiff(){
		var net_weight=$('#net_weight').val();
		net_weight=(net_weight==null || net_weight==undefined)?0.0:parseFloat(net_weight);
		var supplier_weight=$('#supplier_weight').val();
		supplier_weight=(supplier_weight==null || supplier_weight==undefined)?0.0:parseFloat(supplier_weight);
		
		var weight_diff=supplier_weight-net_weight;
		
		$('#weight_diff').val(weight_diff);
	}
</script>
		
		     
    <script type="text/javascript">
    $("#myform").bind('ajax:complete', function() {
		$('#savebtn').hide();
  	});
    </script>
    
    <script lang="javascript">
		var a = ['','one ','two ','three ','four ', 'five ','six ','seven ','eight ','nine ','ten ','eleven ','twelve ','thirteen ','fourteen ','fifteen ','sixteen ','seventeen ','eighteen ','nineteen '];
		var b = ['', '', 'twenty','thirty','forty','fifty', 'sixty','seventy','eighty','ninety'];

		function inWords(num) {
		    if ((num = num.toString()).length > 9) return 'overflow';
		    n = ('000000000' + num).substr(-9).match(/^(\d{2})(\d{2})(\d{2})(\d{1})(\d{2})$/);
		    if (!n) return; var str = '';
		    str += (n[1] != 0) ? (a[Number(n[1])] || b[n[1][0]] + ' ' + a[n[1][1]]) + 'crore ' : '';
		    str += (n[2] != 0) ? (a[Number(n[2])] || b[n[2][0]] + ' ' + a[n[2][1]]) + 'lakh ' : '';
		    str += (n[3] != 0) ? (a[Number(n[3])] || b[n[3][0]] + ' ' + a[n[3][1]]) + 'thousand ' : '';
		    str += (n[4] != 0) ? (a[Number(n[4])] || b[n[4][0]] + ' ' + a[n[4][1]]) + 'hundred ' : '';
		    str += (n[5] != 0) ? ((str != '') ? 'and ' : '') + (a[Number(n[5])] || b[n[5][0]] + ' ' + a[n[5][1]]) + 'only ' : '';
		    return str;
		}
  </script>
  <script type="text/javascript">
	 function setValue(){
		 var input = document.getElementById('quantity');
		  input.setAttribute('value', input.value);
	 }
  </script>
  
  <script type="text/javascript">
  		$(document).ready(function(){
  			$('#vehicle_no').on('change',function(){
  				var vehicle_no=$('#vehicle_no').val();
  				$.ajax({
  	  				type:'POST',
  	  				url:'InventoryController?action=GetLoadedWeight&vehicle_no='+vehicle_no,
  	  				headers:{
  	  					Accept:"text/html;charset=utf-8",
  	  					"Content-Type":"text/html;charset=utf-8"
  	  				},
  	  				success:function(res){
  	  					res=parseFloat(res);
  	  					$('#loaded_weight').val(res);
  	  			     	calculateNetWeight();
  	  				}
  	  			});
  			});
  		});
  </script>
  <script type="text/javascript">
  		$(document).ready(function(){
  			$('#inv_item_id').on('change',function(){
  				var inv_item_id=$('#inv_item_id').val();
  				$.ajax({
  					type:'post',
  					url:'InventoryController?action=getUnit&inv_item_id='+inv_item_id,
  					headers:{
  						"Conent-Type":"text/html;charset=utf-8",
  						Accept:"text/html;charset=utf-8"
  					},
  					success:function(res){
  						$('#unit').html('<option value="'+res+'">'+res+'</option>');
  					}
  				});
  			});
  		});
  </script>
  <script type="text/javascript">
  		$(document).ready(function(){
  			var fewSeconds = 5;
  			$('#savebtn').click(function(){
  			    // Ajax request
  			    $('#myform').submit();
  			    var btn = $(this);
  			    btn.prop('disabled', true);
  			    setTimeout(function(){
  			        btn.prop('disabled', false);
  			    }, fewSeconds*1000);
  			});
  		});
  </script>
  <c:if test="${empty param.action}">
  <script type="text/javascript">
  	
  	function getDeliveryAddress(){
  		var plant_id=$('#plant_id').val();
  		$.ajax({
  			type:'post',
  			url:'PlantController?button=getAllAddressById&plant_id='+plant_id,
  			headers:{
  				Accept:"application/json;charset=utf-8",
  				"Content-Type":"application/json"
  			},
  			success:function(res){
  				$('#pl_delivery_address_id').html("");
  				$.each(res,function(i,val){
  					$('#pl_delivery_address_id').append('<option value="'+val.pl_delivery_address_id+'">'+val.delivery_address+'</option>')
  				});
  			}
  		});
  	}
  	
  	$(document).ready(function(){
  		getDeliveryAddress();
  		$('#plant_id').on('change',function(){
  			getDeliveryAddress();
  		});	
  	});
  </script>
  </c:if>
  
      </body>
</html>