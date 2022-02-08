<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
        <meta charset="utf-8" />
        <title>Generate Consolidate Invoice</title>
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
        
        <style type="text/css">
        	.change{
        		background-color:#469399;
        		color: white;
        	}
        	
        	.nochange{
        		background-color: #d7dfe0;
        		
        	}
        </style>

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
                                    <li class="breadcrumb-item"><a href="#">Billing</a></li>
                                    <li class="breadcrumb-item"><a href="#">Consolidate Invoice</a></li>
                                    <li class="breadcrumb-item"><a href="#">Generate Consolidate Invoice</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Consolidate Invoice</h4>
                        </div>
                    </div>
                </div>
                 <!-- end row -->
                 
                  <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="ConsolidateInvoiceList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Consolidate Invoice List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<div class="row">
		                	<div class="col-md-12">
		                		<h2 class="text-info text-center">Update Consolidate Invoice</h2><hr>
		                	</div>
		                	
		                	<sql:query var="cons" dataSource="jdbc/rmc">
		                		select * from consolidate_invoice where consolidate_invoice_id=?
		                		<sql:param value="${param.consolidate_invoice_id}"/>
		                	</sql:query>
		                	<c:forEach items="${cons.rows}" var="cons">
		                		<c:set value="${cons}" var="rs"/>
		                	</c:forEach>
		                    <div class="col-md-12">
		                    ${rs}
		                       <form action="InvoiceController?action=UpdateConsolidateInvoice" id="myform" method="post">
		                          <div class="row">
		                          	<div class="col-sm-3"></div>
		                          	<div class="col-sm-6">
		                          		<div class="col-sm-12">
		                                   <div class="form-group">
		                                       <label>Report Type<span class="text-danger">*</span></label>
		                                       
		                                       <input type="hidden" value="${rs.consolidate_invoice_id}" name="consolidate_invoice_id"/>
		                                       <select class="select2" name="invoice_type" id="invoice_type" required="required">
		                                           <option value="customer" ${(rs.invoice_type=='customer')?'selected':''}>Customer Wise</option>
		                                           <option value="customerdate" ${(rs.invoice_type=='customerdate')?'selected':''}>Customer With Date Wise</option>
		                                       </select>
		                                   </div>
		                               </div>
		                               
		                                
		                               <c:if test="${rs.invoice_type=='customerdate'}">
		                               	 <div class="col-sm-12">
			                                  <div class="form-group">
			                                      <label>From Date<span class="text-danger">*</span></label>
			                                      <div class="cal-icon">
			                                          <input type="text" name="from_date" class="form-control date-picker" value="${rs.from_date}"  required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
			                                      </div>
			                                  </div>
			                                </div>
			                                
			                                
			                                <div class="col-sm-12">
			                                  <div class="form-group">
			                                      <label>To Date<span class="text-danger">*</span></label>
			                                      <div class="cal-icon">
			                                          <input type="text" name="to_date" class="form-control date-picker" value="${rs.to_date}"  required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
			                                      </div>
			                                  </div>
			                                </div>
		                               </c:if>
		                               
		                               <div class="col-sm-12">
		                                   <div class="form-group">
		                                       <label>Customer <span class="text-danger">*</span></label>
		                                       <sql:query var="customer" dataSource="jdbc/rmc">
		                                       	select * from customer where customer_status='active' order by customer_name asc
		                                       </sql:query>
		                                       <select class="select2" name="customer_id" id="customer_id" required="required">
		                                           <option value="" selected="selected" disabled="disabled">Please Select</option>
		                                           <c:forEach items="${customer.rows}" var="customer">
		                                           <option value="${customer.customer_id}" ${(customer.customer_id==rs.customer_id)?'selected':''}>${customer.customer_name}</option>
		                                           </c:forEach>
		                                       </select>
		                                   </div>
		                               </div>
		                               
		                               
		                               <!-- Get Site Details -->
		                               
		                               <sql:query var="site" dataSource="jdbc/rmc">
		                               		select * from site_detail where customer_id=?
		                               		<sql:param value="${rs.customer_id}"/>
		                               </sql:query>
		                               
		                               
		                               
		                               <div class="col-sm-12">
		                                   <div class="form-group">
		                                       <label>Site <span class="text-danger">*</span></label>
		                                       <select class="select2" name="site_id" id="site_id">
		                                           <option value="">All Site</option>
		                                           <c:forEach var="site" items="${site.rows}">
														<option value="${site.site_id}" ${(site.site_id==rs.site_id)?'selected':''}>${site.site_name}</option>		                                           		
		                                           </c:forEach>
		                                       </select>
		                                   </div>
		                               </div>
		                               
		                               <div class="col-sm-12">
		                                   <div class="form-group">
		                                       <label>Items<span class="text-danger">*</span></label>
		                                        <sql:query var="item" dataSource="jdbc/rmc">
		                                       	select * from product
		                                       </sql:query>
		                                       <select class="select2" name="product_id" id="product_id">
		                                           <option selected="selected"  value="">All Item</option>
		                                           <c:forEach items="${item.rows}" var="item">
		                                           <option value="${item.product_id}" ${(item.product_id==rs.product_id)?'selected':''}>${item.product_name}</option>
		                                           </c:forEach>
		                                       </select>
		                                   </div>
		                               </div>
		                               
		                               <div class="col-sm-12">
		                                   <div class="form-group">
		                                       <label>Plant <span class="text-danger">*</span></label>
		                                       <sql:query var="plant" dataSource="jdbc/rmc">
		                                       	select * from plant where plant_id like if(?=0,'%%',?)
		                                       	<sql:param value="${bean.plant_id}"/>
		                                       	<sql:param value="${bean.plant_id}"/>
		                                       </sql:query>
		                                       <select class="select2" name="plant_id" id="plant_id">
		                                           <c:if test="${bean.plant_id==0}">
		                                           	 <option value="" selected="selected">All Plant</option>
		                                           </c:if>
		                                           <c:forEach items="${plant.rows}" var="plant">
		                                           <option value="${plant.plant_id}" ${(plant.plant_id==rs.plant_id)?'selected':''}>${plant.plant_name}</option>
		                                           </c:forEach>
		                                       </select>
		                                   </div>
		                                </div>
		                                <div class="col-sm-12">
		                                  <div class="form-group">
		                                      <label>Advance Amount(Rs.)<span class="text-danger">*</span></label>
		                                      <input type="number" step="0.01" value="${rs.advance_amount}" class="form-control" name="advance_amount">
		                                  </div>
		                                </div>
		                                
		                                <div class="col-sm-12">
		                                  <div class="form-group">
		                                      <label>Pump Charge(Rs.)<span class="text-danger">*</span></label>
		                                      <input type="number" step="0.01" class="form-control" value="${rs.pump_charge}" name="pump_charge">
		                                  </div>
		                                </div>
		                                
		                                <div class="col-sm-12">
		                                  <div class="form-group">
		                                      <label>Generate Date <span class="text-danger">*</span></label>
		                                      <div class="cal-icon">
		                                          <input type="text" name="generate_date" class="form-control date-picker" value="${rs.generate_date}" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
		                                      </div>
		                                  </div>
		                                </div>
		                               
		                          	</div> 	
		                          </div>
		                           
		                          <div class="text-center m-t-20">
		                               <button type="submit" class="btn btn-primary btn-lg m-r-10 save-button">Generate Report</button>
		                               <a class="btn btn-danger btn-lg" href="InvoiceReport.jsp">Clear Report</a>
		                          </div>
		                       </form>
		                    </div>
		                </div>
                	</c:when>
                	<c:otherwise>
                		<div class="row">
	                	<div class="col-md-12">
	                		<h2 class="text-info text-center">Generate Consolidate Invoice</h2><hr>
	                	</div>
	                    <div class="col-md-12">
	                       <form action="InvoiceController?action=GenerateConsolidateInvoice" id="myform" method="post">
	                          <div class="row">
	                          	<div class="col-sm-3"></div>
	                          	<div class="col-sm-6">
	                          		<div class="col-sm-12">
	                                   <div class="form-group">
	                                       <label>Report Type<span class="text-danger">*</span></label>
	                                       <select class="select2" name="invoice_type" id="invoice_type" required="required">
	                                           <option value="customer">Customer Wise</option>
	                                           <option value="customerdate">Customer With Date Wise</option>
	                                       </select>
	                                   </div>
	                               </div>
	                               
	                                <div class="col-sm-12 dt">
	                                  <div class="form-group">
	                                      <label>From Date<span class="text-danger">*</span></label>
	                                      <div class="cal-icon">
	                                          <input type="text" name="from_date" class="form-control date-picker dt" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
	                                      </div>
	                                  </div>
	                                </div>
	                                
	                                <div class="col-sm-12 dt">
	                                  <div class="form-group">
	                                      <label>To Date<span class="text-danger">*</span></label>
	                                      <div class="cal-icon">
	                                          <input type="text" name="to_date"  class="form-control date-picker dt" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
	                                      </div>
	                                  </div>
	                                </div>
	                               
	                               <div class="col-sm-12">
	                                   <div class="form-group">
	                                       <label>Customer <span class="text-danger">*</span></label>
	                                       <sql:query var="customer" dataSource="jdbc/rmc">
	                                       	select * from customer where customer_status='active' order by customer_name asc
	                                       </sql:query>
	                                       <select class="select2" name="customer_id" id="customer_id" required="required">
	                                           <option value="" selected="selected" disabled="disabled">Please Select</option>
	                                           <c:forEach items="${customer.rows}" var="customer">
	                                           <option value="${customer.customer_id}">${customer.customer_name}</option>
	                                           </c:forEach>
	                                       </select>
	                                   </div>
	                               </div>
	                               
	                               <div class="col-sm-12">
	                                   <div class="form-group">
	                                       <label>Site <span class="text-danger">*</span></label>
	                                       <select class="select2" name="site_id" id="site_id">
	                                           <option value="">All Site</option>
	                                       </select>
	                                   </div>
	                               </div>
	                               
	                               <div class="col-sm-12">
	                                   <div class="form-group">
	                                       <label>Items<span class="text-danger">*</span></label>
	                                        <sql:query var="item" dataSource="jdbc/rmc">
	                                       	select * from product
	                                       </sql:query>
	                                       <select class="select2" name="product_id" id="product_id">
	                                           <option selected="selected"  value="">All Item</option>
	                                           <c:forEach items="${item.rows}" var="item">
	                                           <option value="${item.product_id}">${item.product_name}</option>
	                                           </c:forEach>
	                                       </select>
	                                   </div>
	                               </div>
	                               
	                               <div class="col-sm-12">
	                                   <div class="form-group">
	                                       <label>Plant <span class="text-danger">*</span></label>
	                                       <sql:query var="plant" dataSource="jdbc/rmc">
	                                       	select * from plant where plant_id like if(0=?,'%%',?)
	                                       	<sql:param value="${bean.plant_id}"/>
	                                       	<sql:param value="${bean.plant_id}"/>
	                                       </sql:query>
	                                       <select class="select2" name="plant_id" id="plant_id">
	                                           <c:if test="${bean.plant_id==0}">
	                                           	<option value="" selected="selected">All Plant</option>
	                                           </c:if>
	                                           <c:forEach items="${plant.rows}" var="plant">
	                                           <option value="${plant.plant_id}">${plant.plant_name}</option>
	                                           </c:forEach>
	                                       </select>
	                                   </div>
	                                </div>
	                                <div class="col-sm-12">
	                                  <div class="form-group">
	                                      <label>Advance Amount(Rs.)<span class="text-danger">*</span></label>
	                                      <input type="number" step="0.01" class="form-control" name="advance_amount">
	                                  </div>
	                                </div>
	                                
	                                <div class="col-sm-12">
	                                  <div class="form-group">
	                                      <label>Pump Charge(Rs.)<span class="text-danger">*</span></label>
	                                      <input type="number" step="0.01" class="form-control" name="pump_charge">
	                                  </div>
	                                </div>
	                                
	                                <div class="col-sm-12">
	                                  <div class="form-group">
	                                      <label>Generate Date <span class="text-danger">*</span></label>
	                                      <div class="cal-icon">
	                                          <input type="text" name="generate_date" value="${rs.generate_date}" class="form-control date-picker" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
	                                      </div>
	                                  </div>
	                                </div>
	                               
	                          	</div> 	
	                          </div>
	                           
	                          <div class="text-center m-t-20">
	                               <button type="submit" class="btn btn-primary btn-lg m-r-10 save-button">Generate Report</button>
	                               <a class="btn btn-danger btn-lg" href="InvoiceReport.jsp">Clear Report</a>
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

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<script src="assets/js/ace.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				 $('.select2').css('width','100%').select2({allowClear:true})
					.on('change', function(){
					}); 
		         
		         
		         $('.date-picker').datepicker({
						autoclose: true,
						todayHighlight: true
				 });
					//show datepicker when clicking on the icon
					
		         
		        
				$('.dt').hide();
				$('.dt').prop('disabled',true);
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
			});
		</script>
		<script type="text/javascript">
    	$(document).ready(function(){
    		$('#customer_id').on('change',function(){
    			var customer_id=$('#customer_id').val();
    			$.ajax({
    				type:'POST',
    				url:'CustomerController?action=getCustomerSiteDetails&customer_id='+customer_id,
    				headers:{
    					Accept:"application/json;charset=utf-8",
    					"Content-Type":"application/json;charset=utf-8"
    				},
    				success:function(result){
    					$('#select2-site_id-container').html('Choose Site Address');
    					$('#site_id').html('');
    	        		$('#site_id').html('<option value="">Choose Site Address.</option>');
    	        		$.each(result, function(index, value) {
    	        			   $('#site_id').append("<option value='"+ value.site_id+ "'>" + value.site_name + "</option>");
    	        		});
    	        		
    				}
    			});
    		});
    	});
    </script>
    
    <script type="text/javascript">
    	$(document).ready(function(){
    		$('#invoice_type').on('change',function(){
    			var invoice_type=$('#invoice_type').val();
    			if(invoice_type=='customer'){
    				$('.dt').hide();
    				$('.dt').prop('disabled',true);
    			}else{
    				$('.dt').show();
    				$('.dt').prop('disabled',false);
    			}
    		});
    	});
    </script>
		
    </body>
</html>