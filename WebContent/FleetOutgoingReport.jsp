<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
        <meta charset="utf-8" />
        <title>Outgoing Fleet Report</title>
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
                                    <li class="breadcrumb-item"><a href="#">Fleet</a></li>
                                    <li class="breadcrumb-item"><a href="#">Reports</a></li>
                                    <li class="breadcrumb-item"><a href="#">Outgoing Fleet Report</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Outgoing Fleet Report</h4>
                        </div>
                    </div>
                </div>
                 <!-- end row -->
                <div class="row">
                	<div class="col-md-12">
                		<h2 class="text-info text-center">Outgoing Fleet Report</h2><hr><br><br>
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
                                          <input type="text" name="from_date" class="form-control date-picker no-cus cus-dat date from_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                      </div>
                                  </div>
                                </div>
                                
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat veh-dat date">
                                  <div class="form-group">
                                      <label>To Date<span class="text-danger">*</span></label>
                                      <div class="cal-icon">
                                          <input type="text" name="to_date"  class="form-control date-picker no-cus cus-dat date to_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                      </div>
                                  </div>
                                </div>
                               
                               <div class="col-sm-12 no-date cus no-veh cus-dat no-veh-dat">
                                   <div class="form-group">
                                       <label>Supplier <span class="text-danger">*</span></label>
                                       <sql:query var="customer" dataSource="jdbc/rmc">
                                       	select * from supplier where supplier_status='active' order by supplier_name asc
                                       </sql:query>
                                       <select class="select2 no-date cus no-veh cus-dat no-veh-dat" name="supplier_id" id="supplier_id" required="required">
                                           <option value="" selected="selected" disabled="disabled">Please Select</option>
                                           <c:forEach items="${customer.rows}" var="customer">
                                           <option value="${customer.supplier_id}">${customer.supplier_name}</option>
                                           </c:forEach>
                                       </select>
                                   </div>
                               </div>
                               
                               <div class="col-sm-12">
                                   <div class="form-group">
                                       <label>Items<span class="text-danger">*</span></label>
                                        <sql:query var="item" dataSource="jdbc/rmc">
                                       	select * from fleet_item
                                       </sql:query>
                                       <select class="select2" name="fleet_item_id" id="fleet_item_id">
                                           <option selected="selected"  value="">All Item</option>
                                           <c:forEach items="${item.rows}" var="item">
                                           <option value="${item.fleet_item_id}">${item.item_name}</option>
                                           </c:forEach>
                                       </select>
                                   </div>
                               </div>
                               
                               <div class="col-sm-12">
                                   <div class="form-group">
                                       <label>Plant <span class="text-danger">*</span></label>
                                       <sql:query var="plant" dataSource="jdbc/rmc">
                                       	select * from plant
                                       </sql:query>
                                       <select class="select2" name="plant_id" id="plant_id">
                                           <option value="" selected="selected">All Plant</option>
                                           <option value="0">Office</option>
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
                               <a class="btn btn-danger btn-lg" href="IncomingFleetReport.jsp">Clear Report</a>
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
               				<c:set value="${(empty param.fleet_item_id || param.fleet_item_id=='null')?'':param.fleet_item_id}" var="fleet_item_id"/>
               				<c:choose>
               					<c:when test="${param.report_type=='date'}">
               						<sql:query var="inv" dataSource="jdbc/rmc">
               			               select foi.*,fi.item_name,f.* ,(select plant_name from plant where plant_id=f.plant_id) as plant_name
               			               from fleet_outgoing_item foi LEFT JOIN(fleet_outgoing f,fleet_item fi)
               			               ON foi.fleet_item_id=fi.fleet_item_id
               			               and foi.fleet_outgoing_id=f.fleet_outgoing_id
               			               where f.issued_date between ? and ?
               			               and foi.fleet_item_id like if(''=?,'%%',?)
               			               and f.plant_id like if(''=?,'%%',?)
               			               order by fo_item_id desc 
               						   <sql:param value="${param.from_date}"/>
               						   <sql:param value="${param.to_date}"/>
               						   <sql:param value="${fleet_item_id}"/>
               						   <sql:param value="${fleet_item_id}"/>
               						   <sql:param value="${plant_id}"/>
               						   <sql:param value="${plant_id}"/>
               						</sql:query>
               					</c:when>
               				</c:choose>
               			<table class="table table-bordered" id="example-2">
               				<tr style="background-color: #741d7a;color: white;" class="text-center">
               					<td></td>
               					<td></td>
               					<td colspan="4" class="text-center">
               						<h3>Outgoing Fleet Report</h3>
               					</td>
               					<td></td>
               					<td></td>
               				</tr>
               				<tr style="background-color: #4b9663;color: white;">
               					<th>S/L No</th>
               					<th>Item Name</th>
               					<th>Date</th>
               					<th>Time</th>
               					<th>Received Person</th>
               				    <th>Quantity</th>
               				    <th>Returnable</th>
               					<th>Plant Name</th>
               				</tr>
							<c:set value="0" var="sum"/>               				
               				<c:forEach items="${inv.rows}" var="inv">
	               				<c:set value="${sum+1}" var="sum"/>
               					<tr>
	               					<td>${sum}</td>
	               					<td>${inv.item_name}</td>
	               					<td>${inv.issued_date}</td>
	               					<td>${inv.issued_time}</td>
	               					<td>${inv.received_person}</td>
	               					<td>${inv.quantity}</td>
	               					<td>${inv.returnable}</td>
	               					<td>${(empty inv.plant_name)?'Office':inv.plant_name}</td>
	               					
	               				</tr>
               				</c:forEach> 
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
	        	var fleet_item_id=$('#fleet_item_id').val();
	        	var plant_id=$('#plant_id').val();
	        	window.location="FleetOutgoingReport.jsp?action=generateReport&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&fleet_item_id="+fleet_item_id+"&plant_id="+plant_id;
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
    <script type="text/javascript">
    	$(document).ready(function(){
    		$('#tally').on("click",function(){
    			var report_type=GetURLParameter('report_type');
    			var customer_id=GetURLParameter('supplier_id');
    			var from_date=GetURLParameter('from_date');
    			var to_date=GetURLParameter('to_date');
    			var product_id=GetURLParameter('product_id');
    			var plant_id=GetURLParameter('plant_id');
    			
    			$.ajax({
    				type:'POST',
    				url:'InvoiceController?action=TallyXml&report_type='+report_type+'&supplier_id='+customer_id+'&from_date='+from_date+'&to_date='+to_date+'&inv_item_id='+product_id+'&plant_id='+plant_id,
    				headers:{
    					Accept:"application/json;charset=utf-8",
    				    "Content-Type":"application/json;charset=utf-8"
    				},
    				success:function(res){
    					$('#ledger tbody').html("");
    					var count=0;
    					$.each(res, function(index, value) {
            				count++;
            				var row='<tr>';
            				row+='<td>'+value.name+'<input type="hidden" name="site_id" value="'+index+'"></td><td>'+value.address+'</td><td><input type="text" class="col-xs-12" name="tally_ladger"></td>'
            				row+='</tr>'
            			  $('#ledger tbody').append(row);
    	        		});
    					if(count>0){
    						$('#tally-click').trigger('click');
    					}else{
    						window.location.href='TallyXML.jsp?report_type='+report_type+'&customer_id='+customer_id+'&from_date='+from_date+'&to_date='+to_date+'&site_id='+site_id+'&product_id='+product_id+'&plant_id='+plant_id+'&vehicle_no='+vehicle_no;
    					}
    				}
    			})
    		});
    	});
    </script>
    </body>
</html>