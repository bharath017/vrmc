<!DOCTYPE html>
<%@page import="com.willka.soft.dao.DriverDAOImpl"%>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Customer - ${initParam.company_name}</title>
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
                                    <li class="breadcrumb-item"><a href="#">Sales</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Customer Pipeline</a></li>
                                </ol>
                            </div>
                           
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="PipeLineList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> PipeLine List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="pipe" dataSource="jdbc/rmc">
                			select * from pipe_line where pipe_id=?
                			<sql:param value="${param.pipe_id}"/>
                		</sql:query>
                		<c:forEach var="pipe" items="${pipe.rows}">
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="PipeLineController?action=update" method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="row col-sm-12">
			                        		<div class="col-sm-3"></div>
			                        		
			                        	</div>
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Unit<span class="text-danger">*</span> </label>
			                                    <input type="hidden" value="${pipe.pipe_id}" name="pipe_id"/>
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Vehicle No." value="${pipe.unit}" id="vehicle_no" name="unit"/>
			                                </div>
			                                
			                                <div class="form-group">
                                       <label>Marketing Person : </label>
                                       <sql:query var="mp" dataSource="jdbc/rmc">
                                       	select * from marketing_person where mp_status='active'
                                       </sql:query>
                                       <select class="select2" name="bdm" id=bdm required="required" data-placeholder="Choose Marketing Person">
                                           <option value="" selected="selected"></option>
                                           <c:forEach items="${mp.rows}" var="mp">
                                           <option value="${mp.mp_name}" ${(pipe.bdm==mp.mp_name)?'selected':''}>${mp.mp_name}</option>
                                           </c:forEach>
                                       </select>
                                   </div>
			                                
			                             <div class="form-group">
                                                <label>Customer <span class="text-danger">*</span></label>
													  <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Customer Name" value="${pipe.customer_id}" name="customer_id"/>                                           
                                            </div>
			                                
			                                <div class="form-group">
			                                    <label>Total Volume</label>
												<input type="number" class="form-control" 
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Vehicle Insurance No.." value="${pipe.total_volume}" name="total_volume"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Time Period(in month) </label>
												<input type="number" step="0.01" class="form-control" 
			                                          pattern="[^'&quot;:]*$" value="${pipe.period_month}" placeholder="Enter Meter Reading" name="period_month"/>
			                                </div>
			                                
			                               </div>
			                               <div class="col-sm-6">
			                               
			                                <div class="form-group">
			                                    <label>Vol/Month </label>
												<input type="number" step="0.01" class="form-control" 
			                                          pattern="[^'&quot;:]*$" value="${pipe.vol_month}" placeholder="Enter Meter Reading"  name="vol_month"/>
			                                </div>
			                               
			                              <div class="form-group">
			                                    <label>Target Date </label>
												 <div>
                                                    <div class="input-group">
                                                        <input type="text" name="target_date"  value="${pipe.target_date}"class="form-control date-picker" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
			                                 </div>
			                                 
			                                 <div class="form-group">
			                                    <label>Remark as on</label>
												<input type="text" class="form-control" 
			                                          pattern="[^'&quot;:]*$" value="${pipe.remark_as}" placeholder="Enter Meter Reading" name="remark_as"/>
			                                </div>
			                                 <div class="form-group">
			                                    <label>Status</label>
												<select  name="status"   class="select2"  data-placeholder="Select Status Type">
													<option ${(pipe.status=='Follow up')?'selected':''} value="Follow up">Follow UP</option>
													<option ${(pipe.status=='Order Won')?'selected':''} value="Order Won">Order Won</option>	
													<option ${(pipe.status=='Order Lost')?'selected':''} value="Order Lost">Order Lost</option>
													<option ${(pipe.status=='Others')?'selected':''} value="Others">Others</option>	
												</select>
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
		                </c:forEach>
                	</c:when>
                	<c:otherwise>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="PipeLineController?action=insert" method="post">
			                        <div class="card-box row col-sm-12">			                        	
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Unit<span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Unit"  name="unit"/>
			                                </div>
			                                
			                          <div class="form-group">
                                       <label>Marketing Person : </label>
                                       <sql:query var="mp" dataSource="jdbc/rmc">
                                       	select * from marketing_person where mp_status='active'
                                       </sql:query>
                                       <select class="select2" name="bdm" required="required" data-placeholder="Choose Marketing Person">
                                           <option value="" selected="selected"></option>
                                           <c:forEach items="${mp.rows}" var="mp">
                                           <option value="${mp.mp_name}">${mp.mp_name}</option>
                                           </c:forEach>
                                       </select>
                                   </div>			                                
			                                <div class="form-group">
                                                <label>Customer <span class="text-danger">*</span></label>
				                                    
													  <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Customer Name"  name="customer_id"/>                                           
                                            </div>
			                                
			                                <div class="form-group">
			                                    <label>Total Volume</label>
												<input type="number" class="form-control" 
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Total Volume" id="insurance_no" name="total_volume"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Time Period(in month)</label>
												<input type="number" class="form-control" 
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Time Period(in months)"  name="period_month"/>
			                                </div>
			
			                               </div>
			                               <div class="col-sm-6">
			                                <div class="form-group">
			                                    <label>Vol/Month</label>
												 <input type="number" name="vol_month" class="form-control" data-placeholder="Select Voiume Per Month"/>													
			                                 </div>
			                                 
			                                 <div class="form-group">
			                                    <label>Target Date </label>
												 <div>
                                                    <div class="input-group">
                                                        <input type="text" name="target_date"  class="form-control date-picker" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
			                                 </div>
			                                 
			                                 
			                                 
			                                 <div class="form-group">
			                                    <label>Remark as on</label>
												 <input name="remark_as" class="form-control" data-placeholder="Select Voiume Per Month"/>
			                                 </div>
			                                   
			                                 <div class="form-group">
			                                    <label>Status</label>
												<select id="vehicle_cat"  name="status"   class="select2"  data-placeholder="Select Status Type">
													<option value="Follow up">Follow UP</option>
													<option value="Order Won">Order Won</option>	
													<option value="Order Lost">Order Lost</option>
													<option value="Others">Others</option>									
												</select>
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
					 $(document).on('click', '.removebutton', function () { // <-- changes
					     $(this).closest('tr').remove();
					     return false;
					 });
			</script>		
			<script>
			var str="unit";
			console.log(str);
			</script>
 		
    </body>
</html>