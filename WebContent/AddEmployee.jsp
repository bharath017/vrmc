<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Employee - ${initParam.company_name}</title>
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
        <style type="text/css">
        	.error{
        		color: red;
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
                                    <li class="breadcrumb-item"><a href="#">HRM</a></li>
                                    <li class="breadcrumb-item"><a href="#">New Employee</a></li>
                                </ol>
                            </div>
                            <c:choose>
                            	<c:when test="${param.action=='update'}">
                            		<h4 class="page-title">Update Employee</h4>
                            	</c:when>
                            	<c:otherwise>
                            		<h4 class="page-title">New Employee</h4>
                            	</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="EmployeeList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-grid"></i> Employee List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="employee" dataSource="jdbc/rmc">
                			select e.*,DATE_FORMAT(employee_dob,'%d/%m/%Y') as dob,
                			DATE_FORMAT(employee_joining_date,'%d/%m/%Y') as doj
                		    from employee e where e_id=?
                			<sql:param value="${param.e_id}"/>
                		</sql:query> 
                		<c:set var="res"/>
                		<c:forEach items="${employee.rows}" var="employee">
                			<c:set value="${employee}" var="rs"/>
                		</c:forEach>
                		<div class="row">
		                    <div class="col-sm-12">
		                    
		                    	<form class="" action="EmployeeController?action=updateEmployee" method="post" id="employee-form">
			                       
			                        <div class="card-box row col-sm-12">
			                        
			                        	<div class="row col-sm-12">
				                        		<div class="col-sm-1"></div>
				                        		<div class="col-sm-3">
				                        			<h4 class="text-dark text-left">ENTER PERSONAL DETAIL</h4>
				                        		</div>
				                        		<div class="col-sm-4">
				                        			<h4 class="text-dark text-center">ENTER BANK &amp; OTHER DETAIL</h4>
				                        		</div>
				                        		
				                        		<div class="col-sm-3">
				                        			<h4 class="text-dark text-center">Working Details</h4>
				                        		</div>
			                        		
			                        	</div>
			                        	<div class="row col-sm-12">
			                        	<p></p>
			                        	</div>
			                           	<div class="col-sm-4">
											<div class="form-group">
												<label>Employee Id<span class="text-danger">*</span>
												</label>
												<input type="hidden" name="e_id" id="e_id" value="${rs.e_id}">
												 <input type="text" class="form-control" required
													pattern="[^'&quot;:]*$" placeholder="EX: WI101"
													id="employee_id" name="employee_id" value="${rs.employee_id}"/>
											</div>
	
											<div class="form-group">
												<label>Employee Name<span class="text-danger">*</span>
												</label> <input type="text" class="form-control" required
													pattern="[^'&quot;:]*$" placeholder="Enter Employee Name"
													id="employee_name" name="employee_name" value="${rs.employee_name}"/>
											</div>
	
											<div class="form-group">
												<label>Current Address<span class="text-danger">*</span>
												</label>
												<textarea name="current_address" id="current_address"
													class="form-control" placeholder="Enter Current Address">${rs.current_address}</textarea>
											</div>
	
											<div class="form-group">
												<label>Residential Address<span class="text-danger">*</span>
												</label>
												<textarea name="residental_address" id="residental_address"
													class="form-control"
													placeholder="Enter Residental Address">${rs.residental_address}</textarea>
													
											</div>
	
											<div class="form-group">
												<label>Education <span class="text-danger"></span></label> <input
													type="text" class="form-control" pattern="[^'&quot;:]*$"
													placeholder="Enter Qualification Of Employee"
													id="employee_qualification" name="employee_qualification" value="${rs.employee_qualification}" />
											</div>
	
											<div class="form-group">
												<label>Phone <span class="text-danger">*</span>
												</label> <input type="text" class="form-control"
													pattern="[^'&quot;:]*$" placeholder="ENTER EMPLOYEE PHONE.."
													id="employee_phone" name="employee_phone"  value="${rs.employee_phone}"/>
											</div>
	
											<div class="form-group">
												<label>Emergency Contact Number <span
													class="text-danger">*</span></label> <input type="text"
													id="contact_number" name="contact_number"
													placeholder="ENTER Contact Number"
												    class="form-control" value="${rs.contact_number}" />
											</div>
	
											<div class="form-group">
												<label>E-Mail </label> <input type="email"
													class="form-control" pattern="[^'&quot;:]*$"
													placeholder="EX:xxx@gmail.com" id="employee_email"
													name="employee_email" value="${rs.employee_email}"/>
											</div>

			                            </div>
			                        
			                              <div class="col-sm-4">
			                              			<div class="form-group">
					                                    <label>Adhar Number <span class="text-danger">*</span></label>
					                                    <input type="text" class="form-control" required
					                                          placeholder="Enter Adhar Number" 
					                                          id="employee_aadhar_number"
					                                          name="employee_aadhar_number"
					                                          value="${rs.employee_aadhar_number}"/>
					                                </div>
					                                <div class="form-group">
					                                    <label>Pan Number</label>
					                                    <input type="text" class="form-control" placeholder="ENTER EMPLOYEE PAN NUMBER."
					                                    	   id="employee_pancard_number"
					                                    	   name="employee_pancard_number" value="${rs.employee_pancard_number}"/>
					                                </div>
					                                <div class="form-group">
		                                                <label>Employee DOB</label>
		                                                <div>
		                                                    <div class="input-group">
		                                                        <input type="text" name="employee_dob" 
		                                                        	   class="form-control date-picker"
		                                                        	   placeholder="dd/mm/yyyy" id="id-date-picker-1"
		                                                        	   data-date-format="dd/mm/yyyy" readonly="readonly"
		                                                        	   style="background-color: white;" value="${rs.dob}"/>
		                                                        <div class="input-group-append">
		                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                        </div>
		                                                    </div>
		                                                </div>
		                                            </div>
					                                
					                                <div class="form-group">
					                                    <label>Experience </label>
					                                    <input type="text" class="form-control" placeholder="ENTER EMPLOYEE EXPERIENCE.."
					                                    				   id="employee_experience" name="employee_experience" value="${rs.employee_experience}"/>
					                                </div>
					                                
					                                
					                                <div class="form-group">
					                                    <label>Bank Name</label>
														<input type="text" id="employee_bank_name"  placeholder="EX : BANK OF INDIA"
															   class="form-control"  value="${rs.employee_bank_name}"
					                                           pattern="[^'&quot;:]*$"  name="employee_bank_name"/>
					                                </div>
					                               
		                                            <div class="form-group">
					                                    <label>A/C NO : </label>
														<input type="text" id="employee_account_number" class="form-control"
																  placeholder="Enter Acount Number" name="employee_account_number" value="${rs.employee_account_number}" />
					                                </div>
					                                
					                                <div class="form-group">
					                                    <label>IFSC CODE : </label>
														<input type="text" id="employee_ifsc_code" class="form-control"  
															   pattern="[^'&quot;:]*$" name="employee_ifsc_code"
															   value="${rs.employee_ifsc_code}"/>
					                                </div>
		                                            
		                                            <div class="form-group">
			                                   			<label>Salary (Monthly)*</label>
	                                      				<input type="text" id="employee_monthly_salary" name="employee_monthly_salary"
	                                      								   placeholder="Enter Monthly Salary" 
	                                      								   class="form-control" value="${rs.employee_monthly_salary}"/>	   
	                                       			</div>
	                                       			
	                                      </div>
	                                       
	                                      <div class="col-sm-4">
	                                      	<div class="form-group">
			                                    <label>PF Number : </label>
												<input type="text" id="employee_pf_number" name="employee_pf_number"
													   placeholder="Enter PF Number"  class="form-control" 
													   value="${rs.employee_pf_number}"/>
			                                </div>
			                                
			                                 <div class="form-group">
			                                    <label>Employee ESIC Number </label>
                                               <input type="text" id="esic_number" name="esic_number"
                                               		  placeholder="ENTER ESIC Number"  class="form-control" />			                    
                                            </div>
			                                
			                                <div class="form-group">
                                                <label>Joining Date</label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="employee_joining_date"  class="form-control date-picker"
                                                        			 placeholder="dd/mm/yyyy" id="id-date-picker-1"
                                                        			 data-date-format="dd/mm/yyyy" style=" background-color: white;"
                                                        			 readonly="readonly" value="${rs.doj}"/>
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
			                                <div class="form-group">
	                                   			<label>UA Number</label>
                                     				<input type="text" id="ua_number" name="ua_number"
                                     					    placeholder="Enter UA Number"  class="form-control" 
                                     					    value="${rs.ua_number}"/>	   
                                      		</div>
                                      		<div class="form-group">
				                                <label>Licence Number </label>
		                                      	<input type="text" id="licence_number" name="licence_number" 
		                                      		   placeholder="Enter Licence Number"
		                                      		   class="form-control" value="${rs.licence_number}"/>                             
		                                    </div>
		                                     <div class="form-group">
												<label>Designation <span class="text-danger">*</span></label>
												<div>
													<div class="input-group">
														<select name="designation_id" class="form-control"
															id="designation_id">
															<sql:query var="designation" dataSource="jdbc/rmc">
																		select designation_id,designation_name
																	    from designation
																	</sql:query>
															<c:forEach items="${designation.rows}" var="designation">
																<option value="${designation.designation_id}" 
																	${(designation.designation_id==rs.designation_id)?'selected':''}>${designation.designation_name}</option>
															</c:forEach>
														</select>
													</div>
												</div>
											</div>
											
											<div class="form-group">
												<label>Department <span class="text-danger">*</span></label>
												<div>
													<div class="input-group">
														<select name="department_id" class="form-control"
															id="department_id">
															<sql:query var="department" dataSource="jdbc/rmc">
																		select department_id,department_name
																	    from department
																	</sql:query>
															<c:forEach items="${department.rows}" var="department">
																<option value="${department.department_id}" ${(department.department_id==rs.department_id)?'selected':''}>
																		${department.department_name}</option>
															</c:forEach>
														</select>
													</div>
												</div>
											</div>
											<div class="form-group">
				                                <label>Working Location </label>
		                                      	<input type="text" id="employee_working_location" name="employee_working_location" 
		                                      		   placeholder="ENTER Working Location"  class="form-control"
		                                      		   value="${rs.employee_working_location}" />                             
		                                    </div>
		                                    
		                                    <div class="form-group">
			                                    <label>Business Group <span class="text-danger">*</span></label>
			                                    <div>
			                                    	<sql:query var="group" dataSource="jdbc/rmc">
			                                    		select business_id,group_name
			                                    		from business_group
			                                    		where business_id like if(0=?,'%%',?)
			                                    		<sql:param value="${bean.business_id}"/>
			                                    		<sql:param value="${bean.business_id}"/>
			                                    	</sql:query>
													<select class="form-control" id="business_id" name="business_id">
														<c:forEach items="${group.rows}" var="group">
															<option value="${group.business_id}"
																	 ${(group.business_id==rs.business_id)?'selected':''}>${group.group_name}</option>
														</c:forEach>
													</select>
			                                    </div>
			                                </div>
			                                <div class="form-group text-right">
			                                    <div>
			                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
			                                            SAVE EMPLOYEE
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
		                    
		                    	<form class="" action="EmployeeController?action=insertEmployee" method="post" id="employee-form">
			                       
			                        <div class="card-box row col-sm-12">
			                        
			                        	<div class="row col-sm-12">
				                        		<div class="col-sm-1"></div>
				                        		<div class="col-sm-3">
				                        			<h4 class="text-dark text-left">ENTER PERSONAL DETAIL</h4>
				                        		</div>
				                        		<div class="col-sm-4">
				                        			<h4 class="text-dark text-center">ENTER BANK &amp; OTHER DETAIL</h4>
				                        		</div>
				                        		
				                        		<div class="col-sm-3">
				                        			<h4 class="text-dark text-center">Working Details</h4>
				                        		</div>
			                        		
			                        	</div>
			                        	<div class="row col-sm-12">
			                        	<p></p>
			                        	</div>
			                           	<div class="col-sm-4">
											<div class="form-group">
												<label>Employee Id<span class="text-danger">*</span>
												</label> <input type="text" class="form-control" required
													pattern="[^'&quot;:]*$" placeholder="EX: WI101"
													id="employee_id" name="employee_id" />
											</div>
	
											<div class="form-group">
												<label>Employee Name<span class="text-danger">*</span>
												</label> <input type="text" class="form-control" required
													pattern="[^'&quot;:]*$" placeholder="Enter Employee Name"
													id="employee_name" name="employee_name" />
											</div>
	
											<div class="form-group">
												<label>Current Address<span class="text-danger">*</span>
												</label>
												<textarea name="current_address" id="current_address"
													class="form-control" placeholder="Enter Current Address"></textarea>
											</div>
	
											<div class="form-group">
												<label>Residential Address<span class="text-danger">*</span>
												</label>
												<textarea name="residental_address" id="residental_address"
													class="form-control"
													placeholder="Enter Residental Address"></textarea>
													
											</div>
	
											<div class="form-group">
												<label>Education <span class="text-danger"></span></label> <input
													type="text" class="form-control" pattern="[^'&quot;:]*$"
													placeholder="Enter Qualification Of Employee"
													id="employee_qualification" name="employee_qualification" />
											</div>
	
											<div class="form-group">
												<label>Phone <span class="text-danger">*</span>
												</label> <input type="text" class="form-control"
													pattern="[^'&quot;:]*$" placeholder="ENTER EMPLOYEE PHONE.."
													id="employee_phone" name="employee_phone" />
											</div>
	
											<div class="form-group">
												<label>Emergency Contact Number <span
													class="text-danger">*</span></label> <input type="text"
													id="contact_number" name="contact_number"
													placeholder="ENTER Contact Number" class="form-control" />
											</div>
	
											<div class="form-group">
												<label>E-Mail </label> <input type="email"
													class="form-control" pattern="[^'&quot;:]*$"
													placeholder="EX:xxx@gmail.com" id="employee_email"
													name="employee_email" />
											</div>

			                            </div>
			                        
			                              <div class="col-sm-4">
			                              			<div class="form-group">
					                                    <label>Adhar Number <span class="text-danger">*</span></label>
					                                    <input type="text" class="form-control" required
					                                          placeholder="Enter Adhar Number" 
					                                          id="employee_aadhar_number"
					                                          name="employee_aadhar_number"/>
					                                </div>
					                                <div class="form-group">
					                                    <label>Pan Number</label>
					                                    <input type="text" class="form-control" placeholder="ENTER EMPLOYEE PAN NUMBER."  id="employee_pancard_number" name="employee_pancard_number"/>
					                                </div>
					                                <div class="form-group">
		                                                <label>Employee DOB</label>
		                                                <div>
		                                                    <div class="input-group">
		                                                        <input type="text" name="employee_dob" 
		                                                        	   class="form-control date-picker"
		                                                        	   placeholder="dd/mm/yyyy" id="id-date-picker-1"
		                                                        	   data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;"/>
		                                                        <div class="input-group-append">
		                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                        </div>
		                                                    </div>
		                                                </div>
		                                            </div>
					                                
					                                <div class="form-group">
					                                    <label>Experience </label>
					                                    <input type="text" class="form-control" placeholder="ENTER EMPLOYEE EXPERIENCE.." id="employee_experience" name="employee_experience"/>
					                                </div>
					                                
					                                
					                                <div class="form-group">
					                                    <label>Bank Name</label>
														<input type="text" id="employee_bank_name"  placeholder="EX : BANK OF INDIA" class="form-control" 
					                                          pattern="[^'&quot;:]*$"  name="employee_bank_name"/>
					                                </div>
					                               
		                                            <div class="form-group">
					                                    <label>A/C NO : </label>
														<input type="text" id="employee_account_number" class="form-control"  placeholder="ENTER ACCOUNT NO.." name="employee_account_number" />
					                                </div>
					                                
					                                <div class="form-group">
					                                    <label>IFSC CODE : </label>
														<input type="text" id="employee_ifsc_code" class="form-control"   pattern="[^'&quot;:]*$" name="employee_ifsc_code"/>
					                                </div>
		                                            
		                                            <div class="form-group">
			                                   			<label>Salary (Monthly)*</label>
	                                      				<input type="text" id="employee_monthly_salary" name="employee_monthly_salary"
	                                      								   placeholder="Enter Monthly Salary"  class="form-control" />	   
	                                       			</div>
	                                       			
	                                      </div>
	                                       
	                                      <div class="col-sm-4">
	                                      	<div class="form-group">
			                                    <label>PF Number : </label>
												<input type="text" id="employee_pf_number" name="employee_pf_number" placeholder="ENTER PF NUMBER.."  class="form-control" />
			                                </div>
			                                
			                                 <div class="form-group">
			                                    <label>Employee ESIC Number </label>
                                               <input type="text" id="employee_password" name="employee_password"  placeholder="ENTER ESIC Number"  class="form-control" />			                    
                                            </div>
			                                
			                                <div class="form-group">
                                                <label>Joining Date</label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="employee_joining_date"  class="form-control date-picker"
                                                        			 placeholder="dd/mm/yyyy" id="id-date-picker-1"
                                                        			 data-date-format="dd/mm/yyyy" style=" background-color: white;"
                                                        			 readonly="readonly"/>
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
			                                <div class="form-group">
	                                   			<label>UA Number</label>
                                     				<input type="text" id="ua_number" name="ua_number"  placeholder="Enter UA Number"  class="form-control" />	   
                                      		</div>
                                      		<div class="form-group">
				                                <label>Licence Number </label>
		                                      	<input type="text" id="licence_number" name="licence_number"  placeholder="ENTER LICENCE NUMBER"  class="form-control" />                             
		                                    </div>
		                                     <div class="form-group">
												<label>Designation <span class="text-danger">*</span></label>
												<div>
													<div class="input-group">
														<select name="designation_id" class="form-control"
															id="designation_id">
															<sql:query var="designation" dataSource="jdbc/rmc">
																		select designation_id,designation_name
																	    from designation
																	</sql:query>
															<c:forEach items="${designation.rows}" var="designation">
																<option value="${designation.designation_id}">${designation.designation_name}</option>
															</c:forEach>
														</select>
													</div>
												</div>
											</div>
											
											<div class="form-group">
												<label>Department <span class="text-danger">*</span></label>
												<div>
													<div class="input-group">
														<select name="department_id" class="form-control"
															id="department_id">
															<sql:query var="department" dataSource="jdbc/rmc">
																		select department_id,department_name
																	    from department
																	</sql:query>
															<c:forEach items="${department.rows}" var="department">
																<option value="${department.department_id}">${department.department_name}</option>
															</c:forEach>
														</select>
													</div>
												</div>
											</div>
											<div class="form-group">
				                                <label>Working Location </label>
		                                      	<input type="text" id="employee_working_location" name="employee_working_location"  placeholder="ENTER Working Location "  class="form-control" />                             
		                                    </div>
		                                    
		                                    <div class="form-group">
			                                    <label>Business Group <span class="text-danger">*</span></label>
			                                    <div>
			                                    	<sql:query var="group" dataSource="jdbc/rmc">
			                                    		select business_id,group_name
			                                    		from business_group
			                                    		where business_id like if(0=?,'%%',?)
			                                    		<sql:param value="${bean.business_id}"/>
			                                    		<sql:param value="${bean.business_id}"/>
			                                    	</sql:query>
													<select class="form-control" id="business_id" name="business_id">
														<c:forEach items="${group.rows}" var="group">
															<option value="${group.business_id}">${group.group_name}</option>
														</c:forEach>
													</select>
			                                    </div>
			                                </div>
			                                <div class="form-group text-right">
			                                    <div>
			                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
			                                            SAVE EMPLOYEE
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
        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="validation/jquery.validate.min.js"></script>
		<script type="text/javascript" src="validation/additional-methods.min.js"></script>
		<c:choose>
			<c:when test="${empty param.action}">
				<script type="text/javascript" src="js/hrm/AddEmployee.js"></script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript" src="js/hrm/EditEmployee.js"></script>
			</c:otherwise>
		</c:choose>
    </body>
</html>