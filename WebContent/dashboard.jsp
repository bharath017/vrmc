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
                                		select sum(quantity) as total,count(id) as inv_num from dc where invoice_date=curdate() and plant_id like if(0=?,'%%',?);
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
                                            <p class="text-uppercase m-b-5 font-13 font-600">TOTAL DC QUANTITY</p>
                                        </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-9">
                                    	<sql:query var="quant" dataSource="jdbc/rmc">
                                    		select p.* from (select t.*,(select sum(quantity) from dc where plant_id=t.plant_id and  invoice_date=curdate()) as todayquantty,
											(select sum(quantity) from dc where plant_id=t.plant_id and invoice_date between DATE_SUB( LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) ), INTERVAL DAY( LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) ) )-1 DAY )  and  LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) )) as monthlysum
											from (select plant_id,plant_name from plant where plant_id like if(?=0,'%%',?)) as t) as p where monthlysum is not null
											<sql:param value="${bean.plant_id}"/>
											<sql:param value="${bean.plant_id}"/>
                                    	</sql:query>
                                        <table class="table table-bordered">
                                        	<thead>
                                        		<tr style="color: white;background-color:#26c9e2;">
	                                        		<th>Plant</th>
	                                        		<th>Today Quantity</th>
	                                        		<th>Monthly Quantity</th>
	                                        	</tr>
                                        	</thead>
                                        	<c:set value="0" var="t1"/>
                                        	<c:set value="0" var="t2"/>
                                        	<tbody>
                                        		<c:forEach items="${quant.rows}" var="quant">
	                                        		<tr>
		                                        		<td>${quant.plant_name}</td>
		                                        		<td>${(empty quant.todayquantty)?0:quant.todayquantty}</td>
		                                        		<td>${quant.monthlysum}</td>
		                                        	</tr>
		                                        	<c:set value="${t1+quant.todayquantty}" var="t1"/>
		                                        	<c:set value="${t2+quant.monthlysum}" var="t2"/>
	                                        	</c:forEach>
                                        	</tbody>
                                        	<tfoot>
                                        		<tr>
                                        			<th></th>
                                        			<th>${t1}</th>
                                        			<th>${t2}</th>
                                        		</tr>
                                        	</tfoot>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- end row -->
                        </div>
                    </div>
                </div>
                <!-- end row -->
                
                <div id="stock-area">
                	<!-- <div class="row">
	                    <div class="col-12">
	                        <div class="card-box">
	                            <h4 class="header-title mb-4">TODAY CONSUMPTION OVERVIEW(IN TON) EXCEPT ADMX IN(KG)</h4>
	                            end row
	                        </div>
	                    </div>
	                </div> -->
	                <!-- end row -->
                </div>
                
			  <c:catch var="e">

                <div class="row">
                    <div class="col-lg-7">
                        <div class="card-box">
                            <h4 class="header-title">TODAY DC OVERVIEW</h4>
                            <select class="select" name="duration" id="duration">
                            	<option value="t">Today</option>
                            	<option value="y">Yesterday</option>
                            	<option value="tw">This Week</option>
                            	<option value="lw">Last Week</option>
                            	<option value="tm">This Month</option>
                            	<option value="lm">Last Month</option>
                            </select>
							<div class="table-responsive">
                                <table class="table table-hover table-centered m-0" id="invoictable">
                                	<sql:query var="invoice" dataSource="jdbc/rmc">
                                		select sum(i.quantity) as quantsum,count(id) as totalinvoice,sum(net_amount) as totalamount,
                                		p.product_name,c.customer_name,pl.plant_name
										from dc i LEFT JOIN(customer c,product p,purchase_order_item poi,plant pl)
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
	                                        <td id="total_quant">
												${tquantsum}
	                                        </td>
	
	                                        <td id="total_invoice">
	                                            ${ttotalinvoice}
	                                        </td>
	
	                                        <td id="total_amount">
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

                    <div class="col-lg-5">
                        <div class="card-box">
                            <h4 class="header-title">TODAY INVENTORY OVERVIEW</h4>
							<div class="table-responsive">
                                <table class="table table-hover table-centered m-0">
                                    <thead>
	                                    <tr class="text-center" style="background-color: #26c9e2;color: white;">
	                                        <th>Inventory</th>
	                                        <th>Supplier Name</th>
	                                        <th>Total Load(TONN)</th>
	                                        <th>Plant Name</th>
	                                    </tr>
                                    </thead>
                                    <sql:query var="inventory" dataSource="jdbc/rmc">
                                    	select truncate(sum(i.loaded_weight/1000),2) as total_load,s.supplier_name,it.inventory_name,pl.plant_name
                                    	from inventory i LEFT JOIN(inventory_item it,supplier s,plant pl)
                                    	ON i.inv_item_id=it.inv_item_id
                                    	and i.supplier_id=s.supplier_id
                                    	and i.plant_id=pl.plant_id
                                    	where i.date=curdate()
                                    	and i.plant_id like if(0=?,'%%',?)
                                    	group by it.inventory_name,s.supplier_name,it.inventory_name,pl.plant_name
                                    	<sql:param value="${bean.plant_id}"/>
                                    	<sql:param value="${bean.plant_id}"/>
                                    </sql:query>
                                    <tbody>
	                                    <c:forEach items="${inventory.rows}" var="inventory">
	                                    	<tr class="text-center">
		                                        <td>
													${inventory.inventory_name}
		                                        </td>
		
		                                        <td>
		                                           ${inventory.supplier_name}
		                                        </td>
		
		                                        <td>
		                                            ${inventory.total_load}
		                                        </td>
		                                        <td>
		                                            ${inventory.plant_name}
		                                        </td>
		                                    </tr>
	                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end row -->


		<div class="row">
                    <c:if test="${usertype=='superadmin'}">
                    	<div class="col-lg-7">
	                        <div class="card-box">
	                            <h4 class="header-title mb-3">TODAY WINVOICE OVERVIEW</h4>
	                            <div class="table-responsive">
	                                <table class="table table-hover table-centered m-0">
	                                	<sql:query var="invoice" dataSource="jdbc/rmc">
	                                		select sum(i.quantity) as quantsum,count(id) as totalinvoice,sum(net_amount) as totalamount,
	                                		p.product_name,c.customer_name,pl.plant_name
											from test_dc i LEFT JOIN(test_customer c,product p,test_purchase_order_item poi,plant pl)
											ON i.poi_id=poi.poi_id
											and poi.product_id=p.product_id
											and i.customer_id=c.customer_id
											and i.plant_id=pl.plant_id
											where i.invoice_date=curdate()
											and i.plant_id like if(0=?,'%%',?)
											group by c.customer_name,p.product_name,pl.plant_name                             		
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
		                                        <th>Plant Name</th>
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
                    </c:if>
                </div>

                <div class="row">
                    <div class="col-lg-8">
                        <div class="card-box">
                            <h4 class="header-title mb-3">INCOMING SCHEDULING DETAIL'S</h4>

                            <div class="table-responsive">
                                <table class="table table-hover table-centered m-0">

                                    <thead>
	                                    <tr class="text-center" style="background-color: #26c9e2;color: white;">
	                                        <th>Customer</th>
	                                        <th>Site</th>
	                                        <th>Plant</th>
	                                        <th>Start Time</th>
	                                        <th>End Time</th>
	                                        <th>Quantity</th>
	                                    </tr>
                                    </thead>
                                    <sql:query var="sch" dataSource="jdbc/rmc">
										 select si.*,sc.*,c.customer_name,s.site_name,p.product_name,
										 (select plant_name from plant where plant_id=sc.plant_id) as plant_name
										 from scheduling_item si LEFT JOIN(scheduling sc,customer c,site_detail s,product p)
										 ON si.scheduling_id=sc.scheduling_id
										 and si.product_id=p.product_id
										 and sc.customer_id=c.customer_id
										 and sc.site_id=s.site_id
										 where sc.scheduling_date=curdate()
										 and sc.plant_id like if(0=?,'%%',?)
										 and si.production_quantity>0
										 <sql:param value="${bean.plant_id}"/>
										 <sql:param value="${bean.plant_id}"/>
									</sql:query>
                                    <tbody>
                                    	<c:set value="0" var="tquant"/>
	                                    <c:forEach items="${sch.rows}" var="sch">
	                                    	<c:set value="${tquant+sch.production_quantity}" var="tquant"/>
	                                    	<tr class="text-center">
		                                        <td>
		                                            ${sch.customer_name}
		                                        </td>
		
		                                        <td>
													${sch.site_name}
		                                        </td>
		
		                                        <td>
													${(empty sch.plant_name)?'All Plant':sch.plant_name}
		                                        </td>
		
		                                        <td>
		                                            ${sch.start_time}
		                                        </td>
		
		                                        <td>
		                                            ${sch.end_time}
		                                        </td>
		
		                                        <td>
													${sch.production_quantity}
		                                        </td>
		                                    </tr>
	                                    </c:forEach>
	                                    	<tr style="background-color: #39db84;color: white;">
	                                    		<td colspan="6">TOTAL QUANTITY FOR PRODUCTION : ${tquant}</td>
	                                    	</tr>
                                    </tbody>
                                </table>
                                <input type="hidden" id="bus_id" value="${bean.plant_id}"/>
                            </div>
                        </div>
					  </div>
                    </div>
		    </c:catch>
		    ${e}
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

      
        <script src="plugins/jquery-knob/jquery.knob.js"></script>
        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        
        <script type="text/javascript">
        	$(document).ready(function(){
        		$('#duration').change(function(){
        			var duration=$('#duration').val();
        			$.ajax({
        				type:'post',
        				url:'OtherController?action=GetInvoieDetails&duration='+duration,
        				headers:{
        					Accept:"application/json;charset=utf-8",
        					"Content-Type":"application/json;charset=utf-8"
        				},
        				success:function(res){
        					if(res.result=='noval'){
        						$('#invoictable tbody').html("");
        						$('#total_quant').text(0);
            					$('#total_invoice').text(0);
            					$('#total_amount').text(0);
        					}else{
        						$('#invoictable tbody').html("");
            					var totalquantsum=0;
            					var nettotalinvoice=0;
            					var nettotalamount=0;
            					$.each(res,function(i,s){
            						totalquantsum+=parseFloat(s.quantsum);
            						nettotalinvoice+=s.totalinvoice;
            						nettotalamount+=s.totalamount;
            						var row='<tr>'
            						row+='<td>'+s.customer_name+'</td>'
            						row+='<td>'+s.product_name+'</td>'
            						row+='<td>'+s.quantsum+'</td>'
            						row+='<td>'+s.totalinvoice+'</td>'
            						row+='<td>'+s.totalamount+'</td>'
            						row+='<td>'+s.plant_name+'</td>'
            						row+='</tr>'
            						$('#invoictable tbody').append(row);
            					});
            					
            					$('#total_quant').text(totalquantsum);
            					$('#total_invoice').text(nettotalinvoice);
            					$('#total_amount').text(nettotalamount);
        					}
        				}
        			});
        		});
        		
        		let getStockReport= function() {
        			$.ajax({
        				type:'post',
        				url:'OtherController?action=getStockReport',
        				headers:{
        					Accept:"application/json;charset=utf-8",
        					"Content-Type":"application/json;charset=utf-8"
        				},
        				success:function(res){
        					let count=0;
        					let plant_id=$('#bus_id').val();
        					$.each(res,function(i,v){
        						if(plant_id==v.plant_id || plant_id==0){
        						let html='<div class="row">'
        	                    				html+='<div class="col-12">'
    	                       					html+='<div class="card-box">'
    	                           				 html+='<h4 class="header-title mb-4">CURRENT STOCK IN <span style="color:#fd7e14;">'+v.plant_name+'</span> Plant (TON)</h4>'
				
    	                            				html+='<table class="table table-bordered" id="Table'+count+'">'
    	                            				html+='<tr id="name" style="background-color:#02c0ce;color:white;"></tr>'
    	                           				 html+='<tr id="value"></tr>'
    	                            html+='</table>'
    	                       		html+='</div>'
    	                    		html+='</div>'
    	               			    html+='</div>'
    	               			    $('#stock-area').append(html);
   	               			       $.each(v.stockList,function(j,val){
   	               			    	   	if(val.item_value>0){
    	                            			$('#Table'+count+' tr#name').append('<th>'+val.item_name+'</th>');
							if(val.stock_unit=='TON')
    	                            				$('#Table'+count+' tr#value').append('<td>'+Math.round((val.item_value/1000)*100)/100+'</td>');
							else
								$('#Table'+count+' tr#value').append('<td>'+Math.round((val.item_value)*100)/100+'</td>');
							}
    	                          	   });
    	               			    
    	               		count++;
        				}
        				});
        			  }
        			});
        		}

        		
        		getStockReport();
        	});
        </script>
    </body>
</html>