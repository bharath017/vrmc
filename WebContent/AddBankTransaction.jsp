<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Bank Transaction</title>
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
        <style type="text/css">
        	.error{
        		color:red;
        	}
        </style>
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
                                    <li class="breadcrumb-item"><a href="#">Accounts</a></li>
                                    <li class="breadcrumb-item"><a href="#">Transaction Details</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Bank Transaction</a></li>
                                </ol>
                            </div>
                            <c:choose>
                            	<c:when test="${param.action=='update'}">
                            		<h4 class="page-title">Update Bank Transaction Details</h4>
                            	</c:when>
                            	<c:otherwise>
                            		<h4 class="page-title">Add Bank Transaction Details</h4>
                            	</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="BankTransactionList.jsp" class="btn btn-custom waves-effect waves-light mb-4" 
                         data-overlayColor="#36404a"><i class="mdi mdi-grid"></i> Bank Transaction List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="bank" dataSource="jdbc/rmc">
                			select t.*,DATE_FORMAT(t.transaction_date,'%d/%m/%Y') as transaction_date
                		    from bank_transaction t where transaction_id=?
                			<sql:param value="${param.transaction_id}"/>
                		</sql:query> 
                		<c:forEach items="${bank.rows}" var="bank">
                        	<c:set value="${bank}" var="rs"/>
                        </c:forEach>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<div class="card-box row col-sm-12">
		                    	<form action="BankDetailController?action=updateTransactionDetail"
		                    			 method="post" id="myForm">
		                            <div class="row">
		                            	<div class="col-sm-4">
		                                    <div class="form-group">
			                                    <label>Bank/Cash<span class="text-danger">*</span></label>
			                                     <sql:query var="bank" dataSource="jdbc/rmc">
			                                    	select b.bank_detail_id,b.bank_name,g.group_name
			                                        from bank_detail b,business_group g
			                                        where b.business_id=g.business_id
			                                        and b.business_id like if(?=0,'%%',?)
			                                        <sql:param value="${bean.business_id}"/>
			                                        <sql:param value="${bean.business_id}"/>
			                                    </sql:query>
			                                    <input type="hidden" name="transaction_id" id="transaction_id" value="${rs.transaction_id}"/>
												<select id="bank_id"  name="bank_id" class="form-control"  required >
													<c:forEach items="${bank.rows}" var="bank">
														<option value="${bank.bank_detail_id}"
																 ${(bank.bank_detail_id==rs.bank_id)?'selected':''}>${bank.bank_name} - (${bank.group_name})</option>
													</c:forEach>
												</select>
			                                </div>
		                                </div>
		                                
		                                <div class="col-sm-4">
		                                    <div class="form-group">
		                                        <label>Transaction Amount</label>
		                                        <input class="form-control"
		                                               type="text" id="transaction_amount"
		                                               name="transaction_amount" value="${rs.transaction_amount}">
		                                    </div>
		                                </div>
		                                
		                                <div class="col-sm-4">
		                                    <div class="form-group">
			                                    <label>Transaction Type<span class="text-danger">*</span></label>
			                                    <input type="hidden" name="old_transaction_type" value="${rs.transaction_type}"/>
												<select id="transaction_type"  name="transaction_type"
													    class="form-control"
													    required>
													<option value="" disabled>&nbsp;</option>
													<option value="credit"
														 ${(rs.transaction_type=='credit')?'selected':''}>Credit</option>
													<option value="debit"
														 ${(rs.transaction_type=='debit')?'selected':''}>Debit</option>
													<option value="cuspay"
														 ${(rs.transaction_type=='cuspay')?'selected':''}>Customer Payment</option>
													<option value="suppay"
														 ${(rs.transaction_type=='suppay')?'selected':''}>Supplier Payment</option>
												</select>
			                                </div>
		                                </div>
		                                
		                                
		                                <div class="form-group col-sm-4" style="display:none;" id="customer_id_view">
		                                    <label>Customer <span class="text-danger">*</span></label>
		                                    <sql:query var="customer" dataSource="jdbc/rmc">
		                                    	select customer_id,customer_name
		                                        from customer
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
		                                        from supplier
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
	                                                    id="id-date-picker-1" data-date-format="dd/mm/yyyy" value="${rs.transaction_date}">
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
		                                            required="required" placeholder="HH:MM:SS"
		                                            id="timepicker1" data-date-format="yyyy-mm-dd" value="${rs.transaction_time}">
		                                            <div class="input-group-append">
		                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
		                                            </div>
		                                        </div>
		                                    </div>
		                               </div>
		                               <div class="form-group col-sm-4">
		                                    <div class="form-group">
		                                        <label>Sender/Receiver</label>
		                                        <input class="form-control" type="text"
		                                        	   id="receiver" name="receiver" value="${rs.receiver}">
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
		                                			<option value="${business.business_id}" 
		                                					${(business.business_id==rs.business_id)?'selected':''}>${business.group_name}</option>
		                                		</c:forEach>
		                                	</select>
		                                </div>
		                                
		                                <div class="col-sm-8">
		                                    <div class="form-group">
		                                        <label>Remarks</label>
		                                        <input class="form-control" type="text"
		                                        	   id="remarks" name="remarks" value="${rs.remarks}">
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
		                    	<form action="BankDetailController?action=insertTransactionDetail" method="post" id="myForm">
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
													<option value="credit">Credit</option>
													<option value="debit">Debit</option>
													<option value="cuspay">Customer Payment</option>
													<option value="suppay">Supplier Payment</option>
												</select>
			                                </div>
		                                </div>
		                                
		                                <div class="form-group col-sm-4" style="display:none;" id="customer_id_view">
		                                    <label>Customer <span class="text-danger">*</span></label>
		                                    <sql:query var="customer" dataSource="jdbc/rmc">
		                                    	select customer_id,customer_name
		                                        from customer
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
		                                        from supplier
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
											<select id="payment_type"  name="payment_mode" required="required"   class="form-control"  data-placeholder="Choose Site">
												<option value="CASH">CASH</option>
												<option value="CHEQUE/DD">CHEQUE/DD</option>
												<option value="NEFT/RTGS">NEFT/RTGS</option>
												<option value="BANK_TRANSFER">BANK_TRANSFER</option>
												<option value="CREDIT_CARD">CREDIT_CARD</option>
												<option value="CREDIT_NOTE">CREDIT_NOTE</option>
												<option value="DEBIT_NOTE">DEBIT_NOTE</option>
												<option value="WAIVE_OFF">WAIVE_OFF</option>
											</select>
		                                </div>
		                                
		                                <div class="col-sm-4">
		                                    <div class="form-group">
			                                    <label>Bank/Cash<span class="text-danger">*</span></label>
			                                     <sql:query var="bank" dataSource="jdbc/rmc">
			                                    	select b.bank_detail_id,b.bank_name,g.group_name
			                                        from bank_detail b,business_group g
			                                        where b.business_id=g.business_id
			                                        and b.business_id like if(?=0,'%%',?)
			                                        <sql:param value="${bean.business_id}"/>
			                                        <sql:param value="${bean.business_id}"/>
			                                    </sql:query>
												<select id="bank_id"  name="bank_id" class="form-control"  required >
												</select>
			                                </div>
		                                </div>
		                                
		                                <div class="form-group col-sm-4">
		                                    <label>CHECK/DD NUMBER<span class="text-danger">*</span> </label>
		                                    <div>
		                                       <input type="text" class="form-control pt" 
		                                         pattern="[^'&quot;:]*$"   disabled="disabled"   id="check_dd_number" name="check_dd_no"/>
		                                    </div>
		                                </div>
		                                
		                                <div class="form-group col-sm-4">
	                                        <label>Check/DD Validity <span class="text-danger"></span> </label>
	                                        <div>
	                                            <div class="input-group">
	                                                <input type="text" name="check_dd_validity" disabled="disabled" class="form-control date-picker pt"  placeholder="dd/mm/yyyy" id="id-date-picker-1" data-date-format="dd/mm/yyyy">
	                                                <div class="input-group-append">
	                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
	                                                </div>
	                                            </div>
	                                        </div>
	                                   </div>
	                                   
	                                   
	                                   <div class="form-group col-sm-4">
		                                    <label>NEFT/RTGS NO<span class="text-danger">*</span> </label>
		                                    <div>
		                                       <input type="text" class="form-control pt neft" 
		                                         pattern="[^'&quot;:]*$"   disabled="disabled"   id="neft_number" name="neft_no"/>
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
       <%@ include file="footer.jsp" %>
        <!-- End Footer -->

        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
        
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="picker/js/moment.min.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="assets/js/ace.min.js"></script>
		<c:choose>
			<c:when test="${empty param.action}">
				<script type="text/javascript" src="js/Accounts/Bank/AddBankTransaction.js"></script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript" src="js/Accounts/Bank/UpdateBankTransaction.js"></script>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${empty param.action}">
				<script type="text/javascript" src="js/Pickers/dateTimeValidator.js"></script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript" src="js/Pickers/dateTimeValidatorEdit.js"></script>
			</c:otherwise>
		</c:choose>
		<script type="text/javascript" src="validation/jquery.validate.min.js"></script>
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