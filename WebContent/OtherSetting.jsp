<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
    
<!-- Mirrored from coderthemes.com/highdmin/horizontal/form-validation.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 18 Mar 2018 15:57:25 GMT -->
<head>
        <meta charset="utf-8" />
        <title>Diesel Setting</title>
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
                                    <li class="breadcrumb-item"><a href="#">General Settings</a></li>
                                    <li class="breadcrumb-item"><a href="#">Diesel Settings</a></li>
                                </ol>
                            </div>
                          
                            <h4 class="page-title">Diesel Setting</h4>
                            <p class="text-danger"></p>
                       
                            	
                        </div>
                    </div>
                </div>
                
                <!-- Get GST details here -->
                	<sql:query var="gst" dataSource="jdbc/rmc">
                		select * from general_setting
                	</sql:query>
                	<c:forEach items="${gst.rows}" var="gst">
                		<c:set value="${gst}" var="rs"/>
                	</c:forEach>
                <!-- End of gst details here -->
              	<div class="row">
              		<h4 class="text-success">${result}</h4>
              		<%session.removeAttribute("result"); %>
                    <div class="col-sm-12">
                    	<form class="" action="SettingController?action=changeDIESELSetting" method="post">
	                        <div class="card-box row col-sm-12">
	                        	<div class="col-sm-12 text-center">
	                        		<h2 style="color: #1f6b75;">Diesel Setting </h2>
	                        	</div> 	
	                        	<div class="col-sm-3">
	                        		
	                        	</div>
	                        	<!-- Get diesel setting's here -->
	                        	<sql:query var="diesel" dataSource="jdbc/rmc">
	                        		select diesel_id from general_setting
	                        	</sql:query>
	                        	<c:forEach var="diesel" items="${diesel.rows}">
	                        		<c:set value="${diesel}" var="dies"/>
	                        	</c:forEach>
	                           	<div class="col-sm-6">
	                               	<div class="form-group">
                                    <label>Fleet Item <span class="text-danger">*</span></label>
                                    <sql:query var="inv" dataSource="jdbc/rmc">
                                    	select * from inventory_item
                                    </sql:query>
									<select id="fleet_item_id"  name="fleet_item_id" required="required"  class="select2"  data-placeholder="Choose Fleet Item">
										<option value="">&nbsp;</option>
										<c:forEach var="inv" items="${inv.rows}">
										<option value="${inv.inv_item_id}" ${(inv.inv_item_id==dies.diesel_id)?'selected':''}>${inv.inventory_name}</option>
										</c:forEach>
									</select>
                                </div>
	                                
	                               
	                                <div class="form-group">
	                                    <div>
	                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
	                                            Save
	                                        </button>
	                                        <a href="GradeList.jsp" class="btn btn-light waves-effect m-l-5">
	                                            Cancel
	                                        </a>
	                                    </div>
	                                </div>
	                             </div>
                        	</div>
                        </form>
                    </div>
                </div>
                
                
                
                
                
                <c:if test="${usertype=='superadmin'}">
                <div class="row">
                	<div class="col-sm-12">
                		<div class="card-box row col-sm-12">
                			<div class="col-sm-12 text-center">
                        		<h2 style="color: #1f6b75;">Hide Detail's</h2>
                        	</div> 	
                        	<div class="col-sm-3">
                        		
                        	</div>
                        	<div class="col-sm-6 text-center">
                        	
                        		<sql:query var="hide" dataSource="jdbc/rmc">
                        			select (select count(*) from test_invoice where state='hide') as hidecount,
                        			(select count(*) from test_invoice where state='show') as showcount
                        		</sql:query>
                        		<c:set value="0" var="hidecount"/>
                        		<c:set value="0" var="showcount"/>
                        		<c:forEach var="hide" items="${hide.rows}">
                        			<c:set value="${hide.hidecount}" var="hidecount"/>
                        			<c:set value="${hide.showcount}" var="showcount"/>
                        		</c:forEach>
                        		
                        		<form action="InvoiceControllerTest?action=showhide" method="post">
                        			<div class="form-group">
	                                    <div>
	                                        <button type="submit" name="click" value="hide" ${(showcount>0)?'':'disabled'} class="btn ${(showcount>0)?'btn-danger':'btn-default'} waves-effect waves-light">
	                                            HIDE
	                                        </button>
	                                        <button type="submit" name="click" value="show" ${(hidecount>0)?'':'disabled'} class="btn ${(hidecount>0)?'btn-success':'btn-default'} waves-effect m-l-5">
	                                           UNHIDE
	                                        </button>
	                                    </div>
	                                </div>
                        		</form>
                        	</div>
                		</div>
                	</div>
                </div>
                <!-- end row -->
				</c:if>
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