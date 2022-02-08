<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Employee List</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">

        <!-- DataTables -->
        <link href="plugins/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <!-- Responsive datatable examples -->
        <link href="plugins/datatables/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />

        <!-- Multi Item Selection examples -->
        <link href="plugins/datatables/select.bootstrap4.min.css" rel="stylesheet" type="text/css" />

        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
		  <!-- Custom box css -->
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
		
        <script src="assets/js/modernizr.min.js"></script>

    </head>

    <body>

        <!-- Navigation Bar-->
        <!-- PUT HEADER.JSP HERE -->
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
                                    <li class="breadcrumb-item active">Employee</li>
                                    <li class="breadcrumb-item active">Employee List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Employee List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                <div class="row">
                    <div class="col-sm-4">
                        <a href="AddEmployee.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Add Employee</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
				
				
                	
                    <div class="col-12">
                        <div class="card-box table-responsive">
                            <h4 style="color: green;">${res}</h4>
							<c:remove var="res"/>
                            <table id="datatable-buttons" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="center"> Employee Id	</th>
										<th class="center">Employee Name</th>
										<th class="center">Employee Qualification</th>
										<th class="center">Employee Phone</th>
										<th class="center">Employee Email</th>
										<th class="center">Employee DOB</th>
										<th class="center">Joining Date </th>
										<th class="center">Employee Salary </th>
										<th class="center">Employee Experience </th>
										<th class="center">Photo</th>
										<th class="center">Options</th>
									</tr>
                                </thead>
                                <c:set value="${(empty param.employee_name)?'':param.employee_name}" var="employee_name"/>
								
								<sql:query var="mix" dataSource="jdbc/rmc">
									select * from employee
								</sql:query>
                                <tbody>
                                <c:forEach var="mix" items="${mix.rows}">
									<tr>
										<td class="center"><a href="EmployeeViewPanel.jsp?e_id=${mix.e_id}">${mix.employee_id}</a></td>
										<td class="center"><a href="EmployeeViewPanel.jsp?e_id=${mix.e_id}">${mix.employee_name}</a></td>
										<td class="center">${mix.employee_qualification}</td>
										<td class="center">${mix.employee_phone}</td>
										<td class="center">${mix.employee_email}</td>
										<td class="center">${mix.employee_dob}</td>
										<td class="center">${mix.employee_joining_date}</td>
										<td class="center">${mix.employee_monthly_salary}</td>
										<td class="center">${mix.employee_experience}</td>
										<td class="center"><img alt="Photo" src="${(empty mix.employee_photo)?'document/unknown.png':'document/'}${(empty mix.employee_photo)?'':mix.employee_photo}" width="100" height="100"></td>
										<td>
											 <div class="btn-group dropdown">
	                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
	                                            <div class="dropdown-menu dropdown-menu-right">
	                                            	<a class="dropdown-item" href="#view-model" data-animation="blur" data-plugin="custommodal" onclick="viewEmployee('${mix.e_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="fa fa-eye mr-2 text-muted font-18 vertical-middle"></i>View Employee</a>
	                                                <a class="dropdown-item" href="AddEmployee.jsp?action=update&e_id=${mix.e_id}"><i class="mdi mdi-pencil mr-2 text-muted font-18 vertical-middle"></i>Edit Employee</a>
	                                                <a class="dropdown-item" href="#delete-model" data-animation="blur" data-plugin="custommodal" onclick="deleteMixDesign('${mix.e_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>Delete Employee</a>
	                                            </div>
	                                        </div>
										</td>
									</tr>
									</c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                </div>
                <!-- end row -->


				 <!-- MODAL FOR PLANT DELETE START  -->
				<div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #9b3329;">Are you sure want to delete?</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="EmployeeController?action=deleteEmployee" method="post">
		                	<input type="hidden" name="e_id" id="e_id"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit"><span class="change_status text-uppercase">DELETE</span></button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  PLANT DELETE MODAL END  -->
                
                
                <!-- Employee view model -->
				<div id="view-model" class="modal-demo col-xs-4">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #79c484;">Employee View</h4>
		            <div class="custom-modal-text">
		                <table class="table table-bordered">
		                	<tr>
		                		<th style="width: 20%">Employee ID</th>
		                		<td id="empid_view"></td>
		                		<th style="width: 20%">Name</th>
		                		<td id="name_view"></td>
		                	</tr>
		                	<tr>
		                		<th>Current Address</th>
		                		<td id="caddr_view"></td>
		                		<th>Residential Address</th>
		                		<td id="raddr_view"></td>
		                	</tr>
		                	<tr>
		                		<th>Phone</th>
		                		<td id="phone_view"></td>
		                		<th>Email</th>
		                		<td id="email_view"></td>
		                	</tr>
		                	<tr>
		                		<th>PAN Number</th>
		                		<td id="pan_view"></td>
		                		<th>Adhar Number</th>
		                		<td id="adhar_view"></td>
		                	</tr>
		                	<tr>
		                		<th>DOB</th>
		                		<td id="dob_view"></td>
		                		<th>Experience</th>
		                		<td id="exper_view"></td>
		                	</tr>
		                	<tr>
		                		<th>Bank</th>
		                		<td id="bank_view"></td>
		                		<th>A/C No</th>
		                		<td id="acc_view"></td>
		                	</tr>
		                	<tr>
		                		<th>IFSC Code</th>
		                		<td id="ifsc_view"></td>
		                		<th>Joining Date</th>
		                		<td id="joining_view"></td>
		                	</tr>
		                	<tr>
		                		<th>Licence No</th>
		                		<td id="licence_view"></td>
		                		<th>Working Location</th>
		                		<td id="working_view"></td>
		                	</tr>
		                	<tr>
		                		<th>Employee Photo<br>
		                			<img alt="Photo" src="document/unknown.png" id="emp_photo" width="100" height="100">
		                		</th>
		                		<th>Adhar Photo<br>
		                			<img alt="Photo" src="document/unknown.png" id="adhar_photo" width="100" height="100">
		                		</th>
		                		<th>PAN Photo<br>
		                			<img alt="Photo" src="document/unknown.png" id="pan_photo" width="100" height="100">
		                		</th>
		                		<th>Others</th>
		                	</tr>
		                </table>
		            </div>
		        </div>

            </div> <!-- end container -->
      
        <!-- end wrapper -->


        <!-- Footer -->
        <!-- PUT FOOTER.JSP HERE -->
        <%@ include file="footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>

        <!-- Required datatable js -->
        <script src="plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="plugins/datatables/dataTables.bootstrap4.min.js"></script>
        <!-- Buttons examples -->
        <script src="plugins/datatables/dataTables.buttons.min.js"></script>
        <script src="plugins/datatables/buttons.bootstrap4.min.js"></script>
        <script src="plugins/datatables/jszip.min.js"></script>
        <script src="plugins/datatables/pdfmake.min.js"></script>
        <script src="plugins/datatables/vfs_fonts.js"></script>
        <script src="plugins/datatables/buttons.html5.min.js"></script>
        <script src="plugins/datatables/buttons.print.min.js"></script>

        <!-- Key Tables -->
        <script src="plugins/datatables/dataTables.keyTable.min.js"></script>

        <!-- Responsive examples -->
        <script src="plugins/datatables/dataTables.responsive.min.js"></script>
        <script src="plugins/datatables/responsive.bootstrap4.min.js"></script>

        <!-- Selection table -->
        <script src="plugins/datatables/dataTables.select.min.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>

        <script type="text/javascript">
            $(document).ready(function() {

                // Default Datatable
                $('#datatable').DataTable();

                //Buttons examples
                var table = $('#datatable-buttons').DataTable({
                    lengthChange: false,
                    buttons: ['copy', 'pdf','print']
                });

                // Key Tables

                $('#key-table').DataTable({
                    keys: true
                });

                // Responsive Datatable
                $('#responsive-datatable').DataTable();

                // Multi Selection Datatable
                $('#selection-datatable').DataTable({
                    select: {
                        style: 'multi'
                    }
                });

                table.buttons().container()
                        .appendTo('#datatable-buttons_wrapper .col-md-6:eq(0)');
            } );

        </script>
        
        <!-- Modal-Effect -->
        <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>
        <script type="text/javascript">
			function deleteMixDesign(e_id){
				$('#e_id').val(e_id);
			}
        </script>
		<script type="text/javascript">
		    $(document).ready(function(){
		    	$('#search').on('click',function(){
		    		var receipe_code=$('#receipe_code').val();
		    		var receipe_name=$('#receipe_name').val();
		    		window.location="MixDesignList.jsp?receipe_code="+receipe_code+"&receipe_name="+receipe_name;
		    	});
		    });
	     </script>
	     
	     <script type="text/javascript">
	     	function viewEmployee(e_id){
	     		$.ajax({
	     			type:'post',
	     			url:'EmployeeController?action=viewEmployee&e_id='+e_id,
	     			headers:{
	     				Accept:"application/json;charset=utf-8",
	     				"Content-Type":"application/json;charset=utf-8"
	     			},
	     			success:function(res){
	     				$('#empid_view').text(res.employee_id);
	     				$('#name_view').text(res.employee_name);
	     				$('#caddr_view').text(res.current_address);
	     				$('#raddr_view').text(res.residental_address);
	     				$('#phone_view').text(res.employee_phone);
	     				$('#email_view').text(res.employee_email);
	     				$('#pan_view').text(res.employee_pancard_number);
	     				$('#adhar_view').text(res.employee_aadhar_number);
	     				$('#dob_view').text(res.employee_dob);
	     				$('#exper_view').text(res.employee_experience);
	     				$('#bank_view').text(res.employee_bank_name);
	     				$('#acc_view').text(res.employee_account_number);
	     				$('#ifsc_view').text(res.employee_ifsc_code);
	     				$('#joining_view').text(res.employee_joining_date);
	     				$('#licence_view').text(res.licence_number);
	     				$('#working_view').text(res.working_location);
	     				$('#emp_photo').prop('src',(res.employee_photo==null || res.employee_photo=='')?'document/unknown.png':'image/'+res.employee_photo);
	     				$('#adhar_photo').prop('src',(res.employee_aadhar_photo==null || res.employee_aadhar_photo=='')?'document/unknown.png':'image/'+res.employee_aadhar_photo);
	     				$('#pan_photo').prop('src',(res.employee_pancard_photo==null || res.employee_pancard_photo=='')?'document/unknown.png':'image/'+res.employee_pancard_photo);
	     				
	     				
	     			}
	     		});
	     	}
	     </script>

    </body>
</html>