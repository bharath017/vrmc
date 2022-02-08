<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>New Job Card</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">
		
		<link rel="shortcut icon" href="assets/images/favicon.ico">
		<link rel="stylesheet" href="picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="picker/cs/bootstrap-timepicker.min.css" />
       
        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="assets/css/select2.min.css" />
        <link rel="stylesheet" href="assets/css/render.css">

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
                                    <li class="breadcrumb-item"><a href="#">Job Card</a></li>
                                   
                                </ol>
                            </div>
                            <h4 class="page-title">Add Job Card</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="JobCardList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Job Card List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="jobcard" dataSource="jdbc/rmc">
                			select * from job_card where id=?
                			<sql:param value="${param.id}"/>
                		</sql:query> 
                		<c:forEach items="${jobcard.rows}" var="jobcard">
                			<c:set value="${jobcard}" var="rs"/>
                		</c:forEach>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="JobCardController?action=UpdateJobCard" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Vehicle Details: </label>
			                                    <input type="hidden" name="id" value="${rs.id}" id="customer_id">
			                                    <input type="text" class="form-control" 
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Vehicle Details:" value="${rs.vehicle_details}"  name="vehicle_details"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>REG NO  </label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$" maxlength="10" placeholder="Enter REG NO"  value="${rs.reg_no}"  name="reg_no"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>KMS:</label>
			                                    <div>
			                                        <input type="text" class="form-control" 
			                                             pattern="[^'&quot;:]*$"  value="${rs.kilo_meters}" placeholder="Enter KMS:" name="kilo_meters"/>
			                                    </div>
			                                </div>
			                               <div class="form-group">
			                                    <label>Hours:</label>
			                                    <div>
			                                        <input type="text" class="form-control" 
			                                             pattern="[^'&quot;:]*$"  value="${rs.hours}" placeholder="Enter Hours" name="hours"/>
			                                    </div>
			                                </div>
			                                <div class="form-group">
			                                    <label>Driver Name: </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Driver Name."  value="${rs.driver_name}"  name="driver_name"/>
			                                    </div>
			                                </div>
			                                
			                            </div>
			                            <div class="col-sm-6">
			                               	
			                                
			                                <div class="form-group">
			                                    <label>Arrival Time </label>
			                                   
			                                    <div class="input-group">
		                                            <input type="text" name="arrival_time" class="form-control" value="${rs.arrival_time}" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
		                                            <div class="input-group-append">
		                                             <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
	                                           	 </div>
                                      		  </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Job Started :</span> </label>
			                                    <div class="input-group">
			                                       <input type="text" class="form-control" placeholder="Enter Job Started"  value="${rs.jobstarted_time}"  name="jobstarted_time"  id="timepicker1" data-date-format="yyyy-mm-dd"/>
			                                    <div class="input-group-append">
		                                             <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
	                                           	 </div>
			                                    </div>
			                                </div>
			                                <div class="form-group">
			                                    <label>Job Completed:</label>
			                                    <div  class="input-group">
			                                       <input type="text" class="form-control" placeholder="Enter Job Completed"  value="${rs.jobcompleted_time}"  name="jobcompleted_time"  id="timepicker1" data-date-format="yyyy-mm-dd"/>
			                                    <div class="input-group-append">
		                                             <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
	                                           	 </div>
	                                           	 </div>
			                                </div>
			                                <div class="form-group">
			                                    <label>Attended By  </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Attended By"  value="${rs.attended_by}"  name="attended_by"/>
			                                    </div>
			                                </div>
			                                </div>
			                                <div class="col-sm-12" id="clicked1">
			                             	<table class="table table-bordered" id="Table2">
			                             		<thead>			                             			
			                             				<label>Problem</label>		                             			
			                             		</thead>
			                             		<tbody>
			                             			<tr>
			                             				<td>
			                             					 <div>
						                                       <input type="checkbox" name="frontengine" ${(!empty rs.frontengine)?'checked':''} value="FRONT Engine Oil" id="frontengine">  FRONT Engine Oil 
						                                     
						                                        </div>
			                             				</td>                          				
			                             				<td>
			                             					 <div>
						                                       <input type="checkbox" name="backengine" ${(!empty rs.backengine)?'checked':''} value="Back Engine Oil" id="backengine"> Back Engine Oil
						                                        </div>
			                             				</td>			                             				
			                             			</tr>
			                             			<tr>
			                             				<td>
			                             					 <div>
						                                       <input type="checkbox" name="drumgearbox" ${(!empty rs.drumgearbox)?'checked':''} value="Drum Gear Box Oil" id="drumgearbox">  Drum Gear Box Oil
						                                        </div>
			                             				</td>                          				
			                             				<td>
			                             					 <div>
						                                       <input type="checkbox" name="frontgear" ${(!empty rs.frontgear)?'checked':''} value="Front Gear Box Oil" id="frontgear"> Front Gear Box Oil
						                                        </div>
			                             				</td>			                             				
			                             			</tr>
			                             			<tr>
			                             				<td>
			                             					 <div>
						                                       <input type="checkbox" name="hydraulic" ${(!empty rs.hydraulic)?'checked':''} value="HYDRAULIC OIL" id="hydraulic">HYDRAULIC OIL
						                                        </div>
			                             				</td>	  
			                             				<td>
			                             					 <div>
						                                       <input type="checkbox" name="coollent" ${(!empty rs.coollent)?'checked':''} value="COOLLENT OIL" id="coollent">  COOLLENT OIL
						                                        </div>
			                             				</td>                          				
			                             					                             				
			                             			</tr>
			                             			<tr>
			                             			<td>
			                             					 <div>
						                                       <input type="checkbox" name="clutchoil" ${(!empty rs.clutchoil)?'checked':''} value="CLUTCH OIL BREAK OIL" id="clutchoil"> CLUTCH OIL BREAK OIL
						                                        </div>
			                             				</td>		
			                             				<td>
			                             					 <div>
						                                       <input type="checkbox" name="steering" ${(!empty rs.steering)?'checked':''} value="STEERING OIL" id="steering">  STEERING OIL
						                                        </div>
			                             				</td>                          				
			                             					                             				
			                             			</tr>
			                             			<tr>
			                             			<td>
			                             					 <div>
						                                       <input type="checkbox" name="housing" ${(!empty rs.housing)?'checked':''} value="HOUSING OIL" id="housing"> HOUSING OIL
						                                        </div>
			                             				</td>		
			                             				<td>
			                             					 <div>
						                                       <input type="checkbox" name="breakoil" ${(!empty rs.breakoil)?'checked':''} value="BREAK OIL" id="breakoil">  BREAK OIL
						                                        </div>
			                             				</td>                          				
			                             					                             				
			                             			</tr>
			                             		</tbody>
			                             	</table>
			                             </div>
			                             
		                                 <div class="col-sm-12 text-center">
		                                	<div class="form-group">
			                                    <div>
			                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
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
                	</c:when>
                	<c:otherwise>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="JobCardController?action=InsertJobCard" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Vehicle Details:<span class="text-danger">*</span></label>
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Vehicle Details"  name="vehicle_details"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>REG NO<span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Registration Number"  maxlength="10"   name="reg_no"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>KMS: </label>
			                                    <div>
			                                        <input type="text" class="form-control" 
			                                             pattern="[^'&quot;:]*$"   placeholder="Enter KMS" name="kilo_meters"/>
			                                    </div>
			                                </div>
			                                <div class="form-group">
			                                	 <label>Hours: </label>
			                              	 <div>
			                                        <input type="text" class="form-control" 
			                                             pattern="[^'&quot;:]*$"  placeholder="Enter Hours" name="hours"/>
			                                    </div>
			                                </div>
			                                <div class="form-group">
			                                 <label>Driver Name: </label>
			                              	 <div>
			                                        <input type="text" class="form-control" 
			                                             pattern="[^'&quot;:]*$"   placeholder="Enter Driver Name" name="Driver_name"/>
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Arrival Of the Vehicle </label>
			                                    <div>
		                                      	  <div class="input-group">
		                                            <input type="text" name="arrival_time" class="form-control" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
		                                            <div class="input-group-append">
		                                             <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
	                                           	 </div>
                                      		  </div>
                                   			 </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Job Started : </label>
			                                   <div>
		                                      	  <div class="input-group">
		                                            <input type="text" name="jobstarted_time" class="form-control" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
		                                            <div class="input-group-append">
		                                             <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
	                                           	 </div>
                                      		  </div>
                                   			 </div>
			                                </div>
			                               <div class="form-group">
			                                    <label>Job Completed : </label>
			                                   <div>
		                                      	  <div class="input-group">
		                                            <input type="text" name="jobcompleted_time" class="form-control" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
		                                            <div class="input-group-append">
		                                             <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
	                                           	 </div>
                                      		  </div>
                                   			 </div>
			                                </div>
			                                <div class="form-group">
			                                    <label>Attended By </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Entended By"   name="attended_by"/>
			                                    </div>
			                                </div>			                                
			                             </div>
			                            
			                             <div class="col-sm-12" id="clicked1">
			                             	<table class="table table-bordered" id="Table2">
			                             		<thead>			                             			
			                             				<label>Problem</label>		                             			
			                             		</thead>
			                             		<tbody>
			                             			<tr>
			                             				<td>
			                             					 <div>
						                                       <input type="checkbox" name="frontengine" value="FRONT Engine Oil " id="frontengine">  FRONT Engine Oil 
						                                        </div>
			                             				</td>                          				
			                             				<td>
			                             					 <div>
						                                       <input type="checkbox" name="backengine" value="Back Engine Oil" id="backengine"> Back Engine Oil
						                                        </div>
			                             				</td>			                             				
			                             			</tr>
			                             			<tr>
			                             				<td>
			                             					 <div>
						                                       <input type="checkbox" name="drumgearbox" value="Drum Gear Box Oil" id="drumgearbox">  Drum Gear Box Oil
						                                        </div>
			                             				</td>                          				
			                             				<td>
			                             					 <div>
						                                       <input type="checkbox" name="frontgear" value="Front Gear Box Oil" id="frontgear"> Front Gear Box Oil
						                                        </div>
			                             				</td>			                             				
			                             			</tr>
			                             			<tr>
			                             				<td>
			                             					 <div>
						                                       <input type="checkbox" name="hydraulic" value="HYDRAULIC OIL" id="hydraulic">HYDRAULIC OIL
						                                        </div>
			                             				</td>	     
			                             				<td>
			                             					 <div>
						                                       <input type="checkbox" name="coollent" value="COOLLENT OIL" id="coollent">  COOLLENT OIL
						                                        </div>
			                             				</td>                          				
			                             							                             				
			                             			</tr>
			                             			<tr>
			                             			<td>
			                             					 <div>
						                                       <input type="checkbox" name="clutchoil" value="CLUTCH OIL BREAK OIL" id="clutchoil"> CLUTCH OIL BREAK OIL
						                                        </div>
			                             				</td>
			                             				<td>
			                             					 <div>
						                                       <input type="checkbox" name="steering" value="STEERING OIL" id="steering">  STEERING OIL
						                                        </div>
			                             				</td>                          				
			                             					                             				
			                             			</tr>
			                             			<tr>
			                             			<td>
			                             					 <div>
						                                       <input type="checkbox" name="housing" value="HOUSING OIL" id="housing"> HOUSING OIL
						                                        </div>
			                             				</td>		
			                             				<td>
			                             					 <div>
						                                       <input type="checkbox" name="breakoil" value="BREAK OIL" id="breakoil">  BREAK OIL
						                                        </div>
			                             				</td>                          				
			                             					                        				
			                             			</tr>
			                             		</tbody>
			                             	</table>
			                             </div>
			                        
		                                <div class="col-sm-12 text-center">
		                                	<div class="form-group">
			                                    <div>
			                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
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
        <!-- end wrapper -->


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
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
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
					$('#timepicker2').timepicker('showWidget');
				}).next().on(ace.click_event, function(){
					$(this).prev().focus();
				});
			});
		</script>
		
        <script type="text/javascript">
            $(document).ready(function() {
                $('form').parsley();
                
                $('.select2').css('width','100%').select2({allowClear:true})
				.on('change', function(){
					$(this).closest('form').validate().element($(this));
				}); 
            });
        </script>
        <script type="text/javascript">
		 $(document).ready(function () {
		    function addRow(){
		        var html = '<tr>'+
								'<td>'+
									'<input type="text" class="form-control" required="required" pattern="[^\'&quot;:]*$"  placeholder="Enter Site Name"   name="site_name"/>'+
								'</td>'+
								'<td>'+
									'<input type="text" class="form-control" required="required"  pattern="[^\'&quot;:]*$"  placeholder="Enter Site Address"   name="site_address"/>'+
								'</td>'+
								'<td>'+
									'<span class="text-danger removebtn"><i class="fa fa-trash"></i></span>'+
								'</td>'+
							'</tr>'
		        $(html).appendTo($("#Table1"))
		    };
		    $("#clicked").on("click", ".BtnPlus", addRow);
		});
		 $('#Table1').on('click', '.removebtn', function(){
			    $(this).closest ('tr').remove ();
		});
		</script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				$('#clicked1').on('click','.BtnBillingPlus',function(){
					var html='<tr>'+
								'<td>'+
                          			 '<div>'+
                                    	 '<input type="text" class="form-control"  pattern="[^\'&quot;:]*$"  placeholder="Enter Billing Address" required="required"   name="customer_address"/>'+
                                     '</div>'+
                          		 '</td>'+
                          		 '<td>'+
                          			'<span class="text-danger removebtn"><i class="fa fa-trash"></i></span>'+
                          		 '</td>'+
                          	 '</tr>';
                     $(html).appendTo("#Table2");
				});
				
				
				$('#Table2').on("click",'.removebtn',function(){
					$(this).closest('tr').remove();
				});
			});	
		</script>
		

    </body>
</html>