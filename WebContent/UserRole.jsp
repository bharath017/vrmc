<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Update User Role</title>
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
        <link href="assets/jquery-toast/jquery.toast.min.css" rel="stylesheet" type="text/css">

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
                                    <li class="breadcrumb-item"><a href="#">Other</a></li>
                                    <li class="breadcrumb-item active">User</li>
                                    <li class="breadcrumb-item active">User Role</li>
                                </ol>
                            </div>
                            <h4 class="page-title">User Role</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                <!-- end row -->
               		<div class="row">
               			<div class="col-sm-3">
               				<table class="table table-bordered">
               					<tr>
               						<td colspan="2">
               							<sql:query var="user" dataSource="jdbc/rmc">
	               							select user_id,user_name
	               							from user
	               							where user_status='active'
	               							and user_type not in ('gst','gstbilling','gstqc','sgst','gststore','gstaccount','gstadmin','gstmarketing')	
	               						</sql:query>
               							<div class="form-group">
               								<select class="form-control" id="user_id" name="user_id">
               									<option value="" selected="selected" disabled="disabled">Select User</option>
               									<c:forEach items="${user.rows}" var="user">
               										<option value="${user.user_id}">${user.user_name}</option>
               									</c:forEach>
               								</select>
               							</div>
               						</td>
               					</tr>
               					<tr>
               						<th style="width: 30%;">
               							User Type
               						</th>
               						<td id="user_type">
               							
               						</td>
               					</tr>
               					
               					<tr>
               						<th style="width: 30%;">
               							User Name
               						</th>
               						<td id="user_name">
               							
               						</td>
               					</tr>
               					
               					<tr>
               						<th style="width: 30%;">
               							User Phone
               						</th>
               						<td id="user_phone">
               							
               						</td>
               					</tr>
               				</table>
               			</div>
               			<div class="col-sm-3" style="height: 100%;">
               				<ul>
               					<li>
               						<label>
               							<input type="checkbox" name="role" value="1">
               							Billing
               						</label>
               						<ul>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="2">
               									Invoice
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="3">
               									Sales Document
               								</label>
               							</li>
               							
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="5">
               									Report
               								</label>
               							</li>
               						</ul>
               					</li>
               				</ul>
               				
               				<ul>
               					<li>
               						<label>
               							<input type="checkbox" name="role" value="6">
               							Customer & PO
               						</label>
               						<ul>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="7">
               									Customer 
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="8">
               									Sales Order
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="9">
               									Scheduling
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="10">
               									Customer Quotation
               								</label>
               							</li>
               						</ul>
               					</li>
               				</ul>
               				<ul>
               					<li>
               						<label>
               							<input type="checkbox" name="role" value="11">
               							DC
               						</label>
               						<ul>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="12">
               									Delivery Challen
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="13">
               									DC Report
               								</label>
               							</li>
               							
               						</ul>
               					</li>
               				</ul>
               				
               				<ul>
               					<li>
               						<label>
               							<input type="checkbox" name="role" value="15">
               							QC
               						</label>
               						<ul>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="16">
               									Mix Design
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="17">
               									Recipe
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="18">
               									Cube Test
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="19">
               									Batch List
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="20">
               									Moisture Correction
               								</label>
               							</li>
               						</ul>
               					</li>
               				</ul>
               			</div>
               			<div class="col-sm-3">
               				
               				<ul>
               					<li>
               						<label>
               							<input type="checkbox" name="role" value="21">
               							Accounts
               						</label>
               						<ul>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="22">
               									Customer Payment
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="23">
               									Make Payment
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="24">
               									Purchase Voucher
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="25">
               									Expense Voucher
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="26">
               									Petty Cash
               								</label>
               							</li>
               							
               						</ul>
               					</li>
               				</ul>
               				
               				
               				<ul>
               					<li>
               						<label>
               							<input type="checkbox" name="role" value="27">
               							HRM
               						</label>
               						<ul>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="28">
               									Employee detail
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="29">
               									Employee Attendance
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="30">
               									HRM Setting
               								</label>
               							</li>
               							
               						</ul>
               					</li>
               				</ul>
               				
               				
               				<ul>
               					<li>
               						<label>
               							<input type="checkbox" name="role" value="31">
               							Inventory
               						</label>
               						<ul>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="32">
               									Supplier
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="33">
               									Inventory Item
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="34">
               									Inventory
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="35">
               									Inventory Outgoing
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="36">
               									Indent
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="37">
               									Supplier PO
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="38">
               									Report
               								</label>
               							</li>
               						</ul>
               					</li>
               				</ul>
               			</div>
               			<div class="col-sm-3">
               				
               				<ul>
               					<li>
               						<label>
               							<input type="checkbox" name="role" value="39">
               							Fleet
               						</label>
               						<ul>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="40">
               									Fleet Item
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="41">
               									Fleet Incoming
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="42">
               									Fleet Outgoing
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="43">
               									Report
               								</label>
               							</li>
               						</ul>
               					</li>
               				</ul>
               				
               				<ul>
               					<li>
               						<label>
               							<input type="checkbox" name="role" value="44">
               							Others
               						</label>
               						<ul>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="45">
               									Plant Management
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="46">
               									Marketing Person
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="47">
               									General Setting
               								</label>
               							</li>
               							
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="48">
               									User Management
               								</label>
               							</li>
               						</ul>
               					</li>
               				</ul>
               				
               				<ul>
               					<li>
               						<label>
               							<input type="checkbox" name="role" value="49">
               							Transport
               						</label>
               						<ul>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="50">
               									Vehicle,Driver & Pump
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="51">
               									Diesel Consumption
               								</label>
               							</li>
               							<li>
               								<label>
               									<input type="checkbox" name="role" value="52">
               									Vehicle Service
               								</label>
               							</li>
               						</ul>
               					</li>
               				</ul>
               			</div>
               			<button type="button" class="btn btn-success" id="saveRole">Save Roles</button>
               		</div>
               		<br><br><br>
            </div> <!-- end container -->
        </div>
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
        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script type="text/javascript" src="assets/jquery-toast/jquery.toast.min.js"></script>
		<script type="text/javascript" src="js/other/User/UserRole.js"></script>
    </body>
</html>