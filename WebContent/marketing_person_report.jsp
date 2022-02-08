<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
        <meta charset="utf-8" />
        <title>Marketing Person Report</title>
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
                                    <li class="breadcrumb-item"><a href="#">Billing</a></li>
                                    <li class="breadcrumb-item"><a href="#">Report</a></li>
                                    <li class="breadcrumb-item"><a href="#">Marketing Person Report</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Marketing Person Report</h4>
                        </div>
                    </div>
                </div>
                 <!-- end row -->
                <div class="row">
                	<div class="col-md-12">
                		<h2 class="text-info text-center">Marketing Person Report</h2><hr>
                	</div>
                    <div class="col-md-12">
                       <form action="#" id="myform" method="post">
                          <div class="row">
                          	<div class="col-sm-4"></div>
                          	<div class="col-sm-4">
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat date">
                                  <div class="form-group">
                                      <label>From Date<span class="text-danger">*</span></label>
                                      <div class="input-group">
                                          <input type="text" name="from_date" class="form-control date-picker no-cus no-veh cus-dat veh-dat date from_date"
                                          		 required="required" placeholder="dd/mm/yyyy" id="id-date-picker-1" value="${param.from_date}"
                                          		 data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;"/>
                                           <div class="input-group-append picker">
                                              <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                           </div>
                                      </div>
                                  </div>
                                </div>
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat veh-dat date">
                                  <div class="form-group">
                                      <label>To Date<span class="text-danger">*</span></label>
                                      <div class="input-group">
                                          <input type="text" name="from_date"  class="form-control date-picker no-cus no-veh cus-dat veh-dat date to_date" 
                                          		 required="required" placeholder="dd/mm/yyyy" value="${param.to_date}"
                                          		 id="id-date-picker-1" data-date-format="dd/mm/yyyy"
                                          		 readonly="readonly" style="background-color: white;"/>
                                           <div class="input-group-append picker">
                                              <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                           </div>
                                      </div>
                                  </div>
                                </div>
                               <div class="col-sm-12">
                                   <div class="form-group">
                                       <label>Marketing Person<span class="text-danger">*</span></label>
                                       <sql:query var="mp" dataSource="jdbc/rmc">
                                       	select mp_id,mp_name
                                        from marketing_person
                                        where mp_status='active'
                                       </sql:query>
                                       <select class="select2" name="mp_id" id="mp_id" >
                                           <option value="">Please Select</option>
                                           <c:forEach items="${mp.rows}" var="mp">
                                           <option value="${mp.mp_id}" 
                                           			${(param.mp_id==mp.mp_id)?'selected':''}>${mp.mp_name}</option>
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
               				<sql:query var="market" dataSource="jdbc/rmc">
               					select * from marketing_person where mp_id like if(''=?,'%%',?)
               					<sql:param value="${param.mp_id}"/>
               					<sql:param value="${param.mp_id}"/>
               				</sql:query>
               			<table class="table table-bordered" id="example-2">
               				<tr style="background-color: #741d7a;color: white;" class="text-center">
               					<td></td>
               					<td colspan="4" class="text-center">
               						<h4>Marketing Person Report</h4>
               						 From Date : ${param.from_date}
               						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To Date : ${param.to_date}
               					</td>
               					<td></td>
               				</tr>
               				<tr style="background-color: #4b9663;color: white;">
               					<th>Plant</th>
               					<th>Client Name</th>
               					<th>Quantity</th>
               					<th>Total Amount</th>
               					<th>Paid Amount</th>
               					<th>Balance Amount</th>
               				</tr>
               				
               				<c:forEach items="${market.rows}" var="market">
								<tr>
									<th colspan="6">${market.mp_name}</th>
								</tr>
								<c:set value="0" var="total_quantity"/>
	               				<c:set value="0" var="total_paid"/>
	               				<c:set value="0" var="total_amount"/>
								<sql:query var="report" dataSource="jdbc/rmc">
									select p.*, (select sum(payment_amount) from customer_payment where customer_id=p.customer_id  and payment_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')) as totalpayment
								   	from  (select p.plant_name,sum(i.quantity) as tquantity,sum(net_amount) as totalamount,c.customer_name,c.customer_id
									from invoice i LEFT JOIN(customer c,purchase_order po,purchase_order_item poi,plant p)
									ON i.customer_id=c.customer_id 
									and i.poi_id=poi.poi_id
									and poi.order_id=po.order_id 
									and i.plant_id=p.plant_id 
									where po.marketing_person_id=?
									and i.invoice_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
									and c.business_id like if(?=0,'%%',?)
									group by p.plant_name,c.customer_name,c.customer_id) as p
									<sql:param value="${param.from_date}"/>
									<sql:param value="${param.to_date}"/>
									<sql:param value="${market.mp_id}"/>
									<sql:param value="${param.from_date}"/>
									<sql:param value="${param.to_date}"/>
									<sql:param value="${bean.business_id}"/>
									<sql:param value="${bean.business_id}"/>
								</sql:query>
               					<c:forEach var="report" items="${report.rows}">
               						<tr>
               							<td>${report.plant_name}</td>
               							<td>${report.customer_name}</td>
               							<td>${report.tquantity}</td>
               							<td>${report.totalamount}</td>
               							<td>${report.totalpayment}</td>
               							<td>${report.totalamount-report.totalpayment}</td>
               						</tr>
               						<c:set value="${total_quantity+report.tquantity}" var="total_quantity"/>
		               				<c:set value="${total_amount+report.totalamount}" var="total_amount"/>
		               				<c:set value="${total_paid+report.totalpayment}" var="total_paid"/>
               					</c:forEach>
               					<tr>
               						<td colspan="2"><b>Total : </b></td>
               						<td><b>${total_quantity}</b></td>
               						<td><b>${total_amount}</b></td>
               						<td><b>${total_paid}</b></td>
               						<td><b>${total_amount-total_paid}</b></td>
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
        	var mp_id=$('#mp_id').val();
        	window.location="marketing_person_report.jsp?action=generateReport&from_date="+from_date+"&to_date="+to_date+"&mp_id="+mp_id;
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