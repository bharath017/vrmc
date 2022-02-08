<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Inventory OutGoing</title>
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
        		color: red;
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
                                    <li class="breadcrumb-item"><a href="#">Production</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Production</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Add Production</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
              	<c:choose>
              		<c:when test="${!empty param.action}">
              			<sql:query var="stock" dataSource="jdbc/rmc">
              				select i.*,DATE_FORMAT(i.date,'%d/%m/%Y') as date,p.isConversionRequired,p.conversion_value
              			    from inventory_outgoing i,product p
              			    where i.product_id=p.product_id
              			    and  invout_id=?
              			   <sql:param value="${param.invout_id}"/>
              			</sql:query>
              			
              			<c:forEach items="${stock.rows}" var="stock">
              				<c:set value="${stock}" var="rs"/>
              			</c:forEach>
              			<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" id="myform" 
		                    				action="StockController?action=updateProductionStock" method="post">
			                        <div class="card-box">
			                           	<div class="row">
			                           		<div class="col-sm-6">
			                           			<div class="row">
			                           				<div class="form-group col-sm-6">
					                                    <label>Plant <span class="text-danger">*</span></label>
					                                    <sql:query var="plant" dataSource="jdbc/rmc">
					                                    	select plant_id,plant_name
					                                        from plant
					                                        where plant_id like if(?=0,'%%',?)
					                                        and business_id like if(?=0,'%%',?)
					                                    	<sql:param value="${bean.plant_id}"/>
					                                    	<sql:param value="${bean.plant_id}"/>
					                                    	<sql:param value="${bean.business_id}"/>
					                                    	<sql:param value="${bean.business_id}"/>
					                                    </sql:query>
					                                    <input type="hidden" name="invout_id" value="${rs.invout_id}"/>
														<select id="plant_id"  name="plant_id" required="required"
																	   class="form-control"  data-placeholder="Choose Plant">
															<c:forEach var="plant" items="${plant.rows}">
															<option value="${plant.plant_id}"
																	 ${(rs.plant_id==plant.plant_id)?'selected':''}>${plant.plant_name}</option>
															</c:forEach>
														</select>
					                                </div>
					                                <div class="form-group col-sm-6">
					                                    <label>Item Name<span class="text-danger">*</span></label>
					                                    <sql:query var="inv_item" dataSource="jdbc/rmc">
					                                    	select product_id,product_name
					                                        from product
					                                        where business_id like if(?=0,'%%',?)
					                                        and product_status='active'
					                                        order by product_name asc
					                                        <sql:param value="${bean.business_id}"/>
					                                        <sql:param value="${bean.business_id}"/>
					                                    </sql:query>
					                                  
														<select id="product_id"  name="product_id" required="required"
																   class="select2"  data-placeholder="Choose Inventory Item">
															<option value="">&nbsp;</option>
															<c:forEach var="inv" items="${inv_item.rows}">
															<option value="${inv.product_id}"
																	 ${(rs.product_id==inv.product_id)?'selected':''}>${inv.product_name}</option>
															</c:forEach>
														</select>
														<label id="product_id-error" 
															style="" class="error" for="product_id"></label>
					                                </div>
					                                
					                                <div class="form-group col-sm-6 isConverted" style="display: none;">
					                                    <label>Conversion Quantity <span id="view-conv-value"></span><span class="text-danger">*</span> </label>
					                                    <div>
					                                       <input type="text" class="form-control isConverted" 
					                                        	  required="required"
					                                        	  id="conv_quantity"
					                                        	  name="conv_quantity"
					                                        	  disabled="disabled"
					                                        	  value="<fmt:formatNumber value="${(rs.isConversionRequired==true)?(rs.quantity/rs.conversion_value):0}" maxFractionDigits="2" groupingUsed="false"/>"
					                                        	  placeholder="Enter Product Quantity"/>
					                                       <input type="hidden" name="conversion_value" id="conversion_value" value="${rs.conversion_value}"/>
					                                       <input type="hidden" name="isEdit" id="isEdit" value="1"/>
					                                    </div>
					                                </div>
					                                
					                                <div class="form-group col-sm-6">
					                                    <label><span id="converted_quantity"></span>Quantity <span class="text-danger">*</span> </label>
					                                    <div>
					                                       <input type="text" class="form-control" 
					                                        	  required="required"
					                                        	  id="quantity"
					                                        	  name="quantity"
					                                        	  value="${rs.quantity}"
					                                        	  placeholder="Enter Product Quantity"/>
					                                    </div>
					                                </div>
					                                
					                                <div class="form-group col-sm-6">
					                                    <label>Production Cost / Unit <span class="text-danger">*</span> </label>
					                                    <div>
					                                       <input type="text" class="form-control" 
					                                        	  id="production_cost"
					                                        	  name="production_cost" value="${rs.production_cost}" placeholder="Enter Product Cost"/>
					                                    </div>
					                                </div>
					                                
					                                
					                                <div class="form-group col-sm-6">
				                                        <label>Date <span class="text-danger">*</span> </label>
				                                        <div>
				                                            <div class="input-group">
				                                                <input type="text" name="date" class="form-control date-picker invoice_date" 
				                                                		required="required" placeholder="dd/mm/yyyy"
				                                                	    id="id-date-picker-1" readonly style="background-color: white;"
				                                                	    data-date-format="dd/mm/yyyy" value="${rs.date}"/>
				                                                <div class="input-group-append picker">
				                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
				                                                </div>
				                                            </div>
				                                        </div>
				                                   </div>
				                                   <div class="form-group col-sm-6">
					                                    <label>Comment <span class="text-danger">*</span> </label>
					                                    <div>
					                                       <textarea  class="form-control" 
					                                           id="comment" name="comment">${rs.comment}</textarea>
					                                    </div>
					                               </div>
					                                <div class="form-group col-sm-6">
					                                    <label>Added By <span class="text-danger">*</span> </label>
					                                    <div>
					                                       <textarea  class="form-control" 
					                                           id="added_by" name="added_by">${rs.added_by}</textarea>
					                                    </div>
					                                </div>
			                           			</div>
			                           		</div>
			                           		<div class="col-sm-6">
			                           			<table class="table table-bordered" id="stock-table">
			                           				<thead>
			                           					<tr style="background-color: #02c0ce;color: white;">
			                           						<th>S/L No</th>
			                           						<th>Inventory Name</th>
			                           						<th>Quantity/Unit</th>
			                           						<th>Total Quantity</th>
			                           					</tr>
			                           				</thead>
			                           				<sql:query var="item" dataSource="jdbc/rmc">
			                           					select it.*,ii.inventory_name
			                           					from inventory_outgoing_item it, inventory_item ii
			                           					where it.inv_item_id=ii.inv_item_id
			                           					and it.invout_id=?
			                           					<sql:param value="${param.invout_id}"/>
			                           				</sql:query>
			                           				<tbody>
			                           					<c:set value="0" var="sl_no"/>
			                           					<c:forEach items="${item.rows}" var="item">
			                           					<tr>
															<td>${sl_no+1}<input type="hidden" value="${item.invout_item_id}" name="invout_item_id[${sl_no}]"/></td>		
															<td><input type="hidden" name="inv_item_id[${sl_no}]" class="inv_item_id" value="${item.inv_item_id}"/>${item.inventory_name}</td>
															<td><input type="hidden" class="unit_quantity" value="${item.quantity/rs.quantity}"/>${item.quantity/rs.quantity}</td>
															<td><input type="text" class="form-control quantity" name="quantity[${sl_no}]" value="${item.quantity}"/></td>
														</tr>
														<c:set value="${sl_no+1}" var="sl_no"/>
														</c:forEach>
			                           				</tbody>
			                           			</table>
			                           			<input type="hidden" name="count" id="count" value="${sl_no}"/>
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
              		</c:when>
              		<c:otherwise>
              			<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" id="myform" 
		                    				action="StockController?action=addProductionStock" method="post">
			                        <div class="card-box">
			                           	<div class="row">
			                           		<div class="col-sm-6">
			                           			<div class="row">
			                           				<div class="form-group col-sm-6">
					                                    <label>Plant <span class="text-danger">*</span></label>
					                                    <sql:query var="plant" dataSource="jdbc/rmc">
					                                    	select plant_id,plant_name
					                                        from plant
					                                        where plant_id like if(?=0,'%%',?)
					                                        and business_id like if(?=0,'%%',?)
					                                    	<sql:param value="${bean.plant_id}"/>
					                                    	<sql:param value="${bean.plant_id}"/>
					                                    	<sql:param value="${bean.business_id}"/>
					                                    	<sql:param value="${bean.business_id}"/>
					                                    </sql:query>
														<select id="plant_id"  name="plant_id" required="required"
																	   class="form-control"  data-placeholder="Choose Plant">
															<c:forEach var="plant" items="${plant.rows}">
															<option value="${plant.plant_id}">${plant.plant_name}</option>
															</c:forEach>
														</select>
					                                </div>
					                                <div class="form-group col-sm-6">
					                                    <label>Item Name<span class="text-danger">*</span></label>
					                                    <sql:query var="inv_item" dataSource="jdbc/rmc">
					                                    	select product_id,product_name
					                                        from product
					                                        where business_id like if(?=0,'%%',?)
					                                        and product_status='active'
					                                        order by product_name asc
					                                        <sql:param value="${bean.business_id}"/>
					                                        <sql:param value="${bean.business_id}"/>
					                                    </sql:query>
					                                  
														<select id="product_id"  name="product_id" required="required"
																   class="select2"  data-placeholder="Choose Inventory Item">
															<option value="">&nbsp;</option>
															<c:forEach var="inv" items="${inv_item.rows}">
															<option value="${inv.product_id}">${inv.product_name}</option>
															</c:forEach>
														</select>
														<label id="product_id-error" 
															style="" class="error" for="product_id"></label>
					                                </div>
					                                
					                                
					                                <div class="form-group col-sm-6 isConverted" style="display: none;">
					                                    <label>Conversion Quantity <span id="view-conv-value"></span><span class="text-danger">*</span> </label>
					                                    <div>
					                                       <input type="text" class="form-control isConverted" 
					                                        	  required="required"
					                                        	  id="conv_quantity"
					                                        	  name="conv_quantity"
					                                        	  disabled="disabled"
					                                        	  placeholder="Enter Product Quantity"/>
					                                       <input type="hidden" name="conversion_value" id="conversion_value"/>
					                                    </div>
					                                </div>
					                                
					                                <div class="form-group col-sm-6">
					                                    <label><span id="converted_quantity"></span>Quantity <span class="text-danger">*</span> </label>
					                                    <div>
					                                       <input type="text" class="form-control" 
					                                        		 required="required"
					                                        	  id="quantity"
					                                        	  name="quantity" placeholder="Enter Product Quantity"/>
					                                    </div>
					                                </div>
					                                
					                                <div class="form-group col-sm-6">
					                                    <label>Production Cost / Unit <span class="text-danger">*</span> </label>
					                                    <div>
					                                       <input type="text" class="form-control" 
					                                        	  id="production_cost"
					                                        	  name="production_cost" placeholder="Enter Product Cost"/>
					                                    </div>
					                                </div>
					                                
					                                
					                                <div class="form-group col-sm-6">
				                                        <label>Date <span class="text-danger">*</span> </label>
				                                        <div>
				                                            <div class="input-group">
				                                                <input type="text" name="date" class="form-control date-picker invoice_date" 
				                                                		required="required" placeholder="dd/mm/yyyy" id="id-date-picker-1" readonly style="background-color: white;" data-date-format="dd/mm/yyyy">
				                                                <div class="input-group-append picker">
				                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
				                                                </div>
				                                            </div>
				                                        </div>
				                                   </div>
				                                   <div class="form-group col-sm-6">
					                                    <label>Comment <span class="text-danger">*</span> </label>
					                                    <div>
					                                       <textarea  class="form-control" 
					                                           id="comment" name="comment"></textarea>
					                                    </div>
					                               </div>
					                                <div class="form-group col-sm-6">
					                                    <label>Added By <span class="text-danger">*</span> </label>
					                                    <div>
					                                       <textarea  class="form-control" 
					                                           id="added_by" name="added_by"></textarea>
					                                    </div>
					                                </div>
			                           			</div>
			                           		</div>
			                           		<div class="col-sm-6">
			                           			<input type="hidden" name="count" id="count" value="count"/>
			                           			<table class="table table-bordered" id="stock-table">
			                           				<thead>
			                           					<tr style="background-color: #02c0ce;color: white;">
			                           						<th>S/L No</th>
			                           						<th>Inventory Name</th>
			                           						<th>Quantity/Unit</th>
			                           						<th>Total Quantity</th>
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
		<c:choose>
			<c:when test="${!empty param.action}">
				<script type="text/javascript" src="js/Pickers/dateTimeValidatorEdit.js"></script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript" src="js/Pickers/dateTimeValidator.js"></script>
			</c:otherwise>
		</c:choose>
		

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="js/Production/AddProductStock.js"></script>
		<script type="text/javascript" src="validation/jquery.validate.min.js"></script>
		<script src="assets/js/ace.min.js"></script>
		
      </body>
</html>