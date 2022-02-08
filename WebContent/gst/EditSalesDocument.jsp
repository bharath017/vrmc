<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Edit Sales Document</title>
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

		<style type="text/css">
			.error{
				color:red;
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
                                    <li class="breadcrumb-item"><a href="#">Billing</a></li>
                                    <li class="breadcrumb-item"><a href="#">Sales Document</a></li>
                                    <li class="breadcrumb-item"><a href="#">Edit Sales Document</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Update Sales Document</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="SalesDocumentList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Sales Document List</a>
                    </div><!-- end col -->
                </div>
                <sql:query var="sale" dataSource="jdbc/rmc">
                	select id,invoice_id,DATE_FORMAT(invoice_date,'%d/%m/%Y') as invoice_date,invoice_time,plant_id,
                	s.customer_id,s.site_id,vehicle_no,driver_name,st.site_address
                    from test_sales_document s,test_site_detail st
                	where s.site_id=st.site_id and  id=?
                	<sql:param value="${param.id}"/>
                </sql:query>
                <c:forEach items="${sale.rows}" var="sale">
                	<c:set value="${sale}" var="rs"/>
                </c:forEach>
                <!-- end row -->
               		<div class="row">
	                    <div class="col-sm-12">
	                    	<form class="" action="../SalesDocumentControllerTest?action=updateSalesDocument" method="post" id="sales-document-form">
		                        <div class="card-box row col-sm-12">
		                           	<div class="col-sm-4">
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
		                                    <input type="hidden" name="id" value="${rs.id}" id="id"/>
											<select id="plant_id"  name="plant_id"  required="required"
												  class="form-control"  data-placeholder="Choose Plant">
												<c:forEach var="plant" items="${plant.rows}">
												<option value="${plant.plant_id}" 
														${(plant.plant_id==rs.plant_id)?'selected':''}>${plant.plant_name}</option>
												</c:forEach>
											</select>
		                                </div>
		                                <div class="form-group">
		                                    <label>Invoice No<span class="text-danger">*</span> </label>
		                                    <div>
		                                       <input type="text" class="form-control" 
		                                              id="invoice_no" name="invoice_no" readonly="readonly" value="${rs.invoice_id}" style="background-color: white;"/>
		                                    </div>
		                                </div>
		                                <div class="form-group">
                                               <label>Invoice Date <span class="text-danger"></span> </label>
                                               <div>
                                                   <div class="input-group">
                                                       <input type="text" name="invoice_date" class="form-control date-picker"
                                                       		  placeholder="dd/mm/yyyy" id="id-date-picker-1"
                                                       		  data-date-format="dd/mm/yyyy" value="${rs.invoice_date}"
                                                       		  readonly="readonly" style="background-color: white;">
                                                       <div class="input-group-append picker">
                                                           <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                       </div>
                                                   </div>
                                               </div>
                                         </div>
		                            </div>
		                            <div class="col-sm-4">
		                                 <div class="form-group">
		                                    <label>Customer <span class="text-danger">*</span></label>
		                                    <sql:query var="customer" dataSource="jdbc/rmc">
		                                    	select customer_id,customer_name
		                                        from test_customer 
		                                    	where business_id like if(?=0,'%%',?)
		                                    	order by customer_name asc
		                                    	<sql:param value="${bean.business_id}"/>
		                                    	<sql:param value="${bean.business_id}"/>
		                                    </sql:query>
											<select id="customer_id"  name="customer_id"  
													  class="select2"  data-placeholder="Choose Customer" required="required">
												<option value="">&nbsp;</option>
												<c:forEach var="customer" items="${customer.rows}">
												<option value="${customer.customer_id}"
														 ${(rs.customer_id==customer.customer_id)?'selected':''}>${customer.customer_name}</option>
												</c:forEach>
											</select>
		                                </div>
		                                
										<sql:query var="site" dataSource="jdbc/rmc">
											select site_id,site_name
											from site_detail 
											where customer_id=?
											<sql:param value="${rs.customer_id}"/>
										</sql:query>		                                
		                                <div class="form-group">
		                                    <label>Site Name<span class="text-danger">*</span></label>
											<select id="site_id"  name="site_id" required="required"   
													class="form-control"  data-placeholder="Choose Site">
												<c:forEach items="${site.rows}" var="site">
													<option value="${site.site_id}"
															 ${(site.site_id==rs.site_id)?'selected':''}>${site.site_name}</option>
												</c:forEach>
											</select>
		                                </div>
		                                
		                                <div class="form-group">
		                                    <label>Site Address <span class="text-danger">*</span> </label>
		                                    <div>
		                                       <textarea class="form-control" 
		                                              id="site_address" name="site_address" readonly="readonly">${rs.site_address}</textarea>
		                                    </div>
		                                </div>
		                                
		                             </div>
		                             
		                             <div class="col-sm-4">
		                           		<div class="form-group">
		                                    <label>Vehicle No <span class="text-danger">*</span></label>
		                                    <sql:query var="vehicle" dataSource="jdbc/rmc">
		                                    	select vehicle_no
		                                        from vehicle
		                                    </sql:query>
											<select id="vehicle_no"  name="vehicle_no"  required="required"
												  class="select2"  data-placeholder="Choose Vehicle">
												<c:forEach var="vehicle" items="${vehicle.rows}">
												<option value="${vehicle.vehicle_no}" 
														${(vehicle.vehicle_no==rs.vehicle_no)?'selected':''}>${vehicle.vehicle_no}</option>
												</c:forEach>
											</select>
		                                </div>
		                           	   <div class="form-group">
		                                    <label>Driver </label>
		                                    <sql:query var="driver" dataSource="jdbc/rmc">
		                                    	select driver_name 
		                                    	from driver
		                                    </sql:query>
											<select id="driver_name"  name="driver_name"  
													  class="select2"  data-placeholder="Choose Driver">
												<option value="">&nbsp;</option>
												<c:forEach var="driver" items="${driver.rows}">
												<option value="${driver.driver_name}"
														 ${(driver.driver_name==rs.driver_name)?'selected':''}>${driver.driver_name}</option>
												</c:forEach>
											</select>
		                                </div>
		                                
		                                <div class="form-group">
		                                    <label>Invoice Time <span class="text-danger">*</span> </label>
		                                    <div>
		                                        <div class="input-group">
		                                            <input type="text" name="invoice_time" class="form-control" 
		                                            	required="required" placeholder="HH:MM:SS" value="${rs.invoice_time}"
			                                             id="timepicker1" data-date-format="yyyy-mm-dd">
		                                            <div class="input-group-append">
		                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
		                                            </div>
		                                        </div>
		                                    </div>
		                                </div>
		                            </div>
		                             <div class="col-sm-12" id="clicked">
	                                	<table class="table table-bordered" id="Table1">
	                                		<thead>
	                                			<tr style="background-color: #ce9401;color: white;">
		                                			<th class="text-center" style="width: 15%;">Item <span class="text-white">*</span></th>
		                                			<th class="text-center">Rate <span class="text-white">*</span></th>
		                                			<th class="text-center">Quantity <span class="text-white">*</span></th>
		                                			<th class="text-center" style="width: 10%;">GST@% <span class="text-white">*</span></th>
		                                			<th class="text-center">Gross Amount <span class="text-white">*</span></th>
		                                			<th class="text-center">Tax Amount <span class="text-white">*</span></th>
		                                			<th class="text-center">Net Amount <span class="text-white">*</span></th>
		                                			<th class="text-center">
		                                				<span class="text-white BtnPlus">
		                                					<i class="fa fa-plus"></i>
		                                				</span>
		                                			</th>
		                                		</tr>
	                                		</thead>
	                                		
	                                		<sql:query var="sitem" dataSource="jdbc/rmc">
	                                			select si.poi_id,si.sditem_id,si.id,si.item_quantity,si.item_price,
	                                			si.gross_price,si.tax_price,si.net_price,p.product_name,g.gst_percent,g.gst_category,po.rate_include_tax
	                                			from test_sales_document_item si LEFT JOIN (test_purchase_order_item poi,product p,test_purchase_order po,gst_percent g)
	                                			ON si.poi_id=poi.poi_id
	                                			and poi.product_id=p.product_id
	                                			and poi.order_id=po.order_id
	                                			and po.gst_id=g.gst_id
	                                			where id=?
	                                			<sql:param value="${param.id}"/>
	                                		</sql:query>
	                                		<tbody>
	                                			<c:set value="0" var="vall"/>
	                                			<c:set value="0" var="total_gross"/>
	                                			<c:set value="0" var="total_net"/>
	                                			<c:set value="0" var="total_tax"/>
	                                			<c:forEach items="${sitem.rows}" var="sitem">
		                                			<tr>
		                                				<td>
		                                					<input type="hidden" name="sditem_id[${vall}]" value="${sitem.sditem_id}"/>
															<select required="required"  name="poi_id[${vall}]" 
																	  class="form-control poi_id" title="poi_id"  data-placeholder="Choose Item">
																	  <option value="${sitem.poi_id}">${sitem.product_name}</option>
															</select>		                                				
		                                				</td>
		                                				<td>
		                                					<input type="number" class="form-control rate" 
			                                         			pattern="[^'&quot;:]*$" required="required" style="background-color: white;"
			                                         			 placeholder="Fetch Rete" readonly="readonly"
			                                         		     title="rate"  name="rate[${vall}]" value="${sitem.item_price}"/>
		                                				</td>
		                                				<td>
		                                					<input type="text" class="form-control quantity" 
			                                        			 pattern="[^'&quot;:]*$"  required="required" title="quantity" 
			                                        			 placeholder="Enter Quantity" name="quantity[${vall}]" value="${sitem.item_quantity}"/>
		                                				</td>
		                                				<td>
		                                					<input type="text" class="form-control gst_percent" title="gst_percent" 
		                                							 pattern="[^\'&quot;:]*$" readonly="readonly"
		                                						     required="required" name="gst_percent[${vall}]" value="${sitem.gst_category}@${sitem.gst_percent}%"/>
		                                					<input type="hidden" name="gst[${vall}]" class="gst" title="gst" value="${sitem.gst_percent}"/>
		                                					<input type="hidden" name="rate_include_tax[${vall}]"
		                                						   class="rate_include_tax" title="rate_include_tax" value="${sitem.rate_include_tax}"/>
		                                				</td>
		                                				<td>
		                                					<input type="text" class="form-control gross_amount" title="gross_amount" pattern="[^\'&quot;:]*$"
		                                							 readonly="readonly"  required="required" name="gross_amount[${vall}]" value="${sitem.gross_price}"/>
		                                				</td>
		                                				<td>
		                                					<input type="text" class="form-control tax_amount" title="tax_amount"  readonly="readonly"
		                                							 pattern="[^\'&quot;:]*$"  required="required"   name="tax_amount[${vall}]" value="${sitem.tax_price}"/>
		                                				</td>
		                                				<td>
		                                					<input type="text" class="form-control net_amount" title="net_amount"  readonly="readonly"
		                                							 pattern="[^\'&quot;:]*$"  required="required"   name="net_amount[${vall}]" value="${sitem.net_price}"/>
		                                				</td>
		                                				<td>
		                                					<a class="text-danger deleteSalesDocumentItem" id="${sitem.sditem_id}">
		                                						<span><i class="fa fa-trash"></i></span>
		                                					</a>
		                                				</td>
		                                			</tr>
		                                			<c:set value="${vall+1}" var="vall"/>
		                                			<c:set value="${total_gross+sitem.gross_price}" var="total_gross"/>
		                                			<c:set value="${total_net+sitem.net_price}" var="total_net"/>
		                                			<c:set value="${total_tax+sitem.tax_price}" var="total_tax"/>
	                                			</c:forEach>
	                                		</tbody>
	                                		<tfoot>
	                                			<tr>
	                                				<td colspan="5" class="text-right">Total Gross Amount : </td>
	                                				<td class="text-left" colspan="2" id="total_gross_amount">${total_gross}</td>
	                                			</tr>
	                                			<tr>
	                                				<td colspan="5" class="text-right">Total Tax Amount : </td>
	                                				<td class="text-left" colspan="2" id="total_tax_amount">${total_tax}</td>
	                                			</tr>
	                                			<tr>
	                                				<td colspan="5" class="text-right">Total Net Amount : </td>
	                                				<td class="text-left" colspan="2" id="total_net_total">${total_net}</td>
	                                			</tr>
	                                		</tfoot>
	                                	</table>
	                                	<input type="hidden" name="count" id="count" value="${vall}"/>
	                                </div>
	                                <div class="col-sm-12 text-center">
	                                	<div class="form-group">
		                                    <div>
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
                	
                <!-- end row -->

            </div> <!-- end container -->
        </div>
        <!-- Footer -->
       <%@ include file="../footer.jsp" %>
        <!-- End Footer -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/popper.min.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/waves.js"></script>
        <script src="../assets/js/jquery.slimscroll.js"></script>

        <!-- App js -->
        <script src="../assets/js/jquery.core.js"></script>
        <script src="../assets/js/jquery.app.js"></script>
        <script src="../assets/js/select2.min.js"></script>
		<script src="../picker/js/bootstrap-datepicker.min.js"></script>
		<script src="../assets/js/bootstrap-timepicker.min.js"></script>
		<script src="../picker/js/moment.min.js"></script>
		<script src="../picker/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="../validation/jquery.validate.min.js"></script>
		<script src="../js/Pickers/dateTimeValidatorEdit.js"></script>
		<script src="js/SalesDocument/EditSalesDocument.js"></script>
    </body>
</html>