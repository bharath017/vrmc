<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
        <meta charset="utf-8" />
        <title>Inventory OutGoing Report</title>
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
        
         <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        
        <style type="text/css">
        	.change{
        		background-color:#469399;
        		color: white;
        	}
        	
        	.nochange{
        		background-color: #d7dfe0;
        		
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
                                    <li class="breadcrumb-item"><a href="#">Inventory</a></li>
                                    <li class="breadcrumb-item"><a href="#">Reports</a></li>
                                    <li class="breadcrumb-item"><a href="#">Inventory OutGoing Report</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Inventory OutGoing Report</h4>
                        </div>
                    </div>
                </div>
                 <!-- end row -->
                <div class="row">
                	<div class="col-md-12">
                		<h2 class="text-info text-center">Generate Inventory OutGoing Report</h2><hr><br><br>
                	</div>
                    <div class="col-md-12">
                       <form action="#" id="myform" method="post">
                          <div class="row">
                          	<div class="col-sm-3"></div>
                          	<div class="col-sm-6">
                          		<div class="col-sm-12">
                                   <div class="form-group">
                                       <label>Report Type<span class="text-danger">*</span></label>
                                       <select class="select2" name="report_type" id="report_type" required="required">
                                           <option value="date">Date Wise</option>
                                       </select>
                                   </div>
                               </div>
                               
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat date">
                                  <div class="form-group">
                                      <label>From Date<span class="text-danger">*</span></label>
                                      <div class="cal-icon">
                                          <input type="text" name="from_date" class="form-control date-picker no-cus date from_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                      </div>
                                  </div>
                                </div>
                                
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat veh-dat date">
                                  <div class="form-group">
                                      <label>To Date<span class="text-danger">*</span></label>
                                      <div class="cal-icon">
                                          <input type="text" name="to_date"  class="form-control date-picker date to_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                      </div>
                                  </div>
                                </div>
                               
                             
                               
                               <div class="col-sm-12">
                                   <div class="form-group">
                                       <label>Items<span class="text-danger">*</span></label>
                                        <sql:query var="item" dataSource="jdbc/rmc">
                                       	select * from inventory_item
                                       </sql:query>
                                       <select class="select2" name="inv_item_id" id="inv_item_id">
                                           <option selected="selected"  value="">All Inventory</option>
                                           <c:forEach items="${item.rows}" var="item">
                                           <option value="${item.inv_item_id}">${item.inventory_name}</option>
                                           </c:forEach>
                                       </select>
                                   </div>
                               </div>
                               
                               <div class="col-sm-12">
                                   <div class="form-group">
                                       <label>Plant <span class="text-danger">*</span></label>
                                       <sql:query var="plant" dataSource="jdbc/rmc">
                                       	select * from plant where plant_id like if(?=0,'%%',?)
                                       	<sql:param value="${bean.plant_id}"/>
                                       	<sql:param value="${bean.plant_id}"/>
                                       </sql:query>
                                       <select class="select2" name="plant_id" id="plant_id">
                                           <c:if test="${bean.plant_id==0}">
                                           	<option value="" selected="selected">All Plant</option>
                                           </c:if>
                                           <c:forEach items="${plant.rows}" var="plant">
                                           <option value="${plant.plant_id}">${plant.plant_name}</option>
                                           </c:forEach>
                                       </select>
                                   </div>
                                </div>
                               
                          	</div> 	
                          </div>
                           
                          <div class="text-center m-t-20">
                               <button type="submit" class="btn btn-primary btn-lg m-r-10 save-button">Generate Report</button>
                               <a class="btn btn-danger btn-lg" href="InventoryOutGoingReport.jsp">Clear Report</a>
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
               				<c:set value="${(empty param.plant_id || param.plant_id=='null')?'':param.plant_id}" var="plant_id"/>
               				<c:set value="${(empty param.inv_item_id || param.inv_item_id=='null')?'':param.inv_item_id}" var="inv_item_id"/>
               				<c:choose>
               					<c:when test="${param.report_type=='date'}">
               						<sql:query var="inv" dataSource="jdbc/rmc">
               			               select io.*,it.inventory_name,p.plant_name from inventory_outgoing io LEFT JOIN (plant p,inventory_item it)
               			                ON   io.plant_id=p.plant_id and 
			                            io.inv_item_id=it.inv_item_id 
			                            where io.consumption_date between ? and ?		
			             				and it.inv_item_id like if(''=?,'%%',?)
			             				and io.plant_id like if(''=?,'%%',?)
			             				order by invout_id asc			
               							<sql:param value="${param.from_date}"/>
               							<sql:param value="${param.to_date}"/>
               							<sql:param value="${inv_item_id}"/>
               							<sql:param value="${inv_item_id}"/>
               							<sql:param value="${plant_id}"/>
               							<sql:param value="${plant_id}"/>
               						</sql:query>
               					</c:when>
               					
               				</c:choose>
               			<table class="table table-bordered" id="example-2">
               				<tr style="background-color: #741d7a;color: white;" class="text-center">
               					<td></td>
               					<td></td>
               					<td></td>
               					<td class="text-center" colspan="2">
               						<h3>INVENTORY OUTGOING REPORT</h3>
               					</td>
               					<td></td>
               						
               				</tr>
               				<tr style="background-color: #4b9663;color: white;">
               					<th>Inventory Id</th>
               					<th>Plant Name</th>
               					<th>Inventory Name</th>
               					<th>Date</th>
               					<th>Time</th>
               					<th>Consumption Quantity</th>
               				</tr>
               				<c:set value="0" var="tot_emptyqty"/>
               				
               				<c:forEach items="${inv.rows}" var="inv">
               				    <c:set value="${tot_emptyqty+inv.consumption_quantity}" var="tot_emptyqty"/>
               					<tr>
	               					<td>${inv.invout_id}</td>
	               					<td>${inv.plant_name}</td>
	               					<td>${inv.inventory_name}</td>
	               					<td>${inv.consumption_date}</td>
	               					<td>${inv.consumption_time}</td>
	               					<td>${inv.consumption_quantity}</td>
	               				</tr>
               				</c:forEach> 
               					 <tr style="background-color: #70643b;color: white;">
               						<td colspan="5" class="text-right">Total Empty Weight : </td>
               						<td colspan="2" class="text-left">
               							<fmt:formatNumber value="${tot_emptyqty}" maxFractionDigits="2" groupingUsed="false"/>
               						</td>
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
		
		<!-- Modal-Effect -->
        <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>
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
	    $("#myform").submit(function(e){
	        e.preventDefault();
	        var report_type=$('#report_type').val();
	        if(report_type=='date'){
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	var inv_item_id=$('#inv_item_id').val();
	        	var plant_id=$('#plant_id').val();
	        	window.location="InventoryOutGoingReport.jsp?action=generateReport&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&inv_item_id="+inv_item_id+"&plant_id="+plant_id;
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
    			var report_type=$('#report_type').val();
    			if(report_type=='date'){
    				$('.no-date').hide();
    				$('.no-date').prop('disabled',true);
    				$('.date').show();
    				$('.date').prop('disabled',false);
    			}
    		});
    	})
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
    <script type="text/javascript">
	    function GetURLParameter(sParam)
	    {
	        var sPageURL = window.location.search.substring(1);
	        var sURLVariables = sPageURL.split('&');
	        for (var i = 0; i < sURLVariables.length; i++) 
	        {
	            var sParameterName = sURLVariables[i].split('=');
	            if (sParameterName[0] == sParam) 
	            {
	                return sParameterName[1];
	            }
	        }
	    }
    </script>
 
		
    </body>
</html>