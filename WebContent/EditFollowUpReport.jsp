<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Update Follow Up Report</title>
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
                                    <li class="breadcrumb-item"><a href="#">HRM</a></li>
                                    <li class="breadcrumb-item"><a href="#">Payslip</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Payslip</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Update Follow Up Report</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                 
                    <div class="col-sm-4">
                        <a href="FollowUpReportList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Follow Up Report List</a>
                    </div><!-- end col -->
                    
                </div>
                <!-- end row -->
               <sql:query var="invoice" dataSource="jdbc/rmc">
               		select * from follow_up_report where follow_up_report_id=?
               		<sql:param value="${param.follow_up_report_id}"/>
               </sql:query>
               
               <c:forEach items="${invoice.rows}" var="invoice">
              	 <c:set value="${invoice}" var="rs"/>
              </c:forEach>
               
              	<div class="row">
                    <div class="col-sm-12">
                    	<form class="" id="myform" action="SchedulingController?action=updateFollowUpReport" method="post">
	                        <div class="card-box row col-sm-12">
	                            
	                            <div class="col-sm-6">
                             			<div class="form-group">
			                              <label>Purpose :  <span class="text-danger">*</span> </label>
	       									<select id="type"  name="type" required="required"   class="select2"  data-placeholder="Choose Type">
											<option value="marketing" ${(rs.type=='marketing')?'selected':''}>Marketing </option>
											<option value="collection" ${(rs.type=='collection')?'selected':''}>Payment Collection </option>
											</select>
										</div>
                                
                                
                                		  <div class="form-group">
			                                    <label>Customer <span class="text-danger">*</span></label>
			                                    <sql:query var="customer" dataSource="jdbc/rmc">
			                                    	select * from customer 
			                                    </sql:query>
			                                     <sql:query var="customer1" dataSource="jdbc/rmc">
			                                    	select * from client 
			                                    </sql:query>
												<select id="client_id"  name="customer_id"    class="select2"  data-placeholder="Choose Customer" >
													<option value="${rs.client}">${rs.client}</option>
													<option disabled>Customers</option>
													<c:forEach var="customer" items="${customer.rows}">
													<option value="${customer.customer_name}" >${customer.customer_name}</option>
													</c:forEach>
													<option disabled>Clients</option>
													<c:forEach var="customer1" items="${customer1.rows}">
													<option value="${customer1.client_name}">${customer1.client_name}</option>
													</c:forEach>
												</select>
			                                </div>
                                
                                  <div class="form-group custom">
                                    <label>Visit Count  </label>
                                    <div>
                                        <div class="input-group">
                                            <input type="text" name="phone"  readonly class="form-control custom" placeholder="Visit count" id="client" >
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label>Date <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                            <input type="text" name="date" value="${rs.date}" class="form-control date-picker date" placeholder="yyyy-mm-dd" id="id-date-picker-3" data-date-format="yyyy-mm-dd">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                 
                                
                                <div class="form-group">
                                    <label>Time <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                            <input type="text" name="start_time" value="${rs.time}" class="form-control" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
	                            
	                         <div class="col-sm-6">
                                
                                <div class="form-group">
                                    <label>Description <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                           <%--  <input type="text" name="description" value="${rs.description}" class="form-control" placeholder="Enter Description" id="description" > --%>
	                                            <textarea class="form-control" name="description" >${rs.description}</textarea> 
                                            
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label>Comment <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                            <input type="hidden" name="follow_up_report_id" value="${rs.follow_up_report_id}" > 
	                                        <textarea class="form-control" name="comment" >${rs.comment}</textarea> 
                                            
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group custom">
			                              <label>Status :  <span class="text-danger">*</span> </label>
	       									<select id="status"  name="status"   class="select2 custom"  data-placeholder="Choose Meeting Status">
											<option value=""> </option>
													<option value="Follow up" ${(rs.status=='Follow up')?'selected':''}>Follow UP</option>
													<option value="Order Won" ${(rs.status=='Order Won')?'selected':''}>Order Won</option>	
													<option value="order lost" ${(rs.status=='Order lost')?'selected':''}>Order Lost</option>
													<option value="others" ${(rs.status=='others')?'selected':''}>Others</option>
											</select>
										</div>
                                <div class="form-group follow_up">
                                    <label>Follow Up Date <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                            <input type="text" name="follow_up_date" class="form-control date-picker date follow_up" value="${rs.follow_up_date}" placeholder="yyyy-mm-dd" id="id-date-picker-2" data-date-format="yyyy-mm-dd">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                             </div>    
		                           
                                <div class="col-sm-12 text-center">
                                	<div class="form-group">
	                                    <div>
	                                        <button type="submit" id="savebtn" class="btn btn-custom waves-effect waves-light">
	                                            Update
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
		<script src="assets/js/ace.min.js"></script>
		<script type="text/javascript">
				
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
						
			         
			        $("#id-date-picker-1").datepicker();
					$('#id-date-picker-1').datepicker({
					        "autoclose": true
					});
			     });
			
		</script>
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
				$('#type').on('change',function(){
					var type=$('#type').val();
					if(type=='marketing'){
						$('.custom').show();
						$('.custom').prop('disabled',false);
						$('.no-custom').hide();
						$('.no-custom').prop('disabled',true);
						$('.no-custom').prop('required',false);
					}else if(type=='collection'){
						$('.custom').hide();
						$('.custom').prop('disabled',true);
						$('.no-custom').show();
						$('.no-custom').prop('disabled',false);
						$('.no-custom').prop('required',true);
					}
				});
				
			 	$('.no-custom').hide();
				$('.no-custom').prop('disabled',true);
				$('.custom').show();
				$('.custom').prop('disabled',false);
				$('.follow_up').hide();
				$('.follow_up').prop('disabled', true);
				var status=$('#status').val();
				if(status=='Follow up'){
					$('.follow_up').show();
					$('.follow_up').prop('disabled', false);
				}else{
					$('.follow_up').hide();
					$('.follow_up').prop('disabled', true);
				}
				
				$('#status').on('change',function(){
					var status=$('#status').val();
					if(status=='Follow up'){
						$('.follow_up').show();
						$('.follow_up').prop('disabled', false);
					}else{
						$('.follow_up').hide();
						$('.follow_up').prop('disabled', true);
					}
				});
			});
		</script>

		
		
		<script type="text/javascript">
			$(document).ready(function(){
				$('#client_id').on('change',function(){
					var client_id=$('#client_id').val();
					$.ajax({
						type:'post',
						url:'CustomerController?action=getCount&client_id='+client_id,
						headers:{
							Accept:"text/html;charset=utf-8",
							"Content-Type":"text/html;charset=utf-8"
						},
						success:function(res){
							$('#client').val(res);
						}
					});
				});
			});
		</script>
    

    </body>
</html>