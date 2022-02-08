var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http) {
	$(document).ready(function(){
		$('.select2').css('width','100%').select2({allowClear:true})
			.on('change', function(){
		});
		
		var session_data=getSessionData();
		//get all designation list
		var table =   $('#designation_list').DataTable({
			"order": [],
	        "info":true,
	        "scrollX":true,
	        "processing":true,
	        "serverSide" : true,
	        "iDisplayLength":5,
	        "lengthMenu":[10,20,25,50,75,100],
	        "ordering":false,
	        "searching":true,
	        "responsive": true,
	        "ajax":{
	        	url:"HRMSettingController?action=GetDesignationList",
	        	type:"POST",
	        	 data 	: function ( d ) {
		                  return $.extend( {}, d, {
		                  });
		              },
	        	error:function(){
	        	}
	        },
	        "columnDefs":[
	        	{"targets":[0],"data":"designation_id"},
	        	{"targets":[1],"data":"designation_name"},
	        	{"targets":[2],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		html='';
	        			html+='<a id="'+data.designation_id+'" name="'+data.designation_name+'" class="edit-designation-option"><span class="text-success"><i class="fa fa-edit"></i></span></a>&nbsp;&nbsp;&nbsp;&nbsp;'
	        			html+='<a  class="delete-designation-option" id="'+data.designation_id+'" name="'+data.designation_name+'"><span class="text-danger"><i class="fa fa-trash"></i></span></a>'
	                 return html;
	        	}}  	
	        ]
	    });
		
		
		$('#save-designation').on('click',function(){
			var designation_id=$('#designation_id').val();
			//console.log(designation_id);
			if(designation_id==null || designation_id=="0" || designation_id==""){
				var designation_name=$('#designation_name').val();
				if(designation_name=='' || designation_name==null){
					$('label[for="designation_name-error"]').text('Please enter designation name');
				}else{
					$('label[for="designation_name-error"]').text('');
					$('#designation_name').val("");
					$.ajax({
						type:'post',
						url:'HRMSettingController?action=InsertDesignation&designation_name='+designation_name,
						headers:{
							Accept:"text/html;charset=utf-8",
							"Content-Type":"text/html;charset=utf-8"
						},
						success:function(res){
							if(res>0){
								$.toast({
								    text: 'Designation added successfully',
								    showHideTransition: 'fade',
								    icon: 'success',
								    position: 'top-right'
								});
								table.draw();
							}
						}
					});
				}
			}else{
				var designation_name=$('#designation_name').val();
				if(designation_name=='' || designation_name==null){
					$('label[for="designation_name-error"]').text('Please enter designation name');
				}else{
					$('label[for="designation_name-error"]').text('');
					$('#designation_name').val("");
					$('#designation_id').val("");
					$.ajax({
						type:'post',
						url:'HRMSettingController?action=UpdateDesignation&designation_name='+designation_name+'&designation_id='+designation_id,
						headers:{
							Accept:"text/html;charset=utf-8",
							"Content-Type":"text/html;charset=utf-8"
						},
						success:function(res){
							if(res>0){
								$.toast({
								    text: 'Designation updated successfully',
								    showHideTransition: 'fade',
								    icon: 'success',
								    position: 'top-right'
								});
								table.draw();
							}
							
							$('#save-designation').
							text('Save Designation').
								removeClass('btn-info').
									addClass('btn-success');
						}
					});
				}
			}
			
		});
		
		
		$(document).on('click','#designation_list .delete-designation-option',function(){
		//	console.log('hello world');
	    	$('#designation_name-delete').text($(this).attr('name'));
	    	$('#designation_id-delete').val($(this).attr('id'));
	    	Custombox.open({
	    		target:'#delete-model',
	    		effect:'blur'
	    	});
	    });
		
		$('#designtation-delete-btn').on('click',function(){
			var designation_id=$('#designation_id-delete').val();
			var designation_name=$('#designation_name-delete').text();
			$.ajax({
				type:'post',
				url:'HRMSettingController?action=DeleteDesignation&designation_id='+designation_id,
				headers:{
					Accept:"text/html;charset=utf-8",
					"Content-Type":"text/html;charset=utf-8"
				},
				success:function(res){
					if(res>0){
						$.toast({
						    heading: 'Designation : '+designation_name+' <br>Deleted successfully',
						    showHideTransition: 'fade',
						    icon: 'success',
						    position: 'top-right'
						});
						table.draw();
					}else{
						$.toast({
						    heading: 'Designation already use<br> Deletion Failed!!!',
						    showHideTransition: 'fade',
						    icon: 'error',
						    position: 'top-right'
						});
					}
					
					Custombox.close();
				}
			});
		});
		
		$(document).on('click','#designation_list .edit-designation-option',function(){
			$('#designation_id').val($(this).attr('id'));
			$('#designation_name').val($(this).attr('name'));
			$('#save-designation').
				text('Edit Designation').
					removeClass('btn-success').
						addClass('btn-info');
			
		});
		
		$('#clear-designation').on('click',function(){
			$('#designation_id').val('');
			$('#designation_name').val('');
			$('#save-designation').
				text('Save Designation').
					removeClass('btn-info').
						addClass('btn-success');
		});
		
		
		
		
		
		
		
		
		/////////////////////////////////////DEPARTMENT THINGS GOES HERE//////////////////////////////
		
		//get all designation list
		var table1 =   $('#deparments').DataTable({
			"order": [],
	        "info":true,
	        "scrollX":true,
	        "processing":true,
	        "serverSide" : true,
	        "iDisplayLength":5,
	        "lengthMenu":[10,20,25,50,75,100],
	        "ordering":false,
	        "searching":true,
	        "responsive": true,
	        "ajax":{
	        	url:"HRMSettingController?action=GetAllDepartmentList",
	        	type:"POST",
	        	 data 	: function ( d ) {
		                  return $.extend( {}, d, {
		                  });
		              },
	        	error:function(){
	        	}
	        },
	        "columnDefs":[
	        	{"targets":[0],"data":"department_id"},
	        	{"targets":[1],"data":"department_name"},
	        	{"targets":[2],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		html='';
	        			html+='<a id="'+data.department_id+'" name="'+data.department_name+'" class="edit-department-option"><span class="text-success"><i class="fa fa-edit"></i></span></a>&nbsp;&nbsp;&nbsp;&nbsp;'
	        			html+='<a  class="delete-department-option" id="'+data.department_id+'" name="'+data.department_name+'"><span class="text-danger"><i class="fa fa-trash"></i></span></a>'
	                 return html;
	        	}}  	
	        ]
	    });
		
		
		
		
		$('#save-department').on('click',function(){
			var department_id=$('#department_id').val();
			if(department_id==null || department_id=="0" || department_id==""){
				var department_name=$('#department_name').val();
				if(department_name=='' || department_name==null){
					$('label[for="department_name-error"]').text('Please enter Department name');
				}else{
					$('label[for="department_name-error"]').text('');
					$('#department_name').val("");
					$.ajax({
						type:'post',
						url:'HRMSettingController?action=InsertDepartment&department_name='+department_name,
						headers:{
							Accept:"text/html;charset=utf-8",
							"Content-Type":"text/html;charset=utf-8"
						},
						success:function(res){
							if(res>0){
								$.toast({
								    text: 'Department added successfully',
								    showHideTransition: 'fade',
								    icon: 'success',
								    position: 'top-right'
								});
								table1.draw();
							}
						}
					});
				}
			}else{
				//console.log("coming here");
				var department_name=$('#department_name').val();
				if(department_name=='' || department_name==null){
					$('label[for="department_name-error"]').text('Please enter department name');
				}else{
					$('label[for="designation_name-error"]').text('');
					$('#department_name').val("");
					$('#department_id').val("");
					$.ajax({
						type:'post',
						url:'HRMSettingController?action=UpdateDepartment&department_name='+department_name+'&department_id='+department_id,
						headers:{
							Accept:"text/html;charset=utf-8",
							"Content-Type":"text/html;charset=utf-8"
						},
						success:function(res){
							if(res>0){
								$.toast({
								    text: 'Department updated successfully',
								    showHideTransition: 'fade',
								    icon: 'success',
								    position: 'top-right'
								});
								table1.draw();
							}
							
							$('#save-department').
							text('Save Department').
								removeClass('btn-info').
									addClass('btn-success');
						}
					});
				}
			}
			
		});
		
		
		
		
		
		
		//recalculate datatable tab pane design
		
		$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
	        $($.fn.dataTable.tables(true)).DataTable()
	           .columns.adjust();
	    }); 
		
		
		
		//editing of department details
		
		$(document).on('click','#deparments .edit-department-option',function(){
			console.log($(this).attr('id'));
			$('#department_id').val($(this).attr('id'));
			$('#department_name').val($(this).attr('name'));
			$('#save-department').
				text('Edit Designation').
					removeClass('btn-success').
						addClass('btn-info');
			
		});
		
		
		
		//delete department
		
		$(document).on('click','#deparments .delete-department-option',function(){
			//	console.log('hello world');
		    	$('#department_name-delete').text($(this).attr('name'));
		    	$('#department_id-delete').val($(this).attr('id'));
		    	Custombox.open({
		    		target:'#department-delete-modal',
		    		effect:'blur'
		    	});
		    });
		
		
		//department delete function
		$('#department-delete-btn').on('click',function(){
			var department_id=$('#department_id-delete').val();
			var department_name=$('#department_name-delete').text();
			$.ajax({
				type:'post',
				url:'HRMSettingController?action=DeleteDepartment&department_id='+department_id,
				headers:{
					Accept:"text/html;charset=utf-8",
					"Content-Type":"text/html;charset=utf-8"
				},
				success:function(res){
					if(res>0){
						$.toast({
						    heading: 'Department : '+department_name+' <br>Deleted successfully',
						    showHideTransition: 'fade',
						    icon: 'success',
						    position: 'top-right'
						});
						table1.draw();
					}else{
						$.toast({
						    heading: 'department already use<br> Deletion Failed!!!',
						    showHideTransition: 'fade',
						    icon: 'error',
						    position: 'top-right'
						});
					}
					Custombox.close();
				}
			});
		});
		
		
		
		
		
	//document ends here
	});
	//angular ends here
});