<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Customer Payment</title>
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
        	}
        </style>

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
                                    <li class="breadcrumb-item"><a href="#">Accounts</a></li>
                                    <li class="breadcrumb-item"><a href="#">Customer Payment</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Payment</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Add Payment</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="CustomerPaymentList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Payment List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
               
              	<c:choose>
              		<c:when test="${param.action=='update'}">
              			<!-- Now get payment details here -->
                		<sql:query var="payment" dataSource="jdbc/rmc">
                			select p.*,DATE_FORMAT(payment_date,'%d/%m/%Y') as payment_date
                		    from test_customer_payment p where payment_id=?
                			<sql:param value="${param.payment_id}"/>
                		</sql:query>
                		
                		<c:forEach items="${payment.rows}" var="payment">
                			<c:set value="${payment}" var="pay"/>
                		</c:forEach>
                		
              			<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" id="myform" action="../PaymentControllerTest?action=UpdatePayment" method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="col-sm-4">
											<div class="form-group">
			                                    <label>Customer <span class="text-danger">*</span></label>
			                                    <sql:query var="customer" dataSource="jdbc/rmc">
			                                    	select customer_id,customer_name
			                                        from test_customer
			                                        where business_id like if(0=?,'%%',?)
			                                        order by customer_name asc
			                                        <sql:param value="${bean.business_id}"/>
			                                        <sql:param value="${bean.business_id}"/>
			                                    </sql:query>
			                                    <input type="hidden" name="payment_id" value="${pay.payment_id}">
												<select id="customer_id"  name="customer_id" required="required" 
														  class="select2"  data-placeholder="Choose Customer">
													<option value="" selected disabled>&nbsp;</option>
													<c:forEach var="customer" items="${customer.rows}">
													<option value="${customer.customer_id}" ${(customer.customer_id==pay.customer_id)?'selected':''}>${customer.customer_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Site Address <span class="text-danger">*</span></label>
			                                    <sql:query var="site" dataSource="jdbc/rmc">
			                                    	select site_id,site_name
			                                        from test_site_detail where customer_id=?
			                                    	<sql:param value="${pay.customer_id}"/>
			                                    </sql:query>
												<select id="site_id"  name="site_id" required="required"   class="select2"  data-placeholder="Choose Site">
													<option value="0">All Site</option>
													<c:forEach var="site" items="${site.rows}">
													<option value="${site.site_id}" ${(site.site_id==pay.site_id)?'selected':''}>${site.site_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                <div class="form-group">
			                                    <label>Payment Amount<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  required="required"  value="${pay.payment_amount}"  id="payment_amount" name="payment_amount"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
		                                        <label>Payment Date <span class="text-danger"></span> </label>
		                                        <div>
		                                            <div class="input-group">
		                                                <input type="text" name="payment_date" class="form-control date-picker invoice_date"
		                                                		 value="${pay.payment_date}" required="required"
		                                                		 placeholder="dd/mm/yyyy" id="id-date-picker-1"
		                                                		 data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;">
		                                                <div class="input-group-append picker">
		                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                </div>
		                                            </div>
		                                        </div>
		                                         <label id="id-date-picker-1-error" class="error" for="id-date-picker-1" style="display: none;"></label>
		                                   </div>	
		                                   <div class="form-group">
			                                    <label>Payment Time <span class="text-danger">*</span> </label>
			                                    <div>
			                                        <div class="input-group">
			                                            <input type="text" name="payment_time" class="form-control" required="required" value="${pay.payment_time}" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
			                                            <div class="input-group-append">
			                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
			                                            </div>
			                                        </div>
			                                    </div>
			                                </div>		                        		
			                        	</div>
			                           	<div class="col-sm-4">
			                                <div class="form-group">
			                                    <label>Payment Type<span class="text-danger">*</span></label>
												<select id="payment_type"  name="payment_mode" required="required"   class="select2"  data-placeholder="Choose Site">
													<option ${(pay.payment_mode=='CASH')?'selected':''} value="CASH">CASH</option>
													<option ${(pay.payment_mode=='CHEQUE/DD')?'selected':''} value="CHEQUE/DD">CHEQUE/DD</option>	
													<option ${(pay.payment_mode=='NEFT/RTGS')?'selected':''} value="NEFT/RTGS">NFFT/RTGS</option>		  
													<option ${(pay.payment_mode=='BANK_TRANSFER')?'selected':''} value="BANK_TRANSFER" >BANK_TRANSFER</option>
													<option ${(pay.payment_mode=='CREDIT_CARD')?'selected':''} value="CREDIT_CARD">CREDIT_CARD</option>
													<option ${(pay.payment_mode=='CREDIT_NOTE')?'selected':''} value="CREDIT_NOTE">CREDIT_NOTE</option>
													<option ${(pay.payment_mode=='DEBIT_NOTE')?'selected':''} value="DEBIT_NOTE">DEBIT_NOTE</option>
													<option ${(pay.payment_mode=='WAIVE_OFF')?'selected':''} value="WAIVE_OFF">WAIVE_OFF</option>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>CHECK/DD NUMBER<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control pt" 
			                                         pattern="[^'&quot;:]*$" ${(pay.payment_mode=='CHEQUE/DD')?'':'disabled'}
			                                          value="${pay.check_dd_no}"  disabled="disabled"   id="check_dd_number" name="check_dd_no"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
		                                        <label>Check/DD Validity <span class="text-danger"></span> </label>
		                                        <div>
		                                            <div class="input-group">
		                                                <input type="text" name="check_dd_validity" ${(pay.payment_mode=='CHEQUE/DD')?'':'disabled'}
		                                                		 value="${pay.check_dd_validity}" disabled="disabled"
		                                                		  class="form-control date-picker pt"
		                                                		  placeholder="dd/mm/yyyy" id="id-date-picker-1" data-date-format="dd/mm/yyyy">
		                                                <div class="input-group-append">
		                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                </div>
		                                            </div>
		                                        </div>
		                                   </div>
		                                   
		                                    <div class="form-group">
			                                    <label>NEFT/RTGS NO ${pay.payment_mode}<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control pt neft" ${pay.payment_mode=='NEFT/RTGS'?'':'disabled'} value="${pay.neft_no}" 
			                                         pattern="[^'&quot;:]*$"   id="neft_number" name="neft_no"/>
			                                    </div>
			                                </div>
		                                   
			                               <div class="form-group">
			                                    <label>Bank Name<span class="text-danger">*</span> </label>
			                                    <sql:query var="marketing" dataSource="jdbc/rmc">
			                                    	select * from bank_detail
			                                    </sql:query>
												<select id="bank_detail_id"  name="bank_detail_id" required="required"   class="select2"  data-placeholder="Choose Bank Detail">
													<option value="">&nbsp;</option>
													<c:forEach var="marketing" items="${marketing.rows}">
													<option value="${marketing.bank_detail_id}" ${(marketing.bank_detail_id==pay.bank_detail_id)?'selected':''}>${marketing.bank_name}</option>
													</c:forEach>
												</select>
			                                </div>
		                                   
			                                
		                                   <div class="form-group">
			                                    <label>Comment <span class="text-center">*</span></label>
			                                    <textarea class="form-control datepicker3" required="required" id="comment" name="comment" placeholder="Please Enter Comment"></textarea>
			                                </div>
			                                
			                            </div>
			                            <div class="col-sm-4">
			                            <br><br>
		                               		<table class="table table-bordered">
		                               			<tr>
		                               				<td class="text-center" style="background-color: #09aabc;color: white;">Total Credit Balance</td>
		                               			</tr>
		                               			<tr>
		                               				<td id="credit_balance" class="text-center"></td>
		                               			</tr>
		                               		</table>
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
		                    	<form class="" id="myform" action="../PaymentControllerTest?action=InsertPayment" method="post">
			                        <div class="card-box row col-sm-12">
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
												<select id="customer_id"  name="customer_id" required="required"   class="select2"  data-placeholder="Choose Customer">
													<option value="">&nbsp;</option>
													<c:forEach var="customer" items="${customer.rows}">
													<option value="${customer.customer_id}">${customer.customer_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Site Address <span class="text-danger">*</span></label>
												<select id="site_id"  name="site_id" required="required"   class="select2"  data-placeholder="Choose Site">
													<option value="0">All Site</option>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Payment Amount<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                          required="required"    id="payment_amount" name="payment_amount"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
		                                        <label>Payment Date <span class="text-danger"></span> </label>
		                                        <div>
		                                            <div class="input-group">
		                                                <input type="text" name="payment_date" class="form-control date-picker invoice_date"
		                                                	   required="required" placeholder="dd/mm/yyyy"
		                                                	   id="id-date-picker-1" data-date-format="dd/mm/yyyy">
		                                                <div class="input-group-append picker">
		                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                </div>
		                                            </div>
		                                        </div>
		                                        <label id="id-date-picker-1-error" class="error" style="display: none;" for="id-date-picker-1"></label>
		                                   </div>
		                                   <div class="form-group">
			                                    <label>Payment Time <span class="text-danger">*</span> </label>
			                                    <div>
			                                        <div class="input-group">
			                                            <input type="text" name="payment_time" class="form-control" required="required" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
			                                            <div class="input-group-append">
			                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
			                                            </div>
			                                        </div>
			                                    </div>
			                                </div>			                        		
			                        	</div>
			                           	<div class="col-sm-4">
			                                <div class="form-group">
			                                    <label>Payment Type<span class="text-danger">*</span></label>
												<select id="payment_type"  name="payment_mode" required="required"   class="select2"  data-placeholder="Choose Site">
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
			                                
			                                <div class="form-group">
			                                    <label>CHECK/DD NUMBER<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control pt" 
			                                         pattern="[^'&quot;:]*$"   disabled="disabled"   id="check_dd_number" name="check_dd_no"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
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
		                                   
		                                   
		                                   <div class="form-group">
			                                    <label>NEFT/RTGS NO<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control pt neft" 
			                                         pattern="[^'&quot;:]*$"   disabled="disabled"   id="neft_number" name="neft_no"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Bank Name<span class="text-danger">*</span> </label>
			                                    <sql:query var="marketing" dataSource="jdbc/rmc">
			                                    	select * from bank_detail
			                                    </sql:query>
												<select id="bank_detail_id"  name="bank_detail_id" required="required" 
													  class="form-control"  data-placeholder="Choose Bank Name">
													<option value="" selected disabled>&nbsp;</option>
													<c:forEach var="marketing" items="${marketing.rows}">
													<option value="${marketing.bank_detail_id}">${marketing.bank_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                            </div>
			                            <div class="col-sm-4">
			                            <br><br>
		                               		<table class="table table-bordered">
		                               			<tr>
		                               				<td class="text-center" style="background-color: #09aabc;color: white;">Total Credit Balance</td>
		                               			</tr>
		                               			<tr>
		                               				<td id="credit_balance" class="text-center"></td>
		                               			</tr>
		                               		</table>
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
		<script src="../assets/js/bootstrap-timepicker.min.js"></script>
		<script src="../picker/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="js/Accounts/Payment/AddPayment.js"></script>
		<c:choose>
			<c:when test="${empty param.action}">
				<script type="text/javascript" src="../js/Pickers/dateTimeValidator.js"></script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript" src="../js/Pickers/dateTimeValidatorEdit.js"></script>
			</c:otherwise>
		</c:choose>
		<script type="text/javascript" src="../validation/jquery.validate.js"></script>
    </body>
</html>