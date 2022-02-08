<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Invoice List</title>
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
		
		<link rel="stylesheet" href="picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="picker/cs/bootstrap-timepicker.min.css" />
		
        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
		  <!-- Custom box css -->
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/select2.min.css" />
		<link rel="stylesheet" href="assets/css/render.css">
        <script src="assets/js/modernizr.min.js"></script>
        <style type="text/css">
        	.hidden{
        		display: none;
        	}
        </style>
        
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
                                    <li class="breadcrumb-item"><a href="#">Billing</a></li>
                                    <li class="breadcrumb-item active">Invoice</li>
                                    <li class="breadcrumb-item active">Invoice List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Invoice List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                <div class="row">
                    <div class="col-sm-4">
                    
                        <a href="AddInvoice.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Add Invoice</a>
                        
                    </div><!-- end col -->
                </div>
                <!-- end row -->
				<div class="row filter-row">
					<div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">Invoice No</label>
                                <input class="form-control" placeholder="Enter Invoice No" id="invoice_id" type="text" name="invoice_id">
                        </div>
                    </div>
                    <div class="col-sm-2 col-xs-6 form-group">
                        <label>Invoice Date : </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="scheduling_date" class="form-control date-picker invoice_date" placeholder="yyyy-mm-dd" id="id-date-picker-2" data-date-format="yyyy-mm-dd">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Customer : </label>
                            <sql:query var="customer" dataSource="jdbc/rmc">
                            	select * from customer where customer_status='active'
                            </sql:query>
                            <select class="select2 form-control floating" id="customer_id">
                                <option value="">All Customer</option>
                                <c:forEach items="${customer.rows}" var="customer">
                                	<option value="${customer.customer_id}">${customer.customer_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Site : </label>
                            <select class="form-control select2 floating"   id="site_id">
                                <option value="">All Site</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Vehicle</label>
                            <sql:query var="vehicle" dataSource="jdbc/rmc">
                            	select * from vehicle
                            </sql:query>
                            <select class="select2 form-control floating" id="vehicle_no">
                                <option value="">All Vehicle</option>
                                <c:forEach items="${vehicle.rows}" var="vehicle">
                                	<option value="${vehicle.vehicle_no}">${vehicle.vehicle_no}</option>
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
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card-box table-responsive">
                            <h4 style="color: green;">${res}</h4>
                            <c:remove var="res"/>
                            <table id="example" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="center">
											Invoice No
										</th>
										<th class="text-center">Customer</th>
										<th class="text-center" style="width: 25%;">Site</th>
										<th class="text-center">Date</th>
										<th class="text-center">Time</th>
										<th class="text-center">Grade</th>
										<th class="text-center">Quantity</th>
										<th class="text-center">Vehicle</th>
										<th class="text-center">Net Price</th>
										<th class="text-center">Plant</th>
										<th class="text-center">OPTION</th>
									</tr>
                                </thead>
                                <c:set value="${(empty param.invoice_id)?'':param.invoice_id}" var="invoice_id"/>
                                <c:set value="${(empty param.invoice_date)?'':param.invoice_date}" var="invoice_date"/>
                                <c:set value="${(empty param.customer_id)?'':param.customer_id}" var="customer_id"/>
                                <c:set value="${(empty param.site_id)?'':param.site_id}" var="site_id"/>
                                <c:set value="${(empty param.vehicle_no)?'':param.vehicle_no}" var="vehicle_no"/>
								<sql:query var="invoice" dataSource="jdbc/rmc">
									select i.*,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,c.customer_name,s.site_name,p.product_name,pl.plant_name
									from invoice i LEFT JOIN (customer c,site_detail s,purchase_order_item poi,product p,plant pl)
									ON i.customer_id=c.customer_id
									and i.site_id=s.site_id
									and i.poi_id=poi.poi_id
									and poi.product_id=p.product_id
									and i.plant_id=pl.plant_id
									where i.invoice_id like if(''=?,'%%',?)
									and i.invoice_date like if(''=?,'%%',?)
									and i.customer_id like if(''=?,'%%',?)
									and i.site_id like if(''=?,'%%',?)
									and i.vehicle_no like if(''=?,'%%',?)
									and i.plant_id like if(?=0,'%%',?)
									order by i.id desc
									limit 30;
									<sql:param value="${invoice_id}"/>
									<sql:param value="${invoice_id}"/>
									<sql:param value="${invoice_date}"/>
									<sql:param value="${invoice_date}"/>
									<sql:param value="${customer_id}"/>
									<sql:param value="${customer_id}"/>
									<sql:param value="${site_id}"/>
									<sql:param value="${site_id}"/>
									<sql:param value="${vehicle_no}"/>
									<sql:param value="${vehicle_no}"/>
									<sql:param value="${bean.plant_id}"/>
									<sql:param value="${bean.plant_id}"/>
								</sql:query>
                                <tbody>
                                <c:forEach var="invoice" items="${invoice.rows}">
									<tr class="${(invoice.invoice_status=='cancelled')?'text-danger':''}">
										<td class="text-center">${invoice.invoice_id}</td>
										<td class="text-center">${invoice.customer_name}</td>
										<td class="text-center">${invoice.site_name}</td>
										<td class="text-center">${invoice.invoice_date}</td>
										<td class="text-center">${invoice.invoice_time}</td>
										<td class="text-center">${invoice.product_name}</td>
										<td class="text-center">${invoice.quantity}</td>
										<td class="text-center">${invoice.vehicle_no}</td>
										<td class="text-center">${invoice.net_amount}</td>
										<td class="text-center">${invoice.plant_name}</td>
										<td class="text-center">
						<div class="btn-group dropdown">
	                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
	                                            <div class="dropdown-menu dropdown-menu-right"  style="overflow-y: auto; height: 400px;">
	                                                <span class="text-center text-success">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Invoice No : ${invoice.invoice_id}</span>
	                                            	<c:if test="${invoice.invoice_status=='active'}">
	                                            		<a class="dropdown-item" target="_blank" href="PrintInvoice.jsp?id=${invoice.id}"><i class="fa fa-print mr-2 text-muted font-18 vertical-middle"></i>Print Invoice</a>
		                                            	<a class="dropdown-item" href="PrintDC.jsp?id=${invoice.id}"><i class="fa fa-print mr-2 text-muted font-18 vertical-middle"></i>Print DC</a>
								<c:choose>
									<c:when test="${invoice.plant_id==2}">
										<a class="dropdown-item" href="InvoiceController?action=DownloadBatchSheet2&id=${invoice.id}&class=BCMConcrete"><i class="fa fa-print mr-2 text-muted font-18 vertical-middle"></i>Download Batch Sheet</a>
									</c:when>
									<c:otherwise>
										<a class="dropdown-item" href="InvoiceController?action=DownloadBatchSheet&id=${invoice.id}&class=BCMConcrete"><i class="fa fa-print mr-2 text-muted font-18 vertical-middle"></i>Download Batch Sheet</a>
									</c:otherwise>
								</c:choose>
		                                           	    <a class="dropdown-item" href="#" data-toggle="modal" onclick="updateVehicle('${invoice.id}','${invoice.invoice_id}','${invoice.vehicle_no}','${invoice.driver_name}','${invoice.pump}')" data-target="#update-vehicle"><i class="fa fa-truck mr-2 text-muted font-18 vertical-middle"></i>Edit Vehicle &amp; Pump</a>
		                                           	    <a class="dropdown-item" href="#delete-model" data-animation="blur" data-plugin="custommodal" onclick="updateDateTime('${invoice.id}','${invoice.invoice_id}','${invoice.invoice_date}','${invoice.invoice_time}');" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="fa fa-calendar mr-2 text-muted font-18 vertical-middle"></i>Edit Date &amp; Time</a>
		                                           	    <a class="dropdown-item" href="#docket_modal" data-animation="blur" data-plugin="custommodal" onclick="changeDocketNo('${invoice.id}','${invoice.invoice_id}');" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="fa fa-dashcube mr-2 text-muted font-18 vertical-middle"></i>Edit Docket</a>
		                                           	    <a class="dropdown-item" href="EditInvoice.jsp?id=${invoice.id}"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Edit Invoice</a>
		                                           	    <a class="dropdown-item" href="InvoiceController?action=RefreshInvoice&id=${invoice.id}"><i class="fa fa-print mr-2 text-muted font-18 vertical-middle"></i>Refresh Invoice</a>
														<a class="dropdown-item" href="AddCreditDebitNote.jsp?invoice_id=${invoice.id}"><i class="fa fa-window-restore mr-2 text-muted font-18 vertical-middle" aria-hidden="true"></i>Generate Credit/Debit Note</a>		
		                                                <a class="dropdown-item" href="#cancel-model" data-animation="blur" data-plugin="custommodal" onclick="cancelInvoice('${invoice.id}','${invoice.invoice_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>Cancel Invoice</a>
		                                                <a class="dropdown-item" href="#deleteinvoice-model" data-animation="blur" data-plugin="custommodal" onclick="deleteInvoice('${invoice.id}','${invoice.invoice_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="fa fa-trash mr-2 text-muted font-18 vertical-middle"></i>Delete Invoice</a>

	                                            	</c:if>
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
                
                <!-- Update Site Details Here-->
				<div id="update-vehicle"  class="modal fade" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true" style="display: none;">
                      <div class="modal-dialog" >
                          <div class="modal-content" style="width: 100%;">

                              <div class="modal-body" >
                                  <h2 class="text-uppercase text-center m-b-30 text-success">
                                    Update Vehicle &amp; Pump 
                                  </h2>

                                  <form class="form-horizontal" name="update_vehicle" action="InvoiceController?action=UpdateVehicle" method="post">

	                                
	                                <div class="form-group">
	                                    <label>Driver Name <span class="text-danger">*</span></label>
	                                    <sql:query var="driver" dataSource="jdbc/rmc">
	                                    	select * from driver
	                                    </sql:query>
	                                    <input type="hidden" name="id" id="inv_id"/>
	                                    <input type="hidden" name="invoice_id"  id="vehicle_invoice_id"/>
										<select id="driver_name"  name="driver_name"   class="select2"  data-placeholder="Choose Driver">
											<option value="">&nbsp;</option>
											<c:forEach var="driver" items="${driver.rows}">
											<option value="${driver.driver_name}">${driver.driver_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Pump <span class="text-danger">*</span></label>
	                                    <sql:query var="pump" dataSource="jdbc/rmc">
	                                    	select * from pump where type='pump'
	                                    </sql:query>
										<select id="pump"  name="pump"   class="select2"  data-placeholder="Choose Pump">
											<option value="">&nbsp;</option>
											<c:forEach var="pump" items="${pump.rows}">
											<option value="${pump.pump_name}">${pump.pump_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                                <div class="form-group">
	                                    <label>Vehicle No <span class="text-danger">*</span></label>
	                                    <sql:query var="vehicle" dataSource="jdbc/rmc">
	                                    	select * from vehicle
	                                    </sql:query>
										<select id="vch"  name="vehicle_no" required="required"  class="select2"  data-placeholder="Choose Vehicle">
											<option value="">&nbsp;</option>
											<c:forEach var="vehicle" items="${vehicle.rows}">
											<option value="${vehicle.vehicle_no}">${vehicle.vehicle_no}</option>
											</c:forEach>
										</select>
	                                </div>
                                      
                                      <div class="form-group">
                                           <label for="username">comment</label>
                                           <textarea class="form-control" pattern="[^'&quot;:]*$"  id="comment" name="comment" required="required" placeholder="Write Your Comment Here.."></textarea>
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


				<!-- MODAL FOR PLANT DELETE START  -->
				<div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title text-uppercase" style="color: white;background-color: #28afa0;"><b>Update date &amp; time</b></h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="InvoiceController?action=UpdateDateTime" method="post">
		                	<div class="form-group">
                                  <label class="pull-left">Invoice Date <span class="text-danger">*</span> </label>
                                  <div>
                                      <div class="input-group">
                                      	  <input type="hidden" name="id" id="date_id">
                                      	  <input type="hidden" name="invoice_id" class="invoice_id">
                                          <input type="text" name="invoice_date" class="form-control date-picker invoice_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                          <div class="input-group-append">
                                              <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                          </div>
                                      </div>
                                  </div>
                             </div>
                             
                             <div class="form-group">
                                  <label class="pull-left">Invoice Time <span class="text-danger">*</span> </label>
                                  <div>
                                      <div class="input-group">
                                          <input type="text" name="invoice_time" class="form-control invoice_time" required="required" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
                                          <div class="input-group-append">
                                              <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                              
                               <div class="form-group">
                                    <label class="pull-left" for="username">comment <span class="text-danger">*</span></label>
                                    <textarea class="form-control" pattern="[^'&quot;:]*$"  id="comment" name="comment" required="required" placeholder="Write Your Comment Here.."></textarea>
                               </div>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit"><span class="change_status text-uppercase">Update</span></button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Exit</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  PLANT DELETE MODAL END  -->
				<!-- MODAL FOR INVOICE CANCELLATION  -->
				<div id="cancel-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #491136;">Are you sure want to cancel invoice id : <span class="invoice_id_cancel"></span> </h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" method="post" action="InvoiceController?action=CancelInvoice">
		                	<input type="hidden" name="invoice_id" id="invoice_id_cancel"/>
		                	<input type="hidden" name="id" id="id_cancel"/>
		                	<div class="form-group">
                                 <label class="pull-left" for="username">comment <span class="text-danger">*</span></label>
                                 <textarea class="form-control" pattern="[^'&quot;:]*$"  id="comment" name="comment" required="required" placeholder="Write Your Comment Here.."></textarea>
                            </div>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">CANCEL INVOICE</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  END OF INVOICE CANCEL MODAL  -->
                
                <!-- Modal box to set docket no  -->
				<div id="docket_modal" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #c100db;">Set Docket no for invoice id : <span class="invoice_id_docket"></span> </h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" method="post" action="InvoiceController?action=ChangeDocketNo">
		                	<input type="hidden" name="invoice_id" id="invoice_id_docket"/>
		                	<input type="hidden" name="id" id="id_docket"/>
		                	<div class="form-group">
                                 <label class="pull-left" for="username">Docket No <span class="text-danger">*</span></label>
                                 <input type="text" class="form-control" pattern="[^'&quot;:]*$"  id="docket_no" name="docket_no" required="required" placeholder="Write Docket No here.."/>
                            </div>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">SAVE DOCKET NO</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!-- End of docket no modal set -->
				<!-- Set form here to submit the data -->
				
				<!-- MODAL FOR INVOICE DELETION  -->
				<div id="deleteinvoice-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #491136;">Are you sure want to delete invoice id : <span class="invoice_id_delete"></span> </h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" method="post" action="InvoiceController?action=DeleteInvoice">
		                	<input type="hidden" name="invoice_id" id="invoice_id_delete"/>
		                	<input type="hidden" name="id" id="id_delete"/>
		                	<div class="form-group">
                                 <label class="pull-left" for="username">comment <span class="text-danger">*</span></label>
                                 <textarea class="form-control" pattern="[^'&quot;:]*$"  id="comment" name="comment" required="required" placeholder="Write Your Comment Here.."></textarea>
                            </div>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">DELETE INVOICE</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CLOSE</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  END OF INVOICE DELETION MODAL  -->
				
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

        <!-- Required datatable js -->
        <script src="plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="plugins/datatables/dataTables.bootstrap4.min.js"></script>
        <!-- Buttons examples -->
        <script src="plugins/datatables/dataTables.buttons.min.js"></script>
        <script src="plugins/datatables/buttons.bootstrap4.min.js"></script>
        <script src="plugins/datatables/pdfmake.min.js"></script>
        <script src="plugins/datatables/vfs_fonts.js"></script>
        <script src="plugins/datatables/buttons.html5.min.js"></script>
        <script src="plugins/datatables/buttons.print.min.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
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
    		}).next().on('click', function(){
    			$(this).prev().focus();
    		});
        	
        	
            $('.date-picker').datepicker({
   				autoclose: true,
   				todayHighlight: true
   		 	});
   			//show datepicker when clicking on the icon
          });
        </script>

        <script type="text/javascript">
            $(document).ready(function() {

            	  $('#example').DataTable({
            			"order": [],
            	        "info":true,
            	        "scrollX":true,
            	        "processing":true,
            	        "iDisplayLength":10,
            	        "lengthMenu":[10,20,25,50,75,100],
            	        "ordering":false,
            	        "searching":false,
            	        "dom": 'Blfrtip',
            	        "buttons": [
            	            'copyHtml5',
            	            'excelHtml5',
            	            'csvHtml5',
            	            'pdfHtml5'
            	        ],
            	        lengthChange: true
            	  });
                
		  $('.table-responsive').on('shown.bs.dropdown', function (e) {
		
    	  var $table = $(this),
          $menu = $(e.target).find('.dropdown-menu'),
          tableOffsetHeight = $table.offset().top + $table.height(),
          menuOffsetHeight = $menu.offset().top + $menu.outerHeight(true);

      if (menuOffsetHeight+100 > tableOffsetHeight)
        $('.dataTables_scrollBody').css('padding-bottom',(menuOffsetHeight - tableOffsetHeight)+50);
    });

    $('.table-responsive').on('hide.bs.dropdown', function () {
        $('.dataTables_scrollBody').css("padding-bottom", 0);
    })

                
  } );

        </script>
        
        <!-- Modal-Effect -->
        <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>
        <script type="text/javascript">
			function cancelInvoice(id,invoice_id){
				$('#invoice_id_cancel').val(invoice_id);
				$('.invoice_id_cancel').html(invoice_id);
				$('#id_cancel').val(id);
			}
		</script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				 $('.select2').css('width','100%').select2({allowClear:true})
					.on('change', function(){
					}); 
			});
		</script>
		
		<script type="text/javascript">
			$(document).ready(function(){
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
							$('#select2-site_id-container').html('All Site');
							$('#site_id').html('');
			        		$('#site_id').html('<option value="">All Site</option>');
			        		$.each(result, function(index, value) {
			        			   $('#site_id').append("<option value='"+ value.site_id+ "'>" + value.site_name + "</option>");
			        		});
			        		
						}
					});
				});
			});
		</script>
		<script type="text/javascript">
	    $(document).ready(function(){
	    	$('#search').on('click',function(){
	    		var customer_id=$('#customer_id').val();
	    		var site_id=$('#site_id').val();
	    		var invoice_date=$('.invoice_date').val();
	    		var invoice_id=$('#invoice_id').val();
	    		var vehicle_no=$('#vehicle_no').val();
	    		window.location='InvoiceList.jsp?customer_id='+customer_id+'&site_id='+site_id+"&invoice_date="+invoice_date+"&invoice_id="+invoice_id+"&vehicle_no="+vehicle_no;
	    	});
	    });
    </script>
    <script type="text/javascript">
    	function updateVehicle(id,invoice_id,vehicle_no,driver_name,pump){
			$('#select2-vch-container').html(vehicle_no);
			$('#vch').val(vehicle_no);
			$('#pump').val(pump);
			$('#select2-pump-container').html(pump);
			$('#select2-driver_name-container').html(driver_name);
			$('#driver_name').val(driver_name);
			$('#inv_id').val(id);
			$('#vehicle_invoice_id').val(invoice_id);
    	}
    </script>
    <script type="text/javascript">
    	function updateDateTime(id,invoice_id,date,time){
    		$('#date_id').val(id);
    		$('.invoice_id').val(invoice_id);
    		$('.invoice_date').val(date);
    		$('.invoice_time').val();
    	}
    </script>
    
    <script type="text/javascript">
    	function changeDocketNo(id,invoice_id){
    		$('#id_docket').val(id);
    		$('#invoice_id_docket').val(invoice_id);
    		$('.invoice_id_docket').text(invoice_id);
    	}
    	
    	
    	function deleteInvoice(id,invoice_id){
    		$('.invoice_id_delete').text(invoice_id);
    		$('#invoice_id_delete').val(invoice_id);
    		$('#id_delete').val(id);
    	}
    </script>
    </body>
</html>