<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Mix Design List</title>
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
                                    <li class="breadcrumb-item"><a href="#">QC Department</a></li>
                                    <li class="breadcrumb-item active">Mix Design</li>
                                    <li class="breadcrumb-item active">Mix Design List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Mix Design List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                <div class="row">
                    <div class="col-sm-4">
                        <a href="AddMixDesign.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Add Mix Design</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
				<div class="row filter-row">
					<div class="col-sm-3 col-xs-6">
	                       <div class="form-group form-focus">
	                           <label class="control-label">Receipe Code</label>
	                               <input class="form-control" placeholder="Enter Receipe Code" id="receipe_code" type="text" name="receipe_code">
	                       </div>
	                   </div>
	                   
	                   <div class="col-sm-3 col-xs-6">
	                       <div class="form-group form-focus">
	                           <label class="control-label">Receipe Name</label>
	                               <input class="form-control" placeholder="Enter Receipe Name" id="receipe_name" type="text" name="receipe_name">
	                       </div>
	                   </div>
	                   <div class="col-sm-3 col-xs-6">
	                       <div class="form-group form-focus">
	                           <label class="control-label">&nbsp;</label>
	                           <a href="#" id="search" class="btn btn-success btn-block"> Search </a>
	                       </div>
	                   </div>
	               </div>
                
                	
                    <div class="col-12">
                        <div class="card-box table-responsive">
                            <h4 style="color: green;">${res}</h4>
							<c:remove var="res"/>
                            <table id="datatable-buttons" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="center">
											Receipe Code
										</th>
										<th class="center">Receipe Name</th>
										<th class="center">Aggr1</th>
										<th class="center">Aggr2</th>
										<th class="center">Aggr3</th>
										<th class="center">Aggr4</th>
										<th class="center">Cem1</th>
										<th class="center">Cem2</th>
										<th class="center">Cem3</th>
										<th class="center">Water</th>
										<th class="center">Admix1</th>
										<th class="center">Admix2</th>
										<th class="center">OPTION</th>
									</tr>
                                </thead>
                                <c:set value="${(empty param.receipe_code)?'':param.receipe_code}" var="receipe_code"/>
                                <c:set value="${(empty param.receipe_name)?'':param.receipe_name}" var="receipe_name"/>
								<sql:query var="mix" dataSource="jdbc/rmc">
									select * from mix_design where recipe_code like if(''=?,'%%',?) and recipe_name like if(''=?,'%%',?)
									<sql:param value="${receipe_code}"/>
									<sql:param value="${receipe_code}"/>
									<sql:param value="${receipe_name}"/>
									<sql:param value="${receipe_name}"/>
								</sql:query>
                                <tbody>
                                <c:forEach var="mix" items="${mix.rows}">
									<tr>
										<td class="center">${mix.recipe_code}</td>
										<td class="center">${mix.recipe_name}</td>
										<td class="center">
											<b>Aggr1 :</b> ${mix.aggregate1_name}<br>
											<b>Amount :</b> ${mix.aggregate1_value}
										</td>
										<td class="center">
											<b>Aggr2 :</b> ${mix.aggregate2_name}<br>
											<b>Amount :</b> ${mix.aggregate2_value}
										</td>
										<td class="center">
											<b>Aggr3 :</b> ${mix.aggregate3_name}<br>
											<b>Amount :</b> ${mix.aggregate3_value}
										</td>
										
										<td class="center">
											<b>Aggr4 :</b> ${mix.aggregate4_name}<br>
											<b>Amount :</b> ${mix.aggregate4_value}
										</td>
										<td class="center">
											<b>Cem1 :</b> ${mix.aggregate5_name}<br>
											<b>Amount :</b> ${mix.aggregate5_value}
										</td>
										<td class="center">
											<b>Cem2 :</b> ${mix.aggregate6_name}<br>
											<b>Amount :</b> ${mix.aggregate6_value}
										</td>
										<td class="center">
											<b>Cem3 :</b> ${mix.aggregate7_name}<br>
											<b>Amount :</b> ${mix.aggregate7_value}
										</td>
										<td class="center">
											<b>Water :</b> ${mix.aggregate8_name}<br>
											<b>Amount :</b> ${mix.aggregate8_value}
										</td>
										<td class="center">
											<b>Admix1 :</b> ${mix.aggregate9_name}<br>
											<b>Amount :</b> ${mix.aggregate9_value}
										</td>
										<td class="center">
											<b>Admix2 :</b> ${mix.aggregate10_name}<br>
											<b>Amount :</b> ${mix.aggregate10_value}
										</td>
										
										<td>
											 <div class="btn-group dropdown">
	                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
	                                            <div class="dropdown-menu dropdown-menu-right">
	                                            	<a class="dropdown-item" href="PrintMixDesign.jsp?action=update&design_id=${mix.design_id}"><i class="fa fa-print mr-2 text-muted font-18 vertical-middle"></i>Print Mix Design</a>
	                                                <a class="dropdown-item" href="AddMixDesign.jsp?action=update&design_id=${mix.design_id}"><i class="mdi mdi-pencil mr-2 text-muted font-18 vertical-middle"></i>Edit Mix Design</a>
	                                                <a class="dropdown-item" href="#delete-model" data-animation="blur" data-plugin="custommodal" onclick="deleteMixDesign('${mix.design_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>Delete Mix Design</a>
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
		                <form class="form-horizontal" action="MixDesignController?action=deleteMixDesign" method="post">
		                	<input type="hidden" name="design_id" id="design_id"/>
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
			function deleteMixDesign(design_id){
				$('#design_id').val(design_id);
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

    </body>
</html>