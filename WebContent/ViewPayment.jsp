<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Customer Address</title>
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
        <link rel="stylesheet" href="picker/cs/bootstrap-timepicker.min.css" />
		<!-- Custom box css -->
		<!-- DataTables -->
        <link href="plugins/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
		
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/select2.min.css" />
        <link rel="stylesheet" href="assets/css/render.css">
        <script src="assets/js/modernizr.min.js"></script>
        <style type="text/css">
        	.customer-table tr td:first-child,.table th {
					background-color: #13b2b5;
					color: white;
				}
				
			.error{
				color:red;
			}
        </style>

    </head>

    <body>

        <!-- Navigation Bar-->
        	<%@ include file="header.jsp" %>
        <!-- End Navigation Bar-->

        <div class="wrapper">
            <div class="container-fluid">
                <!-- end page title end breadcrumb -->
                <div class="row">
                	<div class="col-sm-12">
                		<div class="page-title-box">
                            <div class="btn-group pull-right">
                                <ol class="breadcrumb hide-phone p-0 m-0">
                                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                                    <li class="breadcrumb-item"><a href="#">Customer List</a></li>
                                    <li class="breadcrumb-item active">Customer Panel</li>
                                    <li class="breadcrumb-item active">Payment List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Payment List</h4>
                        </div>
                	</div>
                </div>
                <div class="row">
                	<div class="col-sm-12">
                		<div class="col-sm-3 pull-right">
                          	<div class="form-group">
                                   <label>Choose Customer<span class="text-danger">*</span></label>
                                   <sql:query var="customer" dataSource="jdbc/rmc">
                                   		select * from customer order by customer_name asc
                                   </sql:query>
								<select id="customer_id"    class="select2"  data-placeholder="Choose Customer">
									<option value="">&nbsp;</option>
									<c:forEach var="customer" items="${customer.rows}">
									<option value="${customer.customer_id}" ${(customer.customer_id==customer_id)?'selected':''}>${customer.customer_name}</option>
									</c:forEach>
								</select>
                            </div>
                        </div>
                        
                        <div class="col-sm-3 pull-left">
                        	<br>
                          	<a href="AddCustomer.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Add Customer</a>
                          	<a href="AddCustomer.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Customer List</a>
                        </div>
                	</div>
                </div>
                
             	<div class="row">
             		<div class="col-md-12">
                        <div class="card-box">
                            <sql:query var="name" dataSource="jdbc/rmc">
                        		select customer_name from customer where customer_id=?
                        		<sql:param value="${customer_id}"/>
                        	</sql:query>
                        	
                            <h4 class="header-title m-t-0 m-b-30">
                            	<c:forEach items="${name.rows}" var="name">
                            		${name.customer_name}
                            	</c:forEach>
                            </h4>

                            <ul class="nav nav-pills navtab-bg nav-justified pull-in ">
                                <li class="nav-item">
                                    <a href="ViewCustomer.jsp" aria-expanded="false" class="nav-link">
                                        <i class="fi-head mr-2"></i>Profile
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="ViewInvoice.jsp" aria-expanded="true" class="nav-link">
                                        <i class="fa fa-money mr-2"></i>Invoice
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="ViewPurchaseOrder.jsp" aria-expanded="false" class="nav-link">
                                        <i class="fa fa-shopping-cart mr-2"></i>Purchase Order
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="ViewPayment.jsp"  aria-expanded="false" class="nav-link active">
                                        <i class="fa fa-paypal mr-2"></i>Payment
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="ViewTransactionHistory.jsp"  aria-expanded="false" class="nav-link">
                                        <i class="fa fa-paypal mr-2"></i>Transaction History
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="ViewMixDesign.jsp"  aria-expanded="false" class="nav-link">
                                        <i class="fi-cog mr-2"></i>Mix Design
                                    </a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane show active" id="home1">
                                	<div class="row filter-row">
					                    <div class="col-sm-2 col-xs-6 form-group">
					                        <label>From Date : </label>
					                        <div>
					                            <div class="input-group">
					                                <input type="text" name="scheduling_date" class="form-control date-picker from_date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
					                                <div class="input-group-append">
					                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                    
					                     <div class="col-sm-2 col-xs-6 form-group">
					                        <label>To Date : </label>
					                        <div>
					                            <div class="input-group">
					                                <input type="text" name="scheduling_date" class="form-control date-picker to_date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
					                                <div class="input-group-append">
					                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                    
					                    <div class="col-sm-2 col-xs-6">
					                        <div class="form-group form-focus select-focus">
					                            <label class="control-label">Site : </label>
					                            <sql:query var="site" dataSource="jdbc/rmc">
					                            	select * from site_detail where customer_id=?
					                            	<sql:param value="${customer_id}"/>
					                            </sql:query>
					                            <select class="form-control select2 floating"   id="site_id">
					                                <option value="">All Site</option>
					                                <c:forEach var="site" items="${site.rows}">
					                                	<option value="${site.site_id}">${site.site_name}</option>
					                                </c:forEach>
					                            </select>
					                        </div>
					                    </div>
					                   
					                    <div class="col-sm-2 col-xs-6">
					                        <div class="form-group form-focus">
					                            <label class="control-label">&nbsp;</label>
					                            <a href="#" id="search" class="btn btn-success btn-block"> Search </a>
					                        </div>
					                    </div>
					                    
					                    <div class="col-sm-2 col-xs-6">
					                        <div class="form-group form-focus">
					                            <label class="control-label">&nbsp;</label>
					                            <a href="#payment-model" data-animation="blur" id="search" data-plugin="custommodal" data-overlaySpeed="100" data-overlayColor="#36404a" class="btn btn-primary btn-block">Add Payment</a>
					                        </div>
					                    </div>
					                </div>
                                	
                                	<sql:query var="details" dataSource="jdbc/rmc">
		                           		select * from customer where customer_id=?
		                           		<sql:param value="${customer_id}"/>
		                           	</sql:query>
		                           	
		                         	<c:forEach items="${details.rows}" var="details">
		                         		<c:set value="${details}" var="rs"/>
		                         	</c:forEach>
                                    <div class="col-sm-12 table-responsive">
			                            <table id="example" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
			                                <thead>
				                                <tr>
													<th class="center">
														Payment Id
													</th>
													<th class="text-center">Payment Amount$</th>
													<th class="text-center">Payment Date</th>
													<th class="text-center">Payment Time</th>
													<th class="text-center">Payment Mode</th>
													<th class="text-center">Site Details</th>
													<th class="text-center">Option</th>
												</tr>
			                                </thead>
			                                <!-- Get po details here -->
                                           <c:set value="${(empty param.from_date)?'':param.from_date}" var="from_date"/>
                                           <c:set value="${(empty param.to_date)?'':param.to_date}" var="to_date"/>
			                                <sql:query var="payment" dataSource="jdbc/rmc">
			                                	select p.*,c.customer_name,(select site_address from site_detail where site_id=p.site_id) as site_address from customer_payment p left join customer c
			                                    on p.customer_id=c.customer_id where p.customer_id=?
			                                    and p.payment_date between if(''=?,'2011-01-01',?) and if(''=?,'2088-01-01',?)
			                                    order by payment_id desc limit 500
			                                	<sql:param value="${customer_id}"/>
			                                	<sql:param value="${from_date}"/>
			                                	<sql:param value="${from_date}"/>
			                                	<sql:param value="${to_date}"/>
			                                	<sql:param value="${to_date}"/>
			                                </sql:query>
			                                <tbody>
			                                <c:forEach items="${payment.rows}" var="payment">
			                                   	<tr>
			                                        <td class="text-center"><a href="#">${payment.payment_id}</a></td>
			                                        <td class="text-center">${payment.payment_amount}</td>
			                                        <td class="text-center">${payment.payment_date}</td>
			                                        <td class="text-center">${payment.payment_time}</td>
			                                        <td class="text-center">
			                                        	${payment.payment_mode}
			                                        </td>
			                                        <td class="text-center" width="20%;">
			                                        	${(empty payment.site_address)?'All Site':payment.site_address}
			                                        </td>
			                                        <td class="text-center">
														 <div class="btn-group dropdown">
				                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
				                                            	<div class="dropdown-menu dropdown-menu-right">
					                                            	<a class="dropdown-item" href="PaymentReceipt.jsp?payment_id=${payment.payment_id}"><i class="fa fa-print mr-2 text-muted font-18 vertical-middle"></i>Print Receipt</a>
					                                           	    <a class="dropdown-item" href="AddPayment.jsp?action=update&payment_id=${payment.payment_id}"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Edit Payment</a>
					                                                <a class="dropdown-item" href="#dele-model" data-animation="blur" data-plugin="custommodal" onclick="deleteCubeTest('${cube.tst_id}');" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>Cancel Test</a>
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
                        </div>
                    </div> <!-- end col -->
              	 </div>
                <!-- end row -->
            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->
        
         <!-- Add Site Details Here-->
				<div id="add-site-details"  class="modal fade" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true" style="display: none;">
                      <div class="modal-dialog" >
                          <div class="modal-content" style="width: 100%;">

                              <div class="modal-body" >
                                  <h2 class="text-uppercase text-center m-b-30 text-success">
                                    Add Site Details
                                  </h2>

                                  <form class="form-horizontal" action="CustomerController?action=addSiteDetails" method="post">

                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Site Name</label>
	                                              <input type="hidden" name="customer_id" value="${rs.customer_id}"/>
	                                              <input class="form-control" pattern="[^'&quot;:]*$" type="text" id="site_name" name="site_name" required="required" placeholder="Enter Site Name.">
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Site Address</label>
	                                              <textarea class="form-control" pattern="[^'&quot;:]*$"  id="site_address" name="site_address" required="required" placeholder="Enter Site Address."></textarea>
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      
                                      
                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                               <button type="submit" onclick="addCompWeight();" id="comp_save" class="btn btn-custom waves-effect waves-light">
			                                            Submit
			                                        </button>
			                                        <button type="reset" data-dismiss="modal" aria-hidden="true" class="btn btn-light waves-effect m-l-5">
			                                            Cancel
			                                        </button>
	                                          </div>
	                                      </div>
                                      </div>
                                  </form>
                              </div>
                          </div><!-- /.modal-content -->
                      </div><!-- /.modal-dialog -->
                  </div><!-- /.modal -->
                  
                  
                 <!-- Update Site Details Here-->
				<div id="update-site"  class="modal fade" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true" style="display: none;">
                      <div class="modal-dialog" >
                          <div class="modal-content" style="width: 100%;">

                              <div class="modal-body" >
                                  <h2 class="text-uppercase text-center m-b-30 text-success">
                                    Update Site Details
                                  </h2>

                                  <form class="form-horizontal" action="CustomerController?action=updateSiteDetails" method="post">

                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Site Name</label>
	                                              <input type="hidden" name="site_id" id="edit_site_id"/>
	                                              <input class="form-control" pattern="[^'&quot;:]*$" type="text" id="edit_site_name" name="site_name" required="required" placeholder="Enter Site Name.">
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Site Address</label>
	                                              <textarea class="form-control" pattern="[^'&quot;:]*$"  id="edit_site_address" name="site_address" required="required" placeholder="Enter Site Address."></textarea>
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Tally Ledger</label>
	                                              <input class="form-control" pattern="[^'&quot;:]*$" type="text" id="edit_tally_ledger" name="tally_ledger"  placeholder="Enter Tally Ledger..">
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      
                                      
                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                               <button type="submit" onclick="addCompWeight();" id="comp_save" class="btn btn-custom waves-effect waves-light">
			                                            Submit
			                                        </button>
			                                        <button type="reset" data-dismiss="modal" aria-hidden="true" class="btn btn-light waves-effect m-l-5">
			                                            Cancel
			                                        </button>
	                                          </div>
	                                      </div>
                                      </div>
                                  </form>
                              </div>
                          </div><!-- /.modal-content -->
                      </div><!-- /.modal-dialog -->
                  </div><!-- /.modal -->
                
                  <!-- Address Deactivate Model Details  -->
					<div id="delete-model" class="modal-demo col-xs-2">
			            <button type="button" class="close" onclick="Custombox.close();">
			                <span>&times;</span><span class="sr-only">Close</span>
			            </button>
			            <h4 class="custom-modal-title" style="color: white;background-color: #491136;"><span class="show_status text-uppercase"></span> Site  <span class="site_name"></span> </h4>
			            <div class="custom-modal-text">
			                <form class="form-horizontal" action="CustomerController?action=changeSiteStatus" method="post">
			                	<input type="hidden" id="status_site_id" name="site_id">
			                	<input type="hidden" name="site_status" id="site_status"/>
			                    <div class="form-group account-btn text-center m-t-2">
			                        <div class="col-12">
			                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">Change</button>
			                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
			                        </div>
			                    </div>
			                </form>
			            </div>
			        </div>
			        
			        <!-- Address Deactivate Model Details  -->
					<div id="payment-model" class="modal-demo col-xs-2">
			            <button type="button" class="close" onclick="Custombox.close();">
			                <span>&times;</span><span class="sr-only">Close</span>
			            </button>
			            <h4 class="custom-modal-title" style="color: white;background-color: #39918d;">ADD NEW PO</h4>
			            <div class="custom-modal-text">
			                <form class="form-horizontal" id="clicked" action="CustomerViewController?action=InsertPayment" method="post">
								<input type="hidden" name="customer_id" value="${customer_id}"/>
			                	<div class="form-group text-left">
			                		<label for="site_id" class="text-left">Site Name <span class="text-danger">*</span> </label>
			                		<sql:query var="site" dataSource="jdbc/rmc">
			                			select site_id,site_name from site_detail where customer_id=?
			                			<sql:param value="${customer_id}"/>
			                		</sql:query>
			                		<select class="form-control" name="site_id" id="site_id">
			                				<option value="0">All Site</option>
			                			<c:forEach items="${site.rows}" var="site">
			                				<option value="${site.site_id}">${site.site_name}</option>
			                			</c:forEach>
			                		</select>
			                	</div>
			                	<div class="form-group text-left">
                                   <label>Payment Amount<span class="text-danger">*</span> </label>
                                   <div>
                                      <input type="number" class="form-control" 
                                        pattern="[^'&quot;:]*$"  required="required"    id="payment_amount" name="payment_amount"/>
                                   </div>
                               </div>
                               
                               <div class="form-group text-left">
                                      <label>Payment Date <span class="text-danger">*</span> </label>
                                      <div>
                                          <div class="input-group">
                                              <input type="text" name="payment_date"  class="form-control date-picker invoice_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                              <div class="input-group-append">
                                                  <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                              </div>
                                          </div>
                                          <label id="id-date-picker-1-error" class="error" for="id-date-picker-1"></label>
                                      </div>
                                 </div>
                               
                               <div class="form-group text-left">
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
                               <div class="form-group text-left">
                                   <label>Payment Type<span class="text-danger">*</span></label>
								<select id="payment_type"  name="payment_mode" required="required"   class="form-control"  data-placeholder="Choose Site">
									<option value="CASH">CASH</option>
									<option value="CHECK/DD">CHECK/DD</option>
									<option value="NEFT/RTGS">NEFT/RTGS</option>
									<option value="BANK_TRANSFER">BANK_TRANSFER</option>
									<option value="CREDIT_CARD">CREDIT_CARD</option>
									<option value="CREDIT_NOTE">CREDIT_NOTE</option>
									<option value="DEBIT_NOTE">DEBIT_NOTE</option>
									<option value="WAIVE_OFF">WAIVE_OFF</option>
								</select>
                               </div>
               	                     
			                                 
			                                 
			                                
			              <div class="form-group text-left">
			                  <label>Marketing Person <span class="text-danger">*</span></label>
			                  <sql:query var="market" dataSource="jdbc/rmc">
			                  	select * from marketing_person where mp_status='active'  order by mp_name asc
			                  </sql:query>
								<select id="mp_id"  name="mp_id"    class="form-control"  data-placeholder="Choose Marketing Person" required="required">
									<c:forEach var="market" items="${market.rows}">
									<option value="${market.mp_id}">${market.mp_name}</option>
									</c:forEach>
								</select>
			              </div>
			              
			                    <div class="form-group account-btn text-center m-t-2">
			                        <div class="col-12">
			                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">Save</button>
			                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
			                        </div>
			                    </div>
			                </form>
			            </div>
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
        <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>
        <script src="picker/js/moment.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		
		
		<!-- Required datatable js -->
        <script src="plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="plugins/datatables/dataTables.bootstrap4.min.js"></script>
       
        <script type="text/javascript">
            $(document).ready(function() {
              //  $('form').parsley();
                
                $('.select2').css('width','100%').select2({allowClear:true})
				.on('change', function(){
				}); 
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function() {

                // Default Datatable
                $('#datatable').DataTable();

                
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
                
                // Key Tables

                $('#key-table').DataTable({
                    keys: true
                });
                
                $('#example').dataTable({
                    /* No ordering applied by DataTables during initialisation */
                    "order": []
                });

                // Responsive Datatable
                $('#responsive-datatable').DataTable();

                // Multi Selection Datatable
                $('#selection-datatable').DataTable({
                    select: {
                        style: 'multi'
                    }
                });
                
            } );

        </script>
        <script type="text/javascript">
        $(document).ready(function() {
            $('.date-picker').datepicker({
   				autoclose: true,
   				todayHighlight: true
   		 	});
   			//show datepicker when clicking on the icon
          });
        </script>
        <script type="text/javascript">
        	$(document).ready(function(){
        		$('#customer_id').on("change",function(){
        			var customer_id=$('#customer_id').val();
        			$.ajax({
                		type:'POST',
                		url:'CustomerController?action=changeCustomer&customer_id='+customer_id,
                		headers:{
                			Accept:"text/html;charset=utf-8",
                			"Content-Type":"text/html;charset=utf-8"
                		},
                		success:function(result){
                			location.reload();
                		}
                	}); 
        		});
        	});
        </script>
        <script type="text/javascript">
        	function updateCustomerAddress(site_id){
        		$.ajax({
        			type:'POST',
        			url:'CustomerController?action=getSiteDetailsForUpdate&site_id='+site_id,
        			headers:{
        				Accept:"application/json;charset=utf-8",
        				"Content-Type":"application/json;charset=utf-8"
        			},
        			success:function(res){
        				$('#edit_site_id').val(res.site_id);
        				$('#edit_site_name').val(res.site_name);
        				$('#edit_site_address').val(res.site_address);
        				$('#edit_tally_ledger').val(res.tally_ladger);
        			}
        		})
        	}
        </script>
        <script type="text/javascript">
        	function changeAddressStatus(site_id,site_name,site_status){
        		$('.show_status').text(site_status);
        		$('.site_name').text(site_name);
        		$('#status_site_id').val(site_id);
        		$('#site_status').val(site_status);
        	}
        </script>
         <script type="text/javascript">
		    $(document).ready(function(){
		    	$('#search').on('click',function(){
		    		var from_date=$('.from_date').val();
		    		var to_date=$('.to_date').val();
		    		window.location="ViewPayment.jsp?from_date="+from_date+"&to_date="+to_date;
		    	});
		    });
    	</script>
    	<script type="text/javascript" src="validation/jquery.validate.min.js"></script>
    	
    	<script type="text/javascript">
    		$(document).ready(function(){
    			var clicked=false;
    			$('#clicked').validate({
    				debug:true,
    				rules:{
    					site_id:"required",
    					payment_amount:"required",
    					payment_date:"required",
    					payment_time:"required"
    				},
    				messages:{
    					site_id:"Please select site",
    					payment_amount:"Please enter payment amount",
    					payment_date:"Please enter payment date",
    					payment_time:"Please select payment time"
    				},
    				submitHandler:function(form){
    					if(clicked==false){
    						form.submit();
    						//alert("submit the form");
    						clicked=true;
    						
    					}
    				}
    			});
    		});
    	</script>

    </body>
</html>