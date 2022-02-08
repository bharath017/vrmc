<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Fleet Item</title>
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
                                    <li class="breadcrumb-item"><a href="#">Fleet</a></li>
                                    <li class="breadcrumb-item"><a href="#">Fleet Item</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Fleet</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Add Fleet Items</h4>
                        </div>
                    </div>
                </div>
                  <c:choose>
                            	<c:when test="${param.action=='update'}">
                            		<h4 class="page-title">Update Inventory </h4>
                            	</c:when>
                            	<c:otherwise>
                            		<h4 class="page-title text-center">Add Fleet Item </h4>
                            	</c:otherwise>
                            </c:choose>
                
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="FleetItemList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-grid"></i> Fleet Item List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
               
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="inv" dataSource="jdbc/rmc">
                			select * from fleet_item where fleet_item_id=?
                			<sql:param value="${param.fleet_item_id}"/>
                		</sql:query> 
                		<c:set var="res"/>
                		<c:forEach items="${inv.rows}" var="fleet">
                		
              	<div class="row">
                    <div class="col-sm-12">
                    	<form class="" id="myform" action="FleetController?action=UpdateFleetItem" method="post">
	                        <div class="card-box row col-sm-12">
	                        
	                        	<div class="col-sm-3"></div>
	                           	<div class="col-sm-6">
	                           		<div class="form-group">
	                                    <label>Plant <span class="text-danger">*</span></label>
	                                    <sql:query var="plant" dataSource="jdbc/rmc">
	                                    	select * from plant
	                                    </sql:query>
	                                    <input type="hidden" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  value="${fleet.fleet_item_id}" required="required"  id="fleet_item_id" name="fleet_item_id"/>
										<select id="plant_id"  name="plant_id" required="required"   class="select2"  data-placeholder="Choose Plant">
											<c:forEach var="plant" items="${plant.rows}">
											<option value="${plant.plant_id}" ${(plant.plant_id==fleet.plant_id)?'selected':''}>${plant.plant_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                                
	                      	        <div class="form-group">
	                                    <label>Item Name<span class="text-danger">*</span></label>
										   <input class="form-control" value="${fleet.item_name}" type="text" name="item_name" id="item_name">
	                                </div>
	                                
	                                 <div class="form-group">
	                                    <label>Item Cost <span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  value="${fleet.item_cost}"  required="required"  id="item_cost" name="item_cost"/>
	                                    </div>
	                                </div>

                                    <div class="form-group">
	                                    <label>Current Stock Quantity <span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  value="${fleet.item_stock_quantity}"  required="required"  id="item_stock_quantity" name="item_stock_quantity"/>
	                                    </div>
	                                </div>
	                               
	                            </div>
	                             
                                <div class="col-sm-12 text-center">
                                	<div class="form-group">
	                                    <div>
	                                        <button type="submit" id="savebtn" class="btn btn-custom waves-effect waves-light">
	                                            Update
	                                        </button>
	                                        <button type="reset" class="btn btn-light waves-effect m-l-5">
	                                            Cancel
	                                        </button>
	                                    </div>
	                                </div>
                                </div>
                        	</div>
                        </form>
                    </div>
                </div>
                </c:forEach>
         	</c:when>
         
      <c:otherwise>
               
              	<div class="row">
                    <div class="col-sm-12">
                    	<form class="" id="myform" action="FleetController?action=InsertFleetItem" method="post">
	                        <div class="card-box row col-sm-12">
	                        	<div class="col-sm-3"></div>
	                           	<div class="col-sm-6">
	                           		<div class="form-group">
	                                    <label>Plant <span class="text-danger">*</span></label>
	                                    <sql:query var="plant" dataSource="jdbc/rmc">
	                                    	select * from plant
	                                    </sql:query>
										<select id="plant_id"  name="plant_id" required="required"   class="select2"  data-placeholder="Choose Plant">
											<c:forEach var="plant" items="${plant.rows}">
											<option value="${plant.plant_id}">${plant.plant_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                                
	                           	   <div class="form-group">
	                                    <label>Item Name<span class="text-danger">*</span></label>
										   <input class="form-control" type="text" name="item_name">
	                                </div>
	                                
	                                 <div class="form-group">
	                                    <label>Item Cost <span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  required="required"  id="item_cost" name="item_cost"/>
	                                    </div>
	                                </div>

                                    <div class="form-group">
	                                    <label>Current Stock Quantity <span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  required="required"  id="item_stock_quantity" name="item_stock_quantity"/>
	                                    </div>
	                                </div>
	                               
	                            </div>
	                             
                                <div class="col-sm-12 text-center">
                                	<div class="form-group">
	                                    <div>
	                                        <button type="submit" id="savebtn" class="btn btn-custom waves-effect waves-light">
	                                            Submit
	                                        </button>
	                                        <button type="reset" class="btn btn-light waves-effect m-l-5">
	                                            Cancel
	                                        </button>
	                                    </div>
	                                </div>
                                </div>
                        	</div>
                        </form>
                    </div>
                </div>
                </c:otherwise>
                </c:choose>
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

        <!-- Parsley js -->
        <script type="text/javascript" src="plugins/parsleyjs/parsley.min.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="js/AddPurchaseOrder.js"></script>
		<script src="assets/js/ace.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
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
		
		
		
<script>

function calculateNetWeight(){
	
 var loaded_weight = document.getElementById('loaded_weight').value;
 var empty_weight = document.getElementById('empty_weight').value;
    
    var net_weight = loaded_weight - empty_weight;
    net_weight = net_weight.toFixed(2);
    
    if(net_weight>0){
        document.getElementById('net_weight').value=net_weight;
    }else{
    	document.getElementById('net_weight').value='';
    }
}

</script>
		
		     
    <script type="text/javascript">
    $("#myform").bind('ajax:complete', function() {
		$('#savebtn').hide();
  	});
    </script>
    
    <script lang="javascript">
		var a = ['','one ','two ','three ','four ', 'five ','six ','seven ','eight ','nine ','ten ','eleven ','twelve ','thirteen ','fourteen ','fifteen ','sixteen ','seventeen ','eighteen ','nineteen '];
		var b = ['', '', 'twenty','thirty','forty','fifty', 'sixty','seventy','eighty','ninety'];

		function inWords(num) {
		    if ((num = num.toString()).length > 9) return 'overflow';
		    n = ('000000000' + num).substr(-9).match(/^(\d{2})(\d{2})(\d{2})(\d{1})(\d{2})$/);
		    if (!n) return; var str = '';
		    str += (n[1] != 0) ? (a[Number(n[1])] || b[n[1][0]] + ' ' + a[n[1][1]]) + 'crore ' : '';
		    str += (n[2] != 0) ? (a[Number(n[2])] || b[n[2][0]] + ' ' + a[n[2][1]]) + 'lakh ' : '';
		    str += (n[3] != 0) ? (a[Number(n[3])] || b[n[3][0]] + ' ' + a[n[3][1]]) + 'thousand ' : '';
		    str += (n[4] != 0) ? (a[Number(n[4])] || b[n[4][0]] + ' ' + a[n[4][1]]) + 'hundred ' : '';
		    str += (n[5] != 0) ? ((str != '') ? 'and ' : '') + (a[Number(n[5])] || b[n[5][0]] + ' ' + a[n[5][1]]) + 'only ' : '';
		    return str;
		}
  </script>
  <script type="text/javascript">
	 function setValue(){
		 var input = document.getElementById('quantity');
		  input.setAttribute('value', input.value);
	 }
  </script>
  
      </body>
</html>