<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Receipe</title>
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
        <script src="../assets/js/modernizr.min.js"></script>

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
                                    <li class="breadcrumb-item"><a href="#">QC Department</a></li>
                                    <li class="breadcrumb-item"><a href="#">Receipe</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Receipe</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Add Receipe</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="ReceipeList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Receipe List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                	
                		<sql:query var="rec" dataSource="jdbc/rmc">
                			select * from test_receipe where receipe_id=?
                			<sql:param value="${param.receipe_id}"/>
                		</sql:query>
                		
                		<c:forEach items="${rec.rows}" var="rec">
                			<c:set value="${rec}" var="rs"/>
                		</c:forEach>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="../MixDesignControllerTest?action=UpdateReceipe" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                           		<div class="form-group">
			                                    <label>Receipe Code : </label>
			                                    <div>
			                                    	
			                                       <input type="hidden" name="receipe_id" id="receipe_id" value="${rs.receipe_id}">
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$" value="${rs.recipe_code}"  placeholder="Enter Receipe Code" id="receipe_code"   name="receipe_code"/>
			                                    </div>
			                                </div>
			                                <div class="form-group">
			                                    <label>Customer <span class="text-danger">*</span></label>
			                                    <sql:query var="customer" dataSource="jdbc/rmc">
			                                    	select * from test_customer where customer_status='active' order by customer_name asc
			                                    </sql:query>
												<select id="customer_id"  name="customer_id"  class="select2"  data-placeholder="Choose Customer" required="required">
													<option value="">&nbsp;</option>
													<c:forEach var="customer" items="${customer.rows}">
													<option value="${customer.customer_id}" ${(customer.customer_id==rs.customer_id)?'selected':''}>${customer.customer_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                <!-- get details here -->
			                                <sql:query var="pro" dataSource="jdbc/rmc">
			                                	select * from product where product_id=?
			                                	<sql:param value="${rs.product_id}"/>
			                                </sql:query>
			                                
			                                <div class="form-group">
			                                    <label>Grade<span class="text-danger">*</span></label>
												<select id="product_id"  name="product_id" required="required"  class="select2"  data-placeholder="Choose Site">
													<c:forEach items="${pro.rows}" var="pro">
														<option value="${rs.product_id}">${pro.product_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                           	</div>
			                           	<div class="col-sm-6">
			                                <div class="form-group">
			                                    <label>Plant <span class="text-danger">*</span></label>
			                                    <sql:query var="plant" dataSource="jdbc/rmc">
			                                    	select * from plant where plant_id like if(?=0,'%%',?)
			                                    	<sql:param value="${bean.plant_id}"/>
			                                    	<sql:param value="${bean.plant_id}"/>
			                                    </sql:query>
												<select id="plant_id"  name="plant_id"  required="required"  class="select2"  data-placeholder="Choose Plant">
													<c:forEach var="plant" items="${plant.rows}">
													<option value="${plant.plant_id}" ${(plant.plant_id==rs.plant_id)?'selected':''}>${plant.plant_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <!-- Get site details here -->
											<sql:query var="site" dataSource="jdbc/rmc">
												select * from test_site_detail where customer_id=?
												<sql:param value="${rs.customer_id}"/>
											</sql:query>
			                                
			                                <div class="form-group">
			                                    <label>Site Name<span class="text-danger">*</span></label>
												<select id="site_id"  name="site_id" required="required"   class="select2"  data-placeholder="Choose Site">
													<c:forEach items="${site.rows}" var="site">
														<option value="${site.site_id}" ${(site.site_id==rs.site_id)?'selected':''}>${site.site_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Cement Name : </label>
			                                    <div>
			                                    	
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$" value="${rs.cement_name}" 
			                                         		 placeholder="Enter Cement Name" id="cement_name"   name="cement_name"/>
			                                    </div>
			                                </div>
			                            </div>
			                             <div class="col-sm-12 row">
			                            	<div class="col-sm-2"></div>
			                            	<div class="col-sm-8">
			                            		<table class="table table-bordered table-condensed">
			                            			<thead>
			                            				<tr style="background-color: #3eced6;color: white;">
			                            					<th>S/L No</th>
			                            					<th>Mix Types</th>
			                            					<th>Product</th>
			                            					<th>Quantity</th>
			                            				</tr>
			                            			</thead>
			                            			<tbody>
			                            				<tr>
			                            					<td>1</td>
			                            					<td>Aggr1</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate1_name}"  id="aggregate1_name"  name="aggregate1_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate1_value}"    id="aggregate1_value"  name="aggregate1_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>2</td>
			                            					<td>Aggr2</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate2_name}"    id="aggregate2_name"  name="aggregate2_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate2_value}"   id="aggregate2_value"  name="aggregate2_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>3</td>
			                            					<td>Aggr3</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate3_name}"   id="aggregate3_name"  name="aggregate3_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate3_value}"   id="aggregate3_value"  name="aggregate3_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>4</td>
			                            					<td>Aggr4</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate4_name}"   id="aggregate4_name"  name="aggregate4_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   value="${rs.aggregate4_value}"  id="aggregate4_value"  name="aggregate4_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>5</td>
			                            					<td>Cem1</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   value="${rs.aggregate5_name}"   id="aggregate5_name"  name="aggregate5_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   value="${rs.aggregate5_value}"  id="aggregate5_value"  name="aggregate5_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>6</td>
			                            					<td>Cem2</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate6_name}"   id="aggregate6_name"  name="aggregate6_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   value="${rs.aggregate6_value}"  id="aggregate6_value"  name="aggregate6_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>7</td>
			                            					<td>Cem3</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate7_name}"   id="aggregate7_name"  name="aggregate7_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   value="${rs.aggregate7_value}"  id="aggregate7_value"  name="aggregate7_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>8</td>
			                            					<td>Water</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   value="${rs.aggregate8_name}"  id="aggregate8_name"  name="aggregate8_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate8_value}"   id="aggregate8_value"  name="aggregate8_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>9</td>
			                            					<td>Admix1</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate9_name}"   id="aggregate9_name"  name="aggregate9_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   value="${rs.aggregate9_value}"  id="aggregate9_value"  step="0.01" name="aggregate9_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>10</td>
			                            					<td>Admix10</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate10_name}"   id="aggregate10_name"  name="aggregate10_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$" value="${rs.aggregate10_value}"  step="0.01"   id="aggregate10_value"  name="aggregate10_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>11</td>
			                            					<td>Aggr5</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$" value="${rs.aggregate11_name}"     id="aggregate11_name"  name="aggregate11_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate11_value}"   id="aggregate11_value"  name="aggregate11_value"/>
			                            					</td>
			                            				</tr>
			                            			</tbody>
			                            		</table>
			                            	</div>
			                            </div>
		                               
		                                <div class="col-sm-12 text-center">
		                                	<div class="form-group">
			                                    <div>
			                                    	<input type="hidden" name="gst_percent" value="" id="gst_percent">
			                                        <button type="submit" id="save-option" class="btn btn-custom waves-effect waves-light">
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
		                    	<form class="" action="../MixDesignControllerTest?action=InsertReceipe" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                           		<div class="form-group">
			                                    <label>Receipe Code : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Receipe Code" id="receipe_code"   name="receipe_code"/>
			                                    </div>
			                                </div>
			                                <div class="form-group">
			                                    <label>Customer <span class="text-danger">*</span></label>
			                                    <sql:query var="customer" dataSource="jdbc/rmc">
			                                    	select * from test_customer where customer_status='active' order by customer_name asc
			                                    </sql:query>
												<select id="customer_id"  name="customer_id"    class="select2"  data-placeholder="Choose Customer" required="required">
													<option value="">&nbsp;</option>
													<c:forEach var="customer" items="${customer.rows}">
													<option value="${customer.customer_id}">${customer.customer_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                <div class="form-group">
			                                    <label>Grade<span class="text-danger">*</span></label>
												<select id="product_id"  name="product_id" required="required"  class="select2"  data-placeholder="Choose Grade">
													
												</select>
			                                </div>
			                           	</div>
			                           	<div class="col-sm-6">
			                                <div class="form-group">
			                                    <label>Plant <span class="text-danger">*</span></label>
			                                    <sql:query var="plant" dataSource="jdbc/rmc">
			                                    	select * from plant where plant_id like if(0=?,'%%',?)
			                                    	<sql:param value="${bean.plant_id}"/>
			                                    	<sql:param value="${bean.plant_id}"/>
			                                    </sql:query>
												<select id="plant_id"  name="plant_id"  required="required"  class="select2"  data-placeholder="Choose Plant">
													<c:forEach var="plant" items="${plant.rows}">
													<option value="${plant.plant_id}">${plant.plant_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Site Name<span class="text-danger">*</span></label>
												<select id="site_id"  name="site_id" required="required"   class="select2"  data-placeholder="Choose Site">
													
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Cement Name : </label>
			                                    <div>
			                                    	
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  
			                                         		 placeholder="Enter Cement Name" id="cement_name"   name="cement_name"/>
			                                    </div>
			                                </div>
			                            </div>
			                             <div class="col-sm-12 row">
			                            	<div class="col-sm-2"></div>
			                            	<div class="col-sm-8">
			                            		<table class="table table-bordered table-condensed">
			                            			<thead>
			                            				<tr style="background-color: #3eced6;color: white;">
			                            					<th>S/L No</th>
			                            					<th>Mix Types</th>
			                            					<th>Product</th>
			                            					<th>Quantity</th>
			                            				</tr>
			                            			</thead>
			                            			<tbody>
			                            				<tr>
			                            					<td>1</td>
			                            					<td>Aggr1</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"    id="aggregate1_name"  name="aggregate1_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate1_value"  name="aggregate1_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>2</td>
			                            					<td>Aggr2</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate2_name"  name="aggregate2_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate2_value"  name="aggregate2_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>3</td>
			                            					<td>Aggr3</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate3_name"  name="aggregate3_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate3_value"  name="aggregate3_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>4</td>
			                            					<td>Aggr4</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate4_name"  name="aggregate4_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate4_value"  name="aggregate4_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>5</td>
			                            					<td>Cem1</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate5_name"  name="aggregate5_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate5_value"  name="aggregate5_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>6</td>
			                            					<td>Cem2</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate6_name"  name="aggregate6_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate6_value"  name="aggregate6_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>7</td>
			                            					<td>Cem3</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate7_name"  name="aggregate7_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate7_value"  name="aggregate7_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>8</td>
			                            					<td>Water</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate8_name"  name="aggregate8_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate8_value"  name="aggregate8_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>9</td>
			                            					<td>Admix1</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate9_name"  name="aggregate9_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate9_value"  step="0.01" name="aggregate9_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>10</td>
			                            					<td>Admix10</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate10_name"  name="aggregate10_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   step="0.01"   id="aggregate10_value"  name="aggregate10_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>11</td>
			                            					<td>Aggr5</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"      id="aggregate11_name"  name="aggregate11_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate11_value"  name="aggregate11_value"/>
			                            					</td>
			                            				</tr>
			                            			</tbody>
			                            		</table>
			                            	</div>
			                            </div>
		                               
		                                <div class="col-sm-12 text-center">
		                                	<div class="form-group">
			                                    <div>
			                                    	<input type="hidden" name="gst_percent" value="" id="gst_percent">
			                                        <button type="submit" id="save-option" class="btn btn-custom waves-effect waves-light">
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
        <!-- end wrapper -->
		<sql:query var="pro" dataSource="jdbc/rmc">
			select * from product
		</sql:query>
		<c:set var="name">
			<select   class="select2 col-xs-12" name="product_id">'+
				<c:forEach items="${pro.rows}" begin="0" var="pro">
					'<option value="${pro.product_id}">${pro.product_name}</option>'+
				</c:forEach>
			'</select>
		</c:set>

        <!-- Footer -->
       <%@ include file="../footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/popper.min.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/waves.js"></script>
        <script src="../assets/js/jquery.slimscroll.js"></script>

        <!-- Parsley js -->
        <script type="text/javascript" src="../plugins/parsleyjs/parsley.min.js"></script>

        <!-- App js -->
        <script src="../assets/js/jquery.core.js"></script>
        <script src="../assets/js/jquery.app.js"></script>
        <script src="../assets/js/select2.min.js"></script>
		<script src="../picker/js/bootstrap-datepicker.min.js"></script>
		<script src="../picker/js/moment.min.js"></script>
		<script src="../picker/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="../js/AddPurchaseOrder2.js"></script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				$('#site_id').on('change',function(){
					var site_id=$('#site_id').val();
					$.ajax({
						type:'post',
						url:'../CustomerControllerTest?action=siteDetailsUsingId&site_id='+site_id,
						headers:{
							Accept:"text/html;charset=utf-8",
							"Content-Type":"text/html;charset=utf-8"
						},
						success:function(res){
							$('#site_address').val(res);
						}
					});
				});
			});
		</script>
		<script type="text/javascript">
			$(document).ready(function () {
			    function addRow(){
			        var html = '<tr>'+
									'<td>'+
										'${name}'+
									'</td>'+
									'<td>'+
										'<input type="text" class="form-control" pattern="[^\'&quot;:]*$"  required="required" placeholder="Enter Quantity"   name="quantity"/>'+
									'</td>'+
									'<td>'+
										'<input type="text" class="form-control"  pattern="[^\'&quot;:]*$"  required="required" placeholder="Enter Rate"   name="rate"/>'+
									'</td>'+
									'<td>'+
										'<span class="text-danger removebtn"><i class="fa fa-trash"></i></span>'+
									'</td>'+
								'</tr>'
			        $(html).appendTo($("#Table1"))
			        $('.select2').css('width','100%').select2({allowClear:true})
					.on('change', function(){
					}); 
			    };
			    $("#clicked").on("click", ".BtnPlus", addRow);
			});
			 $('#Table1').on('click', '.removebtn', function(){
				    $(this).closest ('tr').remove ();
			});
		</script>
		
		<script type="text/javascript">
			function getGstDetails(){
				var gst_type=$('#gst_type').val();
				$.ajax({
					type:'POST',
					url:'../SettingController?action=getGstDetails&gst_type='+gst_type,
					headers:{
						Accept:"text/html;charset=utf-8",
						"Content-Type":"text/html;charset=utf-8"
					},
					success:function(res){
						if(res==''){
							alert("Please set gst % in GST Setting");
							$('#save-option').prop("disabled",true);
						}else{
							$('#gst_percent').val(res);
						}
					}
				})
			}
		</script>
		<script type="text/javascript">
			$(document).ready(function(){
				getGstDetails();
			});
			
			$(document).ready(function(){
				$('#gst_type').on("change",function(){
					getGstDetails();
				});
			});
		</script>
		<script type="text/javascript">
			$(document).ready(function(){
				$('#site_id').on("change",function(){
					var site_id=$('#site_id').val();
					var plant_id=$('#plant_id').val();
					$.ajax({
						type:'post',
						url:'../CustomerControllerTest?action=GetSiteName&site_id='+site_id,
						headers:{
							Accept:"application/json;charset=utf-8",
							"Content-Type":"application/json;charset=utf-8"
						},
						success:function(result){
							$('#show_site_name').text(result.site_name);
							$('#show_site_address').text(result.site_address);
							$.ajax({
								type:'post',
								url:'../PurchaseOrderControllerTest?action=GetGradeList&site_id='+site_id+'&plant_id='+plant_id,
								headers:{
									Accept:"application/json;charset=utf-8",
									"Content-Type":"application/json;charset=utf-8"
								},
								success:function(res){
									$('#product_id').html('');
									$('#select2-product_id-container').html('Choose Grade');
					        		$('#product_id').append('<option value="" selected disabled>Choose Grade</option>');
					        		$.each(res, function(index, value) {
					        			   $('#product_id').append("<option value='"+ value.product_id+ "'>" + value.product_name + "</option>");
					        		});
								}
							});
						}
					});	
				});
			});
		</script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				$('#receipe_code').on("keyup",function(){
					var receipe_code=$('#receipe_code').val();
					$.ajax({
						type:'POST',
						url:'../MixDesignController?action=GetSingleMixDesign&receipe_code='+receipe_code,
						headers:{
							Accept:"application/json;charset=utf-8",
							"Content-Type":"application/json;charset=utf-8"
						},
						success:function(res){
							$('#aggregate1_name').val(res.aggregate1_name);
							$('#aggregate1_value').val(res.aggregate1_value);
							$('#aggregate2_name').val(res.aggregate2_name);
							$('#aggregate2_value').val(res.aggregate2_value);
							$('#aggregate3_name').val(res.aggregate3_name);
							$('#aggregate3_value').val(res.aggregate3_value);
							$('#aggregate4_name').val(res.aggregate4_name);
							$('#aggregate4_value').val(res.aggregate4_value);
							$('#aggregate5_name').val(res.aggregate5_name);
							$('#aggregate5_value').val(res.aggregate5_value);
							$('#aggregate6_name').val(res.aggregate6_name);
							$('#aggregate6_value').val(res.aggregate6_value);
							$('#aggregate7_name').val(res.aggregate7_name);
							$('#aggregate7_value').val(res.aggregate7_value);
							$('#aggregate8_name').val(res.aggregate8_name);
							$('#aggregate8_value').val(res.aggregate8_value);
							$('#aggregate9_name').val(res.aggregate9_name);
							$('#aggregate9_value').val(res.aggregate9_value);
							$('#aggregate10_name').val(res.aggregate10_name);
							$('#aggregate10_value').val(res.aggregate10_value);
							$('#aggregate11_name').val(res.aggregate11_name);
							$('#aggregate11_value').val(res.aggregate11_value);
						}
					});
				});
			});
		
		</script>
    </body>
</html>