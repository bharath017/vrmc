<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Scheduling</title>
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
                                    <li class="breadcrumb-item"><a href="#">Customer &amp; Purchase Order</a></li>
                                    <li class="breadcrumb-item"><a href="#">Scheduling</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Scheduling</a></li>
                                </ol>
                            </div>
                           
                             <h4 class="page-title">Scheduling</h4>
                            	
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="SchedulingList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Scheduling List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
          
             	<div class="row">
                  <div class="col-sm-12">
                   	<form class="" action="SchedulingController?action=InsertScheduling" method="post">
                        <div class="card-box row col-sm-12">
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
											<option value="0">All Plant</option>
										</c:if>
										<c:forEach var="plant" items="${plant.rows}">
										<option value="${plant.plant_id}">${plant.plant_name}</option>
										</c:forEach>
									</select>
                                </div>
                                
                                <div class="form-group">
                                    <label>Scheduling Date <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                        	<input type="hidden" name="user_id" value="${bean.user_id}" id="user_id"/>
                                            <input type="text" name="scheduling_date" class="form-control date-picker scheduling_date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
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
									<select id="site_id"  name="site_id" required="required"   class="select2"  data-placeholder="Choose Site">
										
									</select>
                                </div>
                                
                                
                                <div class="form-group">
                                    <label>Start Time <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                            <input type="text" name="start_time" class="form-control" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label>End Time <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                            <input type="text" name="end_time" class="form-control" placeholder="HH:MM:SS" id="timepicker2" data-date-format="yyyy-mm-dd">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label>Pump1 <span class="text-danger">*</span></label>
                                    <sql:query var="pump" dataSource="jdbc/rmc">
                                    	select * from pump where type='pump'
                                    </sql:query>
									<select id="pump1"  name="pump1"    class="select2"  data-placeholder="Choose Pump1">
										<option value="">DUMPING</option>
										<c:forEach var="pump" items="${pump.rows}">
										<option value="${pump.pump_name}">${pump.pump_name}</option>
										</c:forEach>
									</select>
                                </div>
                                
                                <div class="form-group">
                                    <label>Pump2 <span class="text-danger">*</span></label>
                                    <sql:query var="pump" dataSource="jdbc/rmc">
                                    	select * from pump where type='pump'
                                    </sql:query>
									<select id="pump2"  name="pump2"    class="select2"  data-placeholder="Choose Pump2">
										<option value="">DUMPING</option>
										<c:forEach var="pump" items="${pump.rows}">
										<option value="${pump.pump_name}">${pump.pump_name}</option>
										</c:forEach>
									</select>
                                </div>
                                
                                <div class="col-sm-12">
                                	<table class="table table-bordered" id="schedule_item">
                                		<thead>
                                			<tr style="background-color: #00bfff;color: white;">
	                                			<th class="text-center">Grade</th>
	                                			<th class="text-center no-view">PO Qty</th>
	                                			<th class="text-center no-view">Inv Qty</th>
	                                			<th class="text-center no-view">Bal. Qty.</th>
	                                			<th class="text-center">Quantity</th>
	                                		</tr>
                                		</thead>
                                		<tbody>
	                                		
	                                	</tbody>
                                	</table>
                                </div>
                             </div>
                             <div class="col-sm-12 text-center">
                               	<div class="form-group">
                                    <div>
                                        <button type="submit" disabled="disabled" id="disable-me" class="btn btn-custom waves-effect waves-light">
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
			$(document).ready(function(){
				$('#site_id').on('change',function(){
					callForSchedule();
				});
				
				$('#plant_id').on('change',function(){
					callForSchedule();
				});
				
				$('.scheduling_date').on('change',function(){
					callForSchedule();
				});
				
			});
		</script>
		
		<script type="text/javascript">
		
			function callForSchedule(){
				console.log('say hii');
				var site_id=$('#site_id').val();
				var plant_id=$('#plant_id').val();
				var date=$('.scheduling_date').val();
				if(site_id !='' && site_id !=null && plant_id !='' && plant_id !=null && date != '' && date !=null){
					getProductDetails(site_id,date,plant_id);
				}
			}
			function getProductDetails(site_id,date,plant_id){
				$.ajax({
					type:'POST',
					url:'SchedulingController?action=getDetails&site_id='+site_id+'&date='+date+'&plant_id='+plant_id,
					headers:{
						Accept:"application/json;charset=utf-8",
						"Content-Type":"application/json;charset=utf-8"
					},
					success:function(res){
						$('#disable-me').prop('disabled',true);
						if(res.sc.scheduling_id==0){
							$('.no-view').show();
							$('#scheduling_id').val('0');
							//for insertion purpose
							$('#schedule_item tbody').html("");
							$.each(res.si,function(index,val){
								var row='<tr>'
								row+='<td>'+val.product_name+'<input type="hidden" name="product_id" value="'+val.product_id+'"/></td>'
								row+='<td class="po_quantity">'+val.po_quantity+'</td>'
								row+='<td class="inv_quantity">'+val.tquantity+'</td>'
								row+='<td class="bal_quantity">'+(val.po_quantity-val.tquantity)+'</td>'
								row+='<td><input type="number" step="0.1" class="form-control" required name="production_quantity" value="'+val.production_quantity+'"/></td>'
								row+='</tr>'
								$('#schedule_item tbody').append(row);
								$('#disable-me').prop('disabled',false);
							});
						}else{
							//$('.no-view').hide();
							$('#disable-me').prop('disabled',true);
							$('.start_time').val(res.sc.start_time);
							$('#scheduling_id').val(res.sc.scheduling_id);
							$('.end_time').val(res.sc.end_time);
							$('#scheduling_id').val(res.sc.scheduling_id);
							$('#schedule_item tbody').html("");
							$.each(res.si,function(index,val){
								var row='<tr>'
									row+='<td>'+val.product_name+'<input type="hidden" name="scheduling_item_id" value="'+val.scheduling_item_id+'"/><input type="hidden" name="product_id" value="'+val.product_id+'"/></td>'
									row+='<td class="po_quantity">'+val.po_quantity+'</td>'
									row+='<td class="inv_quantity">'+val.tquantity+'</td>'
									row+='<td class="bal_quantity">'+(val.po_quantity-val.tquantity)+'</td>'
									row+='<td><input type="number" step="0.1" class="form-control" required name="production_quantity" value="'+val.production_quantity+'"/></td>'
									row+='</tr>'
								$('#schedule_item tbody').append(row);
								$('#disable-me').prop('disabled',false);
							});
						}
					}
				});
			}
		</script>
    </body>
</html>