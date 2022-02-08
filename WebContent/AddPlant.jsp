<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
    
<!-- Mirrored from coderthemes.com/highdmin/horizontal/form-validation.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 18 Mar 2018 15:57:25 GMT -->
<head>
        <meta charset="utf-8" />
        <title>Add Plant - ${initParam.company_name}</title>
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
                            <h4 class="page-title">Add New Plant</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="PlantList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Plant List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="plant" dataSource="jdbc/rmc">
                			select * from plant where plant_id=?
                			<sql:param value="${param.plant_id}"/>
                		</sql:query> 
                		<c:set var="res"/>
                		<c:forEach items="${plant.rows}" var="plant">
                			<c:set value="${plant}" var="res"/>
                		</c:forEach>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="PlantController?button=update" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                           		<div class="form-group">
			                                    <label>Business Group <span class="text-danger">*</span> </label>
			                                    <sql:query var="group" dataSource="jdbc/rmc">
			                                    	select business_id,group_name from business_group 
			                                    </sql:query>
			                                   	<select name="business_id" id="business_id"  class="form-control">
			                                   		<c:forEach items="${group.rows}" var="group">
			                                   			<option value="${group.business_id}"
			                                   			    ${(group.business_id==res.business_id)?'selected':''}>
			                                   				${group.group_name}</option>
			                                   		</c:forEach>
			                                   	</select>
			                                </div>
			                                
			                               	<div class="form-group">
			                                    <label>Plant Name : </label>
			                                    <input type="hidden" name="plant_id" value="${res.plant_id}" id="plant_id"/>
			                                    <input type="text" class="form-control" required
			                                        value="${res.plant_name}"  pattern="[^'&quot;:]*$" placeholder="Enter Plant Name" id="name" name="plant_name"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Plant Address : </label>
			                                    <input type="text" class="form-control" required
			                                       value="${res.plant_address}"   pattern="[^'&quot;:]*$"  placeholder="Enter Plant Address"  id="plant_address" name="plant_address"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Plant Phones : </label>
			                                    <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$"  value="${res.plant_phones}" placeholder="Enter Plant Phone.."  id="plant_phone" name="plant_phone"/>
			                                </div>
			                                
			
			                                <div class="form-group">
			                                    <label>Plant Email : </label>
			                                    <div>
			                                        <input type="email" class="form-control" 
			                                           value="${res.plant_email}"  pattern="[^'&quot;:]*$"  parsley-type="email" placeholder="Ex : example@example.com" id="plant_email" name="plant_email"/>
			                                    </div>
			                                </div>
			                                <div class="form-group">
			                                    <label>Plant Domain : </label>
			                                    <div>
			                                        <input parsley-type="url" type="url" class="form-control"
			                                            pattern="[^'&quot;:]*$" value="${res.plant_domain}" id="plant_domain" name="plant_domain"   placeholder="Enter domain name.."/>
			                                    </div>
			                                </div>
			                               </div>
			                               <div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Plant GSTIN : </label>
			                                    <div>
			                                       <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Plant Address" value="${res.plant_gstin}"  id="plant_gstin" name="plant_gstin"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Plant CST No : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Plant CST No." value="${res.plant_cst}"  id="plant_cst" name="plant_cst"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>PAN No : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Plant PAN No." value="${res.plant_panno}"  id="plant_panno" name="plant_panno"/>
			                                    </div>
			                                </div>
			                                
			                                 <div class="form-group">
			                                    <label>Plant Transport : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Plant Transport " value="${res.plant_transport}"  id="plant_transport" name="plant_transport"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Registration No : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Regt. No" value="${res.plant_regno}"  id="plant_regno" name="plant_regno"/>
			                                    </div>
			                                </div>
			                                <div class="form-group">
			                                    <label>Delivery Address : </label>
			                                    <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Delivery Address" value="${res.delivery_address}"  id="delivery_address" name="delivery_address"/>
			                                </div>
			                                <div class="form-group">
			                                	&nbsp;&nbsp;&nbsp;<br><br><br><br>
			                                </div>
			                               
			                                <div class="form-group">
			                                    <div>
			                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
			                                            Submit
			                                        </button>
			                                        <a href="PlantList.jsp" class="btn btn-light waves-effect m-l-5">
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
		                    	<form class="" action="PlantController?button=insert" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                           		
			                           		<div class="form-group">
			                                    <label>Business Group <span class="text-danger">*</span> </label>
			                                    <sql:query var="group" dataSource="jdbc/rmc">
			                                    	select business_id,group_name from business_group 
			                                    </sql:query>
			                                   	<select name="business_id" id="business_id"  class="form-control">
			                                   		<c:forEach items="${group.rows}" var="group">
			                                   			<option value="${group.business_id}">${group.group_name}</option>
			                                   		</c:forEach>
			                                   	</select>
			                                </div>
			                           		
			                               	<div class="form-group">
			                                    <label>Plant Name <span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Plant Name" id="name" name="plant_name"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Plant Address <span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Plant Address"  id="plant_address" name="plant_address"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Plant Phones <span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Plant Phone.."  id="plant_phone" name="plant_phone"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Plant Email : </label>
			                                    <div>
			                                        <input type="email" class="form-control" 
			                                             pattern="[^'&quot;:]*$"  parsley-type="email" placeholder="Ex : example@example.com" id="plant_email" name="plant_email"/>
			                                    </div>
			                                </div>
			                                <div class="form-group">
			                                    <label>Plant Domain : </label>
			                                    <div>
			                                        <input parsley-type="url" type="url" class="form-control"
			                                            pattern="[^'&quot;:]*$" id="plant_domain" name="plant_domain"   placeholder="Enter domain name.."/>
			                                    </div>
			                                </div>
			                               </div>
			                               <div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Plant GSTIN <span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Plant Address" required  id="plant_gstin" name="plant_gstin"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Plant CST No : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Plant CST No."  id="plant_cst" name="plant_cst"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>PAN No : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Plant PAN No."  id="plant_panno" name="plant_panno"/>
			                                    </div>
			                                </div>
			                                
			                                 <div class="form-group">
			                                    <label>Plant Transport : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Plant Transport"  id="plant_transport" name="plant_transport"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Registration No : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Regt. No"  id="plant_regno" name="plant_regno"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Delivery Address : </label>
			                                    <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Delivery Address"  id="delivery_address" name="delivery_address"/>
			                                </div>
			                                <div class="form-group">
			                                	&nbsp;&nbsp;&nbsp;<br><br><br><br>
			                                </div>
			                               
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

    </body>
</html>