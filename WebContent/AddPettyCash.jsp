<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Petty Cash</title>
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
        	
        	.error{
        		color:red;
        	}
        </style>
        <style type="text/css">
			.mytable tr th{
				background-color: #417a37;
				color: white;
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
                                    <li class="breadcrumb-item"><a href="#">Accounts</a></li>
                                    <li class="breadcrumb-item"><a href="#">Petty Cash</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Petty Cash</a></li>
                                </ol>
                            </div>
                            <c:choose>
	                    		<c:when test="${param.action=='update'}">
	                    			<h4 class="page-title">Update Petty Cash</h4>
	                    		</c:when>
	                    		<c:otherwise>
	                    			<h4 class="page-title">Add Petty Cash</h4>
	                    		</c:otherwise>
	                    	</c:choose>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="PettyCashList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Petty Cash List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
               
              	<c:choose>
              		<c:when test="${param.action=='update'}">
              			<!-- Now get payment details here -->
                		<sql:query var="cash" dataSource="jdbc/rmc">
                			select p.*,DATE_FORMAT(p.date,'%d/%m/%Y') as date
                		    from petty_cash p where cash_id=?
                			<sql:param value="${param.cash_id}"/>
                		</sql:query>
                		
                		<c:forEach items="${cash.rows}" var="cash">
                			<c:set value="${cash}" var="rs"/>
                		</c:forEach>
              			<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" id="myform" action="PettyCashController?action=UpdatePettyCash" method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="col-sm-1"></div>
			                           	<div class="col-sm-6">
			                           	   <div class="form-group">
			                                    <label>Plant<span class="text-danger">*</span></label>
			                                    <sql:query var="plant" dataSource="jdbc/rmc">
			                                    	select plant_id,plant_name from plant
			                                    </sql:query>
			                                    <input type="hidden" name="cash_id" value="${rs.cash_id}"/>
												<select class="form-control" name="plant_id" id="plant_id" required="required">
													<c:forEach items="${plant.rows}" var="plant">
														<option value="${plant.plant_id}" ${(plant.plant_id==rs.plant_id)?'selected':''}>${plant.plant_name}</option>
													</c:forEach>
		                                        </select>
			                                </div>
			                                
			                                <div class="form-group">
		                                        <label>Payment Date <span class="text-danger"></span> </label>
		                                        <div>
		                                            <div class="input-group">
		                                                <input type="text" name="date" value="${rs.date}" class="form-control date-picker invoice_date" 
		                                                		required="required" placeholder="dd/mm/yyyy" 
		                                                		id="id-date-picker-1" data-date-format="dd/mm/yyyy"
		                                                		readonly="readonly" style="background-color: white;"/>
		                                                <div class="input-group-append picker">
		                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                </div>
		                                            </div>
		                                            <label id="id-date-picker-1-error" class="error" for="id-date-picker-1"></label>
		                                        </div>
		                                   </div>
		                                   
			                                <div class="form-group">
			                                    <label>Cash Amount<span class="text-danger">*</span></label>
			                                    <div>
			                                      <input class="form-control" value="${rs.amount}" type="text" id="amount"  required="required" name="amount">
			                                    </div>
			                                </div>
											  <div class="form-group">
			                                    <label>Bank Name<span class="text-danger">*</span> </label>
			                                      <sql:query var="marketing" dataSource="jdbc/rmc">
			                                    	select b.bank_detail_id,b.bank_name,g.group_name
			                                        from bank_detail b,business_group g
			                                        where b.business_id=g.business_id
			                                        and b.business_id like if(?=0,'%%',?)
			                                        <sql:param value="${bean.business_id}"/>
			                                        <sql:param value="${bean.business_id}"/>
			                                    </sql:query>
												<select id="bank_detail_id"  name="bank_detail_id" required="required"   class="select2"  data-placeholder="Choose Bank Detail">
													<option value="">&nbsp;</option>
													<c:forEach var="marketing" items="${marketing.rows}">
													<option value="${marketing.bank_detail_id}" ${(marketing.bank_detail_id==rs.bank_detail_id)?'selected':''}>
															${marketing.bank_name} - (${marketing.group_name})</option>
													</c:forEach>
												</select>
			                                </div>
											
			                                <div class="form-group">
			                                    <label>Received By<span class="text-danger">*</span></label>
			                                    <sql:query var="user" dataSource="jdbc/rmc">
			                                    	select user_id,user_name from user where user_type not in('gst','gstbilling','gstqc') and user_status='active'
			                                    </sql:query>
												<select class="select2" name="received_by" id="received_by" required="required">
													<option value="">Select Received Person</option>
													<c:forEach var="user" items="${user.rows}">
														<option value="${user.user_id}" ${(user.user_id==rs.received_by)?'selected':''}>${user.user_name}</option>
													</c:forEach>
		                                        </select>
			                                </div>
			                                
			                                
			                                
			                                <div class="form-group">
			                                    <label>Purpose<span class="text-danger">*</span></label>
			                                    <div>
			                                      <textarea class="form-control" id="purpose"   required="required" name="purpose">${rs.purpose}</textarea>
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="col-sm-5">
			                            	<div class="col-xs-6 col-sm-12 text-center">
		                                        <div class="card-box widget-flat border-custom bg-custom text-white">
		                                            <i class=" fa fa-money"></i>
		                                            <h3 class="m-b-10" id="petty-cash-amount"></h3>
		                                            <p class="text-uppercase m-b-5 font-13 font-600">AMOUNT RECEIVED</p>
		                                        </div>
		                                    </div>
		                                    <div class="col-xs-6 col-sm-12 text-center">
		                                        <div class="card-box widget-flat border-custom  text-white" style="background-color: #2a57c9;">
		                                            <i class=" fa fa-money"></i>
		                                            <h3 class="m-b-10" id="transaction-amount"></h3>
		                                            <p class="text-uppercase m-b-5 font-13 font-600">AMOUNT SPEND</p>
		                                        </div>
		                                    </div>
		                                    <div class="col-xs-6 col-sm-12 text-center">
		                                        <div class="card-box widget-flat border-custom  text-white" style="background-color: #f75d68;">
		                                            <i class=" fa fa-money"></i>
		                                            <h3 class="m-b-10" id="remaining-amount"></h3>
		                                            <p class="text-uppercase m-b-5 font-13 font-600">REMAINING AMOUNT</p>
		                                        </div>
		                                    </div>
		                                 </div>
		                                <div class="col-sm-12 text-center">
		                                	<div class="form-group">
			                                    <div>
			                                        <button type="submit" id="savebtn" class="btn btn-custom waves-effect waves-light">
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
		                    	<form class="" id="myform" action="PettyCashController?action=InsertPettyCash" method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="col-sm-1"></div>
			                           	<div class="col-sm-6">
			                           	   <div class="form-group">
			                                    <label>Plant<span class="text-danger">*</span></label>
												<sql:query var="plant" dataSource="jdbc/rmc">
			                                    	select plant_id,plant_name
			                                        from plant
			                                        where business_id like if(0=?,'%%',?)
			                                        <sql:param value="${bean.business_id}"/>
			                                        <sql:param value="${bean.business_id}"/>
			                                    </sql:query>
												<select class="form-control" name="plant_id" id="plant_id" required="required">
													<c:forEach items="${plant.rows}" var="plant">
														<option value="${plant.plant_id}">${plant.plant_name}</option>
													</c:forEach>
		                                        </select>
			                                </div>
			                                
			                                <div class="form-group">
		                                        <label>Payment Date <span class="text-danger"></span> </label>
		                                        <div>
		                                            <div class="input-group">
		                                                <input type="text" name="date" class="form-control date-picker invoice_date"
		                                                	 required="required" placeholder="dd/mm/yyyy"
		                                                	  id="id-date-picker-1" data-date-format="dd/mm/yyyy"
		                                                	  readonly="readonly" style="background-color: white;">
		                                                <div class="input-group-append picker">
		                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                </div>
		                                            </div>
		                                            <label id="id-date-picker-1-error" class="error" for="id-date-picker-1"></label>
		                                        </div>
		                                   </div>
		                                   
			                                <div class="form-group">
			                                    <label>Cash Amount<span class="text-danger">*</span></label>
			                                    <div>
			                                      <input class="form-control" type="text" id="amount"  required="required" name="amount">
			                                    </div>
			                                </div>
											  <div class="form-group">
			                                    <label>Bank Name<span class="text-danger">*</span> </label>
			                                      <sql:query var="marketing" dataSource="jdbc/rmc">
			                                    	select b.bank_detail_id,b.bank_name,g.group_name
			                                        from bank_detail b,business_group g
			                                        where b.business_id=g.business_id
			                                        and b.business_id like if(?=0,'%%',?)
			                                        <sql:param value="${bean.business_id}"/>
			                                        <sql:param value="${bean.business_id}"/>
			                                    </sql:query>
												<select id="bank_detail_id"  name="bank_detail_id" required="required"   class="select2"  data-placeholder="Choose Bank Detail">
													<option value="">&nbsp;</option>
													<c:forEach var="marketing" items="${marketing.rows}">
													<option value="${marketing.bank_detail_id}" >${marketing.bank_name} - (${marketing.group_name})</option>
													</c:forEach>
												</select>
			                                </div>
											
			                                <div class="form-group">
			                                    <label>Received By<span class="text-danger">*</span></label>
			                                    <sql:query var="user" dataSource="jdbc/rmc">
			                                    	select user_id,user_name
			                                        from user
			                                        where user_type not in ('gst','gstbilling','gstqc','sgst','gststore','gstaccount','gstadmin','gstmarketing')
			                                        and user_status='active'
			                                    </sql:query>
												<select class="select2" name="received_by" id="received_by" required="required">
													<option value="">Select Received Person</option>
													<c:forEach var="user" items="${user.rows}">
														<option value="${user.user_id}">${user.user_name}</option>
													</c:forEach>
		                                        </select>
			                                </div>
			                                
			                                
			                                
			                                <div class="form-group">
			                                    <label>Purpose<span class="text-danger">*</span></label>
			                                    <div>
			                                      <textarea class="form-control" id="purpose"   required="required" name="purpose"></textarea>
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="col-sm-5">
			                            	<div class="col-xs-6 col-sm-12 text-center">
		                                        <div class="card-box widget-flat border-custom bg-custom text-white">
		                                            <i class=" fa fa-money"></i>
		                                            <h3 class="m-b-10" id="petty-cash-amount"></h3>
		                                            <p class="text-uppercase m-b-5 font-13 font-600">AMOUNT RECEIVED</p>
		                                        </div>
		                                    </div>
		                                    <div class="col-xs-6 col-sm-12 text-center">
		                                        <div class="card-box widget-flat border-custom  text-white" style="background-color: #2a57c9;">
		                                            <i class=" fa fa-money"></i>
		                                            <h3 class="m-b-10" id="transaction-amount"></h3>
		                                            <p class="text-uppercase m-b-5 font-13 font-600">AMOUNT SPEND</p>
		                                        </div>
		                                    </div>
		                                    <div class="col-xs-6 col-sm-12 text-center">
		                                        <div class="card-box widget-flat border-custom  text-white" style="background-color: #f75d68;">
		                                            <i class=" fa fa-money"></i>
		                                            <h3 class="m-b-10" id="remaining-amount"></h3>
		                                            <p class="text-uppercase m-b-5 font-13 font-600">REMAINING AMOUNT</p>
		                                        </div>
		                                    </div>
		                                 </div>
		                                <div class="col-sm-12 text-center">
		                                	<div class="form-group">
			                                    <div>
			                                        <button type="submit" id="savebtn" class="btn btn-custom waves-effect waves-light">
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

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="js/Accounts/PettyCash/AddPettyCash.js"></script>
		<script src="assets/js/ace.min.js"></script>
		<script type="text/javascript" src="validation/jquery.validate.js"></script>
    </body>
</html>