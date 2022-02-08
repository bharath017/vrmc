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
        <link rel="shortcut icon" href="../assets/images/favicon.ico">

        <!-- App css -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css2/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="../assets/css/select2.min.css" />
		<!-- Custom box css -->
        <link href="../plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <script src="../assets/js/modernizr.min.js"></script>
        <style type="text/css">
        	.customer-table tr td:first-child,.table th {
					background-color: #fff76b;
					color: black;
				}
        </style>

    </head>

    <body>

        <!-- Navigation Bar-->
        	<%@ include file="../header.jsp" %>
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
                                    <li class="breadcrumb-item"><a href="#">Customer &amp; PO</a></li>
                                    <li class="breadcrumb-item"><a href="#">Customer</a></li>
                                    <li class="breadcrumb-item"><a href="#">Address &amp; Details</a></li>
                                </ol>
                            </div>
                            <a href="CustomerList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Customer List</a>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
             	<div class="row">
                   <div class="col-sm-12">
                        <div class="card-box row col-sm-12">
                           	<div class="col-sm-12">
                           		<div class="col-sm-8">
                           			<div class="form-group">
		                                   <label>Choose Customer to Add or Modify Address<span class="text-danger">*</span></label>
		                                   <sql:query var="customer" dataSource="jdbc/rmc">
		                                   		select * from test_customer order by customer_name asc
		                                   </sql:query>
										<select id="customer_id"    class="select2"  data-placeholder="Choose Customer">
											<option value="">&nbsp;</option>
											<c:forEach var="customer" items="${customer.rows}">
											<option value="${customer.customer_id}" ${(customer.customer_id==customer_id)?'selected':''}>${customer.customer_name}</option>
											</c:forEach>
										</select>
		                            </div>
                           		</div>
                           	</div>
                           	<sql:query var="details" dataSource="jdbc/rmc">
                           		select * from test_customer where customer_id=?
                           		<sql:param value="${customer_id}"/>
                           	</sql:query>
                           	
                         	<c:forEach items="${details.rows}" var="details">
                         		<c:set value="${details}" var="rs"/>
                         	</c:forEach>
                           	<div class="col-sm-12">
                           		<div class="col-sm-12 row">
                           			<div class="col-sm-5">
	                           			<table class="table table-bordered customer-table">
	                           				<tr>
	                           					<td style="width:40%;">Name : </td>
	                           					<td style="width: 60%;">${rs.customer_name}</td>
	                           				</tr>
	                           				<tr>
	                           					<td>Address : </td>
	                           					<td>${rs.customer_address}</td>
	                           				</tr>
	                           				<tr>
	                           					<td>Phone No : </td>
	                           					<td>${rs.customer_phone}</td>
	                           				</tr>
	                           				<tr>
	                           					<td> Email : </td>
	                           					<td>${rs.customer_email}</td>
	                           				</tr>
	                           				<tr>
	                           					<td>GSTIN No : </td>
	                           					<td>${rs.customer_gstin}</td>
	                           				</tr>
	                           				<tr>
	                           					<td>PAN No : </td>
	                           					<td>${rs.customer_panno}</td>
	                           				</tr>
	                           				<tr>
	                           					<td>Status : </td>
	                           					<td>${rs.customer_status}</td>
	                           				</tr>
	                           			</table>
	                           		</div>
	                           		<div class="col-sm-7">
	                           			<h4 class="text-success">${res}</h4>
	                           			<%session.removeAttribute("res");%>
	                           			<table class="table table-bordered">
	                           				<thead>
	                           					<tr>
	                           						<th>S/L No.</th>
	                           						<th>Site Name</th>
	                           						<th>Site Address</th>
	                           						<th>Tally Ledger</th>
	                           						<th>Site Status</th>
	                           						<th>Action</th>
	                           					</tr>
	                           				</thead>
	                           				<sql:query var="addr" dataSource="jdbc/rmc">
	                           					select * from test_site_detail where customer_id=?
	                           					<sql:param value="${rs.customer_id}"/>
	                           				</sql:query>
	                           				<tbody>
	                           					<c:set value="0" var="count"/>
	                           					<c:forEach var="addr" items="${addr.rows}">
	                           					<c:set value="${count+1}" var="count"/>
	                           					<tr class="${(addr.site_status=='inactive')?'text-danger':''}">
	                           						<td>${count}</td>
	                           						<td>${addr.site_name}</td>
	                           						<td style="w">${addr.site_address}</td>
	                           						<td style="w">${addr.tally_ladger}</td>
	                           						<td>${addr.site_status}</td>
	                           						<td>
	                           							<button onclick="updateCustomerAddress('${addr.site_id}');" data-toggle="modal" data-target="#update-site" class="btn btn-icon waves-effect waves-light btn-success">
	                           								<i class="fa fa-edit"></i>
	                           							</button>
	                           							
	                           							<a href="#delete-model" data-animation="blur" onclick="changeAddressStatus('${addr.site_id}','${addr.site_name}','${(addr.site_status=='active')?'inactive':'active'}');" data-plugin="custommodal" data-overlaySpeed="100" data-overlayColor="#36404a" class="btn btn-icon waves-effect waves-light btn-danger">
	                           								<i class="fa fa-window-close"></i>
	                           							</a>
	                           						</td>
	                           					</tr>
	                           					</c:forEach>
	                           				</tbody>
	                           				<c:if test="${not empty res.customer_id || res.customer_id!=0}">
	                           					<tfoot>
		                           					<tr>
		                           						<td colspan="6" class="text-center">
		                           							<c:if test="${not empty customer_id}">
		                           								<button class="btn btn-info" data-toggle="modal" data-target="#add-site-details" >CLICK HERE TO ADD NEW SITE</button>
		                           							</c:if>
		                           						</td>
		                           					</tr>
		                           				</tfoot>
	                           				</c:if>
	                           			</table>
	                           		</div>
                           		</div>
                           	</div>
                       	</div>
                   </div>
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

                                  <form class="form-horizontal" action="../CustomerControllerTest?action=addSiteDetails" method="post">

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

                                  <form class="form-horizontal" action="../CustomerControllerTest?action=updateSiteDetails" method="post">

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
			                <form class="form-horizontal" action="../CustomerControllerTest?action=changeSiteStatus" method="post">
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
                  


        <!-- Footer -->
       <%@ include file="../footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/popper.min.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/waves.js"></script>
        <script src="../assets/js/jquery.slimscroll.js"></script>

        <!-- Parsley js -->
        <script type="text/javascript" src="../plugins/parsleyjs/parsley.min.js"></script>

        <!-- App js -->
        <script src="../assets/js/jquery.core.js"></script>
        <script src="../assets/js/jquery.app.js"></script>
        <script src="../assets/js/select2.min.js"></script>
        <script src="../plugins/custombox/js/custombox.min.js"></script>
        <script src="../plugins/custombox/js/legacy.min.js"></script>
		
        <script type="text/javascript">
            $(document).ready(function() {
                $('form').parsley();
                
                $('.select2').css('width','100%').select2({allowClear:true})
				.on('change', function(){
				}); 
            });
        </script>
        <script type="text/javascript">
        	$(document).ready(function(){
        		$('#customer_id').on("change",function(){
        			var customer_id=$('#customer_id').val();
        			$.ajax({
                		type:'POST',
                		url:'../CustomerControllerTest?action=changeCustomer&customer_id='+customer_id,
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
        			url:'../CustomerControllerTest?action=getSiteDetailsForUpdate&site_id='+site_id,
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

    </body>
</html>