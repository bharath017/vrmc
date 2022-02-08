<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>General Settings - ${initParam.company_name}</title>
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
                                    <li class="breadcrumb-item"><a href="#">Other</a></li>
                                    <li class="breadcrumb-item"><a href="#">General Settings</a></li>
                                </ol>
                            </div>
                            
                         	<h4 class="page-title">Company Settings</h4>
                            	
                        </div>
                    </div>
                </div>
                
                
                <!-- UPDATE  CONTROLLER PART HERE -->
	                <c:if test="${pageContext.request.method=='POST'}">
						<c:catch var="exception">
							<sql:update var="insert" dataSource="jdbc/rmc">
								UPDATE company_detail SET company_name=?,company_phone=?,company_head_office=?,company_mail=?,company_director=?,pan_number=?,gstin_number=?,registration_no=?,established_year=?,company_address=? WHERE company_id=1
								<sql:param value="${param.company_name}"/>
								<sql:param value="${param.company_phone}"/>
								<sql:param value="${param.company_head_office}"/>
								<sql:param value="${param.company_email}"/>
								<sql:param value="${param.company_director}"/>
								<sql:param value="${param.pan_number}"/>
								<sql:param value="${param.gstin_number}"/>
								<sql:param value="${param.registration_no}"/>
								<sql:param value="${param.established_year}"/>
								<sql:param value="${param.company_address}"/>
							</sql:update>
						</c:catch>
					</c:if>
                <!-- END OF UPDATE CONTROLLER PART -->
               
                <!-- Get company details here -->
                <sql:query var="comp" dataSource="jdbc/rmc">
                	select * from company_detail where company_id=1
                </sql:query>
                
                <c:forEach var="comp" items="${comp.rows}">
                	<c:set var="result" value="${comp}"/>
                </c:forEach>
              	<div class="row">
                    <div class="col-sm-12">
                    	<form class="" action="CompanySetting.jsp" method="post">
	                        <div class="card-box row col-sm-12">
	                        	<div class="row col-sm-12">
	                        		<div class="col-sm-3"></div>
	                        		<div class="col-sm-6">
	                        			<h3 class="text-success text-center"><ins>Company Settings</ins></h3>
	                        			<p class="text-success">${(insert>0)?'Saved Successfully':''}</p>
	                        			<c:remove var="res" scope="session"/>
	                        		</div>
	                        	</div>
	                           	<div class="col-sm-6">
	                               	<div class="form-group">
	                                    <label>Company Name<span class="text-danger">*</span> </label>
	                                    <input type="text" class="form-control" required
	                                          pattern="[^'&quot;:]*$" id="company_name" value="${result.company_name}" name="company_name"/>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Company Phone<span class="text-danger">*</span> </label>
	                                    <input type="text" class="form-control" required
	                                         pattern="[^'&quot;:]*$"  value="${result.company_phone}"  id="company_phone" name="company_phone"/>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Company Head Office<span class="text-danger">*</span> </label>
	                                    <input type="text" class="form-control" required
	                                         pattern="[^'&quot;:]*$"  value="${result.company_head_office}"  id="company_head_office" name="company_head_office"/>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Company Email : </label>
	                                    <div>
	                                        <input type="email" class="form-control" 
	                                             pattern="[^'&quot;:]*$"  parsley-type="email" value="${result.company_mail}" placeholder="Ex : example@example.com" id="company_email" name="company_email"/>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Company Address<span class="text-danger">*</span> </label>
	                                    <textarea  class="form-control" 
	                                         pattern="[^'&quot;:]*$"   id="company_address" name="company_address">${result.company_address}</textarea>
	                                </div>
	                                
	                               </div>
	                               <div class="col-sm-6">
	                                <div class="form-group">
	                                    <label>PAN Number : </label>
	                                    <input type="text" class="form-control" 
	                                         pattern="[^'&quot;:]*$"  value="${result.pan_number}"  id="pan_number" name="pan_number"/>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Company GSTIN : </label>
	                                    <input type="text" class="form-control" 
	                                         pattern="[^'&quot;:]*$"  value="${result.gstin_number}"  id="gstin_number" name="gstin_number"/>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Registration Number : </label>
	                                    <input type="text" class="form-control" 
	                                         pattern="[^'&quot;:]*$"  value="${result.registration_no}"  id="registration_no" name="registration_no"/>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Established Year : </label>
	                                    <input type="text" class="form-control" 
	                                         pattern="[^'&quot;:]*$"  value="${result.established_year}"  id="established_year" name="established_year"/>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Company Director<span class="text-danger">*</span> </label>
	                                    <input type="text" class="form-control" 
	                                         pattern="[^'&quot;:]*$"  value="${result.company_director}"  id="company_director" name="company_director"/>
	                                </div>
	                             </div>
	                             <div class="col-sm-12 text-center">
			                    	<div class="form-group">
			                            <div>
			                                <button type="submit" class="btn btn-custom waves-effect waves-light">
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
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		
        <script type="text/javascript">
            $(document).ready(function() {
                $('form').parsley();
                
                $('.select2').css('width','100%').select2({allowClear:true})
				.on('change', function(){
				}); 
                
                
                $('.date-picker').datepicker({
					autoclose: true,
					todayHighlight: true
				})
				//show datepicker when clicking on the icon
				
                
                $("#id-date-picker-1").datepicker("setDate", new Date());
				$('#id-date-picker-1').datepicker({
				        "setDate": new Date(),
				        "autoclose": true
				});
			
            });
        </script>
        
        <script type="text/javascript">
		 $(document).ready(function () {
			
		    function addRow(){
		    	
		        var html = '<tr class="item-row">'+
								'<td>'+
									'${itm_name}'+
								'</td>'+
								 '<td>'+
								      '<input type="text" name="item_price" class="item_price form-control reqired" size="12" onkeyup="calculate(this);">'+
							     '</td>'+
								'<td>'+
									'<input type="text" name="quantity" size="14" class="quantity form-control reqired" onkeyup="calculate(this);">'+
								'</td>'+
								'<td>'+
									'<input type="text" name="amount" size="16" class="amount form-control reqired" readonly>'+
								'</td>'+
								'<td>'+
								    '<input type="date" name="lead_time" class="form-control reqired">'+
							    '</td>'+
								'<td><a href="#" class="removebutton"><i class="fa fa-trash fa-2x text-danger"></i></a></td>'+
							'</tr>'
					        $(html).appendTo($("#Table1"))
					    };
					    $("#clicked").on("click", ".BtnPlus", addRow);
					});
			</script>
			
			<script type="text/javascript">
					 $(document).on('click', '.removebutton', function () { // <-- changes
					     $(this).closest('tr').remove();
					     return false;
					 });
			</script>
			
			<script type="text/javascript">
				$(document).ready(function(){
					$('.no-po').prop('disabled',true);
					
					/* check po is selected or not */
					
					$( ".po-check" ).click(function() {
				        if(this.checked){
				            $('.no-po').prop("disabled",false);
				            $(".req").prop('required',true);
				        }else{
				        	$('.no-po').prop("disabled",true);
				        	 $(".req").prop('required',false);
				        }
				    });
					
					/* calculation process goes here */
				});
			</script>

			<script>
			
				function calculate(e){
					 var quantity = $(e).closest('tr').find('.quantity').val();
					  quantity=(quantity=='' || quantity==undefined)?0:quantity;
				     var item_price = $(e).closest('tr').find('.item_price').val();
				      item_price=(item_price=='' || item_price==undefined)?0:item_price;
				     var amount = (quantity * item_price);
				     amount = Math.round(amount);
				     $(e).closest('.item-row').find('.amount').val(amount);
				}
			</script>
 		
    </body>
</html>