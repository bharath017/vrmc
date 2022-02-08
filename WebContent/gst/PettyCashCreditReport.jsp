<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
        <meta charset="utf-8" />
        <title>Petty Cash Report</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico">
		<link rel="stylesheet" href="../picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="../picker/cs/bootstrap-timepicker.min.css" />
        <!-- App css -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css2/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="../assets/css/select2.min.css" />
        <link rel="stylesheet" href="../assets/css/render.css">
        
        <style type="text/css">
        	.change{
        		background-color:#469399;
        		color: white;
        	}
        	
        	.nochange{
        		background-color: #d7dfe0;
        		
        	}
        </style>

        <script src="../assets/js/modernizr.min.js"></script>

    </head>

    <body>

        <!-- Navigation Bar-->
        	<%@ include file="../header.jsp" %>
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
                                    <li class="breadcrumb-item"><a href="#">Customer Payment</a></li>
                                    <li class="breadcrumb-item"><a href="#">Payment Report</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Petty Cash Report</h4>
                        </div>
                    </div>
                </div>
                 <!-- end row -->
                <div class="row">
                	<div class="col-md-12">
                		<h2 class="text-info text-center">Petty Cash Report</h2><hr><br><br>
                	</div>
                    <div class="col-md-12">
                       <form action="#" id="myform" method="post">
                          <div class="row">
                          	<div class="col-sm-3"></div>
                          	<div class="col-sm-6">
                          		<div class="col-sm-12">
                                   <div class="form-group">
                                       <label>Plant <span class="text-danger">*</span></label>
                                       <sql:query var="plant" dataSource="jdbc/rmc">
                                       		select * from plant where plant_id like if(0=?,'%%',?)
                                       		<sql:param value="${bean.plant_id}"/>
                                       		<sql:param value="${bean.plant_id}"/>
                                       </sql:query>
                                       <select class="select2" name="plant_id" id="plant_id" required="required">
                                           <c:forEach items="${plant.rows}" var="plant">
                                           <option value="${plant.plant_id}">${plant.plant_name}</option>
                                           </c:forEach>
                                       </select>
                                   </div>
                               </div>
                                <div class="col-sm-12">
                                  <div class="form-group">
                                      <label>From Date<span class="text-danger">*</span></label>
                                      <div class="cal-icon">
                                          <input type="text" name="from_date" class="form-control date-picker from_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                      </div>
                                  </div>
                                </div>
                                
                                <div class="col-sm-12">
                                  <div class="form-group">
                                      <label>To Date<span class="text-danger">*</span></label>
                                      <div class="cal-icon">
                                          <input type="text" name="from_date"  class="form-control date-picker to_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
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
                
                <c:if test="${param.action=='generateReport'}">
               	<div class="row" style="margin-top: 25px;">
               		<div class="col-sm-12">
               			<button class="btn btn-warning btn-sm" onclick="generate_excel();">Excel</button>
               			<button class="btn btn-danger btn-sm" onclick="print();">Print</button>
               		</div>
               		<div class="col-sm-12 printme table-responsive" id="printme">
               			<!-- Get all kind of query here -->
						<sql:query var="oldBalance" dataSource="jdbc/rmc">
 							select truncate((select sum(cash_amount) from petty_cash where plant_id=? and date < ?)-(select sum(item_price*item_quantity) from expense_voucher e,expense_voucher_item ei where e.expense_voucher_id=ei.expense_voucher_id and e.plant_id=? and e.bill_date < ?),2) as old_balance
 							<sql:param value="${param.plant_id}"/>
 							<sql:param value="${param.from_date}"/>
 							<sql:param value="${param.plant_id}"/>
 							<sql:param value="${param.from_date}"/>
 						</sql:query>
 						
 						<c:forEach var="oldBalance" items="${oldBalance.rows}">
 							<c:set value="${oldBalance}" var="Oldbalance"/>
 						</c:forEach>
 						
 						
 						<sql:query var="newBalance" dataSource="jdbc/rmc">
 							select t.* from(
 							select p.date as date,p.cash_amount as received,'' as payment,p.purpose as particular,timestamp as time,approved_by as approver from petty_cash p where plant_id=? and p.date between ? and ?

							UNION ALL 
							
							select e.bill_date as date,'' as received,truncate(item_price*item_quantity,2) as payment,ei.item_name as particular,e.voucher_timestamp as time,'' as approver
							from expense_voucher e LEFT JOIN expense_voucher_item ei 
							ON e.expense_voucher_id=ei.expense_voucher_id 
							where e.plant_id=? 
							and e.bill_date between ? and ?
 							) as t order by t.time asc
							<sql:param value="${param.plant_id}"/>
							<sql:param value="${param.from_date}"/>
							<sql:param value="${param.to_date}"/>
							<sql:param value="${param.plant_id}"/>
							<sql:param value="${param.from_date}"/>
							<sql:param value="${param.to_date}"/>
 						</sql:query>
 						
 						
 						
               			<table class="table table-bordered" id="example-2">
               				<tr style="background-color: blue;color: white;" class="text-center">
               					<td></td>
               					<sql:query var="plant" dataSource="jdbc/rmc">
               						select plant_name from plant where plant_id=?
               						<sql:param value="${param.plant_id}"/>
               					</sql:query>
               					<td colspan="5" class="text-center">
               						<h3>
               							<c:forEach var="plant" items="${plant.rows}">
               								${plant.plant_name}
               							</c:forEach>
               						</h3>
               						<p>IMPREST ACCOUNTS REPORT</p>
               					</td>
               					<td></td>
               				</tr>
               				<tr style="background-color: #4b9663;color: white;">
               					<th>S/L No</th>
               					<th>Date</th>
               					<th>Particulars</th>
               					<th>Payment</th>
               					<th>Received</th>
               					<th>Balance</th>
               					<th>Approved By</th>
               				</tr>
               				
               				<tr>
               					<td>1</td>
               					<td>${param.from_date}</td>
               					<td>Old Balance</td>
               					<td></td>
               					<td>${Oldbalance.old_balance}</td>
               					<td>${Oldbalance.old_balance}</td>
               					<td></td>
               				</tr>
               				
               				<c:set value="0" var="net_amount"/>
               				<c:set value="1" var="count"/>
               				
               				<c:set value="0" var="total_payment"/>
               				<c:set value="${Oldbalance.old_balance}" var="total_received"/>
               				
               				<!-- Here get total received balance -->
               				<c:set value="${(empty Oldbalance.old_balance)?0:Oldbalance.old_balance}" var="balance"/>
               				<c:forEach items="${newBalance.rows}" var="newBalance">
	               				<c:set value="${cash.cash_amount+net_amount}" var="net_amount"/>
	               				<c:set value="${count+1}" var="count"/>
	               				<c:set value="${(((empty newBalance.received || newBalance.received=='')?0:newBalance.received)+balance)-newBalance.payment}" var="balance"/>
               					<tr>
	               					<td>${count}</td>
	               					<td>${newBalance.date}</td>
	               					<td>${newBalance.particular}</td>
	               					<td>${newBalance.payment}</td>
	               					<td>${newBalance.received}</td>
	               					<td><fmt:formatNumber value="${balance}" maxFractionDigits="2" groupingUsed="false"/></td>
	               					<td>${newBalance.approver}</td>
	               					<c:set value="${total_payment+newBalance.payment}" var="total_payment"/>
               						<c:set value="${total_received+newBalance.received}" var="total_received"/>
	               				</tr>
               				</c:forEach>
               					<tr style="background-color: #70643b;color: white;">
									<td colspan="2" class="text-right">Total Payment : </td>
									<td colspan="1" class="text-left"><fmt:formatNumber value="${total_payment}" maxFractionDigits="2" groupingUsed="true"/></td>
									<td colspan="1" class="text-right">Total Received : </td>
									<td colspan="1" class="text-left"><fmt:formatNumber value="${total_received}" maxFractionDigits="2" groupingUsed="true"/></td>
									<td colspan="1" class="text-right">Remaining Amount : </td>
									<td colspan="1" class="text-left"><fmt:formatNumber value="${total_received-total_payment}" groupingUsed="true" maxFractionDigits="2"/></td>
               					</tr>
               			</table>
               		</div>
               	</div>
               </c:if>
              	
                <!-- end row -->
            </div> <!-- end container -->
        </div>
        

        <!-- Footer -->
       <%@ include file="../footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/popper.min.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/waves.js"></script>
        <script src="../assets/js/jquery.slimscroll.js"></script>

        <!-- App js -->
        <script src="../assets/js/jquery.core.js"></script>
        <script src="../assets/js/jquery.app.js"></script>
        <script src="../assets/js/select2.min.js"></script>
		<script src="../picker/js/bootstrap-datepicker.min.js"></script>
		<script src="../picker/js/moment.min.js"></script>
		<script src="../assets/js/bootstrap-timepicker.min.js"></script>
		<script src="../picker/js/bootstrap-datetimepicker.min.js"></script>
		<script src="../assets/js/ace.min.js"></script>
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
					
		         
		         $("#id-date-picker-1").datepicker("setDate", new Date());
					$('#id-date-picker-1').datepicker({
					        "setDate": new Date(),
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
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	var plant_id=$('#plant_id').val();
	        	window.location="PettyCashCreditReport.jsp?action=generateReport&from_date="+from_date+"&to_date="+to_date+"&plant_id="+plant_id;
	       
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
    			}else if(report_type=='vehicle'){
    				$('.veh').prop('disabled',false);
    				$('.no-veh').prop('disabled',true);
    				$('.veh').show();
    				$('.no-veh').hide();
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
    		});
    	})
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