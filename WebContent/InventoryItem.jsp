<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
    
<!-- Mirrored from coderthemes.com/highdmin/horizontal/form-validation.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 18 Mar 2018 15:57:25 GMT -->
<head>
        <meta charset="utf-8" />
        <title>Add  Inventory Item - ${initParam.company_name}</title>
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
                                    <li class="breadcrumb-item"><a href="#">Inventory</a></li>
                                    <li class="breadcrumb-item"><a href="#">Inventory Item</a></li>
                                </ol>
                            </div>
                            <c:choose>
                            	<c:when test="${param.action=='update'}">
                            		<h4 class="page-title">Update Inventory Item</h4>
                            	</c:when>
                            	<c:otherwise>
                            		<h4 class="page-title">Add Inventory Item</h4>
                            	</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="InventoryItemList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-grid"></i> Item List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="inv_item" dataSource="jdbc/rmc">
                			select * from inventory_item where inv_item_id=?
                			<sql:param value="${param.inv_item_id}"/>
                		</sql:query> 
                		<c:set var="res"/>
                		<c:forEach items="${inv_item.rows}" var="inven_item">
                			<c:set value="${inven_item}" var="res"/>
                		</c:forEach>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="InventoryController?action=UpdateItem" method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="col-sm-12 text-center">
			                        		<h2 style="color: #1f6b75;">Add Inventory Item Information</h2>
			                        	</div>
			                        	<div class="col-sm-3">
			                        		
			                        	</div>
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Item Name <span class="text-danger">*</span> </label>
			                                    <input type="hidden" value="${res.inv_item_id}" name="inv_item_id" id="inv_item_id"> 
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" value="${res.inventory_name}" placeholder="Enter Item Name.." id="inv_item_name" name="inv_item_name"/>
			                                </div>
			                                
			                          <div class="form-group">
	                                    <label>Unit Of Measurement<span class="text-danger">*</span></label>
										<select id="uom" name="uom" required="required"  class="select2"  data-placeholder="Choose Vehicle">
											<option value="tonn" ${(res.item_unit=='tonn')?'selected':''} class="text-uppercase">Tonn</option>
											<option value="litre" ${(res.item_unit=='litre')?'selected':''} class="text-uppercase">Litre</option>
											<option value="kg" ${(res.item_unit=='kg')?'selected':''} class="text-uppercase">Kg</option>
										</select>
	                                </div>
			                                <div class="form-group">
			                                    <div>
			                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
			                                            Save
			                                        </button>
			                                        <a href="DriverList.jsp" class="btn btn-light waves-effect m-l-5">
			                                            Cancel
			                                        </a>
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
		                    	<form class="" action="InventoryController?action=InsertInventoryItem" method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="col-sm-12 text-center">
			                        		<h2 style="color: #1f6b75;">Add Inventory Item Information</h2>
			                        	</div>
			                        	<div class="col-sm-3">
			                        		
			                        	</div>
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Item Name <span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Item Name.." id="inv_item_name" name="inv_item_name"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                
			                            <!-- Get all unit of measurement -->
			                            <sql:query var="unit" dataSource="jdbc/rmc">
			                            	select * from unit
			                            </sql:query>
	                                    <label>Unit Of Measurement<span class="text-danger">*</span></label>
										<select id="uom"  name="uom" required="required"  class="select2"  data-placeholder="Choose Vehicle">
											<c:forEach items="${unit.rows}" var="unit">
												<option value="${unit.unit_name}">${unit.unit_name}</option>
											</c:forEach>
										</select>
	                                </div>
			                               
			                                <div class="form-group text-center">
			                                    <div>
			                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
			                                            Save
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
				}); 
            });
        </script>

    </body>
</html>