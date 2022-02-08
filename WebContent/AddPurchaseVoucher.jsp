<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Purchase Order</title>
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
                                    <li class="breadcrumb-item"><a href="#">Customer &amp; Purchase Order</a></li>
                                    <li class="breadcrumb-item"><a href="#">Purchase Order</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Purchase Order</a></li>
                                </ol>
                            </div>
                            <c:choose>
                            	<c:when test="${param.action=='update'}">
                            		<h4 class="page-title">Update Purchase Voucher</h4>
                            	</c:when>
                            	<c:otherwise>
                            		<h4 class="page-title">Add Purchase Voucher</h4>
                            	</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="PurchaseVoucherList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Purchase Voucher List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<!-- Get po details for update -->
                   		<sql:query var="po" dataSource="jdbc/rmc">
                   			select p.*,DATE_FORMAT(p.purchase_date,'%d/%m/%Y') as purchase_date
                   		    from purchase_voucher p
                   		    where purchase_voucher_id=?
                   			<sql:param value="${param.purchase_voucher_id}"/>
                   		</sql:query>
                   		<c:forEach var="po" items="${po.rows}">
                   			<c:set value="${po}" var="rs"/>
                   		</c:forEach>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="PurchaseVoucherController?action=UpdatePurchasevoucher" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                           	   <div class="form-group">
			                                    <label>Bill No : </label>
			                                    <div>
			                                    	<input type="hidden" name="purchase_voucher_id" value="${rs.purchase_voucher_id}">
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Bill No."  value="${rs.bill_no}"  id="bill_no" name="bill_no"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
                                                <label>Purchase Date <span class="text-danger">*</span> </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="purchase_date" class="form-control date-picker"
                                                        	   value="${rs.purchase_date}" placeholder="dd/mm/yyyy" id="id-date-picker-1"
                                                        	   data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                             <div class="form-group">
			                                    <label>Tax Type <span class="text-danger">*</span></label>
												<select id="gst_type"  name="gst_type"   class="select2"  data-placeholder="Choose Plant">
													<option value="GST" ${(rs.gst_type=='GST')?'selected':''}>GST</option>
													<option value="IGST" ${(rs.gst_type=='IGST')?'selected':''}>IGST</option>
												</select>
			                                </div>
			                            </div>
			                            <div class="col-sm-6">
			                               <div class="form-group">
			                                    <label>Supplier Name <span class="text-danger">*</span></label>
			                                    <sql:query var="supplier" dataSource="jdbc/rmc">
			                                    	select supplier_id,supplier_name
			                                    	from supplier 
			                                    	where supplier_status='active'
			                                    	and business_id like if(?=0,'%%',?)
			                                    	<sql:param value="${bean.business_id}"/>
			                                    	<sql:param value="${bean.business_id}"/>
			                                    </sql:query>
												<select id="supplier_id"  name="supplier_id" required="required" class="select2"  data-placeholder="Choose Supplier">
													<option value="">&nbsp;</option>
													<c:forEach var="sup" items="${supplier.rows}">
													<option value="${sup.supplier_id}" 
														${(sup.supplier_id==rs.supplier_id)?'selected':''}>${sup.supplier_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Discount Amount : </label>
			                                    <div>
			                                       <input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Discount" value="${rs.discount_amount}" 
			                                         		onkeyup="calculateNetAmount();" step="0.01" id="discount_amount" name="discount_amount"/>
			                                    </div>
			                                </div>
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
													<option value="0" ${(rs.plant_id==0)?'selected':''}>All Plant</option>
													</c:if>
													<c:forEach var="plant" items="${plant.rows}">
													<option value="${plant.plant_id}"
															 ${(plant.plant_id==rs.plant_id)?'selected':''}>${plant.plant_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                <div class="form-group text-center">
			                                	 <label>&nbsp;</label>
			                                    <div class="checkbox checkbox-custom">
		                                            <input id="checkbox11" name="rate_include_tax" type="checkbox"
		                                            		 ${(rs.rate_include_tax=='yes')?'checked':''} onclick="calculateNetAmount();">
		                                            <label for="checkbox11">
		                                                Rate Include Tax?
		                                            </label>
		                                        </div>
			                                </div>
			                             </div>
			                             
			                             <div class="col-sm-12 text-center">
			                             
			                             	
			                             </div>
			                             
			                            <sql:query var="pro" dataSource="jdbc/rmc">
											select * from inventory_item
										</sql:query>
										<sql:query var="fl" dataSource="jdbc/rmc">
											select * from fleet_item
										</sql:query>
										<c:set var="name">
											<select   class="select2" required="required" name="item_name">'+
												<c:forEach items="${pro.rows}" begin="0" var="pro">
													'<option value="${pro.inventory_name}">${pro.inventory_name}</option>'+
												</c:forEach>
												<c:forEach items="${fl.rows}" begin="0" var="fl">
													'<option value="${fl.item_name}">${fl.item_name}</option>'+
												</c:forEach>
											'</select>
										</c:set>
										
										
										<sql:query var="gst" dataSource="jdbc/rmc">
											select * from gst_percent order by gst_percent asc
										</sql:query>
										<c:set var="gstval">
											<select   class="col-xs-12 select2 gst_percent" required="required" name="gst_percent" onchange="calculateNetAmount(this);">'+
												<c:forEach items="${gst.rows}" begin="0" var="gst">
													'<option value="${gst.gst_percent}">${gst.gst_percent}</option>'+
												</c:forEach>
											'</select>
										</c:set>
			                             
			                             
			                             <div class="col-sm-12" id="clicked">
		                                	<table class="table table-bordered" id="Table1">
		                                		<thead>
		                                			<tr>
			                                			<th class="text-center">Item</th>
			                                			<th class="text-center">Quantity</th>
			                                			<th class="text-center">Rate</th>
			                                			<th class="text-center">GST (%)</th>
			                                			<th class="text-center">Gross Price</th>
			                                			<th class="text-center">Tax price</th>
			                                			<th class="text-center">Net Price</th>
			                                			<th class="text-center">
			                                				<span class="text-success BtnPlus">
			                                					<i class="fa fa-plus"></i>
			                                				</span>
			                                			</th>
			                                		</tr>
		                                		</thead>
		                                		
		                                		 <sql:query var="poi" dataSource="jdbc/rmc">
	                                            	select * from purchase_voucher_item  where purchase_voucher_id=?
	                                            	<sql:param value="${rs.purchase_voucher_id}"/>
	                                             </sql:query>
		                                		<tbody>
		                                			<c:forEach items="${poi.rows}" var="poi">
		                                			<sql:query var="proo" dataSource="jdbc/rmc">
														select * from inventory_item
													</sql:query>
													<sql:query var="fl" dataSource="jdbc/rmc">
														select * from fleet_item
													</sql:query>
													
													<sql:query var="gst" dataSource="jdbc/rmc">
														select * from gst_percent order by gst_percent asc
													</sql:query>
		                                			<tr class="vall">
		                                				<td style="width:15%">
		                                					<input type="hidden" name="pvi_id" value="${poi.pvi_id}" >
															<select class="select2" name="item_name">
	                                                       		<c:forEach var="proo" items="${proo.rows}">
	                                                       			<option value="${proo.inventory_name}" ${(proo.inventory_name==poi.item_name)?'selected':''}>${proo.inventory_name}</option>
	                                                       		</c:forEach>
	                                                       		<c:forEach var="fl" items="${fl.rows}">
	                                                       			<option value="${fl.item_name}" ${(fl.item_name==poi.item_name)?'selected':''}>${fl.item_name}</option>
	                                                       		</c:forEach>
		                                                    </select>	                                				
		                                				</td>
		                                				<td style="width:12%">
		                                					<input class="form-control item_quantity" step="0.01" onkeyup="calculateNetAmount();" value="${poi.item_quantity}" required="required" placeholder="Enter Quantity" name="item_quantity" type="number">
		                                				</td>
		                                				<td style="width:12%">
		                                					<input class="form-control item_price" step="0.01" required="required" onkeyup="calculateNetAmount();" value="${poi.item_price}" placeholder="Enter Rate" name="item_price" type="number">
		                                				</td>
		                                				<td style="width:15%">
															<select class="select2 gst_percent" name="gst_percent" onchange="calculateNetAmount();">
	                                                       		<c:forEach var="gst" items="${gst.rows}">
	                                                       			<option value="${gst.gst_percent}" ${(gst.gst_percent==poi.gst_percent)?'selected':''}>${gst.gst_percent}</option>
	                                                       		</c:forEach>
		                                                    </select>		                                				
		                                				</td>
		                                				<td>
		                                					<input class="form-control gross_amount" name="gross_amount" value="${poi.gross_amount}" id="gross_amount" readonly="readonly" type="text"> 
		                                				</td>
		                                				
		                                				<td>
		                                					<input class="form-control tax_amount" name="tax_amount" value="${poi.tax_amount}" id="tax_amount" readonly="readonly" type="text"> 
		                                				</td>
		                                				
		                                				<td>
		                                					<input class="form-control net_amount" name="net_amount" value="${poi.net_amount}" id="net_amount" readonly="readonly" type="text">
		                                				</td>
		                                				<td></td>
		                                			</tr>
		                                			</c:forEach>
		                                		</tbody>
		                                		<tfoot>
		                                			<tr>
	                                            		<th colspan="6" class="text-right">Total Gross : </th>
	                                            		<th colspan="2" class="text-left" id="total_val"></th>
	                                            	</tr>
	                                            	<tr>
	                                            		<th colspan="6" class="text-right">Total Tax : </th>
	                                            		<th colspan="2" class="text-left" id="total_gst"></th>
	                                            	</tr>
	                                            	<tr>
	                                            		<th colspan="6" class="text-right">Round Off : </th>
	                                            		<th colspan="2" class="text-left">
	                                            			<input type="number" name="round_off" step="0.01" id="round" value="${rs.round_off}" class="form-control text-bold"/>
	                                            		</th>
	                                            	</tr>
	                                            	<tr>
	                                            		<th colspan="6" class="text-right">Total Net : <input type="hidden" id="total_grand"/></th>
	                                            		<th colspan="2" class="text-left" id="t_grand"></th>
	                                            	</tr>
		                                		</tfoot>
		                                	</table>
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
                	</c:when>
                	<c:otherwise>
                		<c:choose>
                			<c:when test="${param.insertType=='inventory'}">
                				<sql:query var="inventory" dataSource="jdbc/rmc">
                					select i.*,it.inventory_name
                				    from inventory i,inventory_item it
                				    where i.inv_item_id=it.inv_item_id and  inventory_id=?
                					<sql:param value="${param.inventory_id}"/>
                				</sql:query>
                				<c:forEach items="${inventory.rows}" var="inventory">
                					<c:set value="${inventory}" var="rs"/>
                				</c:forEach>
                				<div class="row">
				                    <div class="col-sm-12">
				                    	<form class="" action="PurchaseVoucherController?action=InsertVoucher" method="post">
					                        <div class="card-box row col-sm-12">
					                           	<div class="col-sm-6">
					                           	   <div class="form-group">
					                                    <label>Bill No : </label>
					                                    <div>
					                                       <input type="text" class="form-control" 
					                                         pattern="[^'&quot;:]*$"  placeholder="Enter Bill No." 
					                                         id="bill_no" name="bill_no" value="${rs.bill_no}"/>
					                                    </div>
					                                </div>
					                                
					                                <div class="form-group">
		                                                <label>Purchase Date <span class="text-danger">*</span> </label>
		                                                <div>
		                                                    <div class="input-group">
		                                                        <input type="text" name="purchase_date" class="form-control date-picker"
		                                                        		 placeholder="dd/mm/yyyy" id="id-date-picker-1" 
		                                                        		 data-date-format="dd/mm/yyyy"
		                                                        		 readonly="readonly"
		                                                        		 style="background-color: white;"
		                                                        		 value="${rs.date}"/>
		                                                        <div class="input-group-append">
		                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                        </div>
		                                                    </div>
		                                                </div>
		                                            </div>
		                                              <div class="form-group">
					                                    <label>Tax Type <span class="text-danger">*</span></label>
														<select id="gst_type"  name="gst_type"   class="select2"  data-placeholder="Choose Plant">
															<option value="GST" selected >GST</option>
															<option value="IGST">IGST</option>
														</select>
					                                </div>
					                            </div>
					                            <div class="col-sm-6">
					                               <div class="form-group">
					                                    <label>Supplier Name <span class="text-danger">*</span></label>
					                                    <sql:query var="supplier" dataSource="jdbc/rmc">
					                                    	select supplier_id,supplier_name
					                                        from supplier
					                                        where supplier_status='active' 
					                                        and  business_id like if(0=?,'%%',?)
					                                        <sql:param value="${bean.business_id}"/>
					                                        <sql:param value="${bean.business_id}"/>
					                                    </sql:query>
														<select id="supplier_id"  name="supplier_id" class="select2"  required="required" data-placeholder="Choose Supplier">
															<option value="">&nbsp;</option>
															<c:forEach var="sup" items="${supplier.rows}">
															<option value="${sup.supplier_id}"
																	 ${(sup.supplier_id==rs.supplier_id)?'selected':''}>${sup.supplier_name}</option>
															</c:forEach>
														</select>
					                                </div>
					                                
					                                <div class="form-group">
					                                    <label>Discount Amount : </label>
					                                    <div>
					                                       <input type="number" class="form-control" 
					                                         pattern="[^'&quot;:]*$"  placeholder="Enter Discount" onkeyup="calculateNetAmount();"  step="0.01" id="discount_amount" name="discount_amount"/>
					                                    </div>
					                                </div>
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
															<option value="${plant.plant_id}" ${(plant.plant_id==rs.plant_id)?'selected':''}>${plant.plant_name}</option>
															</c:forEach>
														</select>
					                                </div>
					                                <div class="form-group text-center">
					                                	 <label>&nbsp;</label>
					                                    <div class="checkbox checkbox-custom">
				                                            <input id="checkbox11" name="rate_include_tax" onclick="calculateNetAmount();" type="checkbox" ${(res.rate_include_tax=='yes')?'checked':''}>
				                                            <label for="checkbox11">
				                                                Rate Include Tax?
				                                            </label>
				                                        </div>
					                                 </div>
					                             </div>
					                             
					                            
					                             <div class="col-sm-12 text-center">
					                             
					                             	
					                             </div>
					                            <sql:query var="pro" dataSource="jdbc/rmc">
													select * from inventory_item
												</sql:query>
												
												<sql:query var="fl" dataSource="jdbc/rmc">
													select * from fleet_item
												</sql:query>
												<c:set var="name">
													<select   class="select2" required="required" name="item_name">'+
														<c:forEach items="${pro.rows}" begin="0" var="pro">
															'<option value="${pro.inventory_name}" ${(pro.inventory_name==rs.inventory_name)?'selected':''}>${pro.inventory_name}</option>'+
														</c:forEach>
														<c:forEach items="${fl.rows}" begin="0" var="fl">
															'<option value="${fl.item_name}">${fl.item_name}</option>'+
														</c:forEach>
													'</select>
												</c:set>
												
												
												<sql:query var="gst" dataSource="jdbc/rmc">
													select distinct gst_percent
												    from gst_percent
												    order by gst_percent asc
												</sql:query>
												<c:set var="gstval">
													<select   class="col-xs-12 select2 gst_percent" required="required" name="gst_percent" onchange="calculateNetAmount();">'+
														<c:forEach items="${gst.rows}" begin="0" var="gst">
															'<option value="${gst.gst_percent}">${gst.gst_percent}</option>'+
														</c:forEach>
													'</select>
												</c:set>
					                             
					                             
					                             <div class="col-sm-12" id="clicked">
				                                	<table class="table table-bordered" id="Table1">
				                                		<thead>
				                                			<tr>
					                                			<th class="text-center">Item</th>
					                                			<th class="text-center">Quantity</th>
					                                			<th class="text-center">Rate</th>
					                                			<th class="text-center">GST (%)</th>
					                                			<th class="text-center">Gross Price</th>
					                                			<th class="text-center">Tax price</th>
					                                			<th class="text-center">Net Price</th>
					                                			<th class="text-center">
					                                				<span class="text-success BtnPlus">
					                                					<i class="fa fa-plus"></i>
					                                				</span>
					                                			</th>
					                                		</tr>
				                                		</thead>
				                                		<tbody>
				                                			<tr class="vall">
				                                				<td style="width:15%">
																	${name}		                                				
				                                				</td>
				                                				<td style="width:12%">
				                                					<input class="form-control item_quantity"
				                                					 step="0.01" onkeyup="calculateNetAmount();" 
				                                					 required="required" placeholder="Enter Quantity"
				                                					 value="${rs.net_weight/1000}"
				                                					 name="item_quantity" type="number">
				                                				</td>
				                                				<td style="width:12%">
				                                					<input class="form-control item_price" step="0.01" required="required" onkeyup="calculateNetAmount();" placeholder="Enter Rate" name="item_price" type="number">
				                                				</td>
				                                				<td style="width:15%">
																	${gstval}		                                				
				                                				</td>
				                                				<td>
				                                					<input class="form-control gross_amount" name="gross_amount" id="gross_amount" readonly="readonly" type="text"> 
				                                				</td>
				                                				
				                                				<td>
				                                					<input class="form-control tax_amount" name="tax_amount" id="tax_amount" readonly="readonly" type="text"> 
				                                				</td>
				                                				
				                                				<td>
				                                					<input class="form-control net_amount" name="net_amount" id="net_amount" readonly="readonly" type="text">
				                                				</td>
				                                				<td></td>
				                                			</tr>
				                                		</tbody>
				                                		<tfoot>
				                                			<tr>
			                                            		<th colspan="6" class="text-right">Total Gross : </th>
			                                            		<th colspan="2" class="text-left" id="total_val"></th>
			                                            	</tr>
			                                           <tr>
			                                         
			                                			<th style="width: 16.66%">CSGT <span id="show_cgst"></span> </th>
			                                			<th style="width: 16.66%" id="view_cgst"></th>
			                                			<th style="width: 16.66%">SGST <span id="show_sgst"></span> </th>
			                                			<th style="width: 16.66%" id="view_sgst"></th>
			                                			<th style="width: 16.66%">IGST <span id="show_igst"></span></th>
			                                			<th style="width: 16.66%" id="view_igst"></th>
			                                			  <td></td>
			                                		</tr>
			                                            	<tr>
			                                            		<th colspan="6" class="text-right">Total Tax : </th>
			                                            		<th colspan="2" class="text-left" id="total_gst"></th>
			                                            	</tr>
			                                            	<tr>
			                                            		<th colspan="6" class="text-right">Round Off : </th>
			                                            		<th colspan="2" class="text-left">
			                                            			<input type="number" step="0.01" name="round_off" id="round" class="form-control text-bold"/>
			                                            		</th>
			                                            	</tr>
			                                            	<tr>
			                                            		<th colspan="6" class="text-right">Total Net : <input type="hidden" id="total_grand"/></th>
			                                            		<th colspan="2" class="text-left" id="t_grand"></th>
			                                            	</tr>
				                                		</tfoot>
				                                	</table>
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
                			</c:when>
                			<c:otherwise>
                				<div class="row">
				                    <div class="col-sm-12">
				                    	<form class="" action="PurchaseVoucherController?action=InsertVoucher" method="post">
					                        <div class="card-box row col-sm-12">
					                           	<div class="col-sm-6">
					                           	   <div class="form-group">
					                                    <label>Bill No : </label>
					                                    <div>
					                                       <input type="text" class="form-control" 
					                                         pattern="[^'&quot;:]*$"  placeholder="Enter Bill No."   id="bill_no" name="bill_no"/>
					                                    </div>
					                                </div>
					                                
					                                <div class="form-group">
		                                                <label>Purchase Date <span class="text-danger">*</span> </label>
		                                                <div>
		                                                    <div class="input-group">
		                                                        <input type="text" name="purchase_date" class="form-control date-picker"
		                                                        		 placeholder="dd/mm/yyyy" id="id-date-picker-1" 
		                                                        		 data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;">
		                                                        <div class="input-group-append">
		                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                        </div>
		                                                    </div>
		                                                </div>
		                                            </div>
		                                              <div class="form-group">
					                                    <label>Tax Type <span class="text-danger">*</span></label>
														<select id="gst_type"  name="gst_type"   class="select2"  data-placeholder="Choose Plant">
															<option value="GST" selected >GST</option>
															<option value="IGST">IGST</option>
														</select>
					                                </div>
					                            </div>
					                            <div class="col-sm-6">
					                               <div class="form-group">
					                                    <label>Supplier Name <span class="text-danger">*</span></label>
					                                    <sql:query var="supplier" dataSource="jdbc/rmc">
					                                    	select supplier_id,supplier_name
					                                        from supplier
					                                        where supplier_status='active' 
					                                        and  business_id like if(0=?,'%%',?)
					                                        <sql:param value="${bean.business_id}"/>
					                                        <sql:param value="${bean.business_id}"/>
					                                    </sql:query>
														<select id="supplier_id"  name="supplier_id" class="select2"  required="required" data-placeholder="Choose Supplier">
															<option value="">&nbsp;</option>
															<c:forEach var="sup" items="${supplier.rows}">
															<option value="${sup.supplier_id}"
																	 ${(sup.supplier_id==invento.supplier_id)?'selected':''}>${sup.supplier_name}</option>
															</c:forEach>
														</select>
					                                </div>
					                                
					                                <div class="form-group">
					                                    <label>Discount Amount : </label>
					                                    <div>
					                                       <input type="number" class="form-control" 
					                                         pattern="[^'&quot;:]*$"  placeholder="Enter Discount" onkeyup="calculateNetAmount();"  step="0.01" id="discount_amount" name="discount_amount"/>
					                                    </div>
					                                </div>
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
					                                <div class="form-group text-center">
					                                	 <label>&nbsp;</label>
					                                    <div class="checkbox checkbox-custom">
				                                            <input id="checkbox11" name="rate_include_tax" onclick="calculateNetAmount();" type="checkbox" ${(res.rate_include_tax=='yes')?'checked':''}>
				                                            <label for="checkbox11">
				                                                Rate Include Tax?
				                                            </label>
				                                        </div>
					                                 </div>
					                             </div>
					                             
					                            
					                             <div class="col-sm-12 text-center">
					                             
					                             	
					                             </div>
					                            <sql:query var="pro" dataSource="jdbc/rmc">
													select * from inventory_item
												</sql:query>
												
												<sql:query var="fl" dataSource="jdbc/rmc">
													select * from fleet_item
												</sql:query>
												<c:set var="name">
													<select   class="select2" required="required" name="item_name">'+
														<c:forEach items="${pro.rows}" begin="0" var="pro">
															'<option value="${pro.inventory_name}">${pro.inventory_name}</option>'+
														</c:forEach>
														<c:forEach items="${fl.rows}" begin="0" var="fl">
															'<option value="${fl.item_name}">${fl.item_name}</option>'+
														</c:forEach>
													'</select>
												</c:set>
												
												
												<sql:query var="gst" dataSource="jdbc/rmc">
													select distinct gst_percent
												    from gst_percent
												    order by gst_percent asc
												</sql:query>
												<c:set var="gstval">
													<select   class="col-xs-12 select2 gst_percent" required="required" name="gst_percent" onchange="calculateNetAmount();">'+
														<c:forEach items="${gst.rows}" begin="0" var="gst">
															'<option value="${gst.gst_percent}">${gst.gst_percent}</option>'+
														</c:forEach>
													'</select>
												</c:set>
					                             
					                             
					                             <div class="col-sm-12" id="clicked">
				                                	<table class="table table-bordered" id="Table1">
				                                		<thead>
				                                			<tr>
					                                			<th class="text-center">Item</th>
					                                			<th class="text-center">Quantity</th>
					                                			<th class="text-center">Rate</th>
					                                			<th class="text-center">GST (%)</th>
					                                			<th class="text-center">Gross Price</th>
					                                			<th class="text-center">Tax price</th>
					                                			<th class="text-center">Net Price</th>
					                                			<th class="text-center">
					                                				<span class="text-success BtnPlus">
					                                					<i class="fa fa-plus"></i>
					                                				</span>
					                                			</th>
					                                		</tr>
				                                		</thead>
				                                		<tbody>
				                                			<tr class="vall">
				                                				<td style="width:15%">
																	${name}		                                				
				                                				</td>
				                                				<td style="width:12%">
				                                					<input class="form-control item_quantity" step="0.01" onkeyup="calculateNetAmount();" required="required" placeholder="Enter Quantity" name="item_quantity" type="number">
				                                				</td>
				                                				<td style="width:12%">
				                                					<input class="form-control item_price" step="0.01" required="required" onkeyup="calculateNetAmount();" placeholder="Enter Rate" name="item_price" type="number">
				                                				</td>
				                                				<td style="width:15%">
																	${gstval}		                                				
				                                				</td>
				                                				<td>
				                                					<input class="form-control gross_amount" name="gross_amount" id="gross_amount" readonly="readonly" type="text"> 
				                                				</td>
				                                				
				                                				<td>
				                                					<input class="form-control tax_amount" name="tax_amount" id="tax_amount" readonly="readonly" type="text"> 
				                                				</td>
				                                				
				                                				<td>
				                                					<input class="form-control net_amount" name="net_amount" id="net_amount" readonly="readonly" type="text">
				                                				</td>
				                                				<td></td>
				                                			</tr>
				                                		</tbody>
				                                		<tfoot>
				                                			<tr>
			                                            		<th colspan="6" class="text-right">Total Gross : </th>
			                                            		<th colspan="2" class="text-left" id="total_val"></th>
			                                            	</tr>
			                                           <tr>
			                                         
			                                			<th style="width: 16.66%">CSGT <span id="show_cgst"></span> </th>
			                                			<th style="width: 16.66%" id="view_cgst"></th>
			                                			<th style="width: 16.66%">SGST <span id="show_sgst"></span> </th>
			                                			<th style="width: 16.66%" id="view_sgst"></th>
			                                			<th style="width: 16.66%">IGST <span id="show_igst"></span></th>
			                                			<th style="width: 16.66%" id="view_igst"></th>
			                                			  <td></td>
			                                		</tr>
			                                            	<tr>
			                                            		<th colspan="6" class="text-right">Total Tax : </th>
			                                            		<th colspan="2" class="text-left" id="total_gst"></th>
			                                            	</tr>
			                                            	<tr>
			                                            		<th colspan="6" class="text-right">Round Off : </th>
			                                            		<th colspan="2" class="text-left">
			                                            			<input type="number" step="0.01" name="round_off" id="round" class="form-control text-bold"/>
			                                            		</th>
			                                            	</tr>
			                                            	<tr>
			                                            		<th colspan="6" class="text-right">Total Net : <input type="hidden" id="total_grand"/></th>
			                                            		<th colspan="2" class="text-left" id="t_grand"></th>
			                                            	</tr>
				                                		</tfoot>
				                                	</table>
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
                			</c:otherwise>
                		</c:choose>
                	</c:otherwise>
                </c:choose>
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

        <!-- Parsley js -->
        <script type="text/javascript" src="plugins/parsleyjs/parsley.min.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<c:choose>
			<c:when test="${empty param.action}">
				<script type="text/javascript" src="js/Pickers/dateTimeValidator.js"></script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript" src="js/Pickers/dateTimeValidatorEdit.js"></script>
			</c:otherwise>
		</c:choose>
		
		
		<script type="text/javascript">
			$(document).ready(function(){
				$('#site_id').on('change',function(){
					var site_id=$('#site_id').val();
					$.ajax({
						type:'post',
						url:'CustomerController?action=siteDetailsUsingId&site_id='+site_id,
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
			function getGstDetails(){
				var gst_type=$('#gst_type').val();
				$.ajax({
					type:'POST',
					url:'SettingController?action=getGstDetails&gst_type='+gst_type,
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
				$(document).ready(function () {
				    function addRow(){
				        var html = '<tr class="vall">'+
										'<td>'+
											'${name}'+
										'</td>'+
										'<td>'+
											'<input type="number" class="form-control item_quantity" step="0.01" pattern="[^\'&quot;:]*$" onkeyup="calculateNetAmount();"  required="required" placeholder="Enter Quantity"   name="item_quantity"/>'+
										'</td>'+
										'<td>'+
											'<input type="number" class="form-control item_price" step="0.01"  pattern="[^\'&quot;:]*$"  onkeyup="calculateNetAmount();" required="required" placeholder="Enter Rate"   name="item_price"/>'+
										'</td>'+
										'<td>'+
											'${gstval}'+
										'</td>'+
										'<td>'+
											'<input type="text" class="form-control gross_amount"  readonly   name="gross_amount" id="gross_amount"/>'+
										'</td>'+
										'<td>'+
											'<input type="text" class="form-control tax_amount"  readonly   name="tax_amount" id="tax_amount"/>'+
										'</td>'+
										'<td>'+
											'<input type="text" class="form-control net_amount"  readonly   name="net_amount" id="net_amount"/>'+
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
				    $('.selectme').addClass('select');
				    
				 });
				   $('#Table1').on('click', '.removebtn', function(){
					    $(this).closest ('tr').remove ();
				 });
			});
		</script>
		
		<c:choose>
			<c:when test="${empty param.action}">
				<script type="text/javascript">
					function calculateNetAmount(){
						console.log("its calling");
						//declare all sum variable
					    var net_sum=0;
					    var gross_sum=0;
					    var tax_sum=0; 
						var discount_amount=$('#discount_amount').val();
						discount_amount=(isNaN(discount_amount) || discount_amount==undefined || discount_amount.trim()=="")?0.0:parseFloat(discount_amount);
						$('#Table1 tr.vall').each(function(){
							var gst_percent= $(this).find('.gst_percent').val();
							gst_percent=parseFloat(gst_percent);
							var item_price= $(this).find('input.item_price').val();
							item_price=(isNaN(item_price) || item_price==undefined || item_price.trim()=="")?0.0:parseFloat(item_price);
							var quantity= $(this).find('input.item_quantity').val();
							quantity=(isNaN(quantity) || quantity==undefined || quantity.trim()=="")?0.0:parseFloat(quantity);
							var total_price=parseFloat(quantity)*parseFloat(item_price);
							total_price=isNaN(total_price)?0.0:total_price;
							
							var rate_include=$('input[name="rate_include_tax"]:checked').length;
							
							var tax_amount=0;
							var gross_amount=0;
							var net_amount=0;
							
							if(rate_include==0){
								
								tax_amount=((total_price/100)*gst_percent);
								tax_amount=tax_amount.toFixed(2);
								gross_amount=total_price;
								gross_amount=gross_amount.toFixed(2);
								net_amount=(parseFloat(tax_amount)+parseFloat(gross_amount));
							}else{
								tax_amount=((total_price/(100+gst_percent))*gst_percent);
								tax_amount=tax_amount.toFixed(2);
								gross_amount=total_price-tax_amount;
								gross_amount=gross_amount.toFixed(2);
								net_amount=total_price;
								
							}
							
							
							gross_sum=gross_sum+parseFloat(gross_amount);
							tax_sum=parseFloat(tax_sum)+parseFloat(tax_amount);
							
							
						    $(this).find('input.gross_amount').val(gross_amount);
						    $(this).find('input.tax_amount').val(tax_amount);
						    $(this).find('input.net_amount').val(net_amount.toFixed(2));
						    
						});
						
						   net_sum=gross_sum+tax_sum;
						   $('#total_val').html(gross_sum.toFixed(2));
						   $('#total_gst').html(tax_sum.toFixed(2));
						   $('#total_grand').val((net_sum-discount_amount).toFixed(2)); 
						   $('#t_grand').html((net_sum-discount_amount).toFixed(2)); 
						   $('#round').val(0);
						   var gst_type=$('#gst_type').val();
						   console.log(gst_type);
						   if(gst_type=='IGST'){
					    	   $('#view_cgst').text('0');
					    	   $('#view_sgst').text('0');
					    	   $('#view_igst').text(tax_sum.toFixed(2));
					       }else{
					    	   $('#view_cgst').text((tax_sum/2).toFixed(2));
					    	   $('#view_sgst').text((tax_sum/2).toFixed(2)+parseFloat($('#round').val()));
					    	   $('#view_igst').text('0');
					       }
					}
				</script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript">
					function calculateNetAmount(){
						console.log("its calling");
						//declare all sum variable
						var discount_amount=$('#discount_amount').val();
						discount_amount=(isNaN(discount_amount) || discount_amount==undefined || discount_amount.trim()=="")?0.0:parseFloat(discount_amount);

					    var net_sum=0;
					    var gross_sum=0;
					    var tax_sum=0; 
						$('#Table1 tr.vall').each(function(){
							var gst_percent= $(this).find('.gst_percent').val();
							gst_percent=parseFloat(gst_percent);
							var item_price= $(this).find('input.item_price').val();
							item_price=(isNaN(item_price) || item_price==undefined || item_price.trim()=="")?0.0:parseFloat(item_price);
							var quantity= $(this).find('input.item_quantity').val();
							quantity=(isNaN(quantity) || quantity==undefined || quantity.trim()=="")?0.0:parseFloat(quantity);
							var total_price=parseFloat(quantity)*parseFloat(item_price);
							total_price=isNaN(total_price)?0.0:total_price;
							
							var rate_include=$('input[name="rate_include_tax"]:checked').length;
							
							var tax_amount=0;
							var gross_amount=0;
							var net_amount=0;
							
							if(rate_include==0){
								
								tax_amount=((total_price/100)*gst_percent);
								tax_amount=tax_amount.toFixed(2);
								gross_amount=total_price;
								gross_amount=gross_amount.toFixed(2);
								net_amount=(parseFloat(tax_amount)+parseFloat(gross_amount));
							}else{
								tax_amount=((total_price/(100+gst_percent))*gst_percent);
								tax_amount=tax_amount.toFixed(2);
								gross_amount=total_price-tax_amount;
								gross_amount=gross_amount.toFixed(2);
								net_amount=total_price;
								
							}
							
							
							gross_sum=gross_sum+parseFloat(gross_amount);
							tax_sum=parseFloat(tax_sum)+parseFloat(tax_amount);
							
							
						    $(this).find('input.gross_amount').val(gross_amount);
						    $(this).find('input.tax_amount').val(tax_amount);
						    $(this).find('input.net_amount').val(net_amount.toFixed(2));
						 });
						
						   net_sum=gross_sum+tax_sum;
						   $('#total_val').html(gross_sum.toFixed(2));
						   $('#total_gst').html(tax_sum.toFixed(2));
						   $('#total_grand').val((net_sum-discount_amount).toFixed(2));
						   $('#t_grand').html(parseFloat((net_sum-discount_amount).toFixed(2))+parseFloat($('#round').val())); 
						   var gst_type=$('#gst_type').val();
						   console.log(gst_type);
						   if(gst_type=='IGST'){
					    	   $('#view_cgst').text('0');
					    	   $('#view_sgst').text('0');
					    	   $('#view_igst').text(tax_sum.toFixed(2));
					       }else{
					    	   $('#view_cgst').text((tax_sum/2).toFixed(2));
					    	   $('#view_sgst').text((tax_sum/2).toFixed(2));
					    	   $('#view_igst').text('0');
					       }
						   
					}
				</script>
			</c:otherwise>
		</c:choose>
		
		<script type="text/javascript">
				$(document).ready(function(){
					$('#round').on('keyup blur',function(){
						var net_amount=($('#total_grand').val()=='')?0:parseFloat($('#total_grand').val());
						var round=($('#round').val()=='')?0:parseFloat($('#round').val());
						$('#t_grand').text(net_amount+round);
					});
					
					
					$('#gst_type').on('change', function(){
						var gst_type=$('#gst_type').val();
						var tax_price= $('#total_gst').html();
						tax_price=parseFloat(tax_price);
						tax_price=tax_price.toFixed(2);
						if(gst_type=='IGST'){
					    	   $('#view_cgst').text('0');
					    	   $('#view_sgst').text('0');
					    	   $('#view_igst').text(tax_price);
					       }else{
					    	   $('#view_cgst').text(tax_price/2);
					    	   $('#view_sgst').text(tax_price/2);
					    	   $('#view_igst').text('0');
					       }
					}); 
				});
		</script>
		<script type="text/javascript">
			$(document).ready(function(){
				calculateNetAmount();
			})
		</script>
    </body>
</html>