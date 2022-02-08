<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Expense Voucher</title>
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
                                    <li class="breadcrumb-item"><a href="#">Accounts</a></li>
                                    <li class="breadcrumb-item"><a href="#">Expense Voucher</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Expense Voucher</a></li>
                                </ol>
                            </div>
                            <c:choose>
                            	<c:when test="${param.action=='update'}">
                            		<h4 class="page-title">Update Expense Voucher</h4>
                            	</c:when>
                            	<c:otherwise>
                            		<h4 class="page-title">Add Expense Voucher</h4>
                            	</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="ExpenseVoucherList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Expense Voucher List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                	
                		<sql:query var="expense" dataSource="jdbc/rmc">
                			select e.*,DATE_FORMAT(e.bill_date,'%d/%m/%Y') as bill_date
                		    from test_expense_voucher e where expense_voucher_id=?
                			<sql:param value="${param.expense_voucher_id}"/>
                		</sql:query>
                		<c:forEach items="${expense.rows}" var="expense">
                			<c:set value="${expense}" var="rs"/>
                		</c:forEach>
                		
               			<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" id="myForm" action="../ExpenseVoucherControllerTest?action=UpdateExpenseVoucher" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-3">
			                           	   <div class="form-group">
			                                    <label>Bill No : </label>
			                                    <div>
			                                       <input type="hidden" name="expense_voucher_id" value="${rs.expense_voucher_id}"/>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Bill No." 
			                                         	  id="bill_no" name="bill_no" value="${rs.bill_no}"/>
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="col-sm-3">
			                            	<div class="form-group">
                                                <label>Bill Date <span class="text-danger">*</span> </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="bill_date" class="form-control date-picker"
                                                        	 placeholder="dd/mm/yyyy" id="id-date-picker-1"
                                                        	 data-date-format="dd/mm/yyyy" readonly="readonly"
                                                        	 style="background-color: white;" value="${rs.bill_date}">
                                                        <div class="input-group-append picker">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
			                            </div>
			                            <div class="col-sm-3">
			                                <div class="form-group">
			                                    <label>TDS Amount : </label>
			                                    <div>
			                                       <input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Discount" 
			                                         step="0.01" id="tds_amount" name="tds_amount"
			                                         value="${rs.tds_amount}"/>
			                                    </div>
			                                </div>
			                             </div>
			                             
			                             <div class="col-sm-3">
							                    <div class="form-group">
							                       <label>Supplier Name <span class="text-danger">*</span></label>
							                       <sql:query var="supplier" dataSource="jdbc/rmc">
							                       	select supplier_id,supplier_name
							                       	from test_supplier 
							                       	where supplier_status='active'
							                       	and business_id like if(0=?,'%%',?)
							                       	<sql:param value="${bean.business_id}"/>
							                       	<sql:param value="${bean.business_id}"/>
							                       </sql:query>
													<select id="supplier_id"  name="supplier_id" class="select2" 
														 required="required" data-placeholder="Choose Supplier">
														<option value="">&nbsp;</option>
														<c:forEach var="sup" items="${supplier.rows}">
														<option value="${sup.supplier_id}" 
																${(sup.supplier_id==rs.supplier_id)?'selected':''}>${sup.supplier_name}</option>
														</c:forEach>
													</select>
							                    </div>
						                 </div>
			                             
			                             <div class="col-sm-3">
			                                <!-- Get customer site details  -->
			                                <sql:query var="plant" dataSource="jdbc/rmc">
			                                	select plant_id,plant_name
			                                    from plant
			                                    where plant_id like if(0=?,'%%',?)
			                                    and business_id like if(0=?,'%%',?)
			                                	<sql:param value="${bean.plant_id}"/>
			                                	<sql:param value="${bean.plant_id}"/>
			                                	<sql:param value="${bean.business_id}"/>
			                                	<sql:param value="${bean.business_id}"/>
			                                </sql:query>
			                                <div class="form-group">
			                                    <label>Plant<span class="text-danger">*</span></label>
												<select id="plant_id"  name="plant_id" required="required"   class="form-control"  data-placeholder="Choose Plant">
													<c:if test="${bean.plant_id==0}"><option value="0">Office</option></c:if>
													<c:forEach items="${plant.rows}" var="plant">
														<option value="${plant.plant_id}"
															 ${(plant.plant_id==rs.plant_id)?'selected':''}>${plant.plant_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                             </div>
			                             <div class="col-sm-3">
			                                <div class="form-group">
			                                    <label>Remark : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         placeholder="Enter Remark"  value="${rs.remark}"  id="remark" name="remark"/>
			                                    </div>
			                                </div>
			                             </div>
			                             <div class="form-group col-sm-3">
		                                	<div class="form-group">
			                                    <label>GST Category <span class="text-danger">*</span></label>
												<select id="gst_type" class="form-control" name="gst_type">
													<option value="GST" 
														${(rs.gst_category=='GST')?'selected':''}>GST</option>
													<option value="IGST"
													    ${(rs.gst_category=='IGST')?'selected':''}>IGST</option>
												</select>
			                                </div>
		                                </div>
						                  <div class="form-group col-sm-3">
		                                	<div class="form-group">
			                                    <label>Asset<span class="text-danger">*</span></label>
			                                     <sql:query var="cat" dataSource="jdbc/rmc">
													select category_type from expense_category_type
												 </sql:query>
												<select id="category_type" class="form-control" name="category_type">
													<c:forEach items="${cat.rows}" var="cat">
														<option value="${cat.category_type}"
															 ${(cat.category_type==rs.category_type)?'selected':''}
															 >${cat.category_type}</option>
													</c:forEach>
												</select>
			                                </div>
		                                </div>
							   		     <div class="form-group col-sm-3">
							   		     	<label for="include_tax"><input type="checkbox"
							   		     		   name="include_tax" id="include_tax" 
							   		     		   ${(rs.rate_include_tax==true)?'checked':''}/> &nbsp;&nbsp;&nbsp;Rate Include Tax ? </label>
							   		     </div>
			                             <div class="col-sm-12" id="clicked">
		                                	<table class="table table-bordered" id="Table1">
		                                		<thead>
		                                			<tr>
		                                				<th>Category</th>
			                                			<th class="text-center">Particular</th>
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
		                                		<sql:query var="item" dataSource="jdbc/rmc">
		                                			select * from test_expense_voucher_item where expense_voucher_id=?
		                                			<sql:param value="${param.expense_voucher_id}"/>
		                                		</sql:query>
		                                		<c:set value="0" var="count"/>
		                                		<tbody>
		                                			<c:forEach items="${item.rows}" var="item">
		                                			<tr>
		                                				<td style="width:12%">
		                                					<sql:query var="category" dataSource="jdbc/rmc">
					                                			select category_id,category_name
					                                			from expense_category
					                                			where category_type=?
					                                			<sql:param value="${rs.category_type}"/>
					                                		</sql:query>
					                                		<input type="hidden" name="evi_id[${count}]" value="${item.evi_id}"/>
															<select class="form-control category_id" title="category_id"  name="category_id[${count}]">
																<c:forEach items="${category.rows}" var="cat">
																	<option value="${cat.category_id}" 
																			 ${(cat.category_id==item.category_id)?'selected':''}>${cat.category_name}</option>
																</c:forEach>
															</select>
														</td>
		                                				<td style="width:12%">
		                                						<input class="form-control item_name" title="item_name" value="${item.item_name}" name="item_name[${count}]" placeholder="Enter Item name"></input>
		                                				</td>
		                                				<td style="width:10%">
		                                					<input class="form-control item_quantity" title="item_quantity"  
		                                							 required="required" placeholder="Enter Quantity"
		                                							 name="item_quantity[${count}]" type="text" value="${item.item_quantity}"/>
		                                				</td>
		                                				<td style="width:10%">
		                                					<input class="form-control item_price" title="item_price"
		                                					 	 required="required"
		                                					 	 placeholder="Enter Rate" name="item_price[${count}]"
		                                					 	 type="text" value="${item.item_price}"/>
		                                				</td>
		                                				<td style="width:8%">
		                                					<sql:query var="gst" dataSource="jdbc/rmc">
		                                						select distinct(gst_percent) from gst_percent
		                                					</sql:query>
															<select class="form-control gst_percent"
																	 title="gst_percent"  name="gst_percent[${count}]">
																	<c:forEach items="${gst.rows}" var="gst">
																		<option value="${gst.gst_percent}"
																				 ${(gst.gst_percent==item.gst_percent)?'selected':''}>${gst.gst_percent}</option>
																	</c:forEach>
															</select>		                                				
		                                				</td>
		                                				<td style="width:10%">
		                                					<input class="form-control gross_amount" title="gross_amount" name="gross_amount[${count}]" 
		                                						    readonly="readonly" type="text" value="${item.gross_amount}"/> 
		                                				</td>
		                                				
		                                				<td style="width:10%">
		                                					<input class="form-control tax_amount" name="tax_amount[${count}]" title="tax_amount"
		                                						    readonly="readonly" type="text" value="${item.tax_amount}"/> 
		                                				</td>
		                                				
		                                				<td style="width:10%"	>
		                                					<input class="form-control net_amount" name="net_amount[${count}]" title="net_amount"
		                                						    readonly="readonly" type="text" value="${item.net_amount}"/>
		                                				</td>
		                                				<td style="width:3%"></td>
		                                			</tr>
		                                			<c:set value="${count+1}" var="count"/>
		                                			</c:forEach>
		                                		</tbody>
		                                		<tfoot>
		                                			<tr>
	                                            		<th colspan="6" class="text-right">Total Gross : </th>
	                                            		<th colspan="4" class="text-left" id="tgross"></th>
	                                            	</tr>
	                                            	<tr>
	                                            		<th colspan="6" class="text-right">Total Tax : </th>
	                                            		<th colspan="4" class="text-left" id="ttax"></th>
	                                            	</tr>
	                                            	<tr>
	                                            		<th colspan="6" class="text-right">Total Net : </th>
	                                            		<th colspan="4" class="text-left" id="tnet"></th>
	                                            	</tr>
		                                		</tfoot>
		                                	</table>
		                                	<input type="hidden" name="count" id="count" value="${count}"/>
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
		                    	<form class="" id="myForm" action="../ExpenseVoucherControllerTest?action=InsertExpenseVoucher" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-3">
			                           	   <div class="form-group">
			                                    <label>Bill No : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Bill No."   id="bill_no" name="bill_no"/>
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="col-sm-3">
			                            	<div class="form-group">
                                                <label>Bill Date <span class="text-danger">*</span> </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="bill_date" class="form-control date-picker"
                                                        	 placeholder="dd/mm/yyyy" id="id-date-picker-1"
                                                        	 data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;">
                                                        <div class="input-group-append picker">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
			                            </div>
			                            <div class="col-sm-3">
			                                <div class="form-group">
			                                    <label>TDS Amount : </label>
			                                    <div>
			                                       <input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Discount"   step="0.01" id="tds_amount" name="tds_amount"/>
			                                    </div>
			                                </div>
			                             </div>
			                             
			                             <div class="col-sm-3">
							                    <div class="form-group">
							                       <label>Supplier Name <span class="text-danger">*</span></label>
							                       <sql:query var="supplier" dataSource="jdbc/rmc">
							                       	select supplier_id,supplier_name
							                       	from test_supplier 
							                       	where supplier_status='active'
							                       	and business_id like if(0=?,'%%',?)
							                       	<sql:param value="${bean.business_id}"/>
							                       	<sql:param value="${bean.business_id}"/>
							                       </sql:query>
													<select id="supplier_id"  name="supplier_id" class="select2" 
														 required="required" data-placeholder="Choose Supplier">
														<option value="">&nbsp;</option>
														<c:forEach var="sup" items="${supplier.rows}">
														<option value="${sup.supplier_id}" >${sup.supplier_name}</option>
														</c:forEach>
													</select>
							                    </div>
						                 </div>
			                             
			                             <div class="col-sm-3">
			                                <!-- Get customer site details  -->
			                                <sql:query var="plant" dataSource="jdbc/rmc">
			                                	select plant_id,plant_name
			                                    from plant
			                                    where plant_id like if(0=?,'%%',?)
			                                    and business_id like if(0=?,'%%',?)
			                                	<sql:param value="${bean.plant_id}"/>
			                                	<sql:param value="${bean.plant_id}"/>
			                                	<sql:param value="${bean.business_id}"/>
			                                	<sql:param value="${bean.business_id}"/>
			                                </sql:query>
			                                <div class="form-group">
			                                    <label>Plant<span class="text-danger">*</span></label>
												<select id="plant_id"  name="plant_id" required="required"   class="form-control"  data-placeholder="Choose Plant">
													<c:if test="${bean.plant_id==0}"><option value="0">Office</option></c:if>
													<c:forEach items="${plant.rows}" var="plant">
														<option value="${plant.plant_id}" >${plant.plant_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                             </div>
			                             <div class="col-sm-3">
			                                <div class="form-group">
			                                    <label>Remark : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         placeholder="Enter Remark"   id="remark" name="remark"/>
			                                    </div>
			                                </div>
			                             </div>
			                             <div class="form-group col-sm-3">
		                                	<div class="form-group">
			                                    <label>GST Category <span class="text-danger">*</span></label>
												<select id="gst_type" class="form-control" name="gst_type">
													<option value="GST">GST</option>
													<option value="IGST">IGST</option>
												</select>
			                                </div>
		                                </div>
						                  <div class="form-group col-sm-3">
		                                	<div class="form-group">
			                                    <label>Asset<span class="text-danger">*</span></label>
			                                    <sql:query var="cat" dataSource="jdbc/rmc">
													select category_type from expense_category_type
												</sql:query>
												<select id="category_type" class="form-control" name="category_type">
													<c:forEach items="${cat.rows}" var="cat">
														<option value="${cat.category_type}"
															 ${(cat.category_type==rs.category_type)?'selected':''}
															 >${cat.category_type}</option>
													</c:forEach>
												</select>
			                                </div>
		                                </div>
							   		     <div class="form-group col-sm-3">
							   		     	<label for="include_tax"><input type="checkbox" name="include_tax" id="include_tax"/> &nbsp;&nbsp;&nbsp;Rate Include Tax ? </label>
							   		     </div>
			                             <div class="col-sm-12" id="clicked">
			                             	<input type="hidden" name="count" id="count" value="1"/>
		                                	<table class="table table-bordered" id="Table1">
		                                		<thead>
		                                			<tr>
		                                				<th>Category</th>
			                                			<th class="text-center">Particular</th>
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
		                                			<tr>
		                                				<td style="width:12%">
															<select class="form-control category_id" title="category_id"  name="category_id[0]">
															</select>
														</td>
		                                				<td style="width:12%">
		                                						<input class="form-control item_name" title="item_name" name="item_name[0]" placeholder="Enter Item name"></input>
		                                				</td>
		                                				<td style="width:10%">
		                                					<input class="form-control item_quantity" title="item_quantity"  
		                                							 required="required" placeholder="Enter Quantity"
		                                							 name="item_quantity[0]" type="text"/>
		                                				</td>
		                                				<td style="width:10%">
		                                					<input class="form-control item_price" title="item_price"
		                                					 	 required="required"
		                                					 	placeholder="Enter Rate" name="item_price[0]" type="text">
		                                				</td>
		                                				<td style="width:8%">
															<select class="form-control gst_percent"
																	 title="gst_percent"  name="gst_percent[0]">
																
															</select>		                                				
		                                				</td>
		                                				<td style="width:10%">
		                                					<input class="form-control gross_amount" title="gross_amount" name="gross_amount[0]" 
		                                						    readonly="readonly" type="text"/> 
		                                				</td>
		                                				
		                                				<td style="width:10%">
		                                					<input class="form-control tax_amount" name="tax_amount[0]" title="tax_amount"
		                                						    readonly="readonly" type="text"/> 
		                                				</td>
		                                				
		                                				<td style="width:10%"	>
		                                					<input class="form-control net_amount" name="net_amount[0]" title="net_amount"
		                                						    readonly="readonly" type="text"/>
		                                				</td>
		                                				<td style="width:3%"></td>
		                                			</tr>
		                                		</tbody>
		                                		<tfoot>
		                                			<tr>
	                                            		<th colspan="6" class="text-right">Total Gross : </th>
	                                            		<th colspan="4" class="text-left" id="tgross"></th>
	                                            	</tr>
	                                            	<tr>
	                                            		<th colspan="6" class="text-right">Total Tax : </th>
	                                            		<th colspan="4" class="text-left" id="ttax"></th>
	                                            	</tr>
	                                            	<tr>
	                                            		<th colspan="6" class="text-right">Total Net : </th>
	                                            		<th colspan="4" class="text-left" id="tnet"></th>
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
                <!-- end row -->

            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->
        <!-- Footer -->
       <%@ include file="../footer.jsp" %>
        <!-- End Footer -->

        <!-- jQuery  -->
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
		<script src="../picker/js/moment.min.js"></script>
		<script src="../picker/js/bootstrap-datetimepicker.min.js"></script>
		<script src="../assets/js/bootstrap-timepicker.min.js"></script>
		
		<!-- Jquery validation -->
		<script type="text/javascript" src="../validation/jquery.validate.min.js"></script>
		<script type="text/javascript" src="../validation/additional-methods.min.js"></script>
		<c:choose>
			<c:when test="${empty param.action}">
				<script type="text/javascript" src="../js/Pickers/dateTimeValidator.js"></script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript" src="../js/Pickers/dateTimeValidatorEdit.js"></script>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${empty param.action}">
				<script type="text/javascript" src="js/Accounts/ExpenseVoucher/AddExpenseVoucher.js"></script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript" src="js/Accounts/ExpenseVoucher/UpdateExpenseVoucher.js"></script>
			</c:otherwise>
		</c:choose>
    </body>
</html>