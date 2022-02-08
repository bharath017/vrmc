<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Business Group - ${initParam.company_name}</title>
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
        <link rel="stylesheet" href="assets/css/select2.min.css" />
		
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
                                    <li class="breadcrumb-item"><a href="#">Other</a></li>
                                    <li class="breadcrumb-item active">General Setting</li>
                                    <li class="breadcrumb-item active">Business Group</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Business Group</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

				
				<sql:query var="group" dataSource="jdbc/rmc">
					select * from business_group
				</sql:query>
				<h4 class="text-success">${res}</h4>
				<c:remove var="res"/>
                <div class="row">
                	<div class="col-3"></div>
                    <div class="col-6 text-center">
                    	<a href="AddGrade.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-toggle="modal" data-target="#add-comp" data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Add Business Group</a>
                    	<table class="table table-bordered">
                    		<thead>
                    			<tr style="background-color: #1a82cc; color: white;">
                    				<th>S/L No</th>
                    				<th>Group Name</th>
                    				<th>Group Description</th>
                    				<th>Option</th>
                    			</tr>
                    		</thead>
                    		<tbody>
                    			<c:set value="0" var="count"/>
                    			<c:forEach items="${group.rows}" var="group">
                    				<c:set value="${count+1}" var="count"/>
                    				<tr>
                    					<td>${count}</td>
                    					<td>${group.group_name}</td>
                    					<td>${group.group_description}</td>
										<td>
											<a href="#delete-model" class="text-danger" onclick="deleteBusinessGroup('${group.business_id}','${group.group_name}');" data-animation="blur" data-plugin="custommodal"  data-overlaySpeed="100" data-overlayColor="#36404a">
												<i class="fa fa-trash"></i>
											</a>
										</td>                    					
                    				</tr>
                    			</c:forEach>
                    		</tbody>
                    	</table>
                    </div>
                </div>
                <!-- end row -->


				 <!-- Delete of gst percent  -->
				<div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #491136;">Delete Business Group : <span class="group_name"></span> </h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" method="post" action="SettingController?action=DeleteBusinessGroup">
		                	<input type="hidden" name="business_id" id="business_id"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">DELETE</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  PLANT DELETE MODAL END  -->
             
                <!-- MODAL FOR GRADE DETAILS -->
				<div id="add-comp"  class="modal fade" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true" style="display: none;">
                      <div class="modal-dialog" >
                          <div class="modal-content" style="width: 100%;">

                              <div class="modal-body" >
                                  <h2 class="text-uppercase text-center m-b-30 text-success">
                                     Add Business Group
                                  </h2>

                                  <form class="form-horizontal" action="SettingController?action=addBusinessGroup" method="post">

                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Business Group Name</label>
	                                              <input class="form-control" type="text" id="group_name" name="group_name" required="" placeholder="Enter Business Group Name">
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Group Description</label>
	                                              <input class="form-control" type="text" id="group_description" name="group_description" placeholder="Enter Group Description">
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
                
                <!--END FOR GRADE MODAL  -->

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
        <!-- Selection table -->
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
        <script src="assets/js/select2.min.js"></script>
        <script type="text/javascript">
			function deleteBusinessGroup(business_id,group_name){
				$('.group_name').html(group_name);
				$('#business_id').val(business_id);
			}
		</script>
		
		<script type="text/javascript">
            $(document).ready(function() {
                $('.select2').css('width','60%').select2({allowClear:true})
				.on('change', function(){
				}); 
            });
        </script>
        
        
        

    </body>
</html>