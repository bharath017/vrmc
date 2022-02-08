<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>New Customer</title>
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

        <script src="assets/js/modernizr.min.js"></script>

    </head>

    <body>

        <!-- Navigation Bar-->
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
                                    <li class="breadcrumb-item"><a href="#">Add Plant</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Add Customer</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="ClientList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Client List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="customer" dataSource="jdbc/rmc">
                			select * from clint where clint_id=?
                			<sql:param value="${param.clint_id}"/>
                		</sql:query> 
                		<c:forEach items="${customer.rows}" var="customer">
                			<c:set value="${customer}" var="rs"/>
                		</c:forEach>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="ClintController?action=UpdateClient" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Client Name <span class="text-danger">*</span></label>
			                                         <input type="hidden" class="form-control" value="${rs.clint_id}" name="clint_id"/>
			                               
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Client Name" value="${rs.clint_name}" name="clint_name"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Client Phone <span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Client Phone"  maxlength="10" value="${rs.clint_phone}"  name="clint_phone"/>
			                                </div>
			                                
			                                 <div class="form-group">
			                                    <label>Customer Address <span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Customer Address" required="required" value="${rs.customer_address}" name="customer_address"/>
			                                    </div>
			                                </div>
			                             	<div class="form-group">
			                                    <label>Contractor Name </label>
			                                    <input type="text" class="form-control" 
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Customer Name"  name="contractor_name" value="${rs.contractor_name}"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Contractor Phone  </label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Contractor Phone"  maxlength="10"   name="contractor_phone" value="${rs.contractor_phone}"/>
			                                </div>
			                                
			                               	<div class="form-group">
			                                    <label>Architect Name </label>
			                                    <input type="text" class="form-control"
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Architect Name"  name="architech_name" value="${rs.architech_name}"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Architect Phone  </label>
			                                    <input type="text" class="form-control"
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Architect Phone"  maxlength="10"   name="architech_phone" value="${rs.architech_phone}"/>
			                                </div>
			                          
			                                <div class="form-group">
			                                    <label>Structural Consultant Name </label>
			                                    <input type="text" class="form-control" 
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Structural Consultant Name"  name="consultent_name" value="${rs.consultent_name}"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Structural Consultant Phone </label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Structural Consultant Phone"  maxlength="10"   name="consultent_phone" value="${rs.consultent_phone}"/>
			                                </div>
			                                
			                                   </div>
			                          <div class="col-sm-6">
			                                
			                               <div class="form-group">
			                                    <label>PMC Name </label>
			                                    <input type="text" class="form-control" 
			                                          pattern="[^'&quot;:]*$" placeholder="Enter PMC Name"  name="pmc_name" value="${rs.pmc_name}"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>PMC Phone  </label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter PMC Phone"  maxlength="10"   name="pmc_phone" value="${rs.pmc_phone}"/>
			                                </div>
			                       
			                                <div class="form-group">
			                                    <label>Total Project Quantity <span class="text-danger">*</span> </label>
			                                    <input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter  Project Quantity" required name="project_quantity" value="${rs.project_quantity}"/>
			                                </div>
			                                <div class="form-group">
			                                    <label>Monthly Requirement <span class="text-danger">*</span></label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Monthly Requirement" required name="monthly_requirnment"  value="${rs.monthly_requirnment}"/>
			                                </div>
			                                
			                                  <div class="form-group">
			                                    <label>Current Supplier <span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Current Supplier" required name="currnet_supplier" value="${rs.currnet_supplier}" />
			                                </div>
			                                  <div class="form-group">
			                                    <label>Stage <span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Stage "  required  name="stage"  value="${rs.stage}" />
			                                </div>
			                             </div>
			                           
		                                <div class="col-sm-12 text-center">
		                                	<div class="form-group">
			                                    <div>
			                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
			                                            Submit
			                                        </button>
			                                        <button type="reset" class="btn btn-light waves-effect m-l-5">
			                                            Cancel
			                                        </button>
			                                    </div>
			                                </div>
		                                </div>
		                        	</div>
		                        </form>
		                    </div>
		                </div>
                	</c:when>
                	<c:otherwise>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="ClintController?action=AddClint" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Client Name <span class="text-danger">*</span></label>
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Client Name" name="clint_name"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Client Phone <span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Client Phone"  maxlength="10"   name="clint_phone"/>
			                                </div>
			                                
			                                 <div class="form-group">
			                                    <label>Customer Address <span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Customer Address" required="required" name="customer_address"/>
			                                    </div>
			                                </div>
			                             	<div class="form-group">
			                                    <label>Contractor Name </label>
			                                    <input type="text" class="form-control" 
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Customer Name"  name="contractor_name"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Contractor Phone  </label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Contractor Phone"  maxlength="10"   name="contractor_phone"/>
			                                </div>
			                                
			                               	<div class="form-group">
			                                    <label>Architect Name </label>
			                                    <input type="text" class="form-control"
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Architect Name"  name="architech_name"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Architect Phone  </label>
			                                    <input type="text" class="form-control"
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Architect Phone"  maxlength="10"   name="architech_phone"/>
			                                </div>
			                          
			                                <div class="form-group">
			                                    <label>Structural Consultant Name </label>
			                                    <input type="text" class="form-control" 
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Structural Consultant Name"  name="consultent_name"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Structural Consultant Phone </label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Structural Consultant Phone"  maxlength="10"   name="consultent_phone"/>
			                                </div>
			                                
			                                   </div>
			                          <div class="col-sm-6">
			                                
			                               <div class="form-group">
			                                    <label>PMC Name </label>
			                                    <input type="text" class="form-control" 
			                                          pattern="[^'&quot;:]*$" placeholder="Enter PMC Name"  name="pmc_name"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>PMC Phone  </label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter PMC Phone"  maxlength="10"   name="pmc_phone"/>
			                                </div>
			                       
			                                <div class="form-group">
			                                    <label>Total Project Quantity <span class="text-danger">*</span> </label>
			                                    <input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter  Project Quantity" required  name="project_quantity"/>
			                                </div>
			                                <div class="form-group">
			                                    <label>Monthly Requirement <span class="text-danger">*</span></label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Monthly Requirement" required name="monthly_requirnment"/>
			                                </div>
			                                
			                                  <div class="form-group">
			                                    <label>Current Supplier<span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Current Supplier" required name="currnet_supplier"/>
			                                </div>
			                                  <div class="form-group">
			                                    <label>Stage <span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Stage "  required  name="stage"/>
			                                </div>
			                             </div>
			                           
		                                <div class="col-sm-12 text-center">
		                                	<div class="form-group">
			                                    <div>
			                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
			                                            Submit
			                                        </button>
			                                        <button type="reset" class="btn btn-light waves-effect m-l-5">
			                                            Cancel
			                                        </button>
			                                    </div>
			                                </div>
		                                </div>
		                        	</div>
		                        </form>
		                    </div>
		                </div>
                	</c:otherwise>
                </c:choose>
                <!-- end row -->

            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->


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
		
        <script type="text/javascript">
            $(document).ready(function() {
                $('form').parsley();
                
                $('.select2').css('width','100%').select2({allowClear:true})
				.on('change', function(){
					$(this).closest('form').validate().element($(this));
				}); 
            });
        </script>
        <script type="text/javascript">
		 $(document).ready(function () {
		    function addRow(){
		        var html = '<tr>'+
								'<td>'+
									'<input type="text" class="form-control" required="required" pattern="[^\'&quot;:]*$"  placeholder="Enter Site Name"   name="site_name"/>'+
								'</td>'+
								'<td>'+
									'<input type="text" class="form-control" required="required"  pattern="[^\'&quot;:]*$"  placeholder="Enter Site Address"   name="site_address"/>'+
								'</td>'+
								'<td>'+
									'<span class="text-danger removebtn"><i class="fa fa-trash"></i></span>'+
								'</td>'+
							'</tr>'
		        $(html).appendTo($("#Table1"))
		    };
		    $("#clicked").on("click", ".BtnPlus", addRow);
		});
		 $('#Table1').on('click', '.removebtn', function(){
			    $(this).closest ('tr').remove ();
		});
		</script>

    </body>
</html>