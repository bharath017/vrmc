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
        	
        	.batch-table th{
        		background-color: #469399;
        		color: white;
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
							<div class="col-sm-3">
							</div>
							<div class="col-sm-6">
							
								<!-- GET DETAIL'S HERE -->
								<c:choose>
									<c:when test="${empty param.action}">
										<sql:query var="batch" dataSource="jdbc/rmc">
											select date(timestamp),round(sum(AGG1_VALUE_VAL0)/1000,2) as s1,round(sum(AGG2_VALUE_VAL0)/1000,2) as s2,round(sum(AGG3_VALUE_VAL0)/1000,2) as s3,
			                            	round(sum(AGG4_VALUE_VAL0)/1000,2) as s4,round(sum(CEMTWT_VAL0)/1000,2) as s5,
			                            	round(sum(CEMTWT1_VAL0)/1000,2) as s6,round(sum(CEMTWT2_VAL0)/1000,2) as s7,round(sum(WTRWT_VAL0)/1000,2) as s8,
			                            	round(sum(ADDWT_VAL0),2) as s9
			                            	from ved_log where date(timestamp)=curdate();
										</sql:query>
									</c:when>
									<c:otherwise>
										<sql:query var="batch" dataSource="jdbc/rmc">
											select date(timestamp),round(sum(AGG1_VALUE_VAL0),2) as s1,round(sum(AGG2_VALUE_VAL0),2) as s2,round(sum(AGG3_VALUE_VAL0),2) as s3,
			                            	round(sum(AGG4_VALUE_VAL0),2) as s4,round(sum(CEMTWT_VAL0),2) as s5,
			                            	round(sum(CEMTWT1_VAL0),2) as s6,round(sum(CEMTWT2_VAL0),2) as s7,round(sum(WTRWT_VAL0),2) as s8,
			                            	round(sum(ADDWT_VAL0),2) as s9
			                            	from ved_log where date(timestamp) between ? and ?
			                            	<sql:param value="${param.from_date}"/>
			                            	<sql:param value="${param.to_date}"/>
										</sql:query>
									</c:otherwise>
								</c:choose>
								<c:forEach items="${cons.rows}" var="cons">
	                            	<c:set value="${cons}" var="con"/>
	                            </c:forEach>								
								<table class="table table-bordered table-hover batch-table text-center" id="batch-table">
									<thead>
										<tr>
											<th colspan="3">
												<c:choose>
													<c:when test="${empty param.action}">
														Consumption Report From Date -Today Date / To Date -Today Date 
													</c:when>
													<c:otherwise>
														Consumption Report From Date -${param.from_date} / To Date -${param.to_date} 
													</c:otherwise>
												</c:choose>
											</th>
										</tr>
										<tr>
											<th>Item Name</th>
											<th>Quantity</th>
											<th>Unit</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th style="width: 30%;">12MM</th>
											<td>${(empty con.s1)?0:con.s1}</td>
											<td>TON</td>
										</tr>
										<tr>
											<th>M SAND</th>
											<td>${(empty con.s2)?0:con.s2}</td>
											<td>TON</td>
										</tr>
										<tr>
											<th>M SAND</th>
											<td>${(empty con.s3)?0:con.s3}</td>
											<td>TON</td>
										</tr>
										<tr>
											<th>20 MM</th>
											<td>${(empty con.s4)?0:con.s4}</td>
											<td>TON</td>
										</tr>
										<tr>
											<th>CEMENT1</th>
											<td>${(empty con.s5)?0:con.s5}</td>
											<td>TON</td>
										</tr>
										<tr>
											<th>CEMENT2</th>
											<td>${(empty con.s6)?0:con.s6}</td>
											<td>TON</td>
										</tr>
										<tr>
											<th>CEMENT3</th>
											<td>${(empty con.s7)?0:con.s7}</td>
											<td>TON</td>
										</tr>
										<tr>
											<th>WATER</th>
											<td>${(empty con.s8)?0:con.s8}</td>
											<td>TON</td>
										</tr>
										<tr>
											<th>ADMIXTURE</th>
											<td>${(empty con.s9)?0:con.s9}</td>
											<td>KG</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="col-sm-3"></div>
							<div class="col-sm-3"></div>
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
        	window.location="BatchingReport.jsp?action=generateReport&from_date="+from_date+"&to_date="+to_date;
	        
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