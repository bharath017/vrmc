<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Fleet Incoming</title>
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
                                    <li class="breadcrumb-item"><a href="#">Fleet</a></li>
                                    <li class="breadcrumb-item"><a href="#">Fleet Item</a></li>
                                    <li class="breadcrumb-item"><a href="#">Incoming Fleet</a></li>
                                </ol>
                            </div>
                            <c:choose>
                            	<c:when test="${param.action=='update'}">
                            		<h4 class="page-title">Update Fleet InComing</h4>
                            	</c:when>
                            	<c:otherwise>
                            		<h4 class="page-title">Add Fleet InComing</h4>
                            	</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="FleetList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-grid"></i> Incoming Fleet List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="flt" dataSource="jdbc/rmc">
                			select * from fleet_incoming where fleet_id=?
                			<sql:param value="${param.fleet_id}"/>
                		</sql:query> 
                		<c:forEach items="${flt.rows}" var="fleet">
                        	<c:set value="${fleet}" var="rs"/>
                        </c:forEach>
                		<div class="row">
						<div class="col-sm-12">
							<form class=""
								action="FleetController?action=UpdateFleetIncoming"
								method="post">
								<div class="card-box row col-sm-12">

									<div class="col-sm-4">
										<div class="form-group">
											<label>Bill No</label> <input type="hidden" name="fleet_id"
												value="${rs.fleet_id}"> <input class="form-control"
												type="text" id="bill_no" name="bill_no"
												value="${rs.bill_no}">
										</div>
									</div>

									<div class="col-sm-4">
										<div class="form-group">
											<label>Vendor Name</label> <input class="form-control"
												type="text" id="vendor_name" value="${rs.fleet_supplier}"
												name="vendor_name">
										</div>
									</div>

									<div class="col-sm-4">
										<div class="form-group">
											<label>Incoming Date<span class="text-danger">*</span></label>
											<div class="cal-icon">
												<input class="form-control datepicker3"
													value="${rs.incoming_date}" required="required"
													name="incoming_date" type="text">
											</div>
										</div>
									</div>

									<div class="col-sm-4">
										<div class="form-group">
											<label>Incoming Time<span class="text-danger">*</span></label>
											<div class="cal-icon">
												<input name="incoming_time" required="required"
													value="${rs.incoming_time}" id="timepicker1" type="text"
													class="form-control" />
											</div>
										</div>
									</div>

									<div class="col-sm-4">
										<div class="form-group">
											<label>Purchaser Name</label> <input class="form-control"
												type="text" id="purchaser_name" value="${rs.purchaser_name}"
												name="purchaser_name">
										</div>
									</div>
									<div class="col-sm-4">
										<div class="form-group">
											<label>Fleet Type<span class="text-danger">*</span></label> <select
												class="select2" name="fleet_type" id="fleet_type"
												required="required">
												<option value="plant"
													${(rs.fleet_type=='plant')?'selected':''}>Plant Equipment</option>
												<option value="office"
													${(rs.fleet_type=='office')?'selected':''}>Office Stationary</option>
												<option value="other"
													${(rs.fleet_type=='other')?'selected':''}>Other Equipment</option>
											</select>
										</div>
									</div>
								</div>

								<div class="col-sm-8">
									<div class="form-group">
										<label>Comment <span class='text-danger'>*</span></label> <input
											class="form-control" type="text" id="comment" name="comment" required="required">
									</div>
								</div>

								<sql:query var="item" dataSource="jdbc/rmc">
										select * from fleet_item where item_status='active'
									</sql:query>
								<c:set var="name">
									<select class="col-xs-12 select2" required="required"
										name="fleet_item_id">'+
										<c:forEach items="${item.rows}" begin="0" var="item">
												'<option value="${item.fleet_item_id}">${item.item_name}</option>'+
											</c:forEach> '
									</select>
								</c:set>


								<sql:query var="gst" dataSource="jdbc/rmc">
										select * from gst_percent order by gst_percent asc
									</sql:query>
								<c:set var="gstval">
									<select class="col-xs-12 select2 gst_percent"
										required="required" name="gst_percent"
										onchange="calculateNetAmmount(this);">'+
										<c:forEach items="${gst.rows}" begin="0" var="gst">
												'<option value="${gst.gst_percent}">${gst.gst_percent}</option>'+
											</c:forEach> '
									</select>
								</c:set>
								<div class="row" id="clicked">
									<div class="col-md-12 col-sm-12 col-xs-12">
										<div class="table-responsive">
											<table class="table table-hover table-bordered table-white"
												id="Table1">
												<thead>
													<tr>
														<th width="25%;"  class="text-center">Item <span
															class='text-danger'>*</span></th>
														<th width="10%;" class="text-center">Quantity <span
															class='text-danger'>*</span></th>
														<th width="15%;" class="text-center">Rate <span
															class='text-danger'>*</span></th>
														<th width="10%;" class="text-center">GST(%) <span
															class='text-danger'>*</span></th>
														<th width="15%;" class="text-center">Gross Price <span
															class='text-danger'>*</span></th>
														<th width="10%;" class="text-center">Tax Price <span
															class='text-danger'>*</span></th>
														<th width="30%;" class="text-center">Net Price <span
															class='text-danger'>*</span></th>
														<th class="text-center"><a href="#"
															class="text-success BtnPlus"> <i class="fa fa-plus"></i>
														</a></th>
													</tr>
												</thead>

												<!-- Get fleet item details -->
												<sql:query var="fi" dataSource="jdbc/rmc">
		                                            	select * from fleet_incoming_item where fleet_id=?
		                                            	<sql:param
														value="${rs.fleet_id}" />
												</sql:query>


												<tbody>
													<c:forEach items="${fi.rows}" var="fi">
														<tr>
															<td><sql:query var="item" dataSource="jdbc/rmc">
																		select * from fleet_item where item_status='active'
																	</sql:query> <input type="hidden" name="fi_item_id"
																value="${fi.fi_item_id}" /> <select
																class="col-xs-12 select2" required="required"
																name="fleet_item_id">
																	<c:forEach items="${item.rows}" begin="0" var="item">
																		<option value="${item.fleet_item_id}"
																			${(item.fleet_item_id==fi.fleet_item_id)?'selected':''}>${item.item_name}</option>
																	</c:forEach>
															</select></td>
															<td><input class="form-control item_quantity"
																step="0.01" value="${fi.quantity}"
																onkeyup="calculateNetAmmount(this);" required="required"
																placeholder="Enter Quantity" name="quantity"
																type="number"></td>
															<td><input class="form-control item_price"
																step="0.01" value="${fi.rate}" required="required"
																onkeyup="calculateNetAmmount(this);"
																placeholder="Enter Rate" name="rate" type="number">
															</td>
															<td><sql:query var="gst" dataSource="jdbc/rmc">
																		select * from gst_percent order by gst_percent asc
																	</sql:query> <select class="col-xs-12 select2 gst_percent"
																required="required" name="gst_percent"
																onchange="calculateNetAmmount(this);">
																	<c:forEach items="${gst.rows}" begin="0" var="gst">
																		<option value="${gst.gst_percent}"
																			${(gst.gst_percent==fi.gst_percent)?'selected':''}>${gst.gst_percent}</option>
																	</c:forEach>
															</select></td>
															<td><input class="form-control gross_amount"
																name="gross_amount" value="${fi.gross_amount}"
																id="gross_amount" readonly="readonly" type="text">
															</td>
															<td><input class="form-control tax_amount"
																name="tax_amount" id="tax_amount"
																value="${fi.tax_amount}" readonly="readonly" type="text">
															</td>
															<td><input class="form-control net_amount"
																name="net_amount" id="net_amount"
																value="${fi.net_amount}" readonly="readonly" type="text">
															</td>
														</tr>
													</c:forEach>
												</tbody>
												<tfoot>
													<tr>
														<th colspan="6" class="text-right">Total Gross :</th>
														<th colspan="2" class="text-left" id="total_val"></th>
													</tr>
													<tr>
														<th colspan="6" class="text-right">Total Tax :</th>
														<th colspan="2" class="text-left" id="total_gst"></th>
													</tr>
													<tr>
														<th colspan="6" class="text-right">Total Net :</th>
														<th colspan="2" class="text-left" id="total_grand"></th>
													</tr>
												</tfoot>
											</table>
										</div>
									</div>
								</div>
								
								
		                            <div class="text-center m-t-20">
		                                <button type="submit" class="btn btn-primary btn-lg m-r-10 save-button">Update Fleet Incoming</button>
		                                <button type="reset" class="btn btn-danger btn-lg">Cancel</button>
		                            </div>
								
							</form>
						</div>

					</div>
		                       
                  	</c:when>
                 <c:otherwise>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<div class="card-box row col-sm-12">
		                    	<form action="FleetController?action=AddFleetIncoming" method="post">
		                            <div class="row">
		                                <div class="col-sm-4">
		                                    <div class="form-group">
		                                        <label>Bill No</label>
		                                        <input class="form-control" type="text" id="bill_no" name="bill_no">
		                                    </div>
		                                </div>
		                                
		                                <div class="col-sm-4">
		                                    <div class="form-group">
		                                        <label>Vendor Name</label>
		                                        <input class="form-control" type="text" id="vendor_name" name="vendor_name">
		                                    </div>
		                                </div>
		                                
		                               <div class="form-group col-sm-4">
	                                        <label>Incoming Date <span class="text-danger">*</span></label>
	                                        <div>
	                                            <div class="input-group">
	                                                <input type="text" name="incoming_date" class="form-control date-picker invoice_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
	                                                <div class="input-group-append">
	                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
	                                                </div>
	                                            </div>
	                                        </div>
	                                   </div>
		                                
		                               <div class="form-group col-sm-3">
		                                    <label>Incoming Time <span class="text-danger">*</span> </label>
		                                    <div>
		                                        <div class="input-group">
		                                            <input type="text" name="incoming_time" class="form-control" required="required" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
		                                            <div class="input-group-append">
		                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
		                                            </div>
		                                        </div>
		                                    </div>
		                                </div>
		                                
		                                <div class="col-sm-3">
		                                    <div class="form-group">
		                                        <label>Purchaser Name</label>
		                                        <input class="form-control" type="text" id="purchaser_name" name="purchaser_name">
		                                    </div>
		                                </div>
		                                <div class="col-sm-3">
		                                   <div class="form-group">
		                                       <label>Fleet Type<span class="text-danger">*</span></label>
		                                       <select class="select2" name="fleet_type" id="fleet_type" required="required">
		                                           <option value="plant">Plant Equipment</option>
		                                           <option value="office">Office Stationary</option>
		                                           <option value="other">Other Equipment</option>
		                                       </select>
		                                   </div>
		                                </div>
		                                <div class="col-sm-3">
		                                   <div class="form-group">
		                                       <label>Plant<span class="text-danger">*</span></label>
		                                       <sql:query var="plant" dataSource="jdbc/rmc">
		                                       		select * from plant where plant_id like if(?=0,'%%',?)
		                                       		<sql:param value="${bean.plant_id}"/>
		                                       		<sql:param value="${bean.plant_id}"/>
		                                       </sql:query>
		                                       <select class="select2" name="plant_id" id="plant_id" required="required">
		                                           <c:if test="${bean.plant_id==0}">
		                                           	<option value="0">Office</option>
		                                           </c:if>
		                                           <c:forEach var="plant" items="${plant.rows}">
		                                           <option value="${plant.plant_id}">${plant.plant_name}</option>
		                                           </c:forEach>
		                                       </select>
		                                   </div>
		                                </div>
		                            </div>
		                            
									<sql:query var="item" dataSource="jdbc/rmc">
										select * from fleet_item where item_status='active'
									</sql:query>
									<c:set var="name">
										<select   class="col-xs-12 select2" required="required" name="fleet_item_id">'+
											<c:forEach items="${item.rows}" begin="0" var="item">
												'<option value="${item.fleet_item_id}">${item.item_name}</option>'+
											</c:forEach>
										'</select>
									</c:set>
									
									<sql:query var="gst" dataSource="jdbc/rmc">
										select * from gst_percent order by gst_percent asc
									</sql:query>
									<c:set var="gstval">
										<select   class="col-xs-12 select2 gst_percent" required="required" name="gst_percent" onchange="calculateNetAmmount(this);">'+
											<c:forEach items="${gst.rows}" begin="0" var="gst">
												'<option value="${gst.gst_percent}">${gst.gst_percent}</option>'+
											</c:forEach>
										'</select>
									</c:set>
		                            <div class="row" id="clicked">
		                                <div class="col-md-12  ">
		                                    <div class="table-responsive">
		                                        <table class="table table-hover table-bordered table-white" id="Table1">
		                                            <thead>
		                                                <tr>
		                                                    <th width="20%">Item</th>
		                                                    <th width="20%">Quantity</th>
		                                                    <th width="20%">Rate</th>
		                                                    <th width="10%">GST(%)</th>
		                                                    <th width="10%">Gross Price</th>
		                                                    <th width="10%">Tax Price</th>
		                                                    <th width="15%">Net Price</th>
		                                                    <th class="text-center">
		                                                    	<a href="#" class="text-success BtnPlus">
			                                                    	<i class="fa fa-plus"></i>	
			                                                    </a>
		                                                    </th>
		                                                </tr>
		                                            </thead>
		                                            
		                                            <tbody>
		                                                <tr>
		                                                    <td>
		                                                       ${name}
		                                                    </td>
		                                                    <td>
		                                                        <input class="form-control item_quantity" step="0.01" onkeyup="calculateNetAmmount(this);" required="required" placeholder="Enter Quantity" name="quantity" type="number">
		                                                    </td>
		                                                    <td>
		                                                        <input class="form-control item_price" step="0.01" required="required" onkeyup="calculateNetAmmount(this);" placeholder="Enter Rate" name="rate" type="number">
		                                                    </td>
		                                                    <td>
		                                                    	${gstval}
		                                                    </td>
		                                                    <td>
		                                                       <input class="form-control gross_amount" name="gross_amount" id="gross_amount" readonly="readonly" type="text"> 
		                                                    </td>
		                                                    <td>
		                                                       <input class="form-control tax_amount" name="tax_amount" id="tax_amount" readonly="readonly" type="text"> 
		                                                    </td>
		                                                    <td>
		                                                       <input class="form-control net_amount" name="net_amount" id="net_amount" readonly="readonly" type="text"> 
		                                                    </td>
		                                                </tr>
		                                            </tbody>
		                                            <tfoot>
		                                            	<tr>
		                                            		<th colspan="6" class="text-right">Total Gross : </th>
		                                            		<th colspan="2" class="text-left" id="total_val"></th>
		                                            	</tr>
		                                            	<tr>
		                                            		<th colspan="6" class="text-right">Total Tax : </th>
		                                            		<th colspan="2" class="text-left" id="total_gst"></th>
		                                            	</tr>
		                                            	<tr>
		                                            		<th colspan="6" class="text-right">Total Net : </th>
		                                            		<th colspan="2" class="text-left" id="total_grand"></th>
		                                            	</tr>
		                                            </tfoot>
		                                        </table>
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="text-center m-t-20">
		                                <button type="submit" class="btn btn-primary btn-lg m-r-10 save-button">Save Fleet Incoming</button>
		                                <button type="reset" class="btn btn-danger btn-lg">Cancel</button>
		                            </div>
		                        </form>
          		              </div>
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
        <script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
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
			});
		</script>
		<script type="text/javascript">
			$(document).ready(function(){
				$(document).ready(function () {
				    function addRow(){
				        var html = '<tr>'+
										'<td>'+
											'${name}'+
										'</td>'+
										'<td>'+
											'<input type="number" class="form-control item_quantity" step="0.01" pattern="[^\'&quot;:]*$" onkeyup="calculateNetAmmount(this);"  required="required" placeholder="Enter Quantity"   name="quantity"/>'+
										'</td>'+
										'<td>'+
											'<input type="number" class="form-control item_price" step="0.01"  pattern="[^\'&quot;:]*$"  onkeyup="calculateNetAmmount(this);" required="required" placeholder="Enter Rate"   name="rate"/>'+
										'</td>'+
										'<td>'+
											'${gstval}'+
										'</td>'+
										'<td>'+
											'<input type="text" class="form-control gross_amount"  readonly   name="gross_amount" id="gross_amount"/>'+
										'</td>'+
										'<td>'+
											'<input type="text" class="form-control tax_amount"  readonly   name="tax_amount" id="tax_amount"/>'+
										'</td>'+
										'<td>'+
											'<input type="text" class="form-control net_amount"  readonly   name="net_amount" id="net_amount"/>'+
										'</td>'+
										'<td>'+
											'<span class="text-danger removebtn"><i class="fa fa-trash"></i></span>'+
										'</td>'+
									'</tr>'
				        $(html).appendTo($("#Table1"))
				        $('.select2').css('width','100%').select2({allowClear:true})
							.on('change', function(){
						}); 
				    };
				    $("#clicked").on("click", ".BtnPlus", addRow);
				    $('.selectme').addClass('select');
				    
				 });
				   $('#Table1').on('click', '.removebtn', function(){
					    $(this).closest ('tr').remove ();
				 });
			});
		</script>
		
    
   	    <script type="text/javascript">
		function calculateNetAmmount(e){
			var gst_percent= $(e).closest("tr").find('.gst_percent').val();
			var item_price= $(e).closest("tr").find('input.item_price').val();
			item_price=(isNaN(item_price) || item_price==undefined || item_price.trim()=="")?'0.0':parseFloat(item_price);
			var quantity= $(e).closest("tr").find('input.item_quantity').val();
			quantity=(isNaN(quantity) || quantity==undefined || quantity.trim()=="")?'0.0':parseFloat(quantity);
			var total_price=parseFloat(quantity)*parseFloat(item_price);
			total_price=isNaN(total_price)?'0.0':total_price;
			total_gst=(total_price/100)*gst_percent;
			total_gst=isNaN(total_gst)?'0.0':total_gst;
			total_net=total_price+total_gst;
		    $(e).closest("tr").find('input.gross_amount').val(total_price.toFixed(2));
		    $(e).closest("tr").find('input.tax_amount').val(total_gst.toFixed(2));
		    $(e).closest("tr").find('input.net_amount').val(total_net.toFixed(2));
		    
		    //declare all sum variable
		    var net_sum=0;
		    var gross_sum=0;
		    var gst_sum=0;
		    
		    /* now get all value using id loop */
		    
		   var gst_all=document.getElementsByName('gst_percent');
		   var quantity_all=document.getElementsByName('quantity');
		   var unit_cost_all=document.getElementsByName('rate');
		   for(var i=0;i<gst_all.length;i++){
			  /* get all single single value data */
			  var gst_val=gst_all[i].value;
			  var quantity_val=quantity_all[i].value;
			  var unit_cost_val=unit_cost_all[i].value;
			  
			  /* now check the single data are empty or not then change to proper value */
			  gst_val=(gst_val==undefined || gst_val.trim()=='' || gst_val=='')?0.0:parseFloat(gst_val);
			  quantity_val=(quantity_val==undefined || quantity_val.trim()=='' || quantity_val=='')?0.0:parseFloat(quantity_val);
			  unit_cost_val=(unit_cost_val==undefined || unit_cost_val.trim()=='' || unit_cost_val=='')?0.0:parseFloat(unit_cost_val);
			  
			  /* now declare variable for gst calculation,gross calculation and cost calculation */
			  
			  var gst_cal=0;
			  var gross_cal=0;
			  var net_cal=0;
			  
			  //now calculate all details
			  gross_cal=quantity_val*unit_cost_val;
			  gst_cal=(gross_cal/100)*gst_val;
			  net_cal=gross_cal+gst_cal;
			  
			  /* NOW ADD ALL NET CALCULATION HERE */
			
			  net_sum=net_sum+net_cal;
			  gross_sum=gross_sum+gross_cal;
			  gst_sum=gst_sum+gst_cal;
			 
		   }
		   /*  NOW PRINT ALL VALUE HERE*/
		   
		   $('#total_val').html(gross_sum.toFixed(2));
		   $('#total_gst').html(gst_sum.toFixed(2));
		   $('#total_grand').html(net_sum.toFixed(2)); 
		
		}
      </script>

    </body>
</html>