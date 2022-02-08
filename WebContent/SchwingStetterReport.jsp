<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
        <meta charset="utf-8" />
        <title>Customer Payment Report</title>
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
        	
        	.batch-table th{
        		background-color: #469399;
        		color: white;
        	}
        	
        	<style>
				.b1{
					background-color: #c5eada;
				}
				
				.b2{
					background-color: #b8b8e0;
				}
		</style>
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
                                    <li class="breadcrumb-item"><a href="#">Batching List</a></li>
                                    <li class="breadcrumb-item"><a href="#">Batching Report</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Consumption Report</h4>
                        </div>
                    </div>
                </div>
                 <!-- end row -->
                <div class="row">
                    <div class="col-md-12">
                       <form action="#" id="myform" method="post">
                          <div class="row">
                          	<div class="col-sm-3"></div>
                          	<div class="col-sm-6">
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat date">
                                  <div class="form-group">
                                      <label>From Date<span class="text-danger">*</span></label>
                                      <div class="cal-icon">
                                          <input type="text" name="from_date" class="form-control date-picker no-cus no-veh cus-dat veh-dat date from_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                      </div>
                                  </div>
                                </div>
                                
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat veh-dat date">
                                  <div class="form-group">
                                      <label>To Date<span class="text-danger">*</span></label>
                                      <div class="cal-icon">
                                          <input type="text" name="from_date"  class="form-control date-picker no-cus no-veh cus-dat veh-dat date to_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
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
                
               	<div class="row" style="margin-top: 25px;">
               		<div class="col-sm-12 printme table-responsive" id="printme">
						<div class="col-sm-12 row">
							<div class="col-sm-12">
								<sql:query var="batch" dataSource="jdbc/rmc">
									select t.*, DATE_FORMAT(t.batch_date,'%d/%m/%Y') as batch_date from batch_detail t where date(t.batch_date) between ? and ?
									<sql:param value="${param.from_date}"/>
									<sql:param value="${param.to_date}"/>
								</sql:query>
								<c:forEach items="${batch.rows}" var="bat">
								
							<table class="table table-bordered table-hover">
								<tr>
									<th class="text-center" colspan="9" style="background-color: navy;color: white;">
										BATCH REPORT OF BATCH NO - ${bat.Batch_No}
									</th>
								</tr>
								<tr>
									<td><b>Batch No : </b></td>
									<td colspan="2">${bat.Batch_No}</td>
									<td><b>Customer : </b></td>
									<td colspan="2">${bat.cust_id}</td>
									<td><b>Grade : </b></td>
									<td colspan="2">${bat.cust_id}</td>
								</tr>
								<tr>
									<td><b>Batch Date : </b></td>
									<td colspan="2">${bat.batch_date}</td>
									<td><b>Start Time : </b></td>
									<td colspan="2">${bat.batch_start_time_txt}</td>
									<td><b>End Time : </b></td>
									<td colspan="2">${bat.batch_end_time_txt}</td>
								</tr>
								<tr>
									<td><b>Site :</b> </td>
									<td colspan="2">${bat.site}</td>
									<td><b>Vehicle No :</b> </td>
									<td colspan="2">${bat.Truck_Id}</td>
									<td><b>Quantity :</b> </td>
									<td colspan="2">${bat.Production_Qty}</td>
								</tr>
								<tr>
									<th class="text-center">SET/BATCH</th>
									<th class="text-center">SAND1</th>
									<th class="text-center">SAND2</th>
									<th class="text-center">20MM</th>
									<th class="text-center">12MM</th>
									<th class="text-center">CEMENT</th>
									<th class="text-center">GGBS</th>
									<th class="text-center">WATER</th>
									<th class="text-center">ADMIX</th>
								</tr>	
								
								<sql:query var="set" dataSource="jdbc/rmc">
									select DISTINCT Prod1_Agg_Stwt,Prod2_Agg_Stwt,Prod3_Agg_Stwt,Prod4_Agg_Stwt,
									Prod7_Cem_Stwt,Prod8_Cem_Stwt,Prod12_Wtr_Stwt,Prod15_Adm_Stwt
									from batch_transaction
									where Batch_No=?
									<sql:param value="${bat.Batch_No}"/>
								</sql:query>
								<sql:query var="transaction" dataSource="jdbc/rmc">
									select Prod1_Agg_Stwt,Prod1_Agg_Atwt,Prod2_Agg_Stwt,Prod2_Agg_Atwt,Prod3_Agg_Stwt,Prod3_Agg_Atwt,Prod4_Agg_Stwt,Prod4_Agg_Atwt,
									Prod7_Cem_Stwt,Prod7_Cem_Atwt,Prod8_Cem_Stwt,Prod8_Cem_Atwt,Prod12_Wtr_Stwt,Prod12_Wtr_Atwt,Prod15_Adm_Stwt,Prod15_Adm_Atwt
									from batch_transaction
									where Batch_No=?
									<sql:param value="${bat.Batch_No}"/>
								</sql:query>
								<c:forEach items="${set.rows}" var="set">
									<c:set value="${set}" var="st"/>
								</c:forEach>
									<tr>
										<td class="text-center"><b>SET</b></td>
										<td class="text-center">${st.Prod1_Agg_Stwt}</td>
										<td class="text-center">${st.Prod2_Agg_Stwt}</td>
										<td class="text-center">${st.Prod3_Agg_Stwt}</td>
										<td class="text-center">${st.Prod4_Agg_Stwt}</td>
										<td class="text-center">${st.Prod7_Cem_Stwt}</td>
										<td class="text-center">${st.Prod8_Cem_Stwt}</td>
										<td class="text-center">${st.Prod12_Wtr_Stwt}</td>
										<td class="text-center">${st.Prod15_Adm_Stwt}</td>
									</tr>
								<c:set value="0" var="count"/>
								<c:set value="0" var="sum1"/>
								<c:set value="0" var="sum2"/>
								<c:set value="0" var="sum3"/>
								<c:set value="0" var="sum4"/>
								<c:set value="0" var="sum5"/>
								<c:set value="0" var="sum6"/>
								<c:set value="0" var="sum7"/>
								<c:set value="0" var="sum8"/>
								<c:forEach items="${transaction.rows}" var="transaction">
									<c:set var="count" value="${count+1}"/>
									<tr>
										<td class="text-center"><b>${count}</b></td>
										<td class="text-center">${transaction.Prod1_Agg_Atwt}</td>
										<td class="text-center">${transaction.Prod2_Agg_Atwt}</td>
										<td class="text-center">${transaction.Prod3_Agg_Atwt}</td>
										<td class="text-center">${transaction.Prod4_Agg_Atwt}</td>
										<td class="text-center">${transaction.Prod7_Cem_Atwt}</td>
										<td class="text-center">${transaction.Prod8_Cem_Atwt}</td>
										<td class="text-center">${transaction.Prod12_Wtr_Atwt}</td>
										<td class="text-center">${transaction.Prod15_Adm_Atwt}</td>
									</tr>
									<c:set value="${sum1+transaction.Prod1_Agg_Stwt}" var="sum1"/>
									<c:set value="${sum2+transaction.Prod2_Agg_Stwt}" var="sum2"/>
									<c:set value="${sum3+transaction.Prod3_Agg_Stwt}" var="sum3"/>
									<c:set value="${sum4+transaction.Prod4_Agg_Stwt}" var="sum4"/>
									<c:set value="${sum5+transaction.Prod7_Cem_Stwt}" var="sum5"/>
									<c:set value="${sum6+transaction.Prod8_Cem_Stwt}" var="sum6"/>
									<c:set value="${sum7+transaction.Prod12_Wtr_Stwt}" var="sum7"/>
									<c:set value="${sum8+transaction.Prod15_Adm_Stwt}" var="sum8"/>
								</c:forEach>
									<tr>
										<td colspan="9"></td>
									</tr>
									<tr>
										<td colspan="9"></td>
									</tr>
									<tr>
										<th class="text-center b1">TOTAL SET</th>
										<th class="text-center b1"><fmt:formatNumber value="${st.Prod1_Agg_Stwt*bat.Production_Qty}" maxFractionDigits="2" groupingUsed="false"/></th>
										<th class="text-center b1"><fmt:formatNumber value="${st.Prod2_Agg_Stwt*bat.Production_Qty}" maxFractionDigits="2" groupingUsed="false"/></th>
										<th class="text-center b1"><fmt:formatNumber value="${st.Prod3_Agg_Stwt*bat.Production_Qty}" maxFractionDigits="2" groupingUsed="false"/></th>
										<th class="text-center b1"><fmt:formatNumber value="${st.Prod4_Agg_Stwt*bat.Production_Qty}" maxFractionDigits="2" groupingUsed="false"/></th>
										<th class="text-center b1"><fmt:formatNumber value="${st.Prod7_Cem_Stwt*bat.Production_Qty}" maxFractionDigits="2" groupingUsed="false"/></th>
										<th class="text-center b1"><fmt:formatNumber value="${st.Prod8_Cem_Stwt*bat.Production_Qty}" maxFractionDigits="2" groupingUsed="false"/></th>
										<th class="text-center b1"><fmt:formatNumber value="${st.Prod12_Wtr_Stwt*bat.Production_Qty}" maxFractionDigits="2" groupingUsed="false"/></th>
										<th class="text-center b1"><fmt:formatNumber value="${st.Prod15_Adm_Stwt*bat.Production_Qty}" maxFractionDigits="2" groupingUsed="false"/></th>
									</tr>
									<tr>
										<th class="text-center b2">TOTAL BATCHED</th>	
										<th class="text-center b2">${sum1}</th>
										<th class="text-center b2">${sum2}</th>
										<th class="text-center b2">${sum3}</th>
										<th class="text-center b2">${sum4}</th>
										<th class="text-center b2">${sum5}</th>
										<th class="text-center b2">${sum6}</th>
										<th class="text-center b2">${sum7}</th>
										<th class="text-center b2"><fmt:formatNumber value="${sum8}" maxFractionDigits="2"/></th>
									</tr>				
							</table>
							</c:forEach>
							</div>
							
							<div class="col-sm-6">
								<div class="col-sm-12 text-center">
			               			<button class="btn btn-warning btn-sm" onclick="generate_excel();">Excel</button>
			               			<button class="btn btn-danger btn-sm" onclick="print();">Print</button>
			               		</div>
							</div>
						</div>
               		</div>
               	</div>
              	
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
        	window.location="SchwingStetterReport.jsp?action=generateReport&from_date="+from_date+"&to_date="+to_date;
	        
	    });
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
	      var table= document.getElementById("batch-table");
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