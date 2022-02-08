<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
        <meta charset="utf-8" />
        <title>Expense Voucher Report</title>
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
        	.table>thead>tr>th,.table>tbody>tr>th,.table>tfoot>tr>th,.table>thead>tr>td,.table>tbody>tr>td,.table>tfoot>tr>td{
        		padding: 2px;
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
                                    <li class="breadcrumb-item"><a href="#">Journal Voucher</a></li>
                                    <li class="breadcrumb-item"><a href="#">Journal Voucher Report</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Journal Voucher Report</h4>
                        </div>
                    </div>
                </div>
                 <!-- end row -->
                <div class="row">
                	<div class="col-md-12">
                		<h2 class="text-info text-center">Journal Voucher Report</h2><hr><br><br>
                	</div>
                    <div class="col-md-12">
                       <form action="#" id="myform" method="post">
                          <div class="row">
                          	<div class="col-sm-4"></div>
                          	<div class="col-sm-4">
                          		<div class="col-sm-12" style="display: ${(bean.business_id==0)?'block':'none'}">
                                   <div class="form-group">
                                       <label>Business Group <span class="text-danger">*</span></label>
                                       <sql:query var="group" dataSource="jdbc/rmc">
                                       		select business_id,group_name
                                       		from business_group 
                                       		where business_id like if(0=?,'%%',?)
                                       		<sql:param value="${bean.business_id}"/>
                                       		<sql:param value="${bean.business_id}"/>
                                       </sql:query>
                                       <select class="select2" name="business_id" id="business_id" required="required">
                                       		<c:if test="${bean.business_id==0}">
                                       			<option value="0" ${(param.business_id==0)?'selected':''}>All Group</option>
                                       		</c:if>
                                       		<c:forEach items="${group.rows}" var="group">
                                       			<option value="${group.business_id}" ${(param.business_id==group.business_id)?'selected':''}>${group.group_name}</option>
                                       		</c:forEach>
                                       </select>
                                   </div>
                               </div>
                               
                          		<div class="col-sm-12">
                                   <div class="form-group">
                                       <label>Report Type<span class="text-danger">*</span></label>
                                       <select class="select2" name="report_type" id="report_type" required="required">
                                           <option value="date" ${(param.report_type=='date')?'selected':''}>Date Wise</option>
                                           <option value="customerdate" ${(param.report_type=='customerdate')?'selected':''}>Supplier With Date Wise</option>
                                       </select>
                                   </div>
                               </div>
                               
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat date no-mp">
                                  <div class="form-group">
                                      <label>From Date<span class="text-danger">*</span></label>
                                      <div class="input-group">
                                          <input type="text" name="from_date"  class="form-control date-picker no-cus no-veh cus-dat veh-dat date from_date no-mp" 
                                          		 required="required" placeholder="dd/mm/yyyy" id="id-date-picker-1"
                                          		 data-date-format="dd/mm/yyyy" value="${param.from_date}" readonly="readonly" style="background-color: white;"/>
                                          <div class="input-group-append picker">
                                               <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                           </div>
                                      </div>
                                  </div>
                                </div>
                                
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat veh-dat date no-mp">
                                  <div class="form-group">
                                      <label>To Date<span class="text-danger">*</span></label>
                                      <div class="input-group">
                                          <input type="text" name="from_date" value="${param.to_date}" 
                                          		 class="form-control date-picker no-cus no-veh cus-dat veh-dat date to_date no-mp" required="required"
                                          		 placeholder="dd/mm/yyyy" id="id-date-picker-1" data-date-format="dd/mm/yyyy"
                                          		 readonly="readonly" style="background-color: white;"/>
                                          <div class="input-group-append picker">
                                               <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                           </div>
                                      </div>
                                  </div>
                                </div>
                               
                               <div class="col-sm-12 no-date cus no-veh cus-dat no-veh-dat no-mp no-mp-dat">
                                   <div class="form-group">
                                       <label>Supplier wise<span class="text-danger">*</span></label>
                                       <sql:query var="supplier" dataSource="jdbc/rmc">
                                       	select supplier_id,supplier_name
                                       	from supplier
                                       	where business_id like if(?=0,'%%',?)
                                        order by supplier_name asc
                                        <sql:param value="${bean.business_id}"/>
                                        <sql:param value="${bean.business_id}"/>
                                       </sql:query>
                                       <select class="select2 no-date cus no-veh cus-dat no-veh-dat" name="supplier_id" id="supplier_id">
                                           <option value="0" selected="selected" >All supplier</option>
                                           <c:forEach items="${supplier.rows}" var="supplier">
                                           <option value="${supplier.supplier_id}" ${(supplier.supplier_id==param.supplier_id)?'selected':''}>${supplier.supplier_name}</option>
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
               		<div class="col-sm-12">
               			<button class="btn btn-warning btn-sm" onclick="generate_excel();">Excel</button>
               			<button class="btn btn-danger btn-sm" onclick="print();">Print</button>
               		</div>
               		<div class="col-sm-12 printme table-responsive" id="printme">
               			<!-- Get all kind of query here -->
               				<c:choose>
               					<c:when test="${param.report_type=='date'}">
               						<sql:query var="payment" dataSource="jdbc/rmc">
               							select evi.*,ev.*,DATE_FORMAT(ev.bill_date,'%d/%m/%Y') as bill_date,
               							s.supplier_name from 
               							expense_voucher_item evi,expense_voucher ev,supplier s
               							where evi.expense_voucher_id=ev.expense_voucher_id 
               							and ev.supplier_id=s.supplier_id
               							and ev.bill_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
               							and s.business_id like if(?=0,'%%',?)
               							<sql:param value="${param.from_date}"/>
               							<sql:param value="${param.to_date}"/>
               							<sql:param value="${param.business_id}"/>
                                        <sql:param value="${param.business_id}"/>
               						</sql:query>
               					</c:when>
               					<c:when test="${param.report_type=='customerdate'}">
               						<sql:query var="payment" dataSource="jdbc/rmc">
               							select evi.*,ev.*,DATE_FORMAT(ev.bill_date,'%d/%m/%Y') as bill_date,
               							s.supplier_name from 
               							expense_voucher_item evi,expense_voucher ev,supplier s
               							where evi.expense_voucher_id=ev.expense_voucher_id 
               							and ev.supplier_id=s.supplier_id
               							and ev.bill_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
               							and ev.supplier_id=?
               							and s.business_id like if(?=0,'%%',?)
               							<sql:param value="${param.from_date}"/>
               							<sql:param value="${param.to_date}"/>
               							<sql:param value="${param.supplier_id}"/>
               							<sql:param value="${param.business_id}"/>
                                        <sql:param value="${param.business_id}"/>
               						</sql:query>
               					</c:when>
               				</c:choose>
               			<table class="table table-bordered" id="example-2">
               				<tr style="background-color: #741d7a;color: white;" class="text-center">
               					<td></td>
               					<td></td>
               					<td colspan="6" class="text-center">
               						<h3>Journal Voucher Report</h3>
               					</td>
               					<td></td>
               					<td></td>
               				</tr>
               				<tr style="background-color: #4b9663;color: white;">
               					<th>Voucher No</th>
               					<th>Supplier</th>
               					<th>Purchase Date</th>
               					<th>Bill No</th>
               					<th>Item</th>
               					<th>Quantity</th>
               					<th>Rate</th>
               					<th>Gross Amount</th>
               					<th>Tax Amount</th>
               					<th>Net Amount</th>
               					
               				</tr>
               				
               				<c:set value="0" var="total_gross"/>
               				<c:set value="0" var="total_tax"/>
               				<c:set value="0" var="total_net"/>
               				<c:set value="0" var="total_quantity"/>
               				<c:forEach items="${payment.rows}" var="payment">
	               				<c:set value="${payment.gross_amount+total_gross}" var="total_gross"/>
	               				<c:set value="${payment.tax_amount+total_tax}" var="total_tax"/>
	               				<c:set value="${payment.net_amount+total_net}" var="total_net"/>
	               				<c:set value="${total_quantity+payment.item_quantity}" var="total_quantity"/>
               					<tr>
	               					<td>${payment.expense_voucher_id}</td>
	               					<td>${payment.supplier_name}</td>
	               					<td>${payment.bill_date}</td>
	               					<td>${payment.bill_no}</td>
	               					<td>${payment.item_name}</td>
	               					<td>${payment.item_quantity}</td>
	               					<td>${payment.item_price}</td>
	               					<td>${payment.gross_amount}</td>
	               					<td>${payment.tax_amount}</td>
	               					<td>${payment.net_amount}</td>
	               					
	               				</tr>
               				</c:forEach>
               					<tr style="background-color: #70643b;color: white;">
               						<td colspan="5" class="text-right"></td>
               						<td><fmt:formatNumber value="${total_quantity}" maxFractionDigits="2" groupingUsed="false"/></td>
               						<td colspan="1"></td>
               						<td class="text-left"><fmt:formatNumber value="${total_gross}" maxFractionDigits="2" groupingUsed="false"/></td>
               						<td class="text-left"><fmt:formatNumber value="${total_tax}" maxFractionDigits="2" groupingUsed="false"/></td>
               						<td class="text-left"><fmt:formatNumber value="${total_net}" maxFractionDigits="2" groupingUsed="false"/></td>
               						
               					</tr>
               			</table>
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
						todayHighlight: true
				 });
					//show datepicker when clicking on the icon
					
		         
		         $("#id-date-picker-1").datepicker("setDate");
					$('#id-date-picker-1').datepicker({
					        "autoclose": true
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
				}).next().on(ace.click_event, function(){
					$(this).prev().focus();
				});
			});
		</script>
		<script type="text/javascript">
	    $("form").submit(function(e){
	        e.preventDefault();
	        var report_type=$('#report_type').val();
	        if(report_type=='date'){
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	var item_name=$('#item_name').val();
	        	var plant_id=$('#plant_id').val();
	        	var business_id=$('#business_id').val();
	        	window.location="ExpenseVoucherReport.jsp?action=generateReport&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&item_name="+item_name+'&business_id='+business_id;
	        }else if(report_type=='customer'){
	        	var customer_id=$('#customer_id').val();
	        	var site_id=$('#site_id').val();
	        	var product_id=$('#product_id').val();
	        	var plant_id=$('#plant_id').val();
	        	window.location="PurchaseVoucherReport.jsp?action=generateReport&report_type="+report_type+"&customer_id="+customer_id+"&site_id="+site_id+"&product_id="+product_id+'&business_id='+business_id;
	        }
	        else if(report_type=='customerdate'){
	        	var supplier_id=$('#supplier_id').val();
	        	var site_id=$('#site_id').val();
	        	var item_name=$('#item_name').val();
	        	var plant_id=$('#plant_id').val();
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	window.location="ExpenseVoucherReport.jsp?action=generateReport&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&item_name="+item_name+"&supplier_id="+supplier_id+'&business_id='+business_id;
	        }
	        else if(report_type=='marketing'){
	        	var mp_id=$('#mp_id').val();
	        	window.location="CustomerPaymentReport.jsp?action=generateReport&report_type="+report_type+"&mp_id="+mp_id;
	        }
	        else if(report_type=='marketingdate'){
	        	var customer_id=$('#mp_id').val();
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	window.location="CustomerPaymentReport.jsp?action=generateReport&report_type="+report_type+"&mp_id="+mp_id+"&from_date="+from_date+"&to_date="+to_date+'&business_id='+business_id;
	        }
	    });
    </script>
    
    <script type="text/javascript">
    	$(document).ready(function(){
    		$('.no-date').prop('disabled',true);
    		$('.no-date').hide();
    	});
    </script>
    
    <script type="text/javascript">
    	$(document).ready(function(){
    		$('#report_type').on('change',function(){
    			getDetails();
    		});
    		
    		getDetails();
    	})
    </script>
    
    <script type="text/javascript">
    	function getDetails(){
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
    <script type="text/javascript">
    function print() {
        var frame = document.getElementsByClassName('printme').item(0);
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
    
		
    </body>
</html>