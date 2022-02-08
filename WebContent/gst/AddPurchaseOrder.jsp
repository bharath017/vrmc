<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Sales Order</title>
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
                                    <li class="breadcrumb-item"><a href="#">Customer &amp; Purchase Order</a></li>
                                    <li class="breadcrumb-item"><a href="#">Sales Order</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Sales Order</a></li>
                                </ol>
                            </div>
                            <c:choose>
                            	<c:when test="${param.action=='update'}">
                            		<h4 class="page-title">Update Sales Order</h4>
                            	</c:when>
                            	<c:otherwise>
                            		<h4 class="page-title">Add Sales Order</h4>
                            	</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="PurchaseOrderList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Sales Order List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="po" dataSource="jdbc/rmc">
                			select p.*,DATE_FORMAT(p.po_date,'%d/%m/%Y') as po_date,DATE_FORMAT(p.po_valid_till,'%d/%m/%Y') as po_valid_till,
                			s.site_address from test_purchase_order p,test_site_detail s where p.site_id=s.site_id and  p.order_id=?
                			<sql:param value="${param.order_id}"/>
                		</sql:query> 
                		<c:forEach items="${po.rows}" var="po">
                			<c:set value="${po}" var="res"/>
                		</c:forEach>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="../PurchaseOrderControllerTest?action=UpdatePurchaseOrder" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                           	   <div class="form-group">
			                                    <label>Customer <span class="text-danger">*</span></label>
			                                    <sql:query var="customer" dataSource="jdbc/rmc">
			                                    	select customer_id,customer_name
			                                    	from test_customer
			                                        where customer_status='active'
			                                        and business_id like if(0=?,'%%',?)
			                                        and plant_id like if(?=0,'%%',?)
			                                        order by customer_name asc
			                                        <sql:param value="${bean.business_id}"/>
			                                        <sql:param value="${bean.business_id}"/>
			                                        <sql:param value="${bean.plant_id}"/>
			                                        <sql:param value="${bean.plant_id}"/>
			                                    </sql:query>
			                                    <input type="hidden" name="order_id" value="${res.order_id}">
												<select id="customer_id"  name="customer_id"    class="select2"  data-placeholder="Choose Customer" required="required">
													<option value="">&nbsp;</option>
													<c:forEach var="customer" items="${customer.rows}">
													<option value="${customer.customer_id}" ${(res.customer_id==customer.customer_id)?'selected':''}>${customer.customer_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <!-- get all activated site according to perticular customer -->
			                                <sql:query var="site" dataSource="jdbc/rmc">
			                                	select site_id,site_name
			                                    from test_site_detail
			                                    where customer_id=?
			                                	<sql:param value="${res.customer_id}"/>
			                                </sql:query>
			                                
			                                <div class="form-group">
			                                    <label>Site Name<span class="text-danger">*</span></label>
												<select id="site_id"  name="site_id" required="required"   class="select2"  data-placeholder="Choose Site">
													<c:forEach items="${site.rows}" var="site">
														<option value="${site.site_id}" ${(site.site_id==res.site_id)?'selected':''}>${site.site_name}</option>
													</c:forEach>
												</select>
			                                </div>
														                                
			                                <div class="form-group">
			                                    <label>Site Address<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  required="required"  value="${res.site_address}"  id="site_address" readonly="readonly" name="site_address"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
                                                <label>Order Date <span class="text-danger"></span> </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="po_date" class="form-control date-picker"
                                                        	 value="${res.po_date}" placeholder="dd/mm/yyyy" id="id-date-picker-2"
                                                        	 data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                             <div class="form-group">
                                                <label>PO Validity <span class="text-danger"></span> </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="po_valid_till" class="form-control date-picker"
                                                        	 value="${res.po_valid_till}" placeholder="dd/mm/yyyy"
                                                             data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
			                                    <label>Credit Days : </label>
			                                    <div>
			                                       <input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Credit days" value="${res.credit_days}"   name="credit_days"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="col-sm-12 row">
			                               		 <div class="col-sm-8">
				                                	<div class="form-group">
														<label class="control-label">Bill Photo  : </label>
															<div class=" find">
																<input type="file" class="form-control" accept="image/x-png,image/gif,image/jpeg" class="find" id="id-input-file-1" />
																<input type="text" readonly="readonly"   class="form-control" value="${res.bill_photo}" name="bill_photo" id="bill_photo"/>
														</div>
														<button type="button"  class="btn btn-primary btn-xs button" onclick="uploadImage(this);" value="pan">UPLOAD</button>
													</div>
				                                </div>
				                                <div class="col-sm-2">
				                                	 <div class="form-group "> 
														&nbsp;&nbsp;&nbsp;<img alt="img" id="photo-image" src="document/${(empty res.bill_photo)?'unknown.jpg':res.bill_photo}" width="100" height="80">
											        </div>
				                                </div>
				                            </div>  
			                            </div>
			                            <div class="col-sm-6">
			                               <div class="form-group">
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
												<select id="plant_id"  name="plant_id"  required="required"  class="select2"  data-placeholder="Choose Plant">
													<c:if test="${bean.plant_id==0}">
													<option value="0" ${(res.plant_id==0)?'selected':''}>All Plant</option>
													</c:if>
													<c:forEach var="plant" items="${plant.rows}">
													<option value="${plant.plant_id}" ${(plant.plant_id==res.plant_id)?'selected':''}>${plant.plant_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>PO No : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter PO No."  value="${res.po_number}"  name="po_number"/>
			                                    </div>
			                                </div>
			                                
			                               <div class="form-group">
			                                    <label>GST Category <span class="text-danger">*</span></label>
			                                    <sql:query var="gst" dataSource="jdbc/rmc">
			                                    	select * from gst_percent
			                                    </sql:query>
												<select id="gst_id"  name="gst_id" required="required"   class="select2"  data-placeholder="Select GST Category">
													<c:forEach items="${gst.rows}" var="gst">
														<option value="${gst.gst_id}" ${(gst.gst_id==res.gst_id)?'selected':''}>${gst.gst_category} @${gst.gst_percent}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                 <div class="form-group">
			                                    <label>Order Type<span class="text-danger">*</span></label>
												<select id="order_type"  name="order_type"   class="select2"  data-placeholder="Choose Plant">
													<option value="close" ${(res.order_type=='close')?'selected':''}>CLOSE ORDER</option>
													<option value="open" ${(res.order_type=='open')?'selected':''}>OPEN ORDER</option>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Marketing Person <span class="text-danger">*</span></label>
			                                    <sql:query var="market" dataSource="jdbc/rmc">
			                                    	select mp_id,mp_name
			                                        from marketing_person
			                                        where mp_status='active'
			                                        order by mp_name asc
			                                    </sql:query>
												<select id="mp_id"  name="mp_id"    class="form-control"  required="required">
													<c:forEach var="market" items="${market.rows}">
													<option value="${market.mp_id}" ${(market.mp_id==res.marketing_person_id)?'selected':''}>${market.mp_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Credit Limit : </label>
			                                    <div>
			                                       <input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$" step="0.01" placeholder="Enter Credit Limit"  value="${res.credit_limit}"  name="credit_limit"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                	 <label>&nbsp;</label>
			                                    <div class="checkbox checkbox-custom">
		                                            <input id="checkbox11" name="rate_include_tax" type="checkbox" ${(res.rate_include_tax=='yes')?'checked':''}>
		                                            <label for="checkbox11">
		                                                Rate Include Tax?
		                                            </label>
		                                        </div>
			                                </div>
			                             </div>
			                             <div class="col-sm-12" id="clicked">
		                                	<table class="table table-bordered" id="Table1">
		                                		<thead>
		                                			<tr>
			                                			<th class="text-center">Grade</th>
			                                			<th class="text-center">Quantity</th>
			                                			<th class="text-center">Rate</th>
			                                			<th class="text-center">
			                                				<span class="text-success BtnPlus">
			                                					<i class="fa fa-plus"></i>
			                                				</span>
			                                			</th>
			                                		</tr>
		                                		</thead>
		                                		
		                                		<!-- get purchase order details -->
		                                		<sql:query var="poi" dataSource="jdbc/rmc">
		                                			select * from test_purchase_order_item
		                                		    where order_id=?
		                                			<sql:param value="${res.order_id}"/>
		                                		</sql:query>
		                                		<tbody>
		                                			<c:forEach items="${poi.rows}" var="poi">
		                                				<tr>
			                                				<td style="width:30%">
																<sql:query var="grade" dataSource="jdbc/rmc">
							                                    	select * from product
							                                    </sql:query>
							                                    <input type="hidden" name="poi_id" value="${poi.poi_id}">
																<select id="product_id" required="required"  name="product_id"   class="select2"  data-placeholder="Choose Grade">
																	<option value="">&nbsp;</option>
																	<c:forEach var="grade" items="${grade.rows}">
																	<option value="${grade.product_id}" ${(grade.product_id==poi.product_id)?'selected':''}>${grade.product_name}</option>
																	</c:forEach>
																</select>		                                				
			                                				</td>
			                                				<td style="width:30%">
			                                					<input type="text" class="form-control" 
				                                         pattern="[^'&quot;:]*$"  value="${poi.quantity}" required="required" placeholder="Enter Quantity"   name="quantity"/>
			                                				</td>
			                                				<td style="width:35%">
			                                					<input type="text" class="form-control" 
				                                         pattern="[^'&quot;:]*$" value="${poi.rate}"  required="required" placeholder="Enter Rate"   name="rate"/>
			                                				</td>
			                                				<td></td>
			                                			</tr>
		                                			</c:forEach>
		                                		</tbody>
		                                	</table>
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
		                    	<form class="" action="../PurchaseOrderControllerTest?action=insert" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                           	   <div class="form-group">
			                                    <label>Customer <span class="text-danger">*</span></label>
			                                    <sql:query var="customer" dataSource="jdbc/rmc">
			                                    	select customer_id,customer_name
			                                        from test_customer
			                                        where customer_status='active'
			                                        and business_id like if(0=?,'%%',?)
			                                        and plant_id like if(?=0,'%%',?)
			                                        order by customer_name asc
			                                        <sql:param value="${bean.business_id}"/>
			                                        <sql:param value="${bean.business_id}"/>
			                                        <sql:param value="${bean.plant_id}"/>
			                                        <sql:param value="${bean.plant_id}"/>
			                                    </sql:query>
												<select id="customer_id"  name="customer_id"    class="select2"  data-placeholder="Choose Customer" required="required">
													<option value="">&nbsp;</option>
													<c:forEach var="customer" items="${customer.rows}">
													<option value="${customer.customer_id}">${customer.customer_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Site Name<span class="text-danger">*</span></label>
												<select id="site_id"  name="site_id" required="required"   class="select2"  data-placeholder="Choose Site">
													
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Site Address<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  required="required"   id="site_address" readonly="readonly" name="site_address"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
                                                <label>Order Date <span class="text-danger"></span> </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="po_date" class="form-control date-picker" 
                                                        		placeholder="dd/mm/yyyy" id="id-date-picker-1"
                                                        	    data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;">
                                                        <div class="input-group-append picker">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                             <div class="form-group">
                                                <label>PO Validity <span class="text-danger"></span> </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="po_valid_till" class="form-control date-picker" 
                                                        	placeholder="dd/mm/yyyy" id="id-date-picker-1"
                                                            data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;">
                                                        <div class="input-group-append picker">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
			                                    <label>Credit Days : </label>
			                                    <div>
			                                       <input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Credit days"   name="credit_days"/>
			                                    </div>
			                                </div>
                                            
			                               <div class="col-sm-12 row">
			                               		 <div class="col-sm-8">
				                                	<div class="form-group">
														<label class="control-label">Bill Photo  : </label>
															<div class=" find">
																<input type="file" class="form-control" accept="image/x-png,image/gif,image/jpeg" class="find" id="id-input-file-1" />
																<input type="text" readonly="readonly"  class="form-control" value="${rs.bill_photo}" name="bill_photo" id="bill_photo"/>
														</div>
														<button type="button"  class="btn btn-primary btn-xs button" onclick="uploadImage(this);" value="pan">UPLOAD</button>
													</div>
				                                </div>
				                                <div class="col-sm-2">
				                                	 <div class="form-group "> 
														&nbsp;&nbsp;&nbsp;<img alt="img" id="photo-image" src="document/${(empty rs.bill_photo)?'unknown.jpg':rs.bill_photo}" width="100" height="80">
											        </div>
				                                </div>
				                               </div>
			                            </div>
			                            <div class="col-sm-6">
			                               <div class="form-group">
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
												<select id="plant_id"  name="plant_id"  required="required"  class="select2"  data-placeholder="Choose Plant">
													<c:if test="${bean.plant_id==0}">
														<option value="0">All Plant</option>
													</c:if>
													<c:forEach var="plant" items="${plant.rows}">
													<option value="${plant.plant_id}">${plant.plant_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>PO No : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter PO No."   name="po_number"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>GST Category <span class="text-danger">*</span></label>
			                                    <sql:query var="gst" dataSource="jdbc/rmc">
			                                    	select * from gst_percent
			                                    </sql:query>
												<select id="gst_id"  name="gst_id" required="required"   class="select2"  data-placeholder="Select GST Category">
													<c:forEach items="${gst.rows}" var="gst">
														<option value="${gst.gst_id}" ${(gst.gst_percent==18 && gst.gst_category=='GST')?'selected':''}>${gst.gst_category} @${gst.gst_percent}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Order Type<span class="text-danger">*</span></label>
												<select id="order_type"  name="order_type"   class="select2"  data-placeholder="Choose Plant">
													<option value="close">CLOSE ORDER</option>
													<option value="open">OPEN ORDER</option>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Marketing Person <span class="text-danger">*</span></label>
			                                    <sql:query var="market" dataSource="jdbc/rmc">
			                                    	select mp_id,mp_name
			                                        from marketing_person
			                                        where mp_status='active'
			                                        order by mp_name asc
			                                    </sql:query>
												<select id="mp_id"  name="mp_id"    class="form-control" 
													    required="required">
													<c:forEach var="market" items="${market.rows}">
													<option value="${market.mp_id}">${market.mp_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Credit Limit : </label>
			                                    <div>
			                                       <input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$" step="0.01" placeholder="Enter Credit Limit"   name="credit_limit"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                	 <label>&nbsp;</label>
			                                    <div class="checkbox checkbox-custom">
		                                            <input id="checkbox11" name="rate_include_tax" type="checkbox" checked>
		                                            <label for="checkbox11">
		                                                Rate Include Tax?
		                                            </label>
		                                        </div>
			                                </div>
			                             </div>
			                             <div class="col-sm-12" id="clicked">
		                                	<table class="table table-bordered" id="Table1">
		                                		<thead>
		                                			<tr>
			                                			<th class="text-center">Grade</th>
			                                			<th class="text-center">Quantity</th>
			                                			<th class="text-center">Rate</th>
			                                			<th class="text-center">
			                                				<span class="text-success BtnPlus">
			                                					<i class="fa fa-plus"></i>
			                                				</span>
			                                			</th>
			                                		</tr>
		                                		</thead>
		                                		<tbody>
		                                			<tr>
		                                				<td style="width:30%">
															<sql:query var="grade" dataSource="jdbc/rmc">
						                                    	select product_id,product_name
						                                    	from product
						                                    	where business_id like if(?=0,'%%',?)
						                                    	<sql:param value="${bean.business_id}"/>
						                                    	<sql:param value="${bean.business_id}"/>
						                                    </sql:query>
															<select id="product_id" required="required"  name="product_id"   class="select2"  data-placeholder="Choose Grade">
																<option value="">&nbsp;</option>
																<c:forEach var="grade" items="${grade.rows}">
																<option value="${grade.product_id}">${grade.product_name}</option>
																</c:forEach>
															</select>		                                				
		                                				</td>
		                                				<td style="width:30%">
		                                					<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  required="required" placeholder="Enter Quantity"   name="quantity"/>
		                                				</td>
		                                				<td style="width:35%">
		                                					<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  required="required" placeholder="Enter Rate"   name="rate"/>
		                                				</td>
		                                				<td></td>
		                                			</tr>
		                                		</tbody>
		                                	</table>
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
			select product_id,product_name
			from product
			where business_id like if(?=0,'%%',?)
			<sql:param value="${bean.business_id}"/>
			<sql:param value="${bean.business_id}"/>
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
		<script src="../assets/js/bootstrap-timepicker.min.js"></script>
		<c:choose>
			<c:when test="${empty param.action}">
				<script type="text/javascript" src="../js/Pickers/dateTimeValidator.js"></script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript" src="../js/Pickers/dateTimeValidatorEdit.js"></script>
			</c:otherwise>
		</c:choose>
		
		<script type="text/javascript">
			$(document).ready(function(){
				$('#customer_id').on('change',function(){
					var customer_id=$('#customer_id').val();
					getMarketingPersonDetails(customer_id);
					$.ajax({
						type:'POST',
						url:'../CustomerControllerTest?action=getCustomerSiteDetails&customer_id='+customer_id,
						headers:{
							Accept:"application/json;charset=utf-8",
							"Content-Type":"application/json;charset=utf-8"
						},
						success:function(result){
							$('#select2-site_id-container').html('Choose Site Address');
							$('#site_id').html('');
			        		$('#site_id').html('<option value="">Choose Site Address.</option>');
			        		$.each(result, function(index, value) {
			        			   $('#site_id').append("<option value='"+ value.site_id+ "'>" + value.site_name + "</option>");
			        		});
			        		
						}
					});
				});
				
				
				
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
				
				
				
				var getMarketingPersonDetails=function(customer_id){
					$.ajax({
						type:'post',
						url:'../CustomerControllerTest?action=getCustomerMarketingPerson&customer_id='+customer_id,
						headers:{
							Accept:'application/json;charset=utf-8',
							'Content-Type':'application/json;charset=utf-8'
						},
						success:function(res){
							if(res==null || res=='' || res.mp_id=='' || res.mp_id==null)
								return;
							else{
								$('#mp_id').empty();
								$('#mp_id').append('<option value="'+res.mp_id+'">'+res.mp_name+'</option>');
							}
						}
								
					});
				}
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
		<script>
		 function uploadImage(e){
	    	 var data = new FormData();
    		 jQuery.each(jQuery('#id-input-file-1')[0].files, function(i, file) {
	    	     data.append('file-'+i, file);
	    	 });
	    	 var opts = {
   			    url: '../PurchaseOrderControllerTest?action=upload_file',
   			    data: data,
   			    cache: false,
   			    contentType: false,
   			    processData: false,
   			    type: 'POST',
   			    success: function(data){
   			    	console.log(data);
   			    	var src = (data == '' || data==undefined || data==null || data.trim()=='null')? 'assets/images/gallery/unknown.jpg': ''+data;
   	   	        	 $('#photo-image').attr('src', "document/"+src);
   	   	        	 $('#bill_photo').val(data.trim());
   			    }
   			};
   			if(data.fake) {
   			    // Make sure no text encoding stuff is done by xhr
   			    opts.xhr = function() { var xhr = jQuery.ajaxSettings.xhr(); xhr.send = xhr.sendAsBinary; return xhr; }
   			    opts.contentType = "multipart/form-data; boundary="+data.boundary;
   			    opts.data = data.toString();
   			}
   			jQuery.ajax(opts);
			 
		 } 
		</script>
		
		<script type="text/javascript">
			$(document).ajaxStart(function() {
				 $('#loadme').addClass("loadme");
				 $(".loadme").fadeIn();
			});

			$(document).ajaxStop(function() {
				 $('#loadme').removeClass("loadme");
				 $(".loadme").fadeOut();
			});
		</script>
    </body>
</html>