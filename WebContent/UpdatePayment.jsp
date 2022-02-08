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
        	.hide{
        		display: none;
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
                
                
                <sql:query var="payment" dataSource="jdbc/rmc">
                			select * from customer_payment where payment_id=?
                			<sql:param value="${param.payment_id}"/>
                		</sql:query>
                		
                		<c:forEach items="${payment.rows}" var="payment">
                			<c:set value="${payment}" var="pay"/>
                		</c:forEach>
                		
              			<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" id="myform" action="PaymentController?action=UpdatePayment" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-3">
			                           	   <div class="form-group">
			                                    <label>Customer <span class="text-danger">*</span></label>
			                                    <sql:query var="customer" dataSource="jdbc/rmc">
			                                    	select * from customer where customer_status='active' order by customer_name asc
			                                    </sql:query>
			                                    <input type="hidden" name="payment_id" id="update_payment"  value="${pay.payment_id}">
												<select id="customer_id"  name="customer_id" required="required"   class="select2"  data-placeholder="Choose Customer">
													<option value="">&nbsp;</option>
													<c:forEach var="customer" items="${customer.rows}">
													<option value="${customer.customer_id}" ${(customer.customer_id==pay.customer_id)?'selected':''}>${customer.customer_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                            <%--     <div class="form-group">
			                                    <label>Customer <span class="text-danger">*</span></label>
			                                    <sql:query var="site" dataSource="jdbc/rmc">
			                                    	select * from site_detail where customer_id=?
			                                    	<sql:param value="${pay.customer_id}"/>
			                                    </sql:query>
												<select id="site_id"  name="site_id" required="required"   class="select2"  data-placeholder="Choose Site">
													<option value="0">All Site</option>
													<c:forEach var="site" items="${site.rows}">
													<option value="${site.site_id}" ${(site.site_id==pay.site_id)?'selected':''}>${site.site_name}</option>
													</c:forEach>
												</select>
			                                </div> --%>
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
		                                                <input type="text" name="payment_date" class="form-control date-picker invoice_date" value="${pay.payment_date}" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
		                                                <div class="input-group-append">
		                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                </div>
		                                            </div>
		                                        </div>
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
			                                 	<div class="col-sm-3">
			                                <div class="form-group">
			                                    <label>Payment Type<span class="text-danger">*</span></label>
												<select id="payment_type"  name="payment_mode" required="required"   class="select2"  data-placeholder="Choose Site">
													<option ${(pay.payment_mode=='CASH')?'selected':''} value="CASH">CASH</option>
													<option ${(pay.payment_mode=='CHECK/DD')?'selected':''} value="CHECK/DD">CHECK/DD</option>	
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
			                                         pattern="[^'&quot;:]*$" ${(pay.payment_mode=='CASH')?'disabled':''} value="${pay.check_dd_no}"  disabled="disabled"   id="check_dd_number" name="check_dd_no"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
		                                        <label>Check/DD Validity <span class="text-danger"></span> </label>
		                                        <div>
		                                            <div class="input-group">
		                                                <input type="text" name="check_dd_validity" ${(pay.payment_mode=='CASH')?'disabled':''} value="${pay.check_dd_validity}" disabled="disabled" class="form-control date-picker pt"  placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
		                                                <div class="input-group-append">
		                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                </div>
		                                            </div>
		                                        </div>
		                                   </div>
		                                   
		                                   <div class="form-group">
			                                    <label for="marketing_person">Marketing person <span class="text-danger">*</span></label>
			                                    <sql:query var="marketing" dataSource="jdbc/rmc">
			                                    	select * from marketing_person order by mp_name asc
			                                    </sql:query>
												<select id="mp_id"  name="mp_id" required="required"   class="select2"  data-placeholder="Choose Marketing person">
													<option value="">&nbsp;</option>
													<c:forEach var="marketing" items="${marketing.rows}">
													<option value="${marketing.mp_id}" ${(marketing.mp_id==pay.mp_id)?'selected':''}>${marketing.mp_name}</option>
													</c:forEach>
												</select>
			                                </div>
		                                    <div class="form-group">
			                                    <label>Comment <span class="text-center">*</span></label>
			                                    <textarea class="form-control datepicker3" required="required" id="comment" name="comment" placeholder="Please Enter Comment">${pay.comment}</textarea>
			                                </div>
			                            </div>
			                             <div class="col-sm-6 text-center">
			                            	<input type="hidden" name="count" id="count">
			                            	<table class="table table-bordered table-hover mytable" id="Table1">
			                            		<thead>
			                            			<tr style="background-color: #95f5ed;">
			                            				<th>S/L No</th>
			                            				<th>Invoice NO</th>
			                            				<th>Invoice Date</th>
			                            				<th>Overdue Date</th>
			                            				<th>Invoice Amount</th>
			                            				<th>Remaining Amount</th>
			                            				<th>Payment Amount</th>
			                            			</tr>
			                            		</thead>
			                            		<tbody></tbody>
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
		<script type="text/javascript" src="js/UpdatePayment.js"></script>
        <!-- Parsley js -->
        <script type="text/javascript" src="plugins/parsleyjs/parsley.min.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<script src="assets/js/ace.min.js"></script>
		
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
				
				
				
				//normal select and date format option here
				 $(document).ready(function() {
			         $('form').parsley();
			         
			         $('.select2').css('width','100%').select2({allowClear:true})
						.on('change', function(){
						}); 
			         
			         
			         $('.date-picker').datepicker({
							autoclose: true,
							todayHighlight: true
					 });
				//show datepicker when clicking on the icon
						
			         
			         $("#id-date-picker-1").datepicker("setDate", new Date());
						$('#id-date-picker-1').datepicker({
						        "setDate": new Date(),
						        "autoclose": true
					});
			     });
				
			});
		</script>
		
		<script type="text/javascript">
    	$(document).ready(function(){
    		$('#payment_type').on('change',function(){
    			var payment_type=$('#payment_type').val();
    			if(payment_type=='CHECK/DD'){
    				$('.pt').prop('disabled',false);
    			}else{
    				$('.pt').prop('disabled',true);
    			}
    		});
    	});
    </script>
    
    <script type="text/javascript">
    	$(document).ready(function(){
    		$('#customer_id').on('change',function(){
    			var customer_id=$('#customer_id').val();
				$.ajax({
					type:'POST',
					url:'PaymentController?action=GetCreditAmount&customer_id='+customer_id,
					headers:{
						Accept:"text/html;charset=utf-8",
						"Content-Type":"text/html;charset=utf-8"
					},
					success:function(res){
						$('#credit_balance').text(res);
					}
				})    			
    		});
    		
    		//get site details
    		$('#customer_id').on('change',function(){
    			var customer_id=$('#customer_id').val();
    			$.ajax({
    				type:'POST',
    				url:'CustomerController?action=getCustomerSiteDetails&customer_id='+customer_id,
    				headers:{
    					Accept:"application/json;charset=utf-8",
    					"Content-Type":"application/json;charset=utf-8"
    				},
    				success:function(result){
    					$('#select2-site_id-container').html('Choose Site Address');
    					$('#site_id').html('');
    	        		$('#site_id').html('<option value="">Choose Site Address.</option>');
    	        		$('#site_id').append("<option value='0'>All Site</option>");
    	        		$.each(result, function(index, value) {
    	        			   $('#site_id').append("<option value='"+ value.site_id+ "'>" + value.site_name + "</option>");
    	        		});
    	        		
    				}
    			});
    		});
    	});
    </script>
    
    </body>
</html>