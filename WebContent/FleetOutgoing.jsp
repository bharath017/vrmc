<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Fleet OutGoing</title>
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
                                    <li class="breadcrumb-item"><a href="#">Fleet OutGoing</a></li>
                                    <li class="breadcrumb-item"><a href="#">Outgoing Fleet</a></li>
                                </ol>
                            </div>
                            <c:choose>
                            	<c:when test="${param.action=='update'}">
                            		<h4 class="page-title">Update Fleet OutGoing</h4>
                            	</c:when>
                            	<c:otherwise>
                            		<h4 class="page-title">Add Fleet OutGoing</h4>
                            	</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="FleetOutgoingList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-grid"></i> OutGoing Fleet List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="flt" dataSource="jdbc/rmc">
                			select * from fleet_outgoing where fleet_outgoing_id=?
                			<sql:param value="${param.fleet_outgoing_id}"/>
                		</sql:query> 
                		<c:forEach items="${flt.rows}" var="fleet">
                        	<c:set value="${fleet}" var="rs"/>
                        </c:forEach>
                		<div class="row">
						<div class="col-sm-12">
							<form class=""
								action="FleetController?action=UpdateFleetOutgoing"
								method="post">
								<div class="card-box row col-sm-12">
										 <div class="form-group col-sm-4">
	                                        <label>Outgoing Date <span class="text-danger">*</span></label>
	                                        <div>
	                                            <div class="input-group">
	                                            	<input type="hidden" value="${rs.fleet_outgoing_id}" name="fleet_outgoing_id"/>
	                                                <input type="text" name="dispatch_date" value="${rs.issued_date}" class="form-control date-picker invoice_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
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
									
								 	    <div class="col-sm-4">
		                                    <div class="form-group">
		                                        <label>RECEIVED PERSON </label>
		                                        <input class="form-control" value="${rs.received_person}" type="text" id="received_person" name="received_person">
		                                    </div>
		                                </div>
		                                <div class="col-sm-4">
		                                    <div class="form-group">
		                                        <label>OUTGOING COMMENT </label>
		                                        <input class="form-control" value="${rs.outgoing_comment}" type="text" id="outgoing_comment" name="outgoing_comment">
		                                    </div>
		                                </div>
		                                <div class="col-sm-4">
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
		                                           <option value="${plant.plant_id}" ${(plant.plant_id==rs.plant_id)?'selected':''}>${plant.plant_name}</option>
		                                           </c:forEach>
		                                       </select>
		                                   </div>
		                                </div>
		                                <div class="col-sm-4">
		                                    <div class="form-group">
		                                        <label>&nbsp;</label>
		                                        <div class="checkbox checkbox-primary">
		                                            <input id="checkbox2" value="${rs.returnable}" type="checkbox" checked>
		                                            <label for="checkbox2">
		                                                <b>RETURNABLE ITEM</b>
		                                            </label>
		                                        </div>
		                                    </div>
		                                </div>
								</div>

								<!-- <div class="col-sm-8">
									<div class="form-group">
										<label>Comment <span class='text-danger'>*</span></label> <input
											class="form-control" type="text" id="comment" name="comment" required="required">
									</div>
								</div> -->

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
	                         
									
									

								<div class="row" id="clicked">
									<div class="col-md-8 col-sm-12 col-xs-12">
										<div class="table-responsive">
											<table class="table table-hover table-bordered table-white"
												id="Table1">
												<thead>
													<tr>
													<th width="5%">Item</th>
		                                                    <th width="5%">Quantity</th>
		                                                 <!--    <th width="5%">Remaining Quantity</th> -->
		                                                  <!--   <th  width="2%" class="text-center">
		                                                    	<a href="#" class="text-success BtnPlus">
			                                                    	<i class="fa fa-plus"></i>	
			                                                    </a>
		                                                    </th> -->
													</tr>
												</thead>

												<!-- Get fleet item details -->
												<sql:query var="fi" dataSource="jdbc/rmc">
		                                            	select * from fleet_outgoing_item where fleet_outgoing_id=?
		                                            	<sql:param
														value="${rs.fleet_outgoing_id}" />
												</sql:query>



												<tbody>
													<c:forEach items="${fi.rows}" var="fi">
														<tr>
															<td>
															
															<sql:query var="item" dataSource="jdbc/rmc">
																		select * from fleet_item where item_status='active'
																	</sql:query> <input type="hidden" name="fi_item_id"
																value="${fi.fi_item_id}" /> <select
																class="col-xs-12 select2" required="required"
																       name="fleet_item_id">
																	<c:forEach items="${item.rows}" begin="0" var="item">
																		<option value="${item.fleet_item_id}"
																			${(item.fleet_item_id==fi.fleet_item_id)?'selected':''}>${item.item_name}</option>
																	</c:forEach>
															</select>
															
															</td>
															
															 <td>
		                                                        <input class="form-control item_quantity" value="${fi.quantity}" id="item_quantity" step="0.01" onkeyup="getStoreDetail(this)" required="required" placeholder="Enter Quantity" name="quantity" type="number">
		                                                    </td>
		                                                   <%--  <td>
		                                                       <input class="form-control rem" value="${fi.quantity}" name="remaining" id="remaining" readonly="readonly" type="text"> 
		                                                    </td>
															 --%>
															
														</tr>
													</c:forEach>
												</tbody>
											
											</table>
										</div>
									</div>
								</div>
								
		                            <div class="text-center m-t-20">
		                                <button type="submit" class="btn btn-primary btn-lg m-r-10 save-button">Update Fleet Outgoing</button>
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
		                    	<form action="FleetController?action=AddFleetOutgoing" method="post">
		                            <div class="row">
		                                <div class="form-group col-sm-4">
	                                        <label>Outgoing Date <span class="text-danger">*</span></label>
	                                        <div>
	                                            <div class="input-group">
	                                                <input type="text" name="dispatch_date" class="form-control date-picker invoice_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
	                                                <div class="input-group-append">
	                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
	                                                </div>
	                                            </div>
	                                        </div>
	                                   </div>
		                                
		                               <div class="form-group col-sm-3">
		                                    <label>Outgoing Time <span class="text-danger">*</span> </label>
		                                    <div>
		                                        <div class="input-group">
		                                            <input type="text" name="dispatch_time" class="form-control" required="required" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
		                                            <div class="input-group-append">
		                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
		                                            </div>
		                                        </div>
		                                    </div>
		                                </div>
		                                
		                                <div class="col-sm-4">
		                                    <div class="form-group">
		                                        <label>RECEIVED PERSON </label>
		                                        <input class="form-control" type="text" id="received_person" name="received_person">
		                                    </div>
		                                </div>
		                                <div class="col-sm-4">
		                                    <div class="form-group">
		                                        <label>OUTGOING COMMENT </label>
		                                        <input class="form-control" type="text" id="outgoing_comment" name="outgoing_comment">
		                                    </div>
		                                </div>
		                                <div class="col-sm-4">
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
		                                <div class="col-sm-4">
		                                    <div class="form-group">
		                                        <label>&nbsp;</label>
		                                        <div class="checkbox checkbox-primary">
		                                            <input id="checkbox2" type="checkbox" checked>
		                                            <label for="checkbox2">
		                                                <b>RETURNABLE ITEM</b>
		                                            </label>
		                                        </div>
		                                    </div>
		                                </div>
		                                 
		                                 
		                                 
		                            </div>
		                            
									<sql:query var="item" dataSource="jdbc/rmc">
										select * from fleet_item where item_status='active'
									</sql:query>
									<c:set var="name">
										<select   class="col-xs-12 select2 fleet_item_id" id="fleet_item_id" required="required" onchange="getStoreDetail(this);" name="fleet_item_id">'+
											<c:forEach items="${item.rows}" begin="0" var="item">
												'<option value="${item.fleet_item_id}">${item.item_name}</option>'+
											</c:forEach>
										'</select>
									</c:set>
									
									
		                            <div class="row" id="clicked">
		                                <div class="col-md-8">
		                                    <div class="table-responsive">
		                                        <table class="table table-hover table-bordered table-white" id="Table1">
		                                            <thead>
		                                                <tr>
		                                                    <th width="5%">Item</th>
		                                                    <th width="5%">Quantity</th>
		                                                    <th width="5%">Remaining Quantity</th>
		                                                    <th  width="2%" class="text-center">
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
		                                                        <input class="form-control item_quantity" id="item_quantity" step="0.01" onkeyup="getStoreDetail(this)" required="required" placeholder="Enter Quantity" name="quantity" type="number">
		                                                    </td>
		                                                    <td>
		                                                       <input class="form-control rem" name="remaining" id="remaining" readonly="readonly" type="text"> 
		                                                    </td>
		                                                </tr>
		                                            </tbody>
		                                        </table>
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="text-center m-t-20">
		                                <button type="submit" class="btn btn-primary btn-lg m-r-10 save-button">Save Fleet Outgoing</button>
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
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
		<script src="assets/js/modernizr.min.js"></script>
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
			function getStoreDetail(e){
					var fleet_item_id= $(e).closest("tr").find('.fleet_item_id').val();
				
					$.ajax({
						type:'post',
						url:'FleetController?action=QuantityDetailsUsingId&fleet_item_id='+fleet_item_id,
						headers:{
							Accept:"text/html;charset=utf-8",
							"Content-Type":"text/html;charset=utf-8"
						},
						success:function(res){
			        	
			        		var item_quantity=$(e).closest("tr").find('.item_quantity').val();
			        		item_quantity=(item_quantity=="" || item_quantity=="undefined")?0:item_quantity;
			        		$(e).closest("tr").find('.rem').val(res-item_quantity);
						}
					});
				}
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
											'<input type="number" class="form-control item_quantity" step="0.01" pattern="[^\'&quot;:]*$" required="required" placeholder="Enter Quantity"   name="item_quantity"/>'+
										'</td>'+
										'<td>'+
											'<input type="number" class="form-control remaining" step="0.01"  pattern="[^\'&quot;:]*$"  equired="required" placeholder="Enter Remaining Quantity"   name="remaining"/>'+
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


    </body>
</html>