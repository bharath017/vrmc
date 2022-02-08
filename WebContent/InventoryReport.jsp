<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
        <meta charset="utf-8" />
        <title> Inventory Report</title>
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
        	
        	.error{
        		color: red;
        	}
        	
        	.table>thead>tr>th,.table>tbody>tr>th,.table>tfoot>tr>th,.table>thead>tr>td,.table>tbody>tr>td,.table>tfoot>tr>td{
        		padding: 2px;
        		border: 1px solid black;
        	}
        	
        	@media print {
			    body {
			        zoom: .8
			    }
			}
			
			@media print {
			  .visible-print  { display: inherit !important; }
			  .hidden-print   { display: none !important; }
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
                                    <li class="breadcrumb-item"><a href="#">Inventory Report</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Inventory Report</h4>
                        </div>
                    </div>
                </div>
                 <!-- end row -->
                <div class="row card">
                    <div class="col-md-12">
                       <form action="#" id="myform"
                       		 method="post">
                       		 
                          <div class="row">
                          	<div class="form-group col-sm-2">
                          		<label for="report_type">Report Type <span class="text-danger">*</span></label>
                          		<select class="form-control" id="report_type">
                          			<option value="dw">Date Wise</option>
                          			<option value="sw">Supplier Wise</option>
                          			<option value="swd">Supplier With Date</option>
                          			<option value="dwgs">Date Wise(group by item)</option>
                          			<option value="dgs">Supplier(Group by supplier With Item)</option>
                          			<option value="swdgi">Supplier With Date(group by item)</option>
                          			<option value="stock">Stock Report</option>
                          		</select>
                          	</div>
                          	<div class="form-group col-sm-2 dw no-sw swd">
                                <label for="from_date">From Date <span class="text-danger"></span> </label>
                                <div>
                                    <div class="input-group">
                                        <input type="text" name="from_date" class="form-control date-picker from_date dw no-sw swd"
                                        		 required="required" placeholder="yyyy-mm-dd" id="from_date"
                                        		 data-date-format="yyyy-mm-dd" readonly="readonly" style="background-color: white;"/>
                                        <div class="input-group-append">
                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                        </div>
                                    </div>
                                    <label id="from_date-error" class="error" for="from_date"></label>
                                </div>
                           </div>
                           <div class="form-group col-sm-2 dw no-sw swd">
                                <label for="to_date">To Date <span class="text-danger"></span> </label>
                                <div>
                                    <div class="input-group">
                                        <input type="text" name="to_date" class="form-control date-picker to_date dw no-sw swd"
                                        		 required="required" placeholder="yyyy-mm-dd" id="to_date"
                                        		  data-date-format="yyyy-mm-dd" readonly="readonly"
                                        		   style="background-color: white;"/>
                                        <div class="input-group-append">
                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                        </div>
                                    </div>
                                    <label id="to_date-error" class="error" for="to_date"></label>
                                </div>
                           </div>
                            <div class="form-group col-sm-2 no-dw sw swd">
                          		<label for="report_type">Supplier<span class="text-danger">*</span></label>
                          		<sql:query var="supplier" dataSource="jdbc/rmc">
                          			select supplier_id,supplier_name
                                    from supplier
                                   where supplier_status='active'
                                   and business_id like if(?=0,'%%',?)
                                   <sql:param value="${bean.business_id}"/>
                                   <sql:param value="${bean.business_id}"/>
                          		</sql:query>
                          		<select class="select2 no-dw sw swd" id="supplier_id" name="supplier_id">
                          				<option value="0">All Supplier</option>
                          			<c:forEach items="${supplier.rows}" var="rs">
                          				<option value="${rs.supplier_id}">${rs.supplier_name}</option>
                          			</c:forEach>
                          		</select>
                          	</div>
                           <div class="form-group col-sm-2">
                          		<label for="report_type">Item<span class="text-danger">*</span></label>
                          		<sql:query var="item" dataSource="jdbc/rmc">
                          			select inv_item_id,inventory_name
                          			from inventory_item
                          		</sql:query>
                          		<select class="form-control" id="inv_item_id" name="inv_item_id">
                          				<option value="0">All Item</option>
                          			<c:forEach items="${item.rows}" var="rs">
                          				<option value="${rs.inv_item_id}">${rs.inventory_name}</option>
                          			</c:forEach>
                          		</select>
                          	</div>
                          	
                          	<div class="form-group col-sm-2">
                          		<label for="report_type">Plant<span class="text-danger">*</span></label>
                          		<sql:query var="plant" dataSource="jdbc/rmc">
	                          		select plant_id,plant_name
									from plant
									where plant_id like if(0=?,'%%',?)
									and business_id like if(0=?,'%%',?)
									<sql:param value="${bean.plant_id}"/>
									<sql:param value="${bean.plant_id}"/>
									<sql:param value="${bean.business_id}"/>
									<sql:param value="${bean.business_id}"/>
								</sql:query>
								<select class="form-control" id="plant_id" name="plant_id">
										
										<c:if test="${bean.business_id==0}">
										<option value="0">All plant</option>											
										</c:if>
                          			<c:forEach items="${plant.rows}" var="rs">
                          				<option value="${rs.plant_id}">${rs.plant_name}</option>
                          			</c:forEach>
                          		</select>
                          	</div>
                           
                           <div class="form-group col-sm-2">
                           		<br>
                           		<button type="button" class="btn btn-success"
                           			style="margin-top: 4%;" id="generate">Generate</button>
                           		<button type="reset" class="btn btn-danger"
                           			style="margin-top: 4%;"  id="clear-report">Clear</button>
                           </div>
                          </div>
                       </form>
                    </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row card">
                	<div class="text-left" style="display: none;" id="show-excel">
                		<div class="col-sm-12">
                			<button class="btn btn-custom btn-sm" onclick="generate_excel();">Excel</button>
			                <button class="btn btn-custom btn-sm" onclick="print();">Print</button>
                		</div>
                	</div>
                	<div class="col-sm-12 text-center result" id="report-place">
                		<img alt="loader" src="loader/loader.svg" id="loader" style="display: none;">
                		<table class="table table-bordered" id="result" style="display: none;"></table>
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
		
		<!-- Modal-Effect -->
        <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>
        <script type="text/javascript" src="validation/jquery.validate.min.js"></script>
        <script type="text/javascript" src="js/Inward/Inventory/inventory_report.js"></script>
        <script type="text/javascript">
	    function generate_excel() {
	      var table= document.getElementById("result");
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
	        var frame = document.getElementsByClassName('result').item(0);
	        var data = frame.innerHTML;
	        var win = window.open('', '', 'height=900,width=500');
	        win.document.write('<style>@page{size:portrait ;}@media print{*{font-size:12px;}  body {zoom: 1.0} table, td, th {border: 1px solid black;} table {width: 100%;border-collapse: collapse;}}</style><html><head><title></title>');
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