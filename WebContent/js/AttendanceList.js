angular.module("myApp",[])
	   .controller("myController",function($scope,$http,$log,$filter){
		   $(document).ready(function(){
			   $scope.employee_id=0;
			   $http({
				   method:"POST",
				   url:"EmployeeController?action=GetEmployees&employee_id="+$scope.employee_id
			   }).then(function(response){
				   $scope.employees=response.data;
				   console.log(response);
			   });
			   
			   
			   $('.select2').css('width','100%').select2({allowClear:true})
				.on('change', function(){
				}); 
			   
			   $('.date-picker').datepicker({
					autoclose: true,
					todayHighlight: true
			   });
				//show datepicker when clicking on the icon
				
	         
	          $("#id-date-picker-1").datepicker();
				$('#id-date-picker-1').datepicker({
				        "autoclose": true
			  });
			   
			   
			   
			   var table = $('#example').DataTable({
					"order": [],
		            "info":true,
		            "scrollX":true,
		            "processing":true,
		            "serverSide" : true,
		            "iDisplayLength":10,
		            "lengthMenu":[10,20,25,50,75,100],
		            "ordering":false,
		            "searching":false,
		            "ajax":{
		            	url:"AttendanceController?action=getAttendanceList",
		            	type:"POST",
		            	data : function ( d ) {
				                return $.extend( {}, d, {
				                	"date":$('input[name="attendance_date"]').val(),
									 "e_id":$('#e_id').val()
				                  });
				              },
		            	error:function(){
		            	}
		            },
		            "columnDefs":[
		            	{"targets":[0],"data":"employee_name"},
		            	{"targets":[1],"data":"attendance_date"},
		            	{"targets":[2],"data":"start_time"},
		            	{"targets":[3],"data":"end_time"},
		            	{"targets":[4],"data":"total_time"},
		            	{"targets":[5],"data":function(data){
		            		return data;
		            	},
		            	"render":function(data,row){
		            		html='<div class="btn-group dropdown">'+
		                            '<a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>'+
		                            '<div class="dropdown-menu dropdown-menu-right">'+
		                                	'<p class="text-center"><span class="text-center text-success">'+data.attendance_date+'</span></p>'+
		                                	'<a class="dropdown-item" href="Locate.jsp?attendance_date='+data.attendance_date+'&e_id='+data.e_id+'&type=in"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Locate in Map</a>'+
		                            '</div>'+
		                        '</div>'
		                     return html;
		            	}}
		            ]
		        });
			   
			   
			   $('#search').on( 'click', function () {
			   		 table.draw();
			   } );
			        
		        $('#reset').on('click',function(){
		        	$('#branch_name').val('');
		        	$('#client_id').prop('selectedIndex',0);
		        	$('#select2-client_id-container').text("Select Client");
		        	table.draw();
		        });
			   
		   });
		   
		   
		   //get google map location to get the detail's
		   
		  // $scope.attendance_id;
		  // alert(attendance_id);
		   $scope.getData=function(attendance_id){
			   alert(attendance_id);
			   $http({
				   method:'POST',
				   url:'AttendanceController?action=getAttendanceById&attendance_id='+attendance_id
					  
			   }).then(function(response){
				   console.log("coming the response");
				   $scope.attendance=attendance;
			   });
		   }
		   //this is the function
		   
		   $scope.att_id=3;
		   console.log($scope.att_id);
	   });