<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Marketing Person List</title>
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
                                    <li class="breadcrumb-item"><a href="#">Other</a></li>
                                    <li class="breadcrumb-item active">Marketing Person</li>
                                    <li class="breadcrumb-item active">Marketing Person List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Marketing Person List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                <div class="row">
                    <div class="col-sm-4">
                        <a href="AddMarketingPerson.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Add Marketing Person</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
				
                <div class="row">
                	<div class="col-12">
                		<c:set var="alphabet" value="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z" />
                		<div class="btn-group mb-2 table-responsive">
                			<a href="MarketingPersonList.jsp" class="btn waves-light waves-effect ${(empty param.alp)?'btn-primary':'btn-light'} ">ALL MARKETERS</a>
                			<c:forTokens var="letter" items="${alphabet}" delims=",">
							  	<a href="MarketingPersonList.jsp?alp=${letter}" class="btn btn-light waves-effect ${(param.alp==letter)?'btn-primary':'btn-light'}">${letter}</a> 
							</c:forTokens>
                             <!-- 
                             <button type="button" class="btn btn-light waves-effect">3</button> -->
                        </div>
                	</div>
                    <div class="col-12">
                        <div class="card-box table-responsive">
                            <h4 style="color: green;">${result}</h4>
                            <%session.removeAttribute("result");%>
                            <table id="datatable-buttons" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="center">
											Name
										</th>
										<th class="center">Address</th>
										<th class="center">Phone</th>
										<th class="center">Email</th>
										<th class="center">Pan No</th>
										<th class="center">Adhar No</th>
										<th class="center">A/C No</th>
										<th class="center">IFSC Code</th>
										<th class="center">OPTION</th>
									</tr>
                                </thead>
								<c:choose>
									<c:when test="${empty param.alp}">
										<sql:query var="market" dataSource="jdbc/rmc">
											select * from marketing_person order by mp_name asc
										</sql:query>
									</c:when>
									<c:otherwise>
										<sql:query var="market" dataSource="jdbc/rmc">
											select * from marketing_person where mp_name like '${param.alp}%' order by mp_name asc
										</sql:query>
									</c:otherwise>
								</c:choose>
                                <tbody>
                                <c:forEach var="market" items="${market.rows}">
									<tr class="${(market.mp_status=='inactive')?'text-danger':''}">
										<td class="center">${market.mp_name}</td>
										<td class="center">${market.mp_address}</td>
										<td class="center">
											${market.mp_phone}
										</td>
										<td class="center">
											${market.mp_email}
										</td>
										<td class="center">
											${market.mp_panno}
										</td>
										
										<td class="center">
											${market.mp_adharno}
										</td>
										<td class="center">
											${(market.mp_type=='marketing_head')?'BDM':'Sales Person'}
										</td>
										<td class="center">
											${market.mp_ifsc}
										</td>
										<td>
											 <div class="btn-group dropdown">
	                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
	                                            <div class="dropdown-menu dropdown-menu-right">
	                                                <a class="dropdown-item" href="AddMarketingPerson.jsp?action=update&mp_id=${market.mp_id}"><i class="mdi mdi-pencil mr-2 text-muted font-18 vertical-middle"></i>Edit Marketing Person</a>
	                                                <a class="dropdown-item" href="#delete-model" data-animation="blur" data-plugin="custommodal" onclick="changeStatus('${market.mp_id}','${market.mp_name}','${(market.mp_status=='active')?'inactive':'active'}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>${(market.mp_status=='active')?'Deactivate':'Activate'}</a>
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
		            <h4 class="custom-modal-title" style="color: white;background-color: #915d2a;"><span class="change_status text-uppercase"></span> Marketing Person <span class="mp_name"></span></h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="MarketingPersonController?action=changeMarketingStatus" method="post">
		                	<input type="hidden" name="mp_id" id="mp_id"/>
		                	<input type="hidden" name="mp_status" id="mp_status">
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit"><span class="change_status text-uppercase"></span></button>
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
			function changeStatus(mp_id,mp_name,status){
				$('.change_status').text(status);
				$('.mp_name').text(mp_name);
				$('#mp_status').val(status);
				$('#mp_id').val(mp_id);
			}
		</script>

    </body>
</html>