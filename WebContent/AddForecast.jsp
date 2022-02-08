<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Forecast</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">
		<link rel="stylesheet" href="picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="picker/cs/bootstrap-timepicker.min.css" />
        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="assets/css/select2.min.css" />
        <link rel="stylesheet" href="assets/css/render.css">
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
                                    <li class="breadcrumb-item"><a href="#">Sales</a></li>
                                    <li class="breadcrumb-item"><a href="#">Forecast</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Forecast</a></li>
                                </ol>
                            </div>
                           
                             <h4 class="page-title">Add Forecast</h4>
                            	
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="ForecastList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Forecast List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
          
           <c:choose>
              	<c:when test="${param.action=='update'}">
          				<sql:query var="fore" dataSource="jdbc/rmc">
              			select * from forecast where forecast_id=?
              			<sql:param value="${param.forecast_id}"/>
              		</sql:query> 
                 <c:set var="res"/>
                 <c:forEach items="${fore.rows}" var="fore">
             	<div class="row">
                  <div class="col-sm-12">
                   	<form class="" action="ForecastController?action=updateForecast" method="post">
                        <div class="card-box row col-sm-12">
                           	<div class="col-sm-3"></div>
                           	<div class="col-sm-6">
                           		<div class="form-group">
                                    <label>Plant <span class="text-danger">*</span></label>
                                    <sql:query var="plant" dataSource="jdbc/rmc">
                                    	select * from plant where plant_id like if(?=0,'%%',?)
                                    	<sql:param value="${bean.plant_id}"/>
                                    	<sql:param value="${bean.plant_id}"/>
                                    </sql:query>
                                    <input type="hidden" name="forecast_id" value="${fore.forecast_id}" />
									<select id="plant_id"  name="plant_id"  required="required"  class="select2"  data-placeholder="Choose Plant">
										<c:if test="${bean.plant_id==0}">
											<option value=""></option>
										</c:if>
										<c:forEach var="plant" items="${plant.rows}">
										<option value="${plant.plant_id}"  ${(fore.plant_id==plant.plant_id)?'selected':''}>${plant.plant_name}</option>
										</c:forEach>
									</select>
                                </div>
                                
                                 
                           	   <div class="form-group">
                                    <label>Customer <span class="text-danger">*</span></label>
                                    <sql:query var="customer" dataSource="jdbc/rmc">
                                    	select * from customer where customer_status='active' order by customer_name asc
                                    </sql:query>
									<select id="customer_id"  name="customer_id"    class="select2"  data-placeholder="Choose Customer" required="required">
										<option value="">&nbsp;</option>
										<c:forEach var="customer" items="${customer.rows}">
										<option value="${customer.customer_id}" ${(fore.customer_id==customer.customer_id)?'selected':'' }>${customer.customer_name}</option>
										</c:forEach>
									</select>
                                </div>
                                
                                 <sql:query var="site" dataSource="jdbc/rmc">
	                                	select * from site_detail where customer_id=?
	                                	<sql:param value="${fore.customer_id}"/>
	                                </sql:query>
	                                <div class="form-group">
	                                    <label>Site Name<span class="text-danger">*</span></label>
										<select id="site_id"  name="site_id" required="required"   class="select2"  data-placeholder="Choose Site">
											<c:forEach items="${site.rows}" var="site">
												<option value="${site.site_id}" ${(site.site_id==fore.site_id)?'selected':''}>${site.site_name}</option>
											</c:forEach>
										</select>
	                                </div>
                                  
                                   <div class="form-group">
                                       <label>Marketing Person : </label>
                                       <sql:query var="mp" dataSource="jdbc/rmc">
                                       	select * from marketing_person where mp_status='active'
                                       </sql:query>
                                       <select class="select2" name="mp_id" id="mp_id" required="required" data-placeholder="Choose Marketing Person">
                                           <option value="" selected="selected"></option>
                                           <c:forEach items="${mp.rows}" var="mp">
                                           <option value="${mp.mp_id}" ${(fore.mp_id==mp.mp_id)?'selected':''}>${mp.mp_name}</option>
                                           </c:forEach>
                                       </select>
                                   </div>
                                
                              <div class="form-group">
                                    <label>Project Quantity <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                            <input type="number" step="0.1" value="${fore.project_quantity}" class="form-control" required id="project_quantity" name="project_quantity" />
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                            <div class="col-sm-3">
                             
                                
                             
                             </div>
                             <div class="col-sm-12 text-center">
                               	<div class="form-group">
                                    <div>
                                        <button type="submit"  class="btn btn-custom waves-effect waves-light">
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
               </c:forEach>
            </c:when>
            
            <c:otherwise>
            
            	<div class="row">
                  <div class="col-sm-12">
                   	<form class="" action="ForecastController?action=InsertForecast" method="post">
                        <div class="card-box row col-sm-12">
                           	<div class="col-sm-3"></div>
                           	<div class="col-sm-6">
                           		<div class="form-group">
                                    <label>Plant <span class="text-danger">*</span></label>
                                    <sql:query var="plant" dataSource="jdbc/rmc">
                                    	select * from plant where plant_id like if(?=0,'%%',?)
                                    	<sql:param value="${bean.plant_id}"/>
                                    	<sql:param value="${bean.plant_id}"/>
                                    </sql:query>
                                    <input type="hidden" name="scheduling_id" value="0" id="scheduling_id"/>
									<select id="plant_id"  name="plant_id"  required="required"  class="select2"  data-placeholder="Choose Plant">
										<c:if test="${bean.plant_id==0}">
											<option value=""></option>
										</c:if>
										<c:forEach var="plant" items="${plant.rows}">
										<option value="${plant.plant_id}">${plant.plant_name}</option>
										</c:forEach>
									</select>
                                </div>
                                
                                 
                           	   <div class="form-group">
                                    <label>Customer <span class="text-danger">*</span></label>
                                    <sql:query var="customer" dataSource="jdbc/rmc">
                                    	select * from customer where customer_status='active' order by customer_name asc
                                    </sql:query>
									<select id="customer_id"  name="customer_id"    class="select2"  data-placeholder="Choose Customer" required="required">
										<option value="">&nbsp;</option>
										<c:forEach var="customer" items="${customer.rows}">
										<option value="${customer.customer_id}">${customer.customer_name}</option>
										</c:forEach>
									</select>
                                </div>
                                
                                <div class="form-group">
                                    <label>Site Name<span class="text-danger">*</span></label>
									<select id="site_id"  name="site_id" required="required"  onchange="getProjectQuantity()" class="select2"  data-placeholder="Choose Site">
										
									</select>
                                </div>
                                  
                                   <div class="form-group">
                                       <label>Marketing Person : </label>
                                       <sql:query var="mp" dataSource="jdbc/rmc">
                                       	select * from marketing_person where mp_status='active'
                                       </sql:query>
                                       <select class="select2" name="mp_id" id="mp_id" required="required" data-placeholder="Choose Marketing Person">
                                           <option value="" selected="selected"></option>
                                           <c:forEach items="${mp.rows}" var="mp">
                                           <option value="${mp.mp_id}">${mp.mp_name}</option>
                                           </c:forEach>
                                       </select>
                                   </div>
                                
                              <div class="form-group">
                                    <label>Project Quantity <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                            <input type="number" step="0.1" class="form-control" required id="project_quantity" name="project_quantity" />
                                        </div>
                                    </div>
                                </div>
                                
                               
                            </div>
                            <div class="col-sm-3">
                             
                                
                             
                             </div>
                             <div class="col-sm-12 text-center">
                               	<div class="form-group">
                                    <div>
                                        <button type="submit"  class="btn btn-custom waves-effect waves-light">
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
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script type="text/javascript" src="js/AddPurchaseOrder.js"></script>
		<script src="assets/js/ace.min.js"></script>
		
		
		<script type="text/javascript">
			$(document).ready(function(){
				/*TIME PICKER START'S HERE*/
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
				}).next().on(ace.click_event, function(){
					$(this).prev().focus();
				});
				
				
				$('#timepicker2').timepicker({
					minuteStep: 1,
					showSeconds: true,
					showMeridian: false,
					disableFocus: true,
					icons: {
						up: 'fa fa-chevron-up',
						down: 'fa fa-chevron-down'
					}
				}).on('focus', function() {
					$('#timepicker2').timepicker('showWidget');
				}).next().on(ace.click_event, function(){
					$(this).prev().focus();
				});
			});
		</script>
		    <script type="text/javascript">
    	function getProjectQuantity(){
    		var customer_id=$('#customer_id').val();
    		var site_id=$('#site_id').val();
    		$.ajax({
    			type:'POST',
    			url:'ForecastController?action=getProjectQuantity&customer_id='+customer_id+'&site_id='+site_id,
    			headers:{
    				Accept:"application/json;charset=utf-8",
    				"Content-Type":"application/json;charset=utf-8"
    			},
    			success:function(res){
    				if(res!=0){
    				$('#project_quantity').val(res);
    				}else{
    					$('#project_quantity').val(0);
    				}
    			}
    		});
    	}
    </script>
	
    </body>
</html>