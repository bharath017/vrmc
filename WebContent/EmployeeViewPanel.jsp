<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Employee View Panel</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">

        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Date picker details -->
		<link rel="stylesheet" href="picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="picker/cs/bootstrap-timepicker.min.css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="assets/css/select2.min.css" />
        <link rel="stylesheet" href="assets/css/render.css">
        
		<!-- Custom box css -->
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link href="assets/jquery-toast/jquery.toast.min.css" rel="stylesheet" type="text/css" />
        <script src="assets/js/modernizr.min.js"></script>
        <style type="text/css">
        	.customer-table tr td:first-child,.table th {
					background-color: #13b2b5;
					color: white;
			}
			#home1 {
				font-size: 12px;
			}
			.error{
				color:red;
			}
        </style>

    </head>

	<c:catch var="e">
    <body>

        <!-- Navigation Bar-->
        	<%@ include file="header.jsp" %>
        <!-- End Navigation Bar-->

        <div class="wrapper">
            <div class="container-fluid">
                <!-- end page title end breadcrumb -->
                <div class="row">
                	<div class="col-sm-12">
                		&nbsp;
                	</div>
                </div>
                <div class="row">
                	<div class="col-sm-12">
                        <div class="col-sm-3 pull-left">
                        	<br>
                          	<a href="Employees.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Employee List</a>
                        </div>
                	</div>
                </div>
                
                <c:catch var="e">
                <sql:query var="employee" dataSource="jdbc/rmc">
                	select e.*,DATE_FORMAT(employee_dob,'%d/%m/%Y') as dob,
                	DATE_FORMAT(employee_joining_date,'%d/%m/%Y') as doj,
                	d.department_name,dg.designation_name,if(month(e.employee_dob)=month(curdate()) and day(e.employee_dob)=day(curdate()),'yes','no') as birthday
                    from employee e,department d,designation dg
                    where e.department_id=d.department_id
                    and e.designation_id=dg.designation_id
                    and  e_id=?
                	<sql:param value="${param.e_id}"/>
                </sql:query>
                </c:catch>
                
                <c:forEach items="${employee.rows}" var="employee">
                	<c:set value="${employee}" var="rs"/>
                </c:forEach>
                
             	<div class="row">
             		<div class="col-md-12">
                        <div class="card-box">
                            <div class="tab-content">
                                <div class="tab-pane show active" id="home1">
										<div class="card-box">
											<ul class="nav nav-pills navtab-bg nav-justified pull-in">
												<li class="nav-item"><a href="#settings1" data-toggle="tab"
													aria-expanded="false" class="nav-link active">
														<span class="d-none d-sm-inline-block ml-2">Employee Info</span></a></li>
														
												<li class="nav-item"><a href="#settings2" data-toggle="tab"
													aria-expanded="false" class="nav-link">
														<span class="d-none d-sm-inline-block ml-2">Salary Structure</span></a></li>
														
												<li class="nav-item"><a href="#settings4" data-toggle="tab"
													aria-expanded="false" class="nav-link">
														<span class="d-none d-sm-inline-block ml-2">Payment</span></a></li>
												<li class="nav-item"><a href="#settings6" data-toggle="tab"
													aria-expanded="false" class="nav-link">
														<span class="d-none d-sm-inline-block ml-2">Payslip's</span></a></li>
												<li class="nav-item"><a href="#settings9" data-toggle="tab"
													aria-expanded="false" class="nav-link">
														<span class="d-none d-sm-inline-block ml-2">Document</span></a></li>
												
											</ul>
											<div class="tab-content">
												<div class="tab-pane text-center show active" id="settings1">
													<div class="row">
														<div class="col-sm-12">
															<table class="table table-bordered tbl text-left" id="bio-info-table">
																<tr>
																	<th>Employee ID</th>
																	<td id="employee_id_view">${rs.employee_id}</td>
																	<th>Name</th>
																	<td id="employee_name_view">${rs.employee_name}</td>
																	<td rowspan="2" colspan="2">
																		<img src="image/hrm/${(empty rs.employee_photo)?'unknown.png':rs.employee_photo}"
																		width="80" height="100"/>
																		<c:if test="${rs.birthday=='yes'}">
																			<img src="image/hrm/cake.jpg"
																					width="100" height="100"/>
																		</c:if>
																	</td>
																</tr>
																<tr>
																	<th style="width: 10%;">Phone</th>
																	<td id="employee_phone_view">${rs.employee_phone}</td>
																	<th style="width: 20%;">Email</th>
																	<td id="emploee_email_view">${rs.employee_email}</td>
																</tr>
																<tr>
																	<th style="width: 10%;">Date of Birth</th>
																	<td id="employee_dob_view">${rs.dob}</td>
																	<th style="width: 20%;">Date of Joining</th>
																	<td id="employee_doj_view">${rs.doj}</td>
																	<th>Department</th>
																	<td>${rs.department_name}</td>
																</tr>
																<tr>
																	<th>Adhar No</th>
																	<td>${rs.employee_aadhar_number}</td>
																	<th>Pan No</th>
																	<td>${rs.employee_pancard_number}</td>
																	<th>Emergency Contact</th>
																	<td>${rs.contact_number}</td>
																</tr>
																<tr>
																	<th>Designation</th>
																	<td>${rs.designation_name}</td>
																	<th>Permanent Address</th>
																	<td>${rs.residental_address}</td>
																	<th>Present Address</th>
																	<td>${rs.current_address}</td>
																</tr>
																
																<tr>
																	<th>Bank</th>
																	<td>${rs.employee_bank_name}</td>
																	<th>A/C No</th>
																	<td>${rs.employee_account_number}</td>
																	<th>IFSC Code</th>
																	<td>${rs.employee_ifsc_code}</td>
																</tr>
																<tr>
																	<th>PF Number</th>
																	<td>${rs.employee_pf_number}</td>
																	<th>ESIC Number</th>
																	<td>${rs.esic_number}</td>
																	<th>UA Number</th>
																	<td>${rs.ua_number}</td>
																</tr>
																
																<tr>
																	<th>Qualification</th>
																	<td>${rs.employee_qualification}</td>
																	<th>Past Experience</th>
																	<td>${rs.employee_experience}</td>
																	<th>Working Location</th>
																	<td>${rs.employee_working_location}</td>
																</tr>
																
																<tr>
																	<th>Licence Number</th>
																	<td>${rs.licence_number}</td>
																	<th>Monthly Salary</th>
																	<td>${rs.employee_monthly_salary}</td>
																	<th></th>
																	<td></td>
																</tr>
																
															</table>
															<h4 id="update-pofile-btn"><span class="text-warning"><i class="fa fa-edit"></i></span></h4>
														</div>
													</div>
												</div>
												
												<div class="tab-pane text-center show " id="settings2">
													<div class="row">
											       		<div class="col-sm-12">
											       			<div class="row">
											       				<form id="emp-salary-form" action="#">
											       					<input type="hidden" name="e_id" value="${rs.e_id}" id="e_id"/>
											       					<input type="hidden" name="salary" id="salary" value="${rs.employee_monthly_salary}"/>
											       					<table class="table table-bordered">
												       					<thead>
												       						<tr>
												       							<th colspan="4">Salary Structure For Employee - ${rs.employee_name} &nbsp;&nbsp; Monthly Salary - ${rs.employee_monthly_salary}</th>
												       						</tr>
												       						<tr>
												       							<th colspan="2">Payment</th>
												       							<th colspan="2">Deduction</th>
												       						</tr>
												       					</thead>
												       					<tbody>
												       						<tr>
													       						<td>Basic Pay (Rs.) <span class="text-danger">*</span></td>	
													       						<td>
														       						<input type="text" name="basic_pay" id="basic_pay"
														       							   class="form-control salaryCalc" value="${rs.basic_pay}"/>	
														       					</td>
														       					<td>PF (Rs.) <span class="text-danger">*</span></td>
														       					<td>
															       					<input type="text" name="pf" id="pf"
															       						   class="form-control salaryCalc" value="${rs.pf}"/>	
															       				</td>
													       					</tr>
													       					<tr>
													       						<td>HRA (Rs.) <span class="text-danger">*</span></td>	
													       						<td>
														       						<input type="text" name="hra" id="hra"
														       							   class="form-control salaryCalc" value="${rs.hra}"/>	
														       					</td>
														       					<td>ESIC (Rs.) <span class="text-danger">*</span></td>
														       					<td>
															       					<input type="text" name="esic" id="esic"
															       						   class="form-control salaryCalc" value="${rs.esic}"/>	
															       				</td>
													       					</tr>
													       					<tr>
													       						<td>DA (Rs.) <span class="text-danger">*</span></td>	
													       						<td>
														       						<input type="text" name="da" id="da"
														       							   class="form-control salaryCalc" value="${rs.da}"/>	
														       					</td>
														       					<td>Professional Tax (Rs.) <span class="text-danger">*</span></td>
														       					<td>
															       					<input type="text" name="prof_tax" id="prof_tax" 
															       						   class="form-control salaryCalc" value="${rs.prof_tax}"/>	
															       				</td>
													       					</tr>
													       					
													       					<tr>
													       						<td>Other (Rs.) <span class="text-danger">*</span></td>	
													       						<td>
														       						<input type="text" name="other" id="other" readonly="readonly"
														       							   class="form-control salaryCalc" value="${rs.other}"/>	
														       					</td>
														       					<td>TDS (Rs.) <span class="text-danger">*</span></td>
														       					<td>
															       					<input type="text" name="tds" id="tds"
															       						   class="form-control salaryCalc" value="${rs.tds}"/>	
															       				</td>
													       					</tr>
													       					
													       					<tr>
													       						<th>Total Payment (Rs.) <span class="text-danger">*</span></th>	
													       						<th>
														       						<input type="text" name="total_pay" id="total_pay"
														       							   readonly="readonly"
														       							   class="form-control"/>	
														       					</th>
														       					<th>Total Deduction (Rs.) <span class="text-danger">*</span></th>
														       					<th>
															       					<input type="text" name="total_deduction"
															       						   id="total_deduction" readonly="readonly"
															       						   class="form-control"/>	
															       				</th>
													       					</tr>
												       					</tbody>
												       				</table>
											       				</form>
											       			</div>
											       			
											       			
											       			<div class="row text-center">
											       				<button class="btn btn-success" id="save_salary_structure">Save Salary Structure</button>
											       			</div>
											       		</div>
											       </div>
												</div>
												
												
												<div class="tab-pane" id="settings4">
													<div class="row">
														<div class="col-sm-12">
															<table class="table table-bordered tbl">
																<thead>
																	<tr class="text-center">
																		<th colspan="2" style="width: 50%;">PERMANENT ADDRESS</th>
																		<th colspan="2" style="width: 50%;">PRESENT ADDRESS</th>
																	</tr>
																</thead>
																<tbody>
																	<tr>
																		<th style="width: 20%;">ADDRESS</th>
																		<td id="permanent_address_view"></td>
																		<th style="width: 20%;">ADDRESS</th>
																		<td id="present_address_view"></td>
																	</tr>
																	
																	<tr>
																		<th>COUNTRY</th>
																		<td id="permanent_country_view"></td>
																		<th>COUNTRY</th>
																		<td id="present_country_view"></td>
																	</tr>
																	
																	<tr>
																		<th>STATE</th>
																		<td id="permanent_state_view"></td>
																		<th>STATE</th>
																		<td id="present_state_view"></td>
																	</tr>
																	
																	<tr>
																		<th>DIST</th>
																		<td id="permanent_dist_view"></td>
																		<th>DIST</th>
																		<td id="present_dist_view"></td>
																	</tr>
																	
																	<tr>
																		<th>PIN CODE</th>
																		<td id="permanent_pin_view"></td>
																		<th>PIN CODE</th>
																		<td id="present_pin_view"></td>
																	</tr>
																	<tr>
																		<td colspan="4" class="text-center">
																			<span class="text-success" data-toggle="modal" data-target="#myModal">
																				<i class="fa fa-edit"></i>
																			</span>
																		</td>	
																	</tr>
																</tbody>
															</table>
														</div>
													</div>
												</div>
												<div class="tab-pane" id="settings6">
													<div class="row">
														<div class="col-sm-6">
															<table class="table table-bordered tbl">
																<tr>
																	<th style="width: 30%;">A/C Number</th>
																	<td id="acno_view"></td>
																</tr>
																<tr>
																	<th>Bank</th>
																	<td id="bank_view"></td>
																</tr>
																<tr>
																	<th>IFSC Code</th>
																	<td id="ifsc_view"></td>
																</tr>
																<tr>
																	<th>Bank Document</th>
																	<td>
																		<p id="bank_document_view"></p>
																		<a href="" id="bank_document_download" target="_blank" class="btn btn-success">Download Document</a>
																	</td>
																</tr>
																<tr>
																	<td colspan="2" class="text-center">
																		<a id="edit-bank-btn-modal"><span class="text-success"><i class="fa fa-edit"></i></span></a>
																	</td>
																</tr>
															</table>
														</div>
														<div class="col-sm-6 text-center">
															<img src="" alt="NO PRIVIEW FOUND" id="view-bank_document" />
														</div>
													</div>
												</div>
												
												<div class="tab-pane" id="settings7">
													<table class="table table-bordered tbl">
														<tr>
															<th style="width: 20%;">UAN Number</th>
															<td id="uan_number_view"></td>
															<th style="width: 20%;">PF Number</th>
															<td id="pf_number_view"></td>
														</tr>
														<tr>
															<th style="width: 20%;">ESIC Applicable</th>
															<td id="esic_applicable_view"></td>
															<th style="width: 20%;">ESIC Applicable Form</th>
															<td id="esic_applicable_form_view"></td>
														</tr>
														<tr>
															<th style="width: 20%;">ESIC Registration Code</th>
															<td id="esic_registration_code_view"></td>
															<th style="width: 20%;">Name As Per ESIC</th>
															<td id="name_asper_esic_view"></td>
														</tr>
														<tr>
															<th style="width: 20%;">Name as per Adhar</th>
															<td id="name_as_per_ahdar"></td>
															<th style="width: 20%;">PF Registration  Location</th>
															<td id="registration_location_view"></td>
														</tr>
														
														<tr>
															<th style="width: 20%;">Restrict Company PF</th>
															<td id="restrict_company_pf_view"></td>
															<th style="width: 20%;">Existing Member of EPS</th>
															<td id="existing_member_eps_view"></td>
														</tr>
													</table>
													<div class="text-center">
														<a id="open-uanumber-edit-modal"><span class="text-success"><i class="fa fa-edit"></i></span></a>
													</div>
												</div>
												
												<div class="tab-pane" id="settings8">
													<div class="row">
														<div class="col-sm-12 table-responsive">
															<table class="table table-bordered tbl" id="education-table">
																<thead>
																	<tr>
																		<th>Educational Category</th>
																		<th>Education Degree</th>
																		<th>School/College/Institute</th>
																		<th>Board / University</th>
																		<th>From Date</th>
																		<th>To Date</th>
																		<th>Document</th>
																		<th></th>
																	</tr>
																</thead>
																<tbody>
																	
																</tbody>
															</table>
																<div>
																	<button class="btn btn-info" id="add-education-btn">Add Education</button>
																</div>
														</div>
													</div>
												</div>
												
												<div class="tab-pane" id="settings9">
													<div class="row">
														<div class="col-sm-12 table-responsive">
															<table class="table table-bordered">
																<tr>
																	<td>
																		<img alt="Adhar Photo" src="" id="adhar_photo" width="200" height="250"/><br>
																		<a href="" id="download_adhar">Download</a>
																	</td>
																	<td>
																		<input type="file" id="adhar_photo_file" accept="image/x-png,image/gif,image/jpeg"/>
																		<button class="btn btn-success" id="adhar_upload_btn">Upload Adhar</button>
																		<span class="text-danger"><img src="image/loader/loader.gif" id="adhar-loader_update" style="display:none;" width="20" height="20"/></span>
																	</td>
																</tr>
																<tr>
																	<td>
																		<img alt="Pan Photo" src="" id="pan_photo" width="200" height="250"/><br>
																		<a href="" id="download_pan">Download</a>
																	</td>
																	<td>
																		<input type="file" id="pan_photo_file"/>
																		<button class="btn btn-success" id="pan_upload_btn" accept="image/x-png,image/gif,image/jpeg">Upload PAN</button>
																		<span class="text-danger"><img src="image/loader/loader.gif" id="pan-loader_update" style="display:none;" width="20" height="20"/></span>
																	</td>
																</tr>
															</table>											
														</div>
													</div>
												</div>
												
												<div class="tab-pane" id="settings10">
													<div class="row">
														<div class="col-sm-12 table-responsive">
															<table class="table table-bordered">
																<tr>
																	<td><a href="PrintOfferLetter.jsp?e_id=${e_id}" target="_blank">Download Offer letter</a></td>
																</tr>
																<tr>
																	<td><a href="PrintAppointmentLetter.jsp?e_id=${e_id}">Download Appointment letter</a></td>
																</tr>
															</table>								
														</div>
													</div>
												</div>
											</div>
					                </div>
                                </div>
                            </div>
                        </div>
                    </div> <!-- end col -->
              	 </div>
                <!-- end row -->
            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->
        </c:catch>
        
        <!-- Footer -->
       <%@ include file="footer.jsp" %>
        <!-- End Footer -->

        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
		<script type="text/javascript" src="angular/angular.min.js"></script>
        <script src="assets/jquery-toast/jquery.toast.min.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>
        <script type="text/javascript" src="js/hrm/EmployeeViewPanel.js"></script>
       	<script type="text/javascript" src="validation/jquery.validate.js"></script>
       	 <!-- Datepicker details goes here  -->
        <script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>

    </body>
</html>