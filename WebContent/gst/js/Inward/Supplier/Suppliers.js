var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http) {
	$(document).ready(function(){
	var session=getSessionDetails();
		
	$('.select2').css('width','100%').select2({allowClear:true})
			.on('change', function(){
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
	        	url:"../SupplierControllerTest?action=getSupplierList",
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
	        	{"targets":[0],"data":"supplier_name"},
	        	{"targets":[1],"data":"supplier_phone"},
	        	{"targets":[2],"data":"supplier_address"},
	        	{"targets":[3],"data":function(data){
	        		return data;
	        	},
	        	 "render":function(data,row){
	        		 return (data.supplier_gstin=='' || data.supplier_gstin==null)?'':data.supplier_gstin;
	        	 }
	        	},
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
	        		var html='';
	        		if(data.supplier_status=='active')
	        			html+='<a id="'+data.supplier_id+'" style="cursor:pointer;" class="view-supplier"><span class="text-info"><i class="fa fa-eye"></i></span></a>&nbsp&nbsp';
	        		if(data.supplier_status=='active')
	        			html+='<a id="'+data.supplier_id+'" style="cursor:pointer;" class="edit-supplier"><span class="text-success"><i class="fa fa-edit"></i></span></a>&nbsp&nbsp';
	        		html+='<a id="'+data.supplier_id+'" name="'+data.supplier_name+'" status="'+data.supplier_status+'" style="cursor:pointer;" class="change-status"><span class="'+((data.supplier_status=='active')?'text-danger':'text-success')+'"><i class="fa '+((data.supplier_status=='active')?'fa-window-close':'fa-check-circle')+'"></i></span></a>&nbsp&nbsp';
	                 return html;
	        	}}  	
	        ],
	        "createdRow": function( row, data, dataIndex){
                if(data.supplier_status ==  'inactive'){
                    $(row).addClass('redClass');
                }else if(data.product_status=='active'){
                	 $(row).removeClass('redClass');
                }
            }
	    });
		
		
	
    
	    $('#search').on( 'click', function () {
			 table.draw();
	    } );
		
	
	    
	    //Change Supplier Status
	    $(document).on('click','#example .change-status',function(){
	    	var supplier_id=$(this).attr('id');
	    	var supplier_name=$(this).attr('name');
	    	var supplier_status=$(this).attr('status');
	    	$.confirm({
	    	    title: '<span class="'+((supplier_status=='active')?"text-danger":"text-success")+'"><i class="fa '+((supplier_status=='active')?"fa-window-close":"fa-check-circle")+'"></i></span> '+((supplier_status=='active')?"Deactivate":"Activate")+' Confirmation !!!',
	    	    content: 'Are you sure want to '+((supplier_status=='active')?"deactivate":"activate")+' supplier  : '+supplier_name+' ?',
	    	    buttons: {
	    	        confirm:{
	    	        	text: 'CHANGE STATUS',
	    	            btnClass: 'btn-info',
	    	            keys: ['enter', 'shift'],
	    	            action: function(){
	    	                $.ajax({
	    	                	type:'post',
	    	                	url:'SupplierController?action=UpdateStatus&supplier_status='+((supplier_status=='active')?'inactive':'active')+'&supplier_id='+supplier_id,
	    	                	success:function(res){
	    	                		table.draw();
	    	                		$.toast({
	    	        				    heading: 'Supplier Status Changed Successfully',
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

	    
	    
	    // view supplier detail's
	    $(document).on('click','#example .view-supplier',function(){
			var supplier_id=$(this).attr('id');
			$.confirm({
			    title: 'Supplier INFO',
			    content: '' +
			   			'<div class="row">'+
			   				'<div class="col-sm-1">'+
			   				'</div>'+
			   				'<div class="col-sm-10">'+
			   					'<div class="row">'+
    			   					'<table class="table table-bordered">'+
	    			   					'<tr><th style="width:15%;background-color:#17a2b8;color:white;">Supplier Name</th><td id="supplier_name_view"></td><th style="width:15%;background-color:#17a2b8;color:white;">Supplier Phone</th><td id="supplier_phone_view"></td></tr>'+
	    			   					'<tr><th style="width:15%;background-color:#17a2b8;color:white;">Supplier Email</th><td id="supplier_email_view"></td><th style="width:15%;background-color:#17a2b8;color:white;">Supplier Address</th><td id="supplier_address_view"></td></tr>'+ 
	    			   					'<tr><th style="width:15%;background-color:#17a2b8;color:white;">Supplier GSTIN</th><td id="supplier_gstin_view"></td><th style="width:15%;background-color:#17a2b8;color:white;">Supplier PAN No</th><td id="supplier_panno_view"></td></tr>'+
	    			   					'<tr><th style="width:15%;background-color:#17a2b8;color:white;">Business Group</th><td id="business_group_view"></td><th style="width:15%;background-color:#17a2b8;color:white;">Opening Balance</th><td id="opening_balance_view"></td></tr>'+
	    			   				'</table>'+
			   					'</div>'+
			   				'</div>'+
			   			'</div>',
			    type: 'green',
			    columnClass: 'col-md-12',
			    buttons: {
			        close: function () {
			            //close
			        },
			    },
			    onContentReady: function () {
			    	$.ajax({
			    	 type:'post',
			    	 url:'../SupplierControllerTest?action=getSinglesupplierDetailsForUpdate&supplier_id='+supplier_id,
			    	 headers:{
			    		 Accept:"application/json;charset=utf-8",
			    		 "Content-Type":"application/json;charset=utf-8"
			    	 },
			    	 success:function(success){
			        		$('#supplier_name_view').text(success.supplier_name);
			        		$('#supplier_phone_view').text(success.supplier_phone);
			        		$('#business_group_view').text(success.group_name);
			        		$('#supplier_email_view').text(success.supplier_email);
			        		$('#supplier_address_view').text(success.supplier_address);
			        		$('#supplier_gstin_view').text(success.supplier_gstin);
			        		$('#supplier_panno_view').text(success.supplier_panno);
			        		$('#opening_balance_view').text(success.opening_balance);
			    	 }
			      });
			    }
			});
		});	
	    
	    
	
		var submit=false;
		
		//Insert fleet item details here
		$('#myform').validate({
			debug:true,
			rules:{
				supplier_name:"required",
				supplier_phone:"required",
				business_id:"required",
				supplier_address:"required",
				supplier_email:{
					email:true
				},
				opening_balance:"required"
				
			},
			messages:{
				supplier_name:"Enter Name",
				supplier_phone:"Enter supplier phone",
				business_id:"Select business group",
				supplier_address:"Enter supplier address",
				supplier_email:{
					email:"Please enter proper email"
				},
				opening_balance:"Enter Opening Balance"
			},
			submitHandler:function(form){
				if(submit==false){
					submit=true;
					//now submit
					var supplier_id=$('#supplier_id').val();
					if(supplier_id==0 || supplier_id=='' || supplier_id==null){
						var data=$('#myform').serialize();
						//now insert
						$http({
							  method: 'POST',
							  url: '../SupplierControllerTest?action=InsertSupplier&'+data
							})
							.then(function (success) {
								//console.log(success);
								if(success.data>0){
									$.toast({
				    				    heading: 'supplier Added Successfully',
				    				    showHideTransition: 'fade',
				    				    icon: 'success',
				    				    position: 'top-right'
				    				});
									$('#supplier_name').val("");
									$('#supplier_phone').val("");
									$('#supplier_email').val("");
									$('#supplier_address').val("");
									$('#supplier_login_id').val("");
									$('#supplier_password').val("");
									submit=false;
									table.draw();
								}else if(success.data==-1){
									$.toast({
				    				    heading: 'supplier Already Exist',
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
							url:'../SupplierControllerTest?action=UpdateSupplier&'+data
						}).then(function(success){
							if(success.data>0){
								$.toast({
			    				    heading: 'Supplier Updated Successfully',
			    				    showHideTransition: 'fade',
			    				    icon: 'success',
			    				    position: 'top-right'
			    				});
								$('#supplier_id').val(0);
								$('#supplier_name').val("");
								$('#supplier_phone').val("");
								$('#supplier_email').val("");
								$('#supplier_address').val("");
								$('#supplier_login_id').val("");
								$('#supplier_password').val("");
								submit=false;
								table.draw();
							}else if(success.data==-1){
								$.toast({
			    				    heading: 'Supplier already exist',
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
					 .text('Save Grade');
	});
	
	
	
	$(document).on('click','#example .edit-supplier',function(){
    	var supplier_id=$(this).attr('id');
    	$http({
    		method:'post',
    		url:'../SupplierControllerTest?action=getSinglesupplierDetailsForUpdate',
    		headers:{
    			Accept:"application/json;charset=utf-8",
    			"Content-Type":"application/json;charset=utf-8"
    		},
    		params:{
    			supplier_id:supplier_id
    		}
    	}).then(function(success){
    		$('#supplier_id').val(success.data.supplier_id);
    		$('#supplier_name').val(success.data.supplier_name);
    		$('#supplier_phone').val(success.data.supplier_phone);
    		$('#business_id').val(success.data.business_id);
    		$('#supplier_email').val(success.data.supplier_email);
    		$('#supplier_address').val(success.data.supplier_address);
    		$('#supplier_gstin').val(success.data.supplier_gstin);
    		$('#supplier_panno').val(success.data.supplier_panno);
    		$('#opening_balance').val(success.data.opening_balance);
    		$('#submit').removeClass('btn-success')
			.addClass('btn-info').text('Update');
    	},function(error){});
    });
	
	
	
	
	
	
//document ends here	
 });

//angular controller code ends here
});
