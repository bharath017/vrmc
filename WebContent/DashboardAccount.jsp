<%@ include file="Session.jsp" %>
<!DOCTYPE html>
<html>
    
<!-- Mirrored from coderthemes.com/highdmin/horizontal/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 18 Mar 2018 15:53:37 GMT -->
<head>
        <meta charset="utf-8" />
        <title>Dashboard-${initParam.company_name}</title>
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

        <script src="assets/js/modernizr.min.js"></script>

    </head>

    <body>

        <!-- Navigation Bar-->
        <!-- PUT HEADER.JSP HERE -->
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
                                    <li class="breadcrumb-item"><a href="#">Build RMC</a></li>
                                    <li class="breadcrumb-item active">Dashboard</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Dashboard</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->


                <div class="row">
                    <div class="col-12">
                        <div class="card-box">
                            <h4 class="header-title mb-4">TODAY ACCOUNTS OVERVIEW</h4>
							<div class="text-center mt-4 mb-4">
                                <div class="row">
                                	<!-- Get all invoice quantity here -->
                                	<sql:query var="invoice" dataSource="jdbc/rmc">
                                		select sum(quantity) as total,count(id) as inv_num from invoice where invoice_date=curdate() and plant_id like if(0=?,'%%',?);
                                		<sql:param value="${bean.plant_id}"/>
                                		<sql:param value="${bean.plant_id}"/>
                                	</sql:query>
                                	<c:forEach items="${invoice.rows}" var="invoice">
                                		<c:set value="${invoice}" var="rs"/>
                                	</c:forEach>
                                    <div class="col-xs-6 col-sm-3">
                                        <div class="card-box widget-flat border-custom bg-custom text-white">
                                            <i class=" fa fa-money"></i>
                                            <h3 class="m-b-10">${(empty rs.total)?0:rs.total}</h3>
                                            <p class="text-uppercase m-b-5 font-13 font-600">TOTAL INVOICE QUANTITY</p>
                                        </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-3">
                                        <div class="card-box bg-primary widget-flat border-primary text-white">
                                            <i class="fi-archive"></i>
                                            <h3 class="m-b-10">${(empty rs.total)?0:rs.inv_num}</h3>
                                            <p class="text-uppercase m-b-5 font-13 font-600">TOTAL NO OF INVOICE</p>
                                        </div>
                                    </div>
                                    
                                    <!-- Get total customer payment details -->
                                    <sql:query var="payment" dataSource="jdbc/rmc">
                                    	select sum(payment_amount) as total_pay from customer_payment where payment_date=curdate();
                                    </sql:query>
                                    <c:forEach var="payment" items="${payment.rows}">
                                    	<c:set value="${payment}" var="pay"/>
                                    </c:forEach>
                                    <div class="col-xs-6 col-sm-3">
                                        <div class="card-box widget-flat border-success bg-success text-white">
                                            <i class="fi-help"></i>
                                            <h3 class="m-b-10">${(empty pay.total_pay)?0:pay.total_pay}</h3>
                                            <p class="text-uppercase m-b-5 font-13 font-600">TOTAL CUSTOMER PAYMENT</p>
                                        </div>
                                    </div>
                                    
                                    <sql:query var="makepay" dataSource="jdbc/rmc">
                                    	select sum(payment_amount) as total_make from make_payment where payment_date=curdate();
                                    </sql:query>
                                    <c:forEach items="${makepay.rows}" var="makepay">
                                    	<c:set value="${makepay}" var="make"/>
                                    </c:forEach>
                                    <div class="col-xs-6 col-sm-3">
                                        <div class="card-box  widget-flat border-danger text-white" style="background-color: #dd6413;">
                                            <i class="fi-delete"></i>
                                            <h3 class="m-b-10">${(empty make.total_make)?0:make.total_make}</h3>
                                            <p class="text-uppercase m-b-5 font-13 font-600">TOTAL MAKE PAYMENT</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- end row -->
                        </div>
                    </div>
                </div>
                <!-- end row -->
                
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card-box">
                            <h4 class="header-title">TODAY INVOICE OVERVIEW</h4>
							<div class="table-responsive">
                                <table class="table table-hover table-centered m-0">
                                	<sql:query var="invoice" dataSource="jdbc/rmc">
                                		select sum(i.quantity) as quantsum,count(id) as totalinvoice,sum(net_amount) as totalamount,
                                		p.product_name,c.customer_name,pl.plant_name
										from invoice i LEFT JOIN(customer c,product p,purchase_order_item poi,plant pl)
										ON i.poi_id=poi.poi_id
										and poi.product_id=p.product_id
										and i.customer_id=c.customer_id
										and i.plant_id=pl.plant_id
										where i.invoice_date=curdate()
										and i.plant_id like if(0=?,'%%',?)
										group by c.customer_name,p.product_name,plant_name                              		
										<sql:param value="${bean.plant_id}"/>
										<sql:param value="${bean.plant_id}"/>
                                	</sql:query>
                                    <thead>
	                                    <tr class="text-center" style="background-color: #26c9e2;color: white;">
	                                        <th>Customer</th>
	                                        <th>Grade</th>
	                                        <th>Quantity</th>
	                                        <th>No Of Invoice</th>
	                                        <th>Net Amount</th>
	                                        <th>Plant</th>
	                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:set value="0" var="tquantsum"/>
                                    <c:set value="0" var="ttotalinvoice"/>
                                    <c:set value="0" var="ttotalamount"/>
                                    <c:forEach var="invoice" items="${invoice.rows}">
                                    	<c:set value="${tquantsum+invoice.quantsum}" var="tquantsum"/>
	                                    <c:set value="${invoice.totalinvoice+ttotalinvoice}" var="ttotalinvoice"/>
	                                    <c:set value="${ttotalamount+invoice.totalamount}" var="ttotalamount"/>
	                                    <tr class="text-center">
	                                        <td>
	                                            ${invoice.customer_name}
	                                        </td>
	
	                                        <td>
	                                        	${invoice.product_name}
	                                        </td>
	
	                                        <td>
												${invoice.quantsum}
	                                        </td>
	
	                                        <td>
	                                            ${invoice.totalinvoice}
	                                        </td>
	
	                                        <td>
	                                            ${invoice.totalamount}
	                                        </td>
	                                        <td>
	                                            ${invoice.plant_name}
	                                        </td>
	                                    </tr>
                                    </c:forEach>
                                    </tbody>
                                    <tfoot style="background-color: #39db84;color: white;">
                                    	<tr class="text-center">
                                    		<td>
	                                        </td>
	
	                                        <td>
	                                        </td>
	                                        <td>
												${tquantsum}
	                                        </td>
	
	                                        <td>
	                                            ${ttotalinvoice}
	                                        </td>
	
	                                        <td>
	                                            ${ttotalamount}
	                                        </td>
	                                        <td>
	                                        </td>
                                    	</tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end row -->

            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->


        <!-- Footer -->
       <!-- PUT HEADER.JSP HERE -->
       <%@ include file="footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>

        <!-- Flot chart -->
        <script src="plugins/flot-chart/jquery.flot.min.js"></script>
        <script src="plugins/flot-chart/jquery.flot.time.js"></script>
        <script src="plugins/flot-chart/jquery.flot.tooltip.min.js"></script>
        <script src="plugins/flot-chart/jquery.flot.resize.js"></script>
        <script src="plugins/flot-chart/jquery.flot.pie.js"></script>
        <script src="plugins/flot-chart/jquery.flot.crosshair.js"></script>
        <script src="plugins/flot-chart/curvedLines.js"></script>
        <script src="plugins/flot-chart/jquery.flot.axislabels.js"></script>

        <!-- KNOB JS -->
        <!--[if IE]>
        <script type="text/javascript" src="../plugins/jquery-knob/excanvas.js"></script>
        <![endif]-->
        <script src="plugins/jquery-knob/jquery.knob.js"></script>
        <!-- Dashboard Init -->
        <script src="assets/pages/jquery.dashboard.init.js"></script>
        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
    </body>
</html>