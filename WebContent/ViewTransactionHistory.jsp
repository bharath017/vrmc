<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Transaction History</title>
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
		<!-- Custom box css -->
		<!-- DataTables -->
        <link href="plugins/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
		
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/select2.min.css" />
        <link rel="stylesheet" href="assets/css/render.css">
        <script src="assets/js/modernizr.min.js"></script>
        <style type="text/css">
        	.customer-table tr td:first-child,.table th {
					background-color: #13b2b5;
					color: white;
				}
				
				
				
				@media print {
					  body * {
					    visibility: hidden;
					  }
					  #print-me {
					    visibility: visible;
					  }
				}
        </style>

    </head>

    <body>

        <!-- Navigation Bar-->
        	<%@ include file="header.jsp" %>
        <!-- End Navigation Bar-->

        <div class="wrapper">
            <div class="container-fluid">
                <!-- end page title end breadcrumb -->
                <div class="row">
                	<div class="col-sm-12">
                		<div class="page-title-box">
                            <div class="btn-group pull-right">
                                <ol class="breadcrumb hide-phone p-0 m-0">
                                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                                    <li class="breadcrumb-item"><a href="#">Customer List</a></li>
                                    <li class="breadcrumb-item active">Customer Panel</li>
                                    <li class="breadcrumb-item active">Payment List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Payment List</h4>
                        </div>
                	</div>
                </div>
                <div class="row">
                	<div class="col-sm-12">
                		<div class="col-sm-3 pull-right">
                          	<div class="form-group">
                                   <label>Choose Customer<span class="text-danger">*</span></label>
                                   <sql:query var="customer" dataSource="jdbc/rmc">
                                   		select * from customer order by customer_name asc
                                   </sql:query>
								<select id="customer_id"    class="select2"  data-placeholder="Choose Customer">
									<option value="">&nbsp;</option>
									<c:forEach var="customer" items="${customer.rows}">
									<option value="${customer.customer_id}" ${(customer.customer_id==customer_id)?'selected':''}>${customer.customer_name}</option>
									</c:forEach>
								</select>
                            </div>
                        </div>
                        
                        <div class="col-sm-3 pull-left">
                        	<br>
                          	<a href="AddCustomer.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Add Customer</a>
                          	<a href="AddCustomer.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Customer List</a>
                        </div>
                	</div>
                </div>
                
             	<div class="row">
             		<div class="col-md-12">
                        <div class="card-box">
                            <sql:query var="name" dataSource="jdbc/rmc">
                        		select customer_name from customer where customer_id=?
                        		<sql:param value="${customer_id}"/>
                        	</sql:query>
                        	
                            <h4 class="header-title m-t-0 m-b-30">
                            	<c:forEach items="${name.rows}" var="name">
                            		${name.customer_name}
                            	</c:forEach>
                            </h4>

                            <ul class="nav nav-pills navtab-bg nav-justified pull-in ">
                                <li class="nav-item">
                                    <a href="ViewCustomer.jsp" aria-expanded="false" class="nav-link">
                                        <i class="fi-head mr-2"></i>Profile
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="ViewInvoice.jsp" aria-expanded="true" class="nav-link">
                                        <i class="fa fa-money mr-2"></i>Invoice
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="ViewPurchaseOrder.jsp" aria-expanded="false" class="nav-link">
                                        <i class="fa fa-shopping-cart mr-2"></i>Purchase Order
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="ViewPayment.jsp"  aria-expanded="false" class="nav-link">
                                        <i class="fa fa-paypal mr-2"></i>Payment
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="ViewTransactionHistory.jsp"  aria-expanded="false" class="nav-link active">
                                        <i class="fa fa-paypal mr-2"></i>Transaction History
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="ViewMixDesign.jsp"  aria-expanded="false" class="nav-link">
                                        <i class="fi-cog mr-2"></i>Mix Design
                                    </a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane show active" id="home1">
                                	<div class="row filter-row">
					                    <div class="col-sm-2 col-xs-6 form-group">
					                        <label>From Date : </label>
					                        <div>
					                            <div class="input-group">
					                                <input type="text" name="scheduling_date" class="form-control date-picker from_date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
					                                <div class="input-group-append">
					                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                    
					                     <div class="col-sm-2 col-xs-6 form-group">
					                        <label>To Date : </label>
					                        <div>
					                            <div class="input-group">
					                                <input type="text" name="scheduling_date" class="form-control date-picker to_date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
					                                <div class="input-group-append">
					                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                    
					                    <div class="col-sm-2 col-xs-6">
					                        <div class="form-group form-focus select-focus">
					                            <label class="control-label">Site : </label>
					                            <sql:query var="site" dataSource="jdbc/rmc">
					                            	select * from site_detail where customer_id=?
					                            	<sql:param value="${customer_id}"/>
					                            </sql:query>
					                            <select class="form-control select2 floating"   id="site_id">
					                                <option value="">All Site</option>
					                                <c:forEach var="site" items="${site.rows}">
					                                	<option value="${site.site_id}">${site.site_name}</option>
					                                </c:forEach>
					                            </select>
					                        </div>
					                    </div>
					                   
					                    <div class="col-sm-2 col-xs-6">
					                        <div class="form-group form-focus">
					                            <label class="control-label">&nbsp;</label>
					                            <a href="#" id="search" class="btn btn-success btn-block"> Search </a>
					                        </div>
					                    </div>
					                </div>
                                	
                                	<sql:query var="details" dataSource="jdbc/rmc">
		                           		select * from customer where customer_id=?
		                           		<sql:param value="${customer_id}"/>
		                           	</sql:query>
		                           	
		                         	<c:forEach items="${details.rows}" var="details">
		                         		<c:set value="${details}" var="rs"/>
		                         	</c:forEach>
		                         	<c:set value="${(empty param.action || param.action=='')?'':param.action}" var="action"/>
		                         	<c:set value="${(empty param.site_id)?0:param.site_id}" var="site_id"/>
		                         	
		                         	<!-- GET SITE ALL SITE DETAIL'S HERE -->
		                         	<sql:query var="site" dataSource="jdbc/rmc">
		                         		select site_id,site_name from 
		                         		site_detail
		                         		where site_id like if(0=?,'%%',?)
		                         		and customer_id=?
		                         		<sql:param value="${site_id}"/>
		                         		<sql:param value="${site_id}"/>
		                         		<sql:param value="${customer_id}"/>
		                         	</sql:query>
		                       
		                       		
		                         	
		                         	
		                         	
		                         	<div class="text-right">
		                         		<button class="btn btn-success" onclick="print();">Print</button>&nbsp;&nbsp;&nbsp;&nbsp;
			                         	<button class="btn btn-danger" id="btnExport">Pdf</button>
		                         	</div>
                                    <div class="col-sm-12 table-responsive print-me" id="print-me">
			                            <table  class="table table-striped table-bordered table-condensed" id="tblCustomers" cellspacing="0" width="100%">
			                                <thead>
				                                <tr>
													<th class="text-left">Date</th>
													<th class="text-left">TYPE OF TRANSACTION</th>
													<th class="text-left">DEBIT</th>
													<th class="text-left">CREDIT</th>
												</tr>
			                                </thead>
			                                
			                                <tbody>
			                                
			                                	<c:forEach items="${site.rows}" var="site"> 
			                                	<c:set value="0" var="total_debit"/>
		                         				<c:set value="0" var="total_credit"/>	
					                         	<c:choose>
					                         		<c:when test="${empty action || action==''}">
					                         			<sql:query var="opening" dataSource="jdbc/rmc">
							                         		select sum(net_amount) as debit,0 as credit,DATE_FORMAT(max(invoice_date),'%d/%m/%Y') as date,'Opening balance Sales' as type
															from invoice where year(invoice_date) < year(curdate())
															and customer_id=?
															and site_id=?
															UNION ALL   
															select 0 as debit,sum(payment_amount) as credit,DATE_FORMAT(max(payment_date),'%d/%m/%Y') as date,'Opening balance payment' as type
															from customer_payment where year(payment_date) < year(curdate())
															and customer_id=?
															and site_id=?
															<sql:param value="${customer_id}"/>
															<sql:param value="${site.site_id}"/>
															<sql:param value="${customer_id}"/>
															<sql:param value="${site.site_id}"/>
							                         	</sql:query>
							                         	
							                         	<sql:query var="transaction" dataSource="jdbc/rmc">
						                         			select t.* from (select DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as date,i.net_amount as debit,0 as credit,concat('GST/',i.invoice_id) as type
						                         			from invoice i where year(invoice_date) = year(curdate())
						                         			and i.customer_id=?
						                         			and i.site_id=?
						                         			UNION ALL
						                         			select DATE_FORMAT(p.payment_date,'%d/%m/%Y') as date,0 as debit,p.payment_amount as credit,payment_mode as type
						                         			from customer_payment p where year(payment_date) = year(curdate())
						                         			and p.customer_id=? and p.site_id=?) as t order by t.date asc
						                         			<sql:param value="${customer_id}"/>
						                         			<sql:param value="${site.site_id}"/>
						                         			<sql:param value="${customer_id}"/>
						                         			<sql:param value="${site.site_id}"/>
						                         		</sql:query>
					                         		</c:when>
					                         		<c:otherwise>
					                         			<sql:query var="opening" dataSource="jdbc/rmc">
							                         		select sum(net_amount) as debit,0 as credit,DATE_FORMAT(max(invoice_date),'%d/%m/%Y') as date,'Opening balance Sales' as type
															from invoice where invoice_date < if(?='','2000-01-01',?)
															and customer_id=?
															and site_id like if(?=0,'%%',?)
															UNION ALL
															select 0 as debit,sum(payment_amount) as credit,DATE_FORMAT(max(payment_date),'%d/%m/%Y') as date,'Opening balance payment' as type
															from customer_payment where payment_date < if(?='','2000-01-01',?)
															and customer_id=?
															and site_id like if(?=0,'%%',?)
															<sql:param value="${param.from_date}"/>
															<sql:param value="${param.from_date}"/>
															<sql:param value="${customer_id}"/>
															<sql:param value="${site.site_id}"/>
															<sql:param value="${site.site_id}"/>
															<sql:param value="${param.from_date}"/>
															<sql:param value="${param.from_date}"/>
															<sql:param value="${customer_id}"/>
															<sql:param value="${site.site_id}"/>
															<sql:param value="${site.site_id}"/>
							                         	</sql:query>
							                         	
							                         	<sql:query var="transaction" dataSource="jdbc/rmc">
						                         			select t.* from (select DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as date,i.net_amount as debit,0 as credit,concat('GST/',i.invoice_id) as type
						                         			from invoice i where invoice_date between if(?='','2000-01-01',?) and if(?='','3000-01-01',?)
						                         			and i.customer_id=?
						                         			and i.site_id like if(0=?,'%%',?)
						                         			UNION ALL
						                         			select DATE_FORMAT(p.payment_date,'%d/%m/%Y') as date,0 as debit,p.payment_amount as credit,payment_mode as type
						                         			from customer_payment p where payment_date between if(?='','2000-01-01',?) and if(?='','3000-01-01',?)
						                         			and p.customer_id=? and p.site_id like if(?=0,'%%',?)) as t order by t.date asc
						                         			<sql:param value="${param.from_date}"/>
						                         			<sql:param value="${param.from_date}"/>
						                         			<sql:param value="${param.to_date}"/>
						                         			<sql:param value="${param.to_date}"/>
						                         			<sql:param value="${customer_id}"/>
						                         			<sql:param value="${site.site_id}"/>
						                         			<sql:param value="${site.site_id}"/>
						                         			<sql:param value="${param.from_date}"/>
						                         			<sql:param value="${param.from_date}"/>
						                         			<sql:param value="${param.to_date}"/>
						                         			<sql:param value="${param.to_date}"/>
						                         			<sql:param value="${customer_id}"/>
						                         			<sql:param value="${site.site_id}"/>
						                         			<sql:param value="${site.site_id}"/>
						                         		</sql:query>
					                         		</c:otherwise>
					                         	</c:choose>
					                         	<tr>
			                                    	<td class="text-right" colspan="5"><h5 class="text-left">${site.site_name}</h5></td>
			                                    </tr>
			                                	<c:forEach items="${opening.rows}" var="opening">
			                                	<c:set value="${total_debit+opening.debit}" var="total_debit"/>
			                                	<c:set value="${total_credit+opening.credit}" var="total_credit"/>
			                                   	<tr>
			                                        <td class="text-left"><a href="#">${opening.date}</a></td>
			                                        <td class="text-left">${opening.type}</td>
			                                        <td class="text-left">${(opening.debit==0)?'':opening.debit}</td>
			                                        <td class="text-left">${(opening.credit==0)?'':opening.credit}</td>
			                                    </tr>
			                                    </c:forEach>
			                                    <c:forEach items="${transaction.rows}" var="transaction">
			                                    <c:set value="${total_debit+transaction.debit}" var="total_debit"/>
			                                    <c:set value="${total_credit+transaction.credit}" var="total_credit"/>
			                                    <tr>
			                                        <td class="text-left"><a href="#">${transaction.date}</a></td>
			                                        <td class="text-left">${transaction.type}</td>
			                                        <td class="text-left">${(transaction.debit==0)?'':transaction.debit}</td>
			                                        <td class="text-left">${(transaction.credit==0)?'':transaction.credit}</td>
			                                    </tr>
			                                    </c:forEach>
			                                    
			                                    <tr>
			                                    	<th colspan="2" class="text-right">Total : </th>
			                                    	<th><fmt:formatNumber value="${total_debit}" maxFractionDigits="2" groupingUsed="false"/></th>
			                                    	<th><fmt:formatNumber value="${total_credit}" maxFractionDigits="2" groupingUsed="false"/></th>
			                                    </tr>
			                                    <tr>
			                                    	<th class="text-right" colspan="3">Balance : </th>
			                                    	<th><fmt:formatNumber value="${total_debit-total_credit}" maxFractionDigits="2" groupingUsed="false"/></th>
			                                    </tr>
			                                    </c:forEach> 
			                                </tbody>
			                            </table>
			                        </div>
                                </div>
                            </div>
                        </div>
                    </div> <!-- end col -->
              	 </div>
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
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.22/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>
        <script src="picker/js/moment.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		
		<!-- Required datatable js -->
        <script src="plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="plugins/datatables/dataTables.bootstrap4.min.js"></script>
       
        <script type="text/javascript">
            $(document).ready(function() {
                $('form').parsley();
                
                $('.select2').css('width','100%').select2({allowClear:true})
				.on('change', function(){
				}); 
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function() {

                // Default Datatable
                $('#datatable').DataTable();

                
                // Key Tables

                $('#key-table').DataTable({
                    keys: true
                });
                
                $('#example').dataTable({
                    /* No ordering applied by DataTables during initialisation */
                    "order": []
                });

                // Responsive Datatable
                $('#responsive-datatable').DataTable();

                // Multi Selection Datatable
                $('#selection-datatable').DataTable({
                    select: {
                        style: 'multi'
                    }
                });
                
            } );

        </script>
        <script type="text/javascript">
        $(document).ready(function() {
            $('.date-picker').datepicker({
   				autoclose: true,
   				todayHighlight: true
   		 	});
   			//show datepicker when clicking on the icon
          });
        </script>
        <script type="text/javascript">
        	$(document).ready(function(){
        		$('#customer_id').on("change",function(){
        			var customer_id=$('#customer_id').val();
        			$.ajax({
                		type:'POST',
                		url:'CustomerController?action=changeCustomer&customer_id='+customer_id,
                		headers:{
                			Accept:"text/html;charset=utf-8",
                			"Content-Type":"text/html;charset=utf-8"
                		},
                		success:function(result){
                			location.reload();
                		}
                	}); 
        		});
        	});
        </script>
        <script type="text/javascript">
        	function updateCustomerAddress(site_id){
        		$.ajax({
        			type:'POST',
        			url:'CustomerController?action=getSiteDetailsForUpdate&site_id='+site_id,
        			headers:{
        				Accept:"application/json;charset=utf-8",
        				"Content-Type":"application/json;charset=utf-8"
        			},
        			success:function(res){
        				$('#edit_site_id').val(res.site_id);
        				$('#edit_site_name').val(res.site_name);
        				$('#edit_site_address').val(res.site_address);
        				$('#edit_tally_ledger').val(res.tally_ladger);
        			}
        		})
        	}
        </script>
        <script type="text/javascript">
        	function changeAddressStatus(site_id,site_name,site_status){
        		$('.show_status').text(site_status);
        		$('.site_name').text(site_name);
        		$('#status_site_id').val(site_id);
        		$('#site_status').val(site_status);
        	}
        </script>
         <script type="text/javascript">
		    $(document).ready(function(){
		    	$('#search').on('click',function(){
		    		var from_date=$('.from_date').val();
		    		var to_date=$('.to_date').val();
		    		var site_id=$('#site_id').val();
		    		window.location="ViewTransactionHistory.jsp?action=date&from_date="+from_date+"&to_date="+to_date+'&site_id='+site_id;
		    	});
		    });
    	</script>
    	<script type="text/javascript">
		    function print() {
		        var frame = document.getElementsByClassName('print-me').item(0);
		        var data = frame.innerHTML;
		        var win = window.open('', '', 'height=500,width=900');
		        win.document.write('<style>@page{size:landscape;}@media print{*{font-size:12px;}}</style><html><head><title></title>');
		        win.document.write('</head><body >');
		        win.document.write(data);
		        win.document.write('</body></html>');
		        win.print();
		        win.close();
		        return true;
		    }
       </script>
       
       <script type="text/javascript">
        $("body").on("click", "#btnExport", function () {
            html2canvas($('#tblCustomers')[0], {
                onrendered: function (canvas) {
                    var data = canvas.toDataURL();
                    var docDefinition = {
                        content: [{
                            image: data,
                            width: 500
                        }]
                    };
                    pdfMake.createPdf(docDefinition).download("Table.pdf");
                }
            });
        });
    </script>

    </body>
</html>