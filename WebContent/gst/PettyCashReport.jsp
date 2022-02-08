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
                                    <li class="breadcrumb-item"><a href="#">Petty Cash</a></li>
                                    <li class="breadcrumb-item"><a href="#">Petty Cash Report</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Petty Cash Report</h4>
                        </div>
                    </div>
                </div>
                 <!-- end row -->
                <div class="row">
                	<div class="col-md-12 no-print">
                		<h2 class="text-info text-center">Petty Cash Report</h2><hr><br><br>
                	</div>
                    <div class="col-md-12 no-print">
                       <form action="#" id="myform" method="post">
                          <div class="row">
                          	<div class="col-sm-4"></div>
                          	<div class="col-sm-4">
                          		<div class="col-sm-12">
                                   <div class="form-group">
                                       <label>Report Type<span class="text-danger">*</span></label>
                                       <select class="select2" name="report_type" id="report_type" required="required">
                                           <option value="pettycash">Petty Cash Report</option>
                                           <option value="transaction">Transaction Report</option>
                                           <option value="balance">Balance Sheet</option>
                                       </select>
                                   </div>
                               </div>
                               
                               <div class="col-sm-12">
                                   <div class="form-group">
                                       <label>Plant <span class="text-danger">*</span></label>
                                       <select class="form-control" name="plant_id" id="plant_id" required="required">
                                           
                                       </select>
                                   </div>
                               </div>
                               
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat date no-mp mp-dat">
                                  <div class="form-group">
                                      <label>From Date<span class="text-danger">*</span></label>
				      				<div class="input-group">
                                                <input type="text" name="from_date"  value="${param.from_date}" 
                                                		class="form-control date-picker no-cus no-veh cus-dat veh-dat date no-mp from_date mar mp-dat"
                                                		 required="required" placeholder="dd/mm/yyyy"
                                                		 id="id-date-picker-1" data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;">
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
                                                	   id="id-date-picker-2" data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;">
                                                <div class="input-group-append" id="get-to_date">
                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                </div>
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
               		<div class="col-sm-12 no-print">
               			<button class="btn btn-warning btn-sm" onclick="generate_excel();">Excel</button>
               			<button class="btn btn-danger btn-sm" onclick="print();">Print</button>
               		</div>
               		<div class="col-sm-12 printme table-responsive" id="printme">
						<c:choose>
							<c:when test="${param.report_type=='pettycash'}">
								<!--First get the plant  -->
								<table class="table text-center"  id="example-2">
									<tr>
										<th colspan="4" class="text-center" style="background-color:#f0db7f;">PETTY CASH REPORT</th>
									</tr>
									<tr style="background-color: #9fede7;">
										<th>Date</th>
										<th>Amount</th>
										<th>Purpose</th>
										<th>Received By</th>
									</tr>
									<sql:query var="plant" dataSource="jdbc/rmc">
										select plant_id,plant_name from plant where plant_id like if(0=?,'%%',?)
										<sql:param value="${param.plant_id}"/>
										<sql:param value="${param.plant_id}"/>
									</sql:query>
									
									<c:forEach items="${plant.rows}"  var="plant">
										<tr>
											<th colspan="4" class="text-left">${plant.plant_name}</th>
										</tr>
										
										<sql:query var="pettycash" dataSource="jdbc/rmc">
											select DATE_FORMAT(date,'%d/%m/%Y') as date,amount,purpose,u.user_name
											from test_petty_cash p,user u 
											where p.received_by=u.user_id 
											and p.date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
											and p.plant_id=?
											order by cash_id desc 
											<sql:param value="${param.from_date}"/>
											<sql:param value="${param.to_date}"/>
											<sql:param value="${plant.plant_id}"/>
										</sql:query>
										<c:set value="0" var="totalamount"/>
										<c:forEach items="${pettycash.rows}" var="pettycash">
											<tr>
												<td>${pettycash.date}</td>
												<td>${pettycash.amount}</td>
												<td>${pettycash.purpose}</td>
												<td>${pettycash.user_name}</td>
											</tr>
											<c:set value="${totalamount+pettycash.amount}" var="totalamount"/>
										</c:forEach>
											<tr style="background-color: #f0afde">
												<td>Total : </td>
												<td><fmt:formatNumber value="${totalamount}" maxFractionDigits="2" groupingUsed="true" minFractionDigits="2"/></td>
												<td></td>
												<td></td>
											</tr>
									</c:forEach>
								</table>
							</c:when>
							<c:when test="${param.report_type=='transaction'}">
								<!--First get the plant  -->
								<table class="table text-center" id="example-2">
									<tr>
										<th colspan="4" class="text-center" style="background-color:#f0db7f;">PETTY CASH TRANSACTION REPORT</th>
									</tr>
									<tr style="background-color: #9fede7;">
										<th>Date</th>
										<th>Received By</th>
										<th>Purpose</th>
										<th>Amount</th>
									</tr>
									<sql:query var="plant" dataSource="jdbc/rmc">
										select plant_id,plant_name from plant where plant_id like if(0=?,'%%',?)
										<sql:param value="${param.plant_id}"/>
										<sql:param value="${param.plant_id}"/>
									</sql:query>
									
									<c:forEach items="${plant.rows}"  var="plant">
										<tr>
											<th colspan="4" class="text-left">${plant.plant_name}</th>
										</tr>
										
										<sql:query var="pettycash" dataSource="jdbc/rmc">
											select DATE_FORMAT(date,'%d/%m/%Y') as date,amount,description,received_person
											from test_petty_cash_transaction p
											where p.date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
											and p.plant_id=?
											order by transaction_id desc 
											<sql:param value="${param.from_date}"/>
											<sql:param value="${param.to_date}"/>
											<sql:param value="${plant.plant_id}"/>
										</sql:query>
										<c:set value="0" var="totalamount"/>
										<c:forEach items="${pettycash.rows}" var="pettycash">
											<tr>
												<td>${pettycash.date}</td>
												<td>${pettycash.received_person}</td>
												<td>${pettycash.description}</td>
												<td>${pettycash.amount}</td>
											</tr>
											<c:set value="${totalamount+pettycash.amount}" var="totalamount"/>
										</c:forEach>
											<tr style="background-color: #f0afde">
												<td>Total : </td>
												<td><fmt:formatNumber value="${totalamount}" maxFractionDigits="2" groupingUsed="true" minFractionDigits="2"/></td>
												<td></td>
												<td></td>
											</tr>
									</c:forEach>
								</table>
							</c:when>
							
							<c:when test="${param.report_type=='balance'}">
								<!--First get the plant  -->
								<table class="table text-center" id="example-2">
									<tr>
										<th colspan="4" class="text-center" style="background-color:#f0db7f;">PETTY CASH BALANCE SHEET</th>
									</tr>
									<tr style="background-color: #9fede7;">
										<th>Date</th>
										<th>Particular</th>
										<th>Debit</th>
										<th>Credit</th>
									</tr>
									<sql:query var="plant" dataSource="jdbc/rmc">
										select plant_id,plant_name from plant where plant_id like if(0=?,'%%',?)
										<sql:param value="${param.plant_id}"/>
										<sql:param value="${param.plant_id}"/>
									</sql:query>
									
									<c:forEach items="${plant.rows}"  var="plant">
										<tr>
											<th colspan="4" class="text-left">${plant.plant_name}</th>
										</tr>
										
										<sql:query var="opening" dataSource="jdbc/rmc">
				                         		select sum(amount) as debit,0 as credit,DATE_FORMAT(max(date),'%d/%m/%Y') as date,'Total Petty Cash Transaction' as type
												from test_petty_cash_transaction where date < STR_TO_DATE(?, '%d/%m/%Y')
												and plant_id=?
												UNION ALL
												select 0 as debit,sum(amount) as credit,DATE_FORMAT(max(date),'%d/%m/%Y') as date,'Total Petty Cash' as type
												from test_petty_cash where date < STR_TO_DATE(?, '%d/%m/%Y')
												and plant_id=?
												<sql:param value="${param.from_date}"/>
												<sql:param value="${plant.plant_id}"/>
												<sql:param value="${param.from_date}"/>
												<sql:param value="${plant.plant_id}"/>
				                         </sql:query>
										<sql:query var="transaction" dataSource="jdbc/rmc">
			                         			select t.* from (select DATE_FORMAT(i.date,'%d/%m/%Y') as date,i.date as dt,i.amount as debit,0 as credit,description as type
			                         			from test_petty_cash_transaction i where date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
			                         			and i.plant_id=?
			                         			UNION ALL
			                         			select DATE_FORMAT(p.date,'%d/%m/%Y') as date,p.date as dt,0 as debit,p.amount as credit,purpose as type
			                         			from test_petty_cash p where date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
			                         			and p.plant_id=?) as t order by t.dt asc
			                         			<sql:param value="${param.from_date}"/>
			                         			<sql:param value="${param.to_date}"/>
			                         			<sql:param value="${plant.plant_id}"/>
			                         			<sql:param value="${param.from_date}"/>
			                         			<sql:param value="${param.to_date}"/>
			                         			<sql:param value="${plant.plant_id}"/>
			                         		</sql:query>
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
			                                    	<th><fmt:formatNumber value="${total_credit-total_debit}" maxFractionDigits="2" groupingUsed="false"/></th>
			                                    </tr>
									</c:forEach>
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
				
				
				//get plant details
				var session=getSessionDetails();
				var BaseConfig=$.ajax({
			        async:false,
			        url:'../PlantController?button=GetPlantForSelect&plant_id='+session.plant_id+'&business_id='+session.business_id,
			        type:'post',
			        data:{'GetConfig':'YES'},
			        dataType:"JSON"
			     }).responseJSON;
				
				$('#plant_id').html("");
				if(session.plant_id==0)
					$('#plant_id').append('<option value="0">All Plant</option>')
				$.each(BaseConfig,function(i,v){
					$('#plant_id').append('<option value="'+i+'">'+v+'</option>')
				});
				
				
			});
		</script>
		<script type="text/javascript">
	    $("form").submit(function(e){
	        e.preventDefault();
	        var report_type=$('#report_type').val();
	        if(report_type=='pettycash'){
	        	var plant_id=$('#plant_id').val();
	        	var from_date=$('input[name="from_date"]').val();
	        	var to_date=$('input[name="to_date"]').val();
	        	window.location="PettyCashReport.jsp?action=generateReport&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&plant_id="+plant_id;
	        }
	        else if(report_type=='transaction'){
	        	var plant_id=$('#plant_id').val();
	        	var from_date=$('input[name="from_date"]').val();
	        	var to_date=$('input[name="to_date"]').val();
	        	window.location="PettyCashReport.jsp?action=generateReport&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&plant_id="+plant_id;
	        }
	        else if(report_type=='balance'){
	        	var plant_id=$('#plant_id').val();
	        	var from_date=$('input[name="from_date"]').val();
	        	var to_date=$('input[name="to_date"]').val();
	        	window.location="PettyCashReport.jsp?action=generateReport&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&plant_id="+plant_id;
	        }
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
    </body>
</html>