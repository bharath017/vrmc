<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
        <meta charset="utf-8" />
        <title>Bank Transaction Report</title>
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
                            <h4 class="page-title">Cash Register Report</h4>
                        </div>
                    </div>
                </div>
                 <!-- end row -->
                <div class="row">
                	<div class="col-md-12 no-print">
                		<h2 class="text-info text-center"> Cash Register Report</h2><hr><br><br>
                	</div>
                    <div class="col-md-12 no-print">
                       <form action="#" id="myform" method="post">
                          <div class="row">
                          	<div class="col-sm-4"></div>
                          	<div class="col-sm-4">
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat date no-mp mp-dat">
                                  <div class="form-group">
                                      <label>From Date<span class="text-danger">*</span></label>
                                      <!--<div class="cal-icon">
                                          <input type="text" name="from_date" value="${param.from_date}" class="form-control date-picker no-cus no-veh cus-dat veh-dat date from_date mar" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                      </div>-->
				      				<div class="input-group">
                                                <input type="text" name="from_date"  value="${param.from_date}" 
                                                	   class="form-control date-picker no-cus no-veh cus-dat veh-dat date no-mp from_date mar mp-dat"
                                                	   required="required" placeholder="dd/mm/yyyy"
                                                	   id="id-date-picker-1" data-date-format="dd/mm/yyyy"
                                                	   readonly="readonly" style="background-color: white;"/>
                                                <div class="input-group-append" id="get-from_date">
                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                </div>
                                      </div>

                                  </div>
                                </div>
                                
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat veh-dat date no-mp mp-dat">
                                  <div class="form-group">
                                      <label>To Date<span class="text-danger">*</span></label>
				      					<div class="input-group">
                                                <input type="text" name="to_date"  value="${param.to_date}" 
                                                		class="form-control date-picker no-cus no-veh cus-dat veh-dat veh-dat date no-mp to-date mp-dat"
                                                	    required="required" placeholder="dd/mm/yyyy"
                                                	    id="id-date-picker-2" data-date-format="dd/mm/yyyy"
                                                	    readonly="readonly" style="background-color: white;"/>
                                                <div class="input-group-append" id="get-to_date">
                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                </div>
                                      </div>
                                  </div>
                                </div>
                               
                               <div class="col-sm-12 no-date cus no-veh cus-dat no-veh-dat no-mp no-mp-dat">
                                   <div class="form-group">
                                       <label>Bank <span class="text-danger">*</span></label>
                                       <sql:query var="bank" dataSource="jdbc/rmc">
                                       	  select bank_detail_id,bank_name,g.group_name
                                       	  from bank_detail b,business_group g
                                       	  where b.business_id=g.business_id
                                       	  and b.business_id like if(?=0,'%%',?)
                                       	  and b.group_name in ('cash','other')
                                       	  <sql:param value="${bean.business_id}"/>
                                       	  <sql:param value="${bean.business_id}"/>
                                       </sql:query>
                                       <select class="select2 no-date cus no-veh cus-dat no-veh-dat" name="bank_detail_id" id="bank_detail_id">
                                           <c:forEach items="${bank.rows}" var="bank">
                                           <option value="${bank.bank_detail_id}" ${(bank.bank_detail_id==param.bank_detail_id)?'selected':''}>${bank.bank_name}-(${bank.group_name})</option>
                                           </c:forEach>
                                       </select>
                                   </div>
                               </div>
                               
                          	</div> 	
                          </div>
                           
                          <div class="text-center m-t-20">
                               <button type="submit" class="btn btn-custom btn-lg m-r-10 save-button">Generate Report</button>
                               <a class="btn btn-danger btn-lg" href="InvoiceReport.jsp">Clear Report</a>
                          </div>
                       </form>
                    </div>
                </div>
                
                <c:if test="${param.action=='generateReport'}">
               	<div class="row" style="margin-top: 25px;">
               		<div class="col-sm-12 no-print">
               			<button class="btn btn-custom btn-sm" onclick="generate_excel();">Excel</button>
               			<button class="btn btn-custom btn-sm" onclick="print();">Print</button>
               		</div>
               		<div class="col-sm-12 printme table-responsive" id="printme">
               			<!-- Get all kind of query here -->
               				
               			
               			<sql:query var="opening" dataSource="jdbc/rmc">
               				select sum(payment_amount) as credit,0 as debit 
               				from test_customer_payment p,test_customer c
               				where p.customer_id=c.customer_id
               				and c.business_id like if(?=0,'%%',?)
               				and payment_date < STR_TO_DATE(?, '%d/%m/%Y') and  
               				bank_detail_id like if(0=?,'%%',?) and bank_detail_id!=1
               				UNION ALL
               				select 0 as credit,sum(payment_amount) as debit
               				from test_make_payment m,test_supplier s
               				where m.supplier_id=s.supplier_id
               				and s.business_id like if(?=0,'%%',?)
               				and payment_date < STR_TO_DATE(?, '%d/%m/%Y')
               				and bank_detail_id like if(0=?,'%%',?) and bank_detail_id!=1
               				
               				UNION ALL
               				
               				select 0 as credit,sum(m.amount) as debit
               				from test_petty_cash m,bank_detail b 
               				where m.bank_detail_id=b.bank_detail_id
               				and date < STR_TO_DATE(?, '%d/%m/%Y')
               				and m.bank_detail_id like if(0=?,'%%',?) and m.bank_detail_id!=1
               				and b.business_id like if(?=0,'%%',?)	
               	
               				<sql:param value="${bean.business_id}"/>
               				<sql:param value="${bean.business_id}"/>
               				<sql:param value="${param.from_date}"/>
               				<sql:param value="${param.bank_detail_id}"/>
               				<sql:param value="${param.bank_detail_id}"/>
               				<sql:param value="${bean.business_id}"/>
               				<sql:param value="${bean.business_id}"/>
               				<sql:param value="${param.from_date}"/>
               				<sql:param value="${param.bank_detail_id}"/>
               				<sql:param value="${param.bank_detail_id}"/>
               				
               				<sql:param value="${param.from_date}"/>
               				<sql:param value="${param.bank_detail_id}"/>
               				<sql:param value="${param.bank_detail_id}"/>
               				<sql:param value="${bean.business_id}"/>
               				<sql:param value="${bean.business_id}"/>
               			</sql:query>
               			
               			<sql:query var="transaction" dataSource="jdbc/rmc">
               				select t.* from (select payment_amount as credit,'' as debit,DATE_FORMAT(payment_date,'%d/%m/%Y') as payment_date,payment_date as fake_date,b.bank_name,cu.customer_name as person,'Customer payment' as remarks
               				from test_customer_payment c,bank_detail b,test_customer cu
               				where c.bank_detail_id=b.bank_detail_id and c.customer_id=cu.customer_id
               				and payment_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
               				and c.bank_detail_id like if(0=?,'%%',?) and c.bank_detail_id!=1
               				and cu.business_id like if(0=?,'%%',?)
               				and c.payment_amount>0
               				UNION ALL
               				select '' as credit,payment_amount as debit,DATE_FORMAT(payment_date,'%d/%m/%Y') as payment_date,payment_date as fake_date ,b.bank_name,s.supplier_name as person,'Supplier Payment' as remarks
               				from test_make_payment m,bank_detail b,test_supplier s
               				where m.bank_detail_id=b.bank_detail_id and m.supplier_id=s.supplier_id
               				and payment_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
               				and m.bank_detail_id like if(0=?,'%%',?)  and m.bank_detail_id!=1
               				and s.business_id like if(?=0,'%%',?)
               				and m.payment_amount>0
               				UNION ALL
               				select '' as credit, m.amount as debit,DATE_FORMAT(date,'%d/%m/%Y') as payment_date,date as fake_date,b.bank_name,
               				m.purpose as person,m.purpose as remarks
               				from test_petty_cash m,bank_detail b
               				where m.bank_detail_id=b.bank_detail_id
               				and date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
               				and m.bank_detail_id like if(0=?,'%%',?) and m.bank_detail_id!=1
               				and b.business_id like if(?=0,'%%',?)) as t
               				order by t.fake_date asc
               				<sql:param value="${param.from_date}"/>
               				<sql:param value="${param.to_date}"/>
               				<sql:param value="${param.bank_detail_id}"/>
               				<sql:param value="${param.bank_detail_id}"/>
               				<sql:param value="${bean.business_id}"/>
               				<sql:param value="${bean.business_id}"/>
               				<sql:param value="${param.from_date}"/>
               				<sql:param value="${param.to_date}"/>
               				<sql:param value="${param.bank_detail_id}"/>
               				<sql:param value="${param.bank_detail_id}"/>
               				<sql:param value="${bean.business_id}"/>
               				<sql:param value="${bean.business_id}"/>
               				<sql:param value="${param.from_date}"/>
               				<sql:param value="${param.to_date}"/>
               				<sql:param value="${param.bank_detail_id}"/>
               				<sql:param value="${param.bank_detail_id}"/>
               				<sql:param value="${bean.business_id}"/>
               				<sql:param value="${bean.business_id}"/>
               			</sql:query>
               			<sql:query var="old" dataSource="jdbc/rmc">
               				select sum(nb_amount) as amount from bank_detail 
               				where bank_detail_id like if(0=?,'%%',?)
               				<sql:param value="${param.bank_detail_id}"/>
               				<sql:param value="${param.bank_detail_id}"/>
               			</sql:query>
               			
               			
               			<!-- Check which type is coming -->
             			<table class="table" id="example-2">
               				<tr style="color: black;" class="text-center bg-custom">
               					<sql:query dataSource="jdbc/rmc" var="source">
               						select group_name
               						from bank_detail 
               						where bank_detail_id=?
               						<sql:param value="${param.bank_detail_id}"/>
               					</sql:query>
               					<td colspan="6" class="text-center">
               						<c:forEach items="${source.rows}" var="source">
               						<h3 class="text-uppercase">${source.group_name} Statement</h3>
               						</c:forEach>
               						From Date : ${param.from_date}
               						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To Date : ${param.to_date}
               					</td>
               				</tr>
               				<tr style="color: black;" class="bg-custom">
               					<th>Date</th>
               					<th>Particular</th>
               					<th>Credit</th>
               					<th>Debit</th>
               					<th>Bank/Cash</th>
               					<th>Remarks</th>
               				</tr>
               				<c:set value="0" var="t_debit"/>
               				<c:set value="0" var="t_credit"/>
               					<c:set value="0" var="opening_ball"/>
               					<c:forEach items="${old.rows}" var="old">
               					   <c:set value="${old.amount+opening_ball}" var="opening_ball"/>
               					   <c:set value="${old.amount+t_credit}" var="t_credit"/>
               					</c:forEach>
						
               					<c:forEach items="${opening.rows}" var="opening">
               						<c:set value="${(opening.credit-opening.debit)+opening_ball}" var="opening_ball"/> 
               					</c:forEach>
						<c:set value="${opening_ball}" var="t_credit"/>
               					<c:set value="0" var="t_debit"/>
               					<tr>
               					   		<td colspan="2">Opening Balance</td>
               					   		<td><fmt:formatNumber value="${opening_ball}" maxFractionDigits="2" groupingUsed="false"/></td>
               					   		<td></td>
               					   		<td></td>
               					   		<td></td>
               					   </tr>
               					<c:forEach items="${transaction.rows}" var="transaction">
               						<tr>
               							<td>${transaction.payment_date}</td>
               							<td>${transaction.person}</td>
               							<td>${transaction.credit}</td>
               							<td>${transaction.debit}</td>
               							<td>${transaction.bank_name}</td>
               							<td>${transaction.remarks}</td>
               							<c:set value="${transaction.credit+t_credit}" var="t_credit"/>
               							<c:set value="${transaction.debit+t_debit}" var="t_debit"/>
               						</tr>
               					</c:forEach>
               					<tr style="background-color: #e3d39a;color: black;font-weight: bold;">
										<td>Total</td>
										<td>Available Balance : <fmt:formatNumber value="${t_credit-t_debit}" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false"/></td>
										<td><fmt:formatNumber value="${t_credit}" minFractionDigits="2" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${t_debit}" minFractionDigits="2" maxFractionDigits="2" groupingUsed="true"/></td>
										<td>Closing Balance : <fmt:formatNumber value=" ${t_credit-t_debit}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td></td>
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
        	var from_date=$('input[name="from_date"]').val();
        	var to_date=$('input[name="to_date"]').val();
        	var bank_detail_id=$('#bank_detail_id').val();
        	window.location="BankTransactionReport.jsp?action=generateReport&from_date="+from_date+"&to_date="+to_date+'&bank_detail_id='+bank_detail_id;
	      
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