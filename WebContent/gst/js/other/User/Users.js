var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http) {
	$(document).ready(function(){
	var session=getSessionDetails();
		
	$('.select2').css('width','100%').select2({allowClear:true})
			.on('change', function(){
    }); 
	
	
	
	let getPlantList = function() {
		var business_id=$('#business_id').val();
		$.ajax({
			type:'post',
			url:'../PlantController?button=getPlantByBusinessId&business_id='+business_id,
			headers:{
				accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(res){
				$('#plant_id').empty();
				$.each(res,function(i,v){
					$('#plant_id').append('<option value="'+v.plant_id+'">'+v.plant_name+'</option>');
				});
				$('#plant_id').append('<option value="0">All Plant</option>');
			}
		});
	}
	
	getPlantList();
	
	
	$('#business_id').on('change',function(){
		getPlantList();
	});
	
		
	 
		
	
	
		//get all the item details
		
		var table =   $('#example').DataTable({
			"order": [],
	        "info":true,
	        "scrollX":true,
	        "processing":true,
	        "serverSide" : true,
	        "iDisplayLength":10,
	        "lengthMenu":[10,20,25,50,75,100],
	        "ordering":false,
	        "searching":true,
	        "ajax":{
	        	url:"../UserController?action=getAllUserList",
	        	type:"POST",
	        	 data 	: function ( d ) {
		                  return $.extend( {}, d, {
		                	  business_id:session.business_id,
		                	  type:$('#type').val()
		                  });
		              },
	        	error:function(){
	        	}
	        },
	        "columnDefs":[
	        	{"targets":[0],"data":"user_name"},
	        	{"targets":[1],"data":"user_phone"},
	        	{"targets":[2],"data":"user_login_id"},
	        	{"targets":[3],"data":"user_type"},
	        	{"targets":[4],"data":function(data){
	        		return data;
	        		},
	        	"render":function(data,row){
	        		if(data.group_name=='' || data.group_name==null)
	        			return 'ALL GROUP';
	        		else
	        			return data.group_name;
	        	}
	        	},
	        	{"targets":[5],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		html='<a id="'+data.user_id+'" style="cursor:pointer;"><span class="text-info"><i class="fa fa-eye"></i></span></a>&nbsp&nbsp'
	        		html+='<a id="'+data.user_id+'" style="cursor:pointer;" class="edit-user"><span class="text-success"><i class="fa fa-edit"></i></span></a>&nbsp&nbsp'
	        		html+='<a id="'+data.user_id+'" name="'+data.user_name+'" value="'+data.user_status+'" style="cursor:pointer;" class="cancel-user"><span class="text-danger"><i class="fa fa-window-close"></i></span></a>&nbsp&nbsp'
	                 return html;
	        	}}  	
	        ],
	        "createdRow": function( row, data, dataIndex){
                if(data.user_status ==  'inactive'){
                	console.log()
                    $(row).closest('tr').addClass('redClass');
                }else if(data.user_status=='active'){
                	 $(row).removeClass('redClass');
                }
            }
	    });
		
		
	
    
	    $('#search').on( 'click', function () {
			 table.draw();
	    } );
		
	
		/*var loadUnits=function(){
			$.ajax({
				type:'post',
				url:'SettingController?action=getUnitListForOption',
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					$('#unit').html("");
					$.each(res,function(i,v){
						$('#unit').append('<option value="'+v+'">'+v+'</option>');
					});
				}
			});
		};
		loadUnits();*/
	
	
		/*$.validator.addMethod('nospecial', function (value) { 
		    return /^[^']*$/.test(value); 
		}, 'Please remove ( \' ) here');*/
	
	
		var submit=false;
		
		//Insert fleet item details here
		$('#myform').validate({
			debug:true,
			rules:{
				user_name:"required",
				user_phone:"required",
				user_login_id:"required",
				user_password:"required",
				business_id:"required",
				plant_id:"required",
				user_address:"required",
				user_email:{
					email:true
				}
				
			},
			messages:{
				user_name:"Enter Name",
				user_phone:"Enter user phone",
				user_login_id:"Enter user name",
				user_password:"Enter password",
				business_id:"Select business group",
				plant_id:"Select Plant",
				user_address:"Enter user address",
				user_email:{
					email:"Please enter proper email"
				}
			},
			submitHandler:function(form){
				if(submit==false){
					submit=true;
					//now submit
					var user_id=$('#user_id').val();
					console.log(user_id);
					if(user_id==0 || user_id=='' || user_id==null){
						var data=$('#myform').serialize();
						//now insert
						$http({
							  method: 'POST',
							  url: '../UserController?action=InsertUser&'+data
							})
							.then(function (success) {
								//console.log(success);
								if(success.data>0){
									$.toast({
				    				    heading: 'User Added Successfully',
				    				    showHideTransition: 'fade',
				    				    icon: 'success',
				    				    position: 'top-right'
				    				});
									$('#user_name').val("");
									$('#user_phone').val("");
									$('#user_email').val("");
									$('#user_address').val("");
									$('#user_login_id').val("");
									$('#user_password').val("");
									submit=false;
									table.draw();
								}else if(success.data==-1){
									$.toast({
				    				    heading: 'User Already Exist',
				    				    showHideTransition: 'fade',
				    				    icon: 'error',
				    				    position: 'top-right'
				    				});
									submit=false;
								}
							}, function (error) {
							  
							});
					}else{
						var data=$('#myform').serialize();
						$http({
							method:'post',
							url:'../UserController?action=UpdateUser&'+data
						}).then(function(success){
							if(success.data>0){
								$.toast({
			    				    heading: 'User Updated Successfully',
			    				    showHideTransition: 'fade',
			    				    icon: 'success',
			    				    position: 'top-right'
			    				});
								$('#user_id').val(0);
								$('#user_name').val("");
								$('#user_phone').val("");
								$('#user_email').val("");
								$('#user_address').val("");
								$('#user_login_id').val("");
								$('#user_password').val("");
								submit=false;
								table.draw();
							}else if(success.data==-1){
								$.toast({
			    				    heading: 'Grade already exist',
			    				    showHideTransition: 'fade',
			    				    icon: 'error',
			    				    position: 'top-right'
			    				});
								submit=false;
							}
						},function(error){})
					}
				}
				
			}
		});
	
		
		
	
	$('#reset').click(function(){
		$('.edit').hide();
		$('.no-edit').show();
		$('#submit').addClass('btn-success')
					 .removeClass('btn-info')
					 .empty()
					 .text('Save User');
		$('#user_id').val(0);
		
	});
	
	
	
	$(document).on('click','#example .edit-user',function(){
    	var user_id=$(this).attr('id');
    	$http({
    		method:'post',
    		url:'../UserController?action=getSingleUserDetailsForUpdate',
    		headers:{
    			Accept:"application/json;charset=utf-8",
    			"Content-Type":"application/json;charset=utf-8"
    		},
    		params:{
    			user_id:user_id
    		}
    	}).then(function(success){
    		console.log(success.data);
    		$('#user_id').val(success.data.user_id);
    		$('#user_name').val(success.data.user_name);
    		$('#user_phone').val(success.data.user_phone);
    		$('#business_id').val(success.data.business_id);
    		$('#user_email').val(success.data.user_email);
    		$('#user_address').val(success.data.user_address);
    		//$('#plant_id').empty();
    		$('#plant_id').val(success.data.plant_id);
    		$('#user_login_id').val(success.data.user_login_id);
    		$('#user_password').val(success.data.user_password);
    		$('#user_type').val(success.data.user_type);
    		$('#submit').removeClass('btn-success')
			.addClass('btn-info').text('Update');
    	},function(error){});
    });
	
	
	
	$(document).on('click','#example .cancel-user',function(){
		let user_id=$(this).prop('id');
		let user_name=$(this).prop('name');
		let user_status=$(this).attr('value');
		user_status = (user_status=='active')?'inactive':'active';
		console.log(user_status);
		$.confirm({
    	    title: '<span class="text-danger"><i class="fa fa-close"></i></span> Confirmation !!!',
    	    content: 'Are you sure want to '+((user_status=='active')?"Activate":"Deactivate")+' user : '+user_name+' ?',
    	    buttons: {
    	        confirm:{
    	        	text: ((user_status=='active')?"Activate":"Deactivate"),
    	            btnClass: 'btn-warning',
    	            keys: ['enter', 'shift'],
    	            action: function(){
    	                $.ajax({
    	                	type:'post',
    	                	url:'../UserController?action=changeUserStatus&user_id='+user_id+'&user_status='+user_status,
    	                	success:function(res){
    	                		table.draw();
    	                		$.toast({
    	        				    heading: 'User Status Changed Successfully',
    	        				    showHideTransition: 'fade',
    	        				    icon: 'warning',
    	        				    position: 'top-right'
    	        				});
    	                	},
    	                	error:function(error){
    	                		$.toast({
    	        				    heading: 'Failed!!',
    	        				    showHideTransition: 'fade',
    	        				    icon: 'error',
    	        				    position: 'top-right'
    	        				});
    	                	}
    	                });
    	            }
    	        },
    	        cancel:{
    	        	text: 'Close',
    	            btnClass: 'btn-danger',
    	            keys:['esc'],
    	            action: function(){
    	                
    	            }
    	        }
    	    }
    	});
		
		
	});
	
	
	
	
//document ends here	
 });

//angular controller code ends here
});
