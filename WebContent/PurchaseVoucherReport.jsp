<%@ include file="Session.jsp"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
      <title>Purchase Voucher report</title>
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
        <script src="assets/js/modernizr.min.js"></script>
        
        
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
 <!-- Put header panel here -->
        
        <%@ include file="header.jsp" %>
        
        <!-- Put left side panel here -->
      
    <div class="wrapper">       
            <div class="container-fluid">
                <div class="row">
                	<div class="col-md-12">
                		<h2 class="text-info text-center">Purchase Voucher Report</h2><hr>
                	</div>
                    <div class="col-md-12">
                       <form action="#" id="myform" method="post">
                          <div class="row">
                          	<div class="col-sm-3"></div>
                          	<div class="col-sm-6">
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
                                           <option value="date">Date Wise</option>
                                           <option value="supplier">Supplier Wise</option>
                                          
                                       </select>
                                   </div>
                               </div>
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat date dttm">
                                  <div class="form-group">
                                      <label>From Date<span class="text-danger">*</span></label>
                                  		 <div class="input-group cal-icon">
                                 			 <input class="form-control date-picker no-cus cus-dat date from_date" 
                                 			 		  id="id-date-picker-1" name="from_date" type="text"
                                 			 		  required="required" placeholder="dd/mm/yyyy"
                                 			 		  data-date-format="dd/mm/yyyy" readonly="readonly" 
                                 			 		  style="background-color:  white;" value="${param.from_date}"/>
                      			       			<div class="input-group-append picker">
                                                   <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                               </div>
                      			       </div>
                                  </div>
                                </div>
                                <div class="col-sm-12 no-date no-cus no-veh  no-veh-dat dttm cusdttm no-cus-dat">
                                   <div class="form-group">
                                       <label>From Time<span class="text-danger">*</span></label>
										<div class="cal-icon">
											<input name="from_time" required="required" id="timepicker1" type="text" class="form-control no-date  no-veh  no-veh-dat dttm cusdttm from_time no-cus-dat" />
										</div>
                                   </div>
                                </div>
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat veh-dat date dttm">
                                  <div class="form-group">
                                      <label>To Date<span class="text-danger">*</span></label>
                                     <div class="input-group cal-icon ">
                                		  <input class="form-control date-picker no-cus cus-dat date to_date"  
                                		  		 id="id-date-picker-1" name="to_date" type="text" required="required"
                                		  		 placeholder="dd/mm/yyyy" data-date-format="dd/mm/yyyy"
                                		  		 readonly="readonly" style="background-color:  white;"
                                		  		 value="${param.to_date}"/>
                         		  			<div class="input-group-append picker">
                                                   <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                               </div>
                         		    </div>
                                  </div>
                                </div>
                               <div class="col-sm-12 no-date no-cus no-veh  no-veh-dat dttm cusdttm no-cus-dat">
                                   <div class="form-group"> 
                                       <label>To Time<span class="text-danger">*</span></label>
										<div class="cal-icon">
											<input name="to_time" required="required" id="timepicker2" type="text" class="form-control  no-date  no-veh  no-veh-dat dttm cusdttm to_time no-cus-dat" />
										</div>
                                   </div>
                                </div>
                               <div class="col-sm-12 no-date cus no-veh cus-dat no-veh-dat no-dttm">
                                   <div class="form-group">
                                       <label>Supplier <span class="text-danger">*</span></label>
                                       <select class="select2 no-date cus no-veh cus-dat no-veh-dat no-dttm" name="supplier_id" id="supplier_id" required="required">
                                           <option value="" selected="selected" disabled="disabled">Please Select</option>
                                           
                                       </select>
                                   </div>
                               </div>
                               
                          	</div> 	
                          </div>
                           
                          <div class="text-center m-t-20">
                               <button type="submit" class="btn btn-primary btn-lg m-r-10 save-button">Generate Report</button>
                               <a class="btn btn-info btn-lg" href="PurchaseVoucherReport.jsp">Clear Report</a>
                          </div>
                       </form>
                    </div>
                </div>
                
               <c:if test="${param.action=='generateReport'}">
               	<div class="row" style="margin-top: 25px;">
               		<div class="col-sm-12">
               			<button class="btn btn-warning btn-sm" onclick="generate_excel();">Excel</button>
               			<button class="btn btn-danger btn-sm" onclick="print();">Print</button>
               			<button type="button" class="btn btn-success btn-sm" id="tally">TALLY XML</button>
               		</div>
               		<div class="col-sm-12 printme" id="printme">
               			<!-- Get all kind of query here -->
               				<c:choose>
               					<c:when test="${param.report_type=='date'}">
               						<sql:query var="inv" dataSource="jdbc/rmc">
               							select pvi.*,pv.*,DATE_FORMAT(pv.purchase_date,'%d/%m/%Y') as realdate,s.supplier_name,DATE_FORMAT(pvi.timestamp,'%m/%d/%Y %H:%i') as realtimestamp
               							 from purchase_voucher_item pvi LEFT JOIN (purchase_voucher pv,supplier s)               							
               							ON pvi.purchase_voucher_id=pv.purchase_voucher_id
               							where pv.purchase_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
               							and pv.supplier_id=s.supplier_id
               							and pv.voucher_status='active'
               							and s.business_id like if(?=0,'%%',?)
               							order by pv.purchase_date,pv.purchase_voucher_id asc
               							<sql:param value="${param.from_date}"/>
               							<sql:param value="${param.to_date}"/>
               							<sql:param value="${param.business_id}"/>
               							<sql:param value="${param.business_id}"/>
               						</sql:query>
               					</c:when>
               					
               					<c:when test="${param.report_type=='datetime'}">
               						<sql:query var="inv" dataSource="jdbc/rmc">
               							select pvi.*,pv.*,DATE_FORMAT(pv.purchase_date,'%d/%m/%Y') as realdate,DATE_FORMAT(pvi.timestamp,'%m/%d/%Y %H:%i') as realtimestamp,s.supplier_name
               							from purchase_voucher_item pvi LEFT JOIN (purchase_voucher pv,supplier s)               						
               							ON pvi.purchase_voucher_id=pv.purchase_voucher_id
               							where pvi.timestamp between concat(?,' ',?) and concat(?,' ',?)
               							and pv.supplier_id=s.supplier_id
               							and pv.voucher_status='active'
               							and s.business_id like if(?=0,'%%',?)
               							order by pv.purchase_date,pv.purchase_voucher_id asc
               							<sql:param value="${param.from_date}"/>
               							<sql:param value="${param.from_time}"/>
               							<sql:param value="${param.to_date}"/>
               							<sql:param value="${param.to_time}"/>
               							<sql:param value="${param.business_id}"/>
               							<sql:param value="${param.business_id}"/>
               						</sql:query>
               					</c:when>
               					
               					<c:when test="${param.report_type=='supplier'}">
               						<sql:query var="inv" dataSource="jdbc/rmc">
               							select pvi.*,pv.*,DATE_FORMAT(pv.purchase_date,'%d/%m/%Y') as realdate,DATE_FORMAT(pvi.timestamp,'%m/%d/%Y %H:%i') as realtimestamp,s.supplier_name
               							from purchase_voucher_item pvi LEFT JOIN (purchase_voucher pv,supplier s)
               							ON pvi.purchase_voucher_id=pv.purchase_voucher_id
               							where pv.supplier_id like if(''=?,'%%',?)
               							and pv.supplier_id=s.supplier_id
               							and pv.voucher_status='active'
               							and s.business_id like if(?=0,'%%',?)
               							order by pv.purchase_date,pv.purchase_voucher_id asc
               							<sql:param value="${param.supplier_id}"/>
               							<sql:param value="${param.supplier_id}"/>
               							<sql:param value="${param.business_id}"/>
               							<sql:param value="${param.business_id}"/>
               						</sql:query>
               					</c:when>
               					
               					<c:when test="${param.report_type=='supplierdate'}">
               						<sql:query var="inv" dataSource="jdbc/rmc">
               							select pvi.*,pv.*,DATE_FORMAT(pv.purchase_date,'%d/%m/%Y') as realdate,DATE_FORMAT(pvi.timestamp,'%m/%d/%Y %H:%i') as realtimestamp
               							from purchase_voucher_item pvi LEFT JOIN (purchase_voucher pv)
               							ON pvi.purchase_voucher_id=pv.purchase_voucher_id
               							where pv.supplier_id like if(''=?,'%%',?)
               							and pv.purchase_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
               							and pv.voucher_status='active'
               							order by pv.purchase_date,pv.purchase_voucher_id asc
               							<sql:param value="${param.supplier_id}"/>
               							<sql:param value="${param.supplier_id}"/>
               							<sql:param value="${param.from_date}"/>
               							<sql:param value="${param.to_date}"/>
               						</sql:query>
               					</c:when>
               				</c:choose>
               			<table class="table table-bordered" id="example-2">
               				<tr style="background-color: #741d7a;color: white;" class="text-center">
               					<td></td>
               					<td></td>
               					<td></td>
               					<td></td>
               					<td colspan="3" class="text-center">
               						<h3>Purchase Voucher Report</h3>
               					</td>
               					<td></td>
               					<td></td>
               					<td></td>
               					<td></td>
               				</tr>
               				<tr style="background-color: #4b9663;color: white;">
               					<th>DC No</th>
						<th>Vendor Name</th>
               					<th>Item Name</th>
               					<th>Date</th>
               					<th>Bill No</th>	
               					<th>Quantity</th>
               					<th>Rate</th>
               					<th>GST(%)</th>
               					<th>Gross Amount</th>
               					<th>Tax Amount</th>
               					<th>Net Amount</th>
               					
               				</tr>
               					
               				<c:set value="0" var="total_gross"/>
               				<c:set value="0" var="total_tax"/>
               				<c:set value="0" var="total_net"/>
               				<c:set value="0" var="total_quantity"/>
               				<c:set value="0" var="count"/>
               				<c:forEach items="${inv.rows}" var="inv">
								<c:set value="${inv.gross_amount+total_gross}" var="total_gross"/>
	               				<c:set value="${inv.tax_amount+total_tax}" var="total_tax"/>
	               				<c:set value="${inv.net_amount+total_net}" var="total_net"/>
	               				<c:set value="${total_quantity+inv.item_quantity}" var="total_quantity"/>
               					<c:set value="${count+1}" var="count"/>
               					<tr>
	               					<td>${count}</td>
									<td>${inv.supplier_name}</td>
	               					<td>${inv.item_name}</td>
	               					<td>${inv.realdate}</td>
	               					<td>${inv.bill_no}</td>
	               					<td>${inv.item_quantity}</td>
	               					<td>${inv.item_price}</td>
	               					<td>${inv.gst_percent}</td>
	               					<td>${inv.gross_amount}</td>
	               					<td>${inv.tax_amount}</td>
	               					<td>${inv.net_amount}</td>
	               					
	               				</tr>
               				</c:forEach>
               					<tr style="background-color: #70643b;color: white;">
               						<td colspan="5" class="text-right"></td>
               						<td><fmt:formatNumber value="${total_quantity}" maxFractionDigits="2" groupingUsed="false"/></td>
               						<td colspan="2"></td>
               						<td class="text-left"><fmt:formatNumber value="${total_gross}" maxFractionDigits="2" groupingUsed="false"/></td>
               						<td class="text-left"><fmt:formatNumber value="${total_tax}" maxFractionDigits="2" groupingUsed="false"/></td>
               						<td class="text-left"><fmt:formatNumber value="${total_net}" maxFractionDigits="2" groupingUsed="false"/></td>
               						
               					</tr>
               				
               			</table>
               		</div>
               	</div>
               </c:if>
            </div>      
    </div>
    
    
    	<a class="dropdown-item" id="tally-click" style="display: none;" href="#tally_modal" data-animation="blur" data-plugin="custommodal"  data-overlaySpeed="100" data-overlayColor="#36404a"><i class="fa fa-pencil mr-2 text-muted font-18 vertical-middle"></i>Change Docket No</a>
				<div id="tally_modal" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title text-uppercase" style="color: white;background-color: #28afa0;"><b>Update Tally Ledger</b></h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="SupplierController?action=UpdateTallyLedger" method="post">
		                	<table class="table table-bordered" id="ledger">
		                		<thead>
		                			<tr style="background-color: #c100db;color: white;">
		                				<th>Customer</th>
		                				<th>Tally Ledger</th>
		                			</tr>
		                		</thead>
		                		<tbody>
		            				    			
		                		</tbody>
		                		<tfoot>
		                			<tr>
		                				<td colspan="2">
		                					<button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">SAVE TALLY LEDGER</button>
		                            		<button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
		                				</td>
		                			</tr>
		                		</tfoot>
		                	</table>
		                	
		                </form>
		            </div>
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
    	<script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>
		    <script>
		 	  $(document).ready(function(){
				 $('.select2').css('width','100%').select2({allowClear:true})
					.on('change', function(){
					}); 
		         
		         
				    $('.date-picker').datepicker({
						autoclose: true,
						todayHighlight: true,
						"orientation":"bottom right"
				 });
					//show datepicker when clicking on the icon
					
		         
		         $("#id-date-picker-1").datepicker();
					$('#id-date-picker-1').datepicker({
					        "autoclose": true,
					        "orientation":"bottom right"
				});
		    
			
			 $('.picker').on('click',function(){
					$(this).prev("input.date-picker").datepicker("show");
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
				
				$('#timepicker2').timepicker({
					minuteStep: 1,
					showSeconds: true,
					showMeridian: false,
					disableFocus: true,
					icons: {
						up: 'fa fa-chevron-up',
						down: 'fa fa-chevron-down'
					}
				}).on('focus', function() {
					$('#timepicke2').timepicker('showWidget');
				}).next().on(ace.click_event, function(){
					$(this).prev().focus();
				});
			});
		</script>
    
    <script type="text/javascript">
	    $("#myform").submit(function(e){
	        e.preventDefault();
	        var report_type=$('#report_type').val();
	        var business_id=$('#business_id').val();
	        if(report_type=='date'){
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	window.location="PurchaseVoucherReport.jsp?action=generateReport&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&business_id="+business_id;
	        }else if(report_type=='datetime'){
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	var from_time=$('.from_time').val();
	        	var to_time=$('.to_time').val();
	        	window.location="PurchaseVoucherReport.jsp?action=generateReport&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&from_time="+from_time+"&to_time="+to_time+"&business_id="+business_id;
	        }else if(report_type=='supplier'){
	        	var supplier_id=$('#supplier_id').val();	        
	        	window.location="PurchaseVoucherReport.jsp?action=generateReport&report_type="+report_type+"&supplier_id="+supplier_id+"&business_id="+business_id;
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
    			}else if(report_type=='supplier'){
    				$('.cus').prop('disabled',false);
    				$('.no-cus').prop('disabled',true);
    				$('.cus').show();
    				$('.no-cus').hide();
    			}else if(report_type=='supplierdate'){
    				$('.cus-dat').prop('disabled',false);
    				$('.no-cus-dat').prop('disabled',true);
    				$('.cus-dat').show();
    				$('.no-cus-dat').hide();
    			}else if(report_type=='datetime'){
    				$('.dttm').prop('disabled',false);
    				$('no-dttm').prop('disabled',true);
    				$('.dttm').show();
    				$('.no-dttm').hide();
    			}
    		});
    	})
    </script>
    <script type="text/javascript">
    	$(document).ready(function(){
    		
    		var getSupplierByBusinessGroup=function(business_id){
    			$.ajax({
    				type:'POST',
    				url:'SupplierController?action=getSupplierListByBusinessGroup&business_id='+business_id,
    				headers:{
    					Accept:"application/json;charset=utf-8",
    					"Content-Type":"application/json;charset=utf-8"
    				},
    				success:function(res){
    					$('#supplier_id').empty();
    					$('#supplier_id').append('<option value="" selected="selected" disabled>Select Supplier</option>');
    					$.each(res,function(i,d){
    						$('#supplier_id').append('<option value="'+d.supplier_id+'">'+d.supplier_name+'</option>');
    					});
    				}
    			});
    		}
    		
    		$('#business_id').on('change',function(){
    			var business_id=$('#business_id').val();
    			getSupplierByBusinessGroup(business_id);
    		});
    		
    		var business_id=$('#business_id').val();
    		getSupplierByBusinessGroup(business_id);
    		
    		
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
    			var from_date=GetURLParameter('from_date');
    			var report_type=GetURLParameter('report_type');
    			var to_date=GetURLParameter('to_date');
    			if(report_type=='date'){
    			$.ajax({
    				type:'POST',
    				url:'PurchaseVoucherController?action=TallyXml&from_date='+from_date+'&to_date='+to_date,
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
            				row+='<td>'+value.name+'<input type="hidden" name="supplier_id" value="'+index+'"></td><td><input type="text" class="col-xs-12" name="tally_ledger"></td>'
            				row+='</tr>'
            			  $('#ledger tbody').append(row);
    	        		});
    					if(count>0){
    						$('#tally-click').trigger('click');
    					}else{
    						 window.location.href='PurchaseVoucherTally.jsp?report_type='+report_type+'&from_date='+from_date+'&to_date='+to_date; 
    					}
    				}
    			})
    			}
    		});
    	});
    </script>
</body>
</html>