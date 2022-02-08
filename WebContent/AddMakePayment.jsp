<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Make Payment</title>
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
        		color:red;
        	}
        </style>
        <style type="text/css">
			.mytable tr th{
				background-color: #417a37;
				color: white;
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
                                    <li class="breadcrumb-item"><a href="#">Accounts</a></li>
                                    <li class="breadcrumb-item"><a href="#">Make Payment</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Make Payment</a></li>
                                </ol>
                            </div>
                            <c:choose>
	                    		<c:when test="${param.action=='update'}">
	                    			<h4 class="page-title">Update Payment</h4>
	                    		</c:when>
	                    		<c:otherwise>
	                    			<h4 class="page-title">Add Make Payment</h4>
	                    		</c:otherwise>
	                    	</c:choose>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="MakePaymentList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Make Payment List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
               
              	<c:choose>
              		<c:when test="${param.action=='update'}">
              			<!-- Now get payment details here -->
                		<sql:query var="payment" dataSource="jdbc/rmc">
                			select p.*,DATE_FORMAT(p.payment_date,'%d/%m/%Y') as payment_date
                		    from make_payment p
                		    where payment_id=?
                			<sql:param value="${param.payment_id}"/>
                		</sql:query>
                		
                		<c:forEach items="${payment.rows}" var="payment">
                			<c:set value="${payment}" var="pay"/>
                		</c:forEach>
              			<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" id="myform" action="MakePaymentController?action=UpdateMakePayment" method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="col-sm-4">
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
			                                    <input type="hidden" name="payment_id" value="${pay.payment_id}"/>
												<select id="supplier_id"  name="supplier_id" class="select2" 
													    required="required" data-placeholder="Choose Supplier">
													<option value="">&nbsp;</option>
													<c:forEach var="sup" items="${supplier.rows}">
													<option value="${sup.supplier_id}" ${(sup.supplier_id==pay.supplier_id)?'selected':''}>${sup.supplier_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Payment Details<span class="text-danger">*</span></label>
			                                    <div>
			                                      <input class="form-control" type="text"
			                                      		 id="payment_details"  name="payment_details" value="${pay.payment_details}">
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Payment Amount<span class="text-danger">*</span></label>
			                                    <div>
			                                      <input class="form-control" type="text" 
			                                      		 id="payment_amount"  name="payment_amount" value="${pay.payment_amount}">
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
		                                        <label>Payment Date <span class="text-danger"></span> </label>
		                                        <div>
		                                            <div class="input-group">
		                                                <input type="text" name="payment_date" class="form-control date-picker invoice_date"
		                                                	   required="required" placeholder="dd/mm/yyyy"
		                                                	   id="id-date-picker-1"
		                                                	   data-date-format="dd/mm/yyyy"
		                                                	   value="${pay.payment_date}"
		                                                	   readonly="readonly" style="background-color: white;">
		                                                <div class="input-group-append picker">
		                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                </div>
		                                            </div>
		                                             <label id="id-date-picker-1-error" class="error" for="id-date-picker-1" style="display: none;"></label>
		                                        </div>
		                                   </div>
			                                
			                                <div class="form-group">
			                                    <label>Payment Time <span class="text-danger">*</span> </label>
			                                    <div>
			                                        <div class="input-group">
			                                            <input type="text" name="payment_time" class="form-control" required="required"
			                                            	   placeholder="HH:MM:SS"
			                                            	   id="timepicker1"
			                                            	   data-date-format="yyyy-mm-dd" value="">
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
												<select id="payment_mode"  name="payment_mode" required="required"   class="select2"  data-placeholder="Choose Site">
													<option value="CASH" ${(pay.payment_mode=='CASH')?'selected':''}>CASH</option>
													<option value="CHEQUE/DD" ${(pay.payment_mode=='CHEQUE/DD')?'selected':''}>CHEQUE/DD</option>
													<option value="NEFT/RTGS" ${(pay.payment_mode=='NEFT/RTGS')?'selected':''}>NEFT/RTGS</option>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>CHEQUE/DD NUMBER<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control pt" 
			                                         pattern="[^'&quot;:]*$"   disabled="disabled"
			                                         id="check_dd_number" name="check_dd_no" value="${pay.check_dd_no}"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
		                                        <label>CHEQUE/DD Validity <span class="text-danger"></span> </label>
		                                        <div>
		                                            <div class="input-group">
		                                                <input type="text" name="check_dd_validity" disabled="disabled"
		                                                	   class="form-control date-picker pt"
		                                                	   placeholder="dd/mm/yyyy" 
		                                                	   id="id-date-picker-1" 
		                                                	   data-date-format="dd/mm/yyyy" value="${pay.check_dd_validity}">
		                                                <div class="input-group-append">
		                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                </div>
		                                            </div>
		                                        </div>
		                                   </div>
		                                   
		                                   <div class="form-group">
			                                    <label>Bank Name<span class="text-danger">*</span> </label>
			                                    <sql:query var="marketing" dataSource="jdbc/rmc">
			                                    	select b.bank_detail_id,b.bank_name,g.group_name
			                                        from bank_detail b,business_group g
			                                        where b.business_id=g.business_id
			                                        and b.business_id like if(?=0,'%%',?)
			                                        <sql:param value="${bean.business_id}"/>
			                                        <sql:param value="${bean.business_id}"/>
			                                    </sql:query>
												<select id="bank_detail_id"  name="bank_detail_id" required="required"   class="select2"  data-placeholder="Choose Bank Name">
													<option value="">&nbsp;</option>
													<c:forEach var="marketing" items="${marketing.rows}">
													<option value="${marketing.bank_detail_id}" 
																${(marketing.bank_detail_id==pay.bank_detail_id)?'selected':''}>${marketing.bank_name} - (${marketing.group_name})</option>
													</c:forEach>
												</select>
			                                </div>
		                                   
		                                   <div class="form-group">
			                                    <label>Remark<span class="text-danger"></span></label>
			                                    <div>
			                                      <input class="form-control" type="text" id="remark"  value="${pay.remark}"   name="remark">
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="col-sm-4">
			                            <br><br>
			                            	<table class="table table-bordered table-hover mytable">
			                            		<tr>
			                            			<td  colspan="2" style="background-color: #09aabc;color: white;" class="col-xs-12 text-center">
			                            				<h4 class="text-center">Remaining Credit Balance</h4>
			                            			</td>
			                            		</tr>
			                            		<tr>
			                            			<td style="width: 60%" colspan="2" id="credit_balance" class="text-center credit_balance"></td>
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
		                    	<form class="" id="myform" action="MakePaymentController?action=InsertMakePayment" method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="col-sm-4">
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
												<select id="supplier_id"  name="supplier_id" class="select2" 
													    required="required" data-placeholder="Choose Supplier">
													<option value="">&nbsp;</option>
													<c:forEach var="sup" items="${supplier.rows}">
													<option value="${sup.supplier_id}">${sup.supplier_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Payment Details<span class="text-danger">*</span></label>
			                                    <div>
			                                      <input class="form-control" type="text" id="payment_details"   name="payment_details">
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Payment Amount<span class="text-danger">*</span></label>
			                                    <div>
			                                      <input class="form-control" type="text" id="payment_amount"  name="payment_amount">
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
		                                        <label>Payment Date <span class="text-danger"></span> </label>
		                                        <div>
		                                            <div class="input-group">
		                                                <input type="text" name="payment_date" class="form-control date-picker invoice_date"
		                                                	   required="required" placeholder="dd/mm/yyyy"
		                                                	   id="id-date-picker-1" data-date-format="dd/mm/yyyy"
		                                                	   readonly="readonly" style="background-color: white;">
		                                                <div class="input-group-append picker">
		                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                </div>
		                                            </div>
		                                             <label id="id-date-picker-1-error" class="error" for="id-date-picker-1" style="display: none;"></label>
		                                        </div>
		                                   </div>
			                                
			                                <div class="form-group">
			                                    <label>Payment Time <span class="text-danger">*</span> </label>
			                                    <div>
			                                        <div class="input-group">
			                                            <input type="text" name="payment_time" class="form-control" required="required"
			                                            	   placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
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
												<select id="payment_mode"  name="payment_mode" required="required"   class="select2"  data-placeholder="Choose Site">
													<option value="CASH">CASH</option>
													<option value="CHEQUE/DD">CHEQUE/DD</option>
													<option value="NEFT/RTGS">NEFT/RTGS</option>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>CHEQUE/DD NUMBER<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control pt" 
			                                         pattern="[^'&quot;:]*$"   disabled="disabled"   id="check_dd_number" name="check_dd_no"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
		                                        <label>CHEQUE/DD Validity <span class="text-danger"></span> </label>
		                                        <div>
		                                            <div class="input-group">
		                                                <input type="text" name="check_dd_validity" disabled="disabled"
		                                                	   class="form-control date-picker pt"
		                                                	   placeholder="dd/mm/yyyy" id="id-date-picker-1" data-date-format="dd/mm/yyyy">
		                                                <div class="input-group-append">
		                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                </div>
		                                            </div>
		                                        </div>
		                                   </div>
		                                   
		                                   <div class="form-group">
			                                    <label>Bank Name<span class="text-danger">*</span> </label>
			                                     <sql:query var="marketing" dataSource="jdbc/rmc">
			                                    	select b.bank_detail_id,b.bank_name,g.group_name
			                                        from bank_detail b,business_group g
			                                        where b.business_id=g.business_id
			                                        and b.business_id like if(?=0,'%%',?)
			                                        <sql:param value="${bean.business_id}"/>
			                                        <sql:param value="${bean.business_id}"/>
			                                    </sql:query>
												<select id="bank_detail_id"  name="bank_detail_id" required="required"   class="select2"  data-placeholder="Choose Bank Name">
													<option value="">&nbsp;</option>
													<c:forEach var="marketing" items="${marketing.rows}">
													<option value="${marketing.bank_detail_id}">${marketing.bank_name} - (${marketing.group_name})</option>
													</c:forEach>
												</select>
			                                </div>
		                                   
		                                   <div class="form-group">
			                                    <label>Remark<span class="text-danger"></span></label>
			                                    <div>
			                                      <input class="form-control" type="text" id="remark"    name="remark">
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="col-sm-4">
			                            <br><br>
			                            	<table class="table table-bordered table-hover mytable">
			                            		<tr>
			                            			<td  colspan="2" style="background-color: #09aabc;color: white;" class="col-xs-12 text-center">
			                            				<h4 class="text-center">Remaining Credit Balance</h4>
			                            			</td>
			                            		</tr>
			                            		<tr>
			                            			<td style="width: 60%" colspan="2" id="credit_balance" class="text-center credit_balance"></td>
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
       <%@ include file="footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script type="text/javascript" src="js/Accounts/MakePayment/AddMakePayment.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="validation/jquery.validate.js"></script>
		<c:choose>
			<c:when test="${empty param.action}">
				<script type="text/javascript" src="js/Pickers/dateTimeValidator.js"></script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript" src="js/Pickers/dateTimeValidatorEdit.js"></script>
			</c:otherwise>
		</c:choose>
    </body>
</html>