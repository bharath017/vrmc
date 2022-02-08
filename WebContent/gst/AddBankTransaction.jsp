<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Cash Register</title>
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
                                    <li class="breadcrumb-item"><a href="#">Accounts</a></li>
                                    <li class="breadcrumb-item"><a href="#">Transaction Details</a></li>
                                    <li class="breadcrumb-item"><a href="#">Cash Register</a></li>
                                </ol>
                            </div>
                            <c:choose>
                            	<c:when test="${param.action=='update'}">
                            		<h4 class="page-title">Update Cash Register</h4>
                            	</c:when>
                            	<c:otherwise>
                            		<h4 class="page-title">Add Cash Register</h4>
                            	</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="BankTransactionList.jsp" class="btn btn-custom waves-effect waves-light mb-4" 
                         data-overlayColor="#36404a"><i class="mdi mdi-grid"></i>Cash Register List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<c:choose>
                			<c:when test="${param.type=='cuspay'}">
                				<sql:query var="transaction" dataSource="jdbc/rmc">
                					select p.*,DATE_FORMAT(p.payment_date,'%d/%m/%Y') as payment_date
                					from test_customer_payment
                					where payment_id=?
                					<sql:param value="${param.id}"/>
                				</sql:query>
                			</c:when>
                		</c:choose>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<div class="card-box row col-sm-12">
		                    	<form action="../BankDetailControllerTest?action=insertTransactionDetail" method="post" id="myForm">
		                            <div class="row">
		                                <div class="col-sm-4">
		                                    <div class="form-group">
		                                        <label>Transaction Amount</label>
		                                        <input class="form-control" type="text" id="transaction_amount" name="transaction_amount">
		                                    </div>
		                                </div>
		                                
		                                <div class="col-sm-4">
		                                    <div class="form-group">
			                                    <label>Transaction Type<span class="text-danger">*</span></label>
												<select id="transaction_type"  name="transaction_type" class="select2"  required data-placeholder="Select Transaction Type">
													<option value="">&nbsp;</option>
													<option value="cuspay">Customer Payment</option>
													<option value="suppay">Supplier Payment</option>
													<option value="pettycash">Petty Cash</option>
												</select>
			                                </div>
		                                </div>
		                                
		                                <div class="form-group col-sm-4" style="display:none;" id="customer_id_view">
		                                    <label>Customer <span class="text-danger">*</span></label>
		                                    <sql:query var="customer" dataSource="jdbc/rmc">
		                                    	select customer_id,customer_name
		                                        from test_customer
		                                        where customer_status='active'
		                                        and business_id like if(0=?,'%%',?)
		                                        order by customer_name asc 
		                                        <sql:param value="${bean.business_id}"/>
		                                        <sql:param value="${bean.business_id}"/>
		                                    </sql:query>
											<select id="customer_id"  name="customer_id" required="required"
													   class="select2"  disabled="disabled" data-placeholder="Choose Customer"  style="display: none;">
												<option value="">&nbsp;</option>
												<c:forEach var="customer" items="${customer.rows}">
												<option value="${customer.customer_id}">${customer.customer_name}</option>
												</c:forEach>
											</select>
		                                </div>
		                                
		                                 <div class="form-group col-sm-4" style="display: none;" id="supplier_id_view">
		                                    <label>Supplier Name <span class="text-danger">*</span></label>
		                                    <sql:query var="supplier" dataSource="jdbc/rmc">
		                                    	select supplier_id,supplier_name
		                                        from test_supplier
		                                        where supplier_status='active'
		                                        and business_id like if(?=0,'%%',?)
		                                        <sql:param value="${bean.business_id}"/>
		                                        <sql:param value="${bean.business_id}"/>
		                                    </sql:query>
											<select id="supplier_id"  name="supplier_id" class="select2" 
												    required="required" disabled="disabled" data-placeholder="Choose Supplier" style="display: none;">
												<option value="">&nbsp;</option>
												<c:forEach var="sup" items="${supplier.rows}">
												<option value="${sup.supplier_id}" 
														${(sup.supplier_id==pay.supplier_id)?'selected':''}>${sup.supplier_name}</option>
												</c:forEach>
											</select>
		                                </div>
		                                
		                               <div class="form-group col-sm-4">
	                                        <label>Transaction Date <span class="text-danger">*</span></label>
	                                        <div>
	                                            <div class="input-group">
	                                                <input type="text" name="transaction_date" class="form-control date-picker transaction_date_date" 
	                                                	required="required" placeholder="dd/mm/yyyy"
	                                                	readonly="readonly" style="background-color: white;"
	                                                    id="id-date-picker-1" data-date-format="dd/mm/yyyy">
	                                                <div class="input-group-append">
	                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
	                                                </div>
	                                            </div>
	                                        </div>
	                                   </div>
		                                
		                               <div class="form-group col-sm-4">
		                                    <label>Transaction Time <span class="text-danger">*</span> </label>
		                                    <div>
		                                        <div class="input-group">
		                                            <input type="text" name="transaction_time" class="form-control"
		                                            required="required" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
		                                            <div class="input-group-append">
		                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
		                                            </div>
		                                        </div>
		                                    </div>
		                               </div>
		                                <div class="form-group col-sm-4">
		                                    <label>Payment Type<span class="text-danger">*</span></label>
											<select id="payment_type"  name="payment_mode" required="required"   class="select2"  data-placeholder="Choose Site">
												<option value="CASH">CASH</option>
												<option value="WAIVE_OFF">WAIVE_OFF</option>
											</select>
		                                </div>
		                                
		                                <div class="col-sm-4">
		                                    <div class="form-group">
			                                    <label>Bank/Cash<span class="text-danger">*</span></label>
												<select id="bank_id"  name="bank_id" class="form-control"  required >
												
												</select>
			                                </div>
		                                </div>
		                               <div class="form-group col-sm-4">
		                                    <div class="form-group">
		                                        <label>Sender/Receiver</label>
		                                        <input class="form-control" type="text" id="receiver" name="receiver">
		                                    </div>
		                                </div>
		                                <div class="form-group col-sm-4">
		                                	<label for="business_id">Business Group <span class="text-danger"></span></label>
		                                	<sql:query var="business" dataSource="jdbc/rmc">
		                                		select business_id,group_name
		                                		from business_group
		                                		where business_id like if(?=0,'%%',?)
		                                		<sql:param value="${bean.business_id}"/>
		                                		<sql:param value="${bean.business_id}"/>
		                                	</sql:query>
		                                	<select name="business_id" id="business_id" class="form-control">
		                                		<c:forEach items="${business.rows}" var="business">
		                                			<option value="${business.business_id}">${business.group_name}</option>
		                                		</c:forEach>
		                                	</select>
		                                </div>
		                                <div class="col-sm-4">
		                                    <div class="form-group">
		                                        <label>Remarks</label>
		                                        <input class="form-control" type="text" id="remarks" name="remarks">
		                                    </div>
		                                </div>
		                                
		                            </div>
		                            
		                            <div class="text-center m-t-20">
		                                <button type="submit" class="btn btn-primary btn-lg m-r-10 save-button">Save Transaction</button>
		                                <button type="reset" class="btn btn-danger btn-lg">Cancel</button>
		                            </div>
		                        </form>
          		              </div>
		                   </div>
		                </div>
                  	</c:when>
                 <c:otherwise>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<div class="card-box row col-sm-12">
		                    	<form action="../BankDetailControllerTest?action=insertTransactionDetail" method="post" id="myForm">
		                            <div class="row">
		                                <div class="col-sm-4">
		                                    <div class="form-group">
		                                        <label>Transaction Amount</label>
		                                        <input class="form-control" type="text" id="transaction_amount" name="transaction_amount">
		                                    </div>
		                                </div>
		                                
		                                <div class="col-sm-4">
		                                    <div class="form-group">
			                                    <label>Transaction Type<span class="text-danger">*</span></label>
												<select id="transaction_type"  name="transaction_type" class="select2"  required data-placeholder="Select Transaction Type">
													<option value="">&nbsp;</option>
													<option value="cuspay">Customer Payment</option>
													<option value="suppay">Supplier Payment</option>
													<option value="pettycash">Petty Cash</option>
												</select>
			                                </div>
		                                </div>
		                                
		                                <div class="form-group col-sm-4" style="display:none;" id="customer_id_view">
		                                    <label>Customer <span class="text-danger">*</span></label>
		                                    <sql:query var="customer" dataSource="jdbc/rmc">
		                                    	select customer_id,customer_name
		                                        from test_customer
		                                        where customer_status='active'
		                                        and business_id like if(0=?,'%%',?)
		                                        order by customer_name asc 
		                                        <sql:param value="${bean.business_id}"/>
		                                        <sql:param value="${bean.business_id}"/>
		                                    </sql:query>
											<select id="customer_id"  name="customer_id" required="required"
													   class="select2"  disabled="disabled" data-placeholder="Choose Customer"  style="display: none;">
												<option value="">&nbsp;</option>
												<c:forEach var="customer" items="${customer.rows}">
												<option value="${customer.customer_id}">${customer.customer_name}</option>
												</c:forEach>
											</select>
		                                </div>
		                                
		                                 <div class="form-group col-sm-4" style="display: none;" id="supplier_id_view">
		                                    <label>Supplier Name <span class="text-danger">*</span></label>
		                                    <sql:query var="supplier" dataSource="jdbc/rmc">
		                                    	select supplier_id,supplier_name
		                                        from test_supplier
		                                        where supplier_status='active'
		                                        and business_id like if(?=0,'%%',?)
		                                        <sql:param value="${bean.business_id}"/>
		                                        <sql:param value="${bean.business_id}"/>
		                                    </sql:query>
											<select id="supplier_id"  name="supplier_id" class="select2" 
												    required="required" disabled="disabled" data-placeholder="Choose Supplier" style="display: none;">
												<option value="">&nbsp;</option>
												<c:forEach var="sup" items="${supplier.rows}">
												<option value="${sup.supplier_id}" 
														${(sup.supplier_id==pay.supplier_id)?'selected':''}>${sup.supplier_name}</option>
												</c:forEach>
											</select>
		                                </div>
		                                
		                                <div class="form-group col-sm-4">
		                                    <label>Expenditure Group <span class="text-danger">*</span></label>
											<select class="select2" name="category_type"
													 id="category_type">
													 
	                                        </select>
		                                </div>
			                                
		                                <div class="form-group col-sm-4">
		                                    <label>Expenditure A/C <span class="text-danger">*</span></label>
											<select class="form-control" name="category_id"
												    id="category_id" required="required">
												    
	                                        </select>
		                                </div>
		                                
		                               <div class="form-group col-sm-4">
	                                        <label>Transaction Date <span class="text-danger">*</span></label>
	                                        <div>
	                                            <div class="input-group">
	                                                <input type="text" name="transaction_date" class="form-control date-picker transaction_date_date" 
	                                                	required="required" placeholder="dd/mm/yyyy"
	                                                	readonly="readonly" style="background-color: white;"
	                                                    id="id-date-picker-1" data-date-format="dd/mm/yyyy">
	                                                <div class="input-group-append">
	                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
	                                                </div>
	                                            </div>
	                                        </div>
	                                   </div>
		                                
		                               <div class="form-group col-sm-4">
		                                    <label>Transaction Time <span class="text-danger">*</span> </label>
		                                    <div>
		                                        <div class="input-group">
		                                            <input type="text" name="transaction_time" class="form-control"
		                                            required="required" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
		                                            <div class="input-group-append">
		                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
		                                            </div>
		                                        </div>
		                                    </div>
		                               </div>
		                                <div class="form-group col-sm-4">
		                                    <label>Payment Type<span class="text-danger">*</span></label>
											<select id="payment_type"  name="payment_mode" required="required"   class="select2"  data-placeholder="Choose Site">
												<option value="CASH">CASH</option>
												<option value="WAIVE_OFF">WAIVE_OFF</option>
											</select>
		                                </div>
		                                
		                                <div class="col-sm-4">
		                                    <div class="form-group">
			                                    <label>Bank/Cash<span class="text-danger">*</span></label>
												<select id="bank_id"  name="bank_id" class="form-control"  required >
												
												</select>
			                                </div>
		                                </div>
		                               <div class="form-group col-sm-4">
		                                    <div class="form-group">
		                                        <label>Sender/Receiver</label>
		                                        <input class="form-control" type="text" id="receiver" name="receiver">
		                                    </div>
		                                </div>
		                                <div class="form-group col-sm-4">
		                                	<label for="business_id">Business Group <span class="text-danger"></span></label>
		                                	<sql:query var="business" dataSource="jdbc/rmc">
		                                		select business_id,group_name
		                                		from business_group
		                                		where business_id like if(?=0,'%%',?)
		                                		<sql:param value="${bean.business_id}"/>
		                                		<sql:param value="${bean.business_id}"/>
		                                	</sql:query>
		                                	<select name="business_id" id="business_id" class="form-control">
		                                		<c:forEach items="${business.rows}" var="business">
		                                			<option value="${business.business_id}">${business.group_name}</option>
		                                		</c:forEach>
		                                	</select>
		                                </div>
		                                <div class="col-sm-4">
		                                    <div class="form-group">
		                                        <label>Remarks</label>
		                                        <input class="form-control" type="text" id="remarks" name="remarks">
		                                    </div>
		                                </div>
		                                
		                            </div>
		                            
		                            <div class="text-center m-t-20">
		                                <button type="submit" class="btn btn-primary btn-lg m-r-10 save-button">Save Transaction</button>
		                                <button type="reset" class="btn btn-danger btn-lg">Cancel</button>
		                            </div>
		                        </form>
          		              </div>
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
        
        <script src="../assets/js/jquery.core.js"></script>
        <script src="../assets/js/jquery.app.js"></script>
        <script src="../picker/js/moment.min.js"></script>
        <script src="../assets/js/select2.min.js"></script>
        <script src="../picker/js/bootstrap-datetimepicker.min.js"></script>
		<script src="../assets/js/bootstrap-timepicker.min.js"></script>
		<script src="../picker/js/bootstrap-datepicker.min.js"></script>
		<script src="../assets/js/ace.min.js"></script>
		<script type="text/javascript" src="js/Bank/AddBankTransaction.js"></script>
		<c:choose>
			<c:when test="${empty param.action}">
				<script type="text/javascript" src="../js/Pickers/dateTimeValidator.js"></script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript" src="../js/Pickers/dateTimeValidatorEdit.js"></script>
			</c:otherwise>
		</c:choose>
		<script type="text/javascript" src="../validation/jquery.validate.min.js"></script>
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
    
		

    </body>
</html>