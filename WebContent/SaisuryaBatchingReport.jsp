<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
        <meta charset="utf-8" />
        <title>Batching Consumption Report</title>
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
        	
        	.table tr th,.table tr td{
        		border:1px solid black;
        	}
        	
        	.table>thead>tr>th,.table>tbody>tr>th,.table>tfoot>tr>th,.table>thead>tr>td,.table>tbody>tr>td,.table>tfoot>tr>td{
        		padding: 2px;
        	}
        	
        	@media print{
        		.no-print{
        			display: none;
        		}
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
                                    <li class="breadcrumb-item"><a href="#">QC</a></li>
                                    <li class="breadcrumb-item"><a href="#">Batching</a></li>
                                    <li class="breadcrumb-item"><a href="#">Batching Report</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Batching Report</h4>
                        </div>
                    </div>
                </div>
                 <!-- end row -->
                <div class="row">
                	<div class="col-md-12 no-print">
                		<h2 class="text-info text-center">Batching Report</h2><hr><br><br>
                	</div>
                    <div class="col-md-12 no-print">
                       <form action="#" id="myform" method="post">
                          <div class="row">
                          	<div class="col-sm-4"></div>
                          	<div class="col-sm-4">
                          		<div class="col-sm-12">
                                   <div class="form-group">
                                       <label>Report Type<span class="text-danger">*</span></label>
                                       <select class="select2" name="report_type" onchange="changeType()" id="report_type" required="required">
                                           <option value="date" ${param.report_type=='date'?'selected':''}>Date Wise</option>
                                           <option value="customerdate" ${param.report_type=='customerdate'?'selected':''}>Customer With Date Wise</option>
                                       </select>
                                   </div>
                               </div>
                               
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat date no-mp mp-dat">
                                  <div class="form-group">
                                      <label>From Date<span class="text-danger">*</span></label>
                                      <!--<div class="cal-icon">
                                          <input type="text" name="from_date" value="${param.from_date}" class="form-control date-picker no-cus no-veh cus-dat veh-dat date from_date mar" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                      </div>-->
				      				<div class="input-group">
                                                <input type="text" name="from_date"  value="${param.from_date}" class="form-control date-picker no-cus no-veh cus-dat veh-dat date no-mp from_date mar mp-dat" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                <div class="input-group-append" id="get-from_date">
                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                </div>
                                      </div>

                                  </div>
                                </div>
                                
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat veh-dat date no-mp mp-dat">
                                  <div class="form-group">
                                      <label>To Date<span class="text-danger">*</span></label>
                                      <!--<div class="cal-icon">
                                          <input type="text" name="to_date" value="${param.to_date}"  class="form-control date-picker no-cus no-veh cus-dat veh-dat date to_date mar" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                      </div>-->
				      					<div class="input-group">
                                                <input type="text" name="to_date"  value="${param.to_date}" class="form-control date-picker no-cus no-veh cus-dat veh-dat veh-dat date no-mp to-date mp-dat" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-2" data-date-format="yyyy-mm-dd">
                                                <div class="input-group-append" id="get-to_date">
                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                </div>
                                      </div>
                                  </div>
                                </div>
                               
                               <div class="col-sm-12 no-date cus no-veh cus-dat no-veh-dat no-mp no-mp-dat">
                                   <div class="form-group">
                                       <label>Customer <span class="text-danger">*</span></label>
                                       <sql:query var="customer" dataSource="jdbc/rmc">
                                       		select customer_id,customer_name from customer where customer_status='active'
                                       </sql:query>
                                       <select class="select2 no-date cus no-veh cus-dat no-veh-dat" name="customer_id" id="customer_id">
                                           <option value="0" selected="selected" >All Customer</option>
                                           <c:forEach items="${customer.rows}" var="customer">
                                           <option value="${customer.customer_id}">${customer.customer_name}</option>
                                           </c:forEach>
                                       </select>
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
                
                <c:if test="${param.action=='generateReport'}">
               	<div class="row" style="margin-top: 25px;">
               		<div class="col-sm-12 no-print">
               			<button class="btn btn-warning btn-sm" onclick="generate_excel();">Excel</button>
               			<button class="btn btn-danger btn-sm" onclick="print();">Print</button>
               		</div>
               		<div class="col-sm-12 printme table-responsive" id="printme">
               			<!-- Check which type is coming -->
               			<c:choose>
               				<c:when test="${param.report_type=='date'}">
               					<table class="table" id="example-2">
		               				<tr style="background-color: #91e9eb;color: black;" class="text-center">
		               					<td colspan="15" class="text-center">
		               						<h3>Batching  Report</h3>
		               						<fmt:parseDate value="${param.from_date}" pattern="yyyy-MM-dd" var="from_date"/>
		               						<fmt:parseDate value="${param.to_date}" pattern="yyyy-MM-dd" var="to_date"/>
		               						From Date : <fmt:formatDate value="${from_date}" pattern="dd/MM/yyyy"/>
		               						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To Date : <fmt:formatDate value="${to_date}" pattern="dd/MM/yyyy"/>
		               					</td>
		               				</tr>
		               				<tr style="background-color: #9debb6;color: black;">
		               					<th>Date</th>
		               					<th>Invoice NO</th>
		               					<th>Customer</th>
		               					<th>Site</th>
		               					<th>Grade</th>
		               					<th>Agg1</th>
		               					<th>Agg2</th>
		               					<th>Agg3</th>
		               					<th>Agg4</th>
		               					<th>Cem1</th>
		               					<th>Cem2</th>
		               					<th>Cem3</th>
		               					<th>Water</th>
		               					<th>Add</th>
		               				</tr>
		               				
		               				<sql:query var="batch" dataSource="jdbc/rmc">
		               					select i.invoice_id,i.invoice_date,c.customer_name,p.product_name,s.site_name,sum(aggr1) as aggr1,sum(aggr2) as aggr2,
		               					sum(aggr3) as aggr3,sum(aggr4) as aggr4,sum(aggr5) as aggr5,sum(aggr6) as aggr6,sum(aggr7) as aggr7,
		               					sum(aggr8) as aggr8,sum(aggr9) as aggr9
		               					from batchingsheet b LEFT JOIN(invoice i,customer c,site_detail s,purchase_order_item poi,product p)
		               					ON b.id=i.id
		               					and c.customer_id=i.customer_id
		               					and s.site_id=i.site_id 
		               					and poi.poi_id=i.poi_id
		               					and poi.product_id=p.product_id
		               					where i.invoice_date between ? and ?
		               					group by i.invoice_id,c.customer_name,p.product_name,s.site_name,i.invoice_date
		               					order by i.invoice_id
		               					<sql:param value="${param.from_date}"/>
		               					<sql:param value="${param.to_date}"/>
		               				</sql:query>
		               				<c:set value="0" var="t1"/>
		               				<c:set value="0" var="t2"/>
		               				<c:set value="0" var="t3"/>
		               				<c:set value="0" var="t4"/>
		               				<c:set value="0" var="t5"/>
		               				<c:set value="0" var="t6"/>
		               				<c:set value="0" var="t7"/>
		               				<c:set value="0" var="t8"/>
		               				<c:set value="0" var="t9"/>
		               				<c:forEach items="${batch.rows}" var="batch">
		               					<tr>
		               						<td>${batch.invoice_date}</td>
			               					<td>${batch.invoice_id}</td>
			               					<td>${batch.customer_name}</td>
			               					<td>${batch.site_name}</td>
			               					<td>${batch.product_name}</td>
			               					<td>${batch.aggr1}</td>
			               					<td>${batch.aggr2}</td>
			               					<td>${batch.aggr3}</td>
			               					<td>${batch.aggr4}</td>
			               					<td>${batch.aggr5}</td>
			               					<td>${batch.aggr6}</td>
			               					<td>${batch.aggr7}</td>
			               					<td>${batch.aggr8}</td>
			               					<td><fmt:formatNumber value="${batch.aggr9}" maxFractionDigits="2"/></td>
			               					<c:set value="${t1+batch.aggr1}" var="t1"/>
				               				<c:set value="${t2+batch.aggr2}" var="t2"/>
				               				<c:set value="${t3+batch.aggr3}" var="t3"/>
				               				<c:set value="${t4+batch.aggr4}" var="t4"/>
				               				<c:set value="${t5+batch.aggr5}" var="t5"/>
				               				<c:set value="${t6+batch.aggr6}" var="t6"/>
				               				<c:set value="${t7+batch.aggr7}" var="t7"/>
				               				<c:set value="${t8+batch.aggr8}" var="t8"/>
				               				<c:set value="${t9+batch.aggr9}" var="t9"/>
				               			</tr>
		               				</c:forEach>
		               					<tr style="background-color: #e3d39a;color: black;font-weight: bold;">
											<td colspan="5" class="text-right">Total: </td>
											<th>${t1}</th>
											<th>${t2}</th>
											<th>${t3}</th>
											<th>${t4}</th>
											<th>${t5}</th>
											<th>${t6}</th>
											<th>${t7}</th>
											<th>${t8}</th>
											<th><fmt:formatNumber value="${t9}" maxFractionDigits="2" groupingUsed="false"/></th>
		               					</tr>
		               			</table>
               				</c:when>
               				
               				<c:when test="${param.report_type=='customerdate'}">
               					<table class="table" id="example-2">
		               				<tr style="background-color: #91e9eb;color: black;" class="text-center">
		               					<td colspan="15" class="text-center">
		               						<h3>Batching  Report</h3>
		               						<fmt:parseDate value="${param.from_date}" pattern="yyyy-MM-dd" var="from_date"/>
		               						<fmt:parseDate value="${param.to_date}" pattern="yyyy-MM-dd" var="to_date"/>
		               						From Date : <fmt:formatDate value="${from_date}" pattern="dd/MM/yyyy"/>
		               						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To Date : <fmt:formatDate value="${to_date}" pattern="dd/MM/yyyy"/>
		               					</td>
		               				</tr>
		               				<tr style="background-color: #9debb6;color: black;">
		               					<th>Date</th>
		               					<th>Invoice NO</th>
		               					<th>Customer</th>
		               					<th>Site</th>
		               					<th>Grade</th>
		               					<th>Agg1</th>
		               					<th>Agg2</th>
		               					<th>Agg3</th>
		               					<th>Agg4</th>
		               					<th>Cem1</th>
		               					<th>Cem2</th>
		               					<th>Cem3</th>
		               					<th>Water</th>
		               					<th>Add</th>
		               				</tr>
		               				
		               				<sql:query var="batch" dataSource="jdbc/rmc">
		               					select i.invoice_id,i.invoice_date,c.customer_name,i.customer_id,p.product_name,s.site_name,sum(aggr1) as aggr1,sum(aggr2) as aggr2,
		               					sum(aggr3) as aggr3,sum(aggr4) as aggr4,sum(aggr5) as aggr5,sum(aggr6) as aggr6,sum(aggr7) as aggr7,
		               					sum(aggr8) as aggr8,sum(aggr9) as aggr9
		               					from batchingsheet b LEFT JOIN(invoice i,customer c,site_detail s,purchase_order_item poi,product p)
		               					ON b.id=i.id
		               					and c.customer_id=i.customer_id
		               					and s.site_id=i.site_id 
		               					and poi.poi_id=i.poi_id
		               					and poi.product_id=p.product_id
		               					where i.invoice_date between ? and ?
		               					and i.customer_id = ?
		               					group by i.invoice_id,c.customer_name,p.product_name,s.site_name,i.customer_id,i.invoice_date
		               					order by i.invoice_id
		               					<sql:param value="${param.from_date}"/>
		               					<sql:param value="${param.to_date}"/>
		               					<sql:param value="${param.customer_id}"/>
		               				</sql:query>
		               				<c:set value="0" var="t1"/>
		               				<c:set value="0" var="t2"/>
		               				<c:set value="0" var="t3"/>
		               				<c:set value="0" var="t4"/>
		               				<c:set value="0" var="t5"/>
		               				<c:set value="0" var="t6"/>
		               				<c:set value="0" var="t7"/>
		               				<c:set value="0" var="t8"/>
		               				<c:set value="0" var="t9"/>
		               				<c:forEach items="${batch.rows}" var="batch">
		               					<tr>
		               						<td>${batch.invoice_date} ${batch.customer_id}</td>
			               					<td>${batch.invoice_id}</td>
			               					<td>${batch.customer_name}</td>
			               					<td>${batch.site_name}</td>
			               					<td>${batch.product_name}</td>
			               					<td>${batch.aggr1}</td>
			               					<td>${batch.aggr2}</td>
			               					<td>${batch.aggr3}</td>
			               					<td>${batch.aggr4}</td>
			               					<td>${batch.aggr5}</td>
			               					<td>${batch.aggr6}</td>
			               					<td>${batch.aggr7}</td>
			               					<td>${batch.aggr8}</td>
			               					<td><fmt:formatNumber value="${batch.aggr9}" maxFractionDigits="2"/></td>
			               					<c:set value="${t1+batch.aggr1}" var="t1"/>
				               				<c:set value="${t2+batch.aggr2}" var="t2"/>
				               				<c:set value="${t3+batch.aggr3}" var="t3"/>
				               				<c:set value="${t4+batch.aggr4}" var="t4"/>
				               				<c:set value="${t5+batch.aggr5}" var="t5"/>
				               				<c:set value="${t6+batch.aggr6}" var="t6"/>
				               				<c:set value="${t7+batch.aggr7}" var="t7"/>
				               				<c:set value="${t8+batch.aggr8}" var="t8"/>
				               				<c:set value="${t9+batch.aggr9}" var="t9"/>
				               			</tr>
		               				</c:forEach>
		               					<tr style="background-color: #e3d39a;color: black;font-weight: bold;">
											<td colspan="5" class="text-right">Total: </td>
											<th>${t1}</th>
											<th>${t2}</th>
											<th>${t3}</th>
											<th>${t4}</th>
											<th>${t5}</th>
											<th>${t6}</th>
											<th>${t7}</th>
											<th>${t8}</th>
											<th><fmt:formatNumber value="${t9}" maxFractionDigits="2" groupingUsed="false"/></th>
		               					</tr>
		               			</table>
               				</c:when>
               			</c:choose>
               			
               		</div>
               	</div>
               </c:if>
              	
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
						todayHighlight: true,
						"orientation":"bottom left"
				 });
					//show datepicker when clicking on the icon
					
		         
		         $("#id-date-picker-1").datepicker();
					$('#id-date-picker-1').datepicker({
					        "autoclose": true,
					        "orientation":"bottom left"
				});
					
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
				}).next().on('click', function(){
					$(this).prev().focus();
				});
				
				$('#get-from_date').on('click',function(){
	  				 $('#id-date-picker-1').datepicker('show');
	  			});
					
				$('#get-to_date').on('click',function(){
 				  $('#id-date-picker-2').datepicker('show');
 				});
			});
		</script>
		<script type="text/javascript">
	    $("form").submit(function(e){
	        e.preventDefault();
	        var report_type=$('#report_type').val();
	        if(report_type=='date'){
	        	var from_date=$('input[name="from_date"]').val();
	        	var to_date=$('input[name="to_date"]').val();
	        	window.location="SaisuryaBatchingReport.jsp?action=generateReport&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date;
	        }
	        else if(report_type=='customerdate'){
	        	var customer_id=$('#customer_id').val();
	        	var from_date=$('input[name="from_date"]').val();
	        	var to_date=$('input[name="to_date"]').val();
	        	window.location="SaisuryaBatchingReport.jsp?action=generateReport&report_type="+report_type+"&customer_id="+customer_id+"&from_date="+from_date+"&to_date="+to_date;
	        }
	    });
    </script>
    
    <script type="text/javascript">
    	$(document).ready(function(){
    		changeType();
    	});
    </script>
    
    <script type="text/javascript">
    	function changeType(){
    		var report_type=$('#report_type').val();
			if(report_type=='date'){
				$('.no-date').hide();
				$('.no-date').prop('disabled',true);
				$('.date').show();
				$('.date').prop('disabled',false);
			}else if(report_type=='customer'){
				$('.cus').prop('disabled',false);
				$('.no-cus').prop('disabled',true);
				$('.cus').show();
				$('.no-cus').hide();
			}else if(report_type=='customerdate'){
				$('.cus-dat').prop('disabled',false);
				$('.no-cus-dat').prop('disabled',true);
				$('.cus-dat').show();
				$('.no-cus-dat').hide();
			}else if(report_type=='vehicledate'){
				$('.veh-dat').prop('disabled',false);
				$('no-veh-dat').prop('disabled',true);
				$('.veh-dat').show();
				$('.no-veh-dat').hide();
			}
			else if(report_type=='marketing'){
				$('.mp').prop('disabled',false);
				$('.no-mp').prop('disabled',true);
				$('.mp').show();
				$('.no-mp').hide();
			}else if(report_type=='marketingdate'){
				$('.mp-dat').prop('disabled',false);
				$('.no-mp-dat').prop('disabled',true);
				$('.mp-dat').show();
				$('.no-mp-dat').hide();
			}
    	}
    </script>
    <script type="text/javascript">
	    function generate_excel() {
	      var table= document.getElementById("example-2");
	      var html = table.outerHTML;
	      window.open('data:application/vnd.ms-excel;base64,' + base64_encode(html));
	    }
	    function base64_encode (data) {
	      // http://kevin.vanzonneveld.net
	      // +   original by: Tyler Akins (http://rumkin.com)
	      // +   improved by: Bayron Guevara
	      // +   improved by: Thunder.m
	      // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	      // +   bugfixed by: Pellentesque Malesuada
	      // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	      // +   improved by: Rafal Kukawski (http://kukawski.pl)
	      // *     example 1: base64_encode('Kevin van Zonneveld');
	      // *     returns 1: 'S2V2aW4gdmFuIFpvbm5ldmVsZA=='
	      // mozilla has this native
	      // - but breaks in 2.0.0.12!
	      //if (typeof this.window['btoa'] == 'function') {
	      //    return btoa(data);
	      //}
	      var b64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	      var o1, o2, o3, h1, h2, h3, h4, bits, i = 0,
	        ac = 0,
	        enc = "",
	        tmp_arr = [];
	
	      if (!data) {
	        return data;
	      }
	
	      do { // pack three octets into four hexets
	        o1 = data.charCodeAt(i++);
	        o2 = data.charCodeAt(i++);
	        o3 = data.charCodeAt(i++);
	
	        bits = o1 << 16 | o2 << 8 | o3;
	
	        h1 = bits >> 18 & 0x3f;
	        h2 = bits >> 12 & 0x3f;
	        h3 = bits >> 6 & 0x3f;
	        h4 = bits & 0x3f;
	
	        // use hexets to index into b64, and append result to encoded string
	        tmp_arr[ac++] = b64.charAt(h1) + b64.charAt(h2) + b64.charAt(h3) + b64.charAt(h4);
	      } while (i < data.length);
	
	      enc = tmp_arr.join('');
	
	      var r = data.length % 3;
	
	      return (r ? enc.slice(0, r - 3) : enc) + '==='.slice(r || 3);
	
	    }
    </script>
    </body>
</html>