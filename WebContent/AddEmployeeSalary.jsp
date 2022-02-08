<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Employee Salary Structure</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">

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
                                    <li class="breadcrumb-item"><a href="#">HRM</a></li>
                                    <li class="breadcrumb-item"><a href="#">Employee Salary</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Employee Salary</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Add Employee Salary</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="EmployeeSalarylist.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Employee Salary List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="customer" dataSource="jdbc/rmc">
                			select * from customer where customer_id=?
                			<sql:param value="${param.customer_id}"/>
                		</sql:query> 
                		<c:forEach items="${customer.rows}" var="customer">
                			<c:set value="${customer}" var="rs"/>
                		</c:forEach>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="CustomerController?action=UpdateCustomer" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Customer Name <span class="text-danger">*</span></label>
			                                    <input type="hidden" name="customer_id" value="${rs.customer_id}" id="customer_id">
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Customer Name" value="${rs.customer_name}"  name="customer_name"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Customer Phone <span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$" maxlength="10" placeholder="Enter Customer Phone"  value="${rs.customer_phone}"  name="customer_phone"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Customer Email : </label>
			                                    <div>
			                                        <input type="email" class="form-control" 
			                                             pattern="[^'&quot;:]*$"  parsley-type="email" value="${rs.customer_email}" placeholder="Ex : example@example.com" name="customer_email"/>
			                                    </div>
			                                </div>
			                                
			                            </div>
			                            <div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Customer GSTIN : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter GSTIN."  value="${rs.customer_gstin}"  name="customer_gstin"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>PAN No : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Customer PAN No." value="${rs.customer_panno}"   name="customer_panno"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Customer Address <span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Billing Address" required="required" value="${rs.customer_address}"  name="customer_address"/>
			                                    </div>
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
                	</c:when>
                	
                	<c:otherwise>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="EmployeeController?action=insertEmployeeSalaryStructure" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                               	
			                               	<div class="form-group">
			                                    <label>Employee Id <span class="text-danger">*</span></label>
			                                    
			                                    <sql:query var="customer" dataSource="jdbc/rmc">
		                                       		select * from employee order by employee_name asc
		                                       </sql:query>
		                                       <select class="select2 no-date cus no-veh cus-dat no-veh-dat" name="employee_id" id="employee_id" required="required">
		                                           <option value="" selected="selected" disabled="disabled">Please Select</option>
		                                           <c:forEach items="${customer.rows}" var="customer">
		                                           <option value="${customer.e_id}">${customer.employee_id}</option>
		                                           </c:forEach>
		                                       </select>
			                                </div>
			                                
			                               	<div class="form-group">
			                                    <label>Employee Name <span class="text-danger">*</span></label>
			                                    
			                                    <sql:query var="customer" dataSource="jdbc/rmc">
		                                       		select * from employee order by employee_name asc
		                                       </sql:query>
		                                       <select class="select2 no-date cus no-veh cus-dat no-veh-dat" name="employee_name" id="employee_id" required="required">
		                                           <option value="" selected="selected" disabled="disabled">Please Select</option>
		                                           <c:forEach items="${customer.rows}" var="customer">
		                                           <option value="${customer.employee_name}">${customer.employee_name}</option>
		                                           </c:forEach>
		                                       </select>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Month </label>
			                                    <div>
				                                       
				                                   <select class="select2" name="employee_month" id="employee_month" required="required">
			                                           <option value="" selected="selected" disabled="disabled">Please Select</option>
			                                           <option value="January">January</option>
			                                           <option value="February">February</option>
			                                           <option value="March">March</option>
			                                           <option value="April">April</option>
			                                           <option value="May">May</option>
			                                           <option value="June">January</option>
			                                           <option value="July">July</option>
			                                           <option value="September">September</option>
			                                           <option value="October">October</option>
			                                           <option value="November">November</option>
			                                           <option value="December">December</option>
			                                       </select>
			                                       
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Basic Salary<span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Basic Salary"  maxlength="10"   name="employee_basic"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>House Rent Allowance </label>
			                                    <div>
			                                        <input type="text" class="form-control" 
			                                             pattern="[^'&quot;:]*$"  placeholder="Enter HRA" name="employee_hra"/>
			                                    </div>
			                                </div>
			                                
			                                 <div class="form-group">
			                                    <label>Travel Allowance </label>
			                                    <div>
			                                        <input type="text" class="form-control" 
			                                             pattern="[^'&quot;:]*$"  placeholder="Enter Travel Allowance" name="employee_ta"/>
			                                    </div>
			                                </div>
			                            </div>
			                            
			                            
			                            <div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Miscellaneous: </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter mISCELLANEOUS"   name="employee_mr"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>ESIC: </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter ESIC"   name="employee_esic"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Daily Allowance<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter DA" required="required"   name="employee_da"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Provident Fund<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter PF" required="required"   name="employee_pf"/>
			                                    </div>
			                                </div>
			                                <div class="form-group">
			                                    <label>Professional Tax<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Professional Tax" required="required"   name="employee_pt"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Advance Salary<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Advance Salary" required="required"   name="advance_salary"/>
			                                    </div>
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

        <!-- Parsley js -->
        <script type="text/javascript" src="plugins/parsleyjs/parsley.min.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
		
        <script type="text/javascript">
            $(document).ready(function() {
                $('form').parsley();
                
                $('.select2').css('width','100%').select2({allowClear:true})
				.on('change', function(){
					$(this).closest('form').validate().element($(this));
				}); 
            });
        </script>
       

    </body>
</html>