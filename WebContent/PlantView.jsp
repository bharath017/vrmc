<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>View Plant Detail's</title>
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
        <link rel="stylesheet" href="assets/css/render.css">
		<!-- Custom box css -->
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <script src="assets/js/modernizr.min.js"></script>
        <link href="assets/jquery-toast/jquery.toast.min.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
        	.customer-table tr th:first-child,.table th {
					background-color: #13b2b5;
					color: white;
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
                		&nbsp;
                	</div>
                </div>
                <div class="row">
                	<div class="col-sm-12">
                        <div class="col-sm-3 pull-left">
                        	<br>
                          	<a href="AddPlant.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Add Plant</a>
                          	<a href="PlantList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Plant List</a>
                        </div>
                        <h4>${result}</h4>
                        <c:remove var="result"/>
                	</div>
                </div>
                
             	<div class="row">
             		<div class="col-md-12">
                        <div class="card-box">
                            <div class="tab-content">
                                <div class="tab-pane show active" id="home1">
                                	<sql:query var="details" dataSource="jdbc/rmc">
		                           		select * from plant where plant_id=?
		                           		<sql:param value="${param.plant_id}"/>
		                           	</sql:query>
		                           	
		                         	<c:forEach items="${details.rows}" var="details">
		                         		<c:set value="${details}" var="rs"/>
		                         	</c:forEach>
		                         	
		                         	<input type="hidden" name="plant_id_view" id="plant_id_view" value="${param.plant_id}">
                                    <div class="col-sm-12">
		                           		<div class="col-sm-12 row">
		                           			<div class="col-sm-5 table-responsive">
			                           			<table class="table table-bordered customer-table">
			                           				<thead>
			                           					<tr>
			                           						<th class="text-center" colspan="2" style="background-color: #866d87;color: white;">Plant Detail's</th>
			                           					</tr>
			                           				</thead>
			                           				<tbody>
			                           					<tr>
				                           					<th style="width:40%;">Name : </th>
				                           					<td style="width: 60%;">${rs.plant_name}</td>
				                           				</tr>
				                           				<tr>
				                           					<th>Address : </th>
				                           					<td>${rs.plant_address}</td>
				                           				</tr>
				                           				<tr>
				                           					<th>Phone No : </th>
				                           					<td>${rs.plant_phones}</td>
				                           				</tr>
				                           				<tr>
				                           					<th> Email : </th>
				                           					<td>${rs.plant_email}</td>
				                           				</tr>
				                           				<tr>
				                           					<th>GSTIN No : </th>
				                           					<td>${rs.plant_gstin}</td>
				                           				</tr>
				                           				<tr>
				                           					<th>PAN No : </th>
				                           					<td>${rs.plant_panno}</td>
				                           				</tr>
				                           				<tr>
				                           					<th>Status : </th>
				                           					<td>${rs.plant_status}</td>
				                           				</tr>
				                           				<tr style="background-color: white !important;">
				                           					<td colspan="2">
				                           						 <div class="checkbox checkbox-custom">
						                                            <input id="checkbox11" name="isAutoInventory" ${(rs.isAutoInventory==true)?'selected':''}  type="checkbox">
						                                            <label for="checkbox11">
						                                                Automatic weight is required for inventory ?
						                                            </label>
						                                         </div>
				                           					</td>
				                           				</tr>
				                           				<tr>
				                           					<td colspan="2">
				                           						<div class="checkbox checkbox-custom">
						                                            <input id="checkbox111" name="isAutoDC"  type="checkbox">
						                                            <label for="checkbox111">
						                                                Automatic weight is required for DC ?
						                                            </label>
						                                        </div>
				                           					</td>
				                           				</tr>
				                           				<tr>
				                           					<td style="background-color: white;" colspan="2" class="text-center">
				                           						<a href="AddPlant.jsp?action=update&plant_id=${param.plant_id}" class="btn btn-success">Edit</a>
				                           					</td>
				                           				</tr>
			                           				</tbody>
			                           			</table>
			                           		</div>
			                           		<div class="col-sm-6 table-responsive">
			                           			<table class="table table-bordered">
			                           				<thead>
			                           					<tr>
			                           						<th colspan="5" class="text-center" style="background-color: #866d87;color: white;">Delivery Addresses</th>
			                           					</tr>
			                           					<tr>
			                           						<th>S/L No.</th>
			                           						<th>Delivery Address</th>
			                           						<th>Status</th>
			                           						<th>Action</th>
			                           					</tr>
			                           				</thead>
			                           				<sql:query var="addr" dataSource="jdbc/rmc">
			                           					select * from plant_delivery_address where plant_id=?
			                           					<sql:param value="${rs.plant_id}"/>
			                           				</sql:query>
			                           				<tbody>
			                           					<c:set value="0" var="count"/>
			                           					<c:forEach var="addr" items="${addr.rows}">
			                           					<c:set value="${count+1}" var="count"/>
			                           					<tr class="${(addr.status=='inactive')?'text-danger':''}">
			                           						<td>${count}</td>
			                           						<td style="w">${addr.delivery_address}</td>
			                           						<td>${addr.status}</td>
			                           						<td>
			                           							<button onclick="updateDeliveryAddress('${addr.pl_delivery_add_id}');" data-toggle="modal" data-target="#update-site" class="btn btn-icon waves-effect waves-light btn-success">
			                           								<i class="fa fa-edit"></i>
			                           							</button>
			                           							
			                           							<a href="#delete-model" onclick="changeDeliveryStatus('${addr.pl_delivery_add_id}')" data-animation="blur" title="${(addr.status=='active')?'Deactivate this delivery address':'Activate this delivery address'}"  data-plugin="custommodal" data-overlaySpeed="100" data-overlayColor="#36404a" class="btn btn-icon waves-effect waves-light ${(addr.status=='active')?'btn-danger':'btn-success'}">
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
				                           							<c:if test="${not empty param.plant_id}">
				                           								<button class="btn btn-info" data-toggle="modal" data-target="#add-site-details" >ADD NEW DELIVERY ADDRESS</button>
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
                                    Add Delivery Address
                                  </h2>

                                  <form class="form-horizontal" action="PlantController?button=InsertDeliveryAddress" method="post">

                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Delivery Address</label>
	                                              <input type="hidden" name="plant_id" value="${param.plant_id}"/>
	                                              <textarea class="form-control" pattern="[^'&quot;:]*$"  id="delivery_address" name="delivery_address" required="required" placeholder="Enter Delivery Address.."></textarea>
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
                                   Update Plant Delivery Address
                                  </h2>

                                  <form class="form-horizontal" action="PlantController?button=UpdatePlantDeliveryAddress" method="post">

                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Site Address</label>
	                                              <input type="hidden" name="plant_id" value="${param.plant_id}"/>
	                                              <input type="hidden" name="pl_delivery_address_id" id="pl_delivery_address_id"/>
	                                              <textarea class="form-control" pattern="[^'&quot;:]*$"  id="delivery_address_update" name="delivery_address" required="required" placeholder="Enter Delivery Address"></textarea>
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      
                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                               <button type="submit" id="comp_save" class="btn btn-custom waves-effect waves-light">
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
			            <h4 class="custom-modal-title" style="color: white;background-color: #491136;"><span class="show_status text-uppercase"></span>Change Delivery Address Status<span class="site_name"></span> </h4>
			            <div class="custom-modal-text">
			                <form class="form-horizontal" action="PlantController?button=changeStatus" method="post">
			                	<input type="hidden" id="pl_delivery_address_id_status" name="pl_delivery_address_id">
			                	<input type="hidden" name="plant_id" value="${param.plant_id}"/>
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
        <script type="text/javascript" src="js/plant/PlantView.js"></script>
		<script src="assets/jquery-toast/jquery.toast.min.js"></script>
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
        	function updateDeliveryAddress(pl_delivery_address_id){
        		$.ajax({
        			type:'post',
        			url:'PlantController?button=getDeliveryAddressDetails&pl_delivery_address_id='+pl_delivery_address_id,
        			headers:{
        				Accept:"application/json;charset=utf-8",
        				"Content-Type":"application/json;charset=utf-8"
        			},
        			success:function(res){
        				$('#delivery_address_update').val(res.delivery_address);
        				$('#pl_delivery_address_id').val(res.pl_delivery_address_id);
        			}
        		});
        	}
        </script>
       
       <script type="text/javascript">
       		function changeDeliveryStatus(pl_delivery_address_id){
       			$('#pl_delivery_address_id_status').val(pl_delivery_address_id);
       		}
       </script>

    </body>
</html>