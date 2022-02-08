<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Sales Commission</title>
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
                                    <li class="breadcrumb-item"><a href="#">Sales Commission</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Sales Commission</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Add Sales Comission</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="SalesComissionList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#09aabc"><i class="mdi mdi-plus"></i>Sales Commission List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
               
              	<c:choose>
              		<c:when test="${param.action=='update'}">
              			<!-- Now get payment details here -->
                		<sql:query var="payment" dataSource="jdbc/rmc">
                			select * from test_sales_comission where payment_id=?
                			<sql:param value="${param.payment_id}"/>
                		</sql:query>
                		
                		<c:forEach items="${payment.rows}" var="payment">
                			<c:set value="${payment}" var="pay"/>
                		</c:forEach>
                		
              			<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" id="myform" action="SalesComissionController?action=UpdatePayment" method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="col-sm-2"></div>
			                           	<div class="col-sm-6">
			                           	   <div class="form-group">
			                                    <label>Customer <span class="text-danger">*</span></label>
			                                    <sql:query var="customer" dataSource="jdbc/rmc">
			                                    	select * from customer order by customer_name asc
			                                    </sql:query>
			                                    <input type="hidden" name="payment_id" value="${pay.payment_id}">
												<select id="customer_id"  name="customer_id" required="required"   class="select2"  data-placeholder="Choose Customer">
													<option value="">&nbsp;</option>
													<c:forEach var="customer" items="${customer.rows}">
													<option value="${customer.customer_id}" ${(customer.customer_id==pay.customer_id)?'selected':''}>${customer.customer_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Site Address <span class="text-danger">*</span></label>
			                                    <sql:query var="site" dataSource="jdbc/rmc">
			                                    	select * from site_detail where customer_id=?
			                                    	<sql:param value="${pay.customer_id}"/>
			                                    </sql:query>
												<select id="site_id"  name="site_id" required="required"   class="select2"  data-placeholder="Choose Site">
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
		                                        <label>Paid to<span class="text-danger"></span> </label>
		                                        <div>
		                                            <div class="input-group">
		                                                <input type="text" name="paid_to" value="${pay.paid_to}" class="form-control" required="required" placeholder="Enter Sales Person" >
		                                            </div>
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
			                                <div class="form-group">
			                                    <label>Payment Type<span class="text-danger">*</span></label>
												<select id="payment_type"  name="payment_mode" required="required"   class="select2"  data-placeholder="Choose Site">
													<option value="SPC" ${(pay.payment_type=='SPC')?'selected':''}>SPC</option>
													<option value="knock Off" ${(pay.payment_type=='knock Off')?'selected':''}>Knock off</option>		  
												</select>
			                                </div>
			                                
			                               
		                                    <div class="form-group">
			                                    <label>Comment <span class="text-danger">*</span></label>
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
		                    	<form class="" id="myform" action="SalesComissionController?action=InsertPayment" method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="col-sm-2"></div>
			                           	<div class="col-sm-6">
			                           	   <div class="form-group">
			                                    <label>Customer <span class="text-danger">*</span></label>
			                                    <sql:query var="customer" dataSource="jdbc/rmc">
			                                    	select * from customer order by customer_name asc
			                                    </sql:query>
												<select id="customer_id"  name="customer_id" required="required"   class="select2"  data-placeholder="Choose Customer">
													<option value="">&nbsp;</option>
													<c:forEach var="customer" items="${customer.rows}">
													<option value="${customer.customer_id}">${customer.customer_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Site Address<span class="text-danger">*</span></label>
												<select id="site_id"  name="site_id" required="required"   class="select2"  data-placeholder="Choose Site">
												</select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Payment Amount<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  required="required"    id="payment_amount" name="payment_amount"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
		                                        <label>Payment Date <span class="text-danger"></span> </label>
		                                        <div>
		                                            <div class="input-group">
		                                                <input type="text" name="payment_date" class="form-control date-picker invoice_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
		                                                <div class="input-group-append">
		                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                </div>
		                                            </div>
		                                        </div>
		                                   </div>
		                                      <div class="form-group">
		                                        <label>Paid to<span class="text-danger"></span> </label>
		                                        <div>
		                                            <div class="input-group">
		                                                <input type="text" name="paid_to" class="form-control" required="required" placeholder="Enter Sales Person" >
		                                            </div>
		                                        </div>
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
			                                <div class="form-group">
			                                    <label>Payment Type<span class="text-danger">*</span></label>
												<select id="payment_type"  name="payment_mode" required="required"   class="select2"  data-placeholder="Choose Site">
													<option value="SPC">SPC</option>
													<option value="knock Off">Knock off</option>
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
		<script src="picker/js/moment.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="js/AddPurchaseOrder.js"></script>
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
						var amount=parseFloat(res);
						$('#credit_balance').text(amount.toFixed(2));
					}
				})    			
    		});
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
	        		$.each(result, function(index, value) {
	        			   $('#site_id').append("<option value='"+ value.site_id+ "'>" + value.site_name + "</option>");
	        		});
	        		
				}
			});
		});
    </script>
    </body>
</html>