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
	        	url:"StockController?action=getInventoryOutgoingList",
	        	type:"POST",
	        	 data 	: function ( d ) {
		                  return $.extend( {}, d, {
		                	  plant_id:$('#plant_id_view option:selected').val(),
		                	  inv_item_id:$('#inv_item_id_view option:selected').val(),
		                	  from_date:$('#from_date').val(),
		                	  to_date:$('#to_date').val()
		                  });
		              },
	        	error:function(){
	        	}
	        },
	        "columnDefs":[
	        	{"targets":[0],"data":"inventory_name"},
	        	{"targets":[1],"data":"quantity"},
	        	{"targets":[2],"data":"date"},
	        	{"targets":[3],"data":"plant_name"},
	        	{"targets":[4],"data":"comment"},
	        	{"targets":[5],"data":"added_by"},
	        	{"targets":[6],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		var html='';
	        			//html+='<a id="'+data.invout_id+'" name="'+data.invout_item_id+'" style="cursor:pointer;" class="edit-supplier"><span class="text-success"><i class="fa fa-edit"></i></span></a>&nbsp&nbsp';
	        			html+='<a id="'+data.invout_id+'" style="cursor:pointer;" class="delete-inventory-outgoing"><span class="text-danger"><i class="fa fa-trash"></i></span></a>&nbsp&nbsp';
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
	    
	    $('#clear').on( 'click', function () {
			 $('#clear-form').trigger("reset");
			 table.draw();
	    } );
		
	
	    
	    //Change Supplier Status
	    $(document).on('click','#example .delete-inventory-outgoing',function(){
	    	var invout_id=$(this).attr('id');
	    	$.confirm({
	    	    title: '<span class="text-danger"><i class="fa fa-trash"></i></span> Delete Confirmation !!!',
	    	    content: 'Are you sure want to delete ?',
	    	    buttons: {
	    	        confirm:{
	    	        	text: 'Delete',
	    	            btnClass: 'btn-warning',
	    	            keys: ['enter', 'shift'],
	    	            action: function(){
	    	                $.ajax({
	    	                	type:'post',
	    	                	url:'StockController?action=deleteProductionDetails&invout_id='+invout_id,
	    	                	success:function(res){
	    	                		table.draw();
	    	                		$.toast({
	    	        				    heading: 'Deleted Successfully',
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

	    
	    
	  
	    
	
		var submit=false;
		
		//Insert fleet item details here
		$('#myform').validate({
			debug:true,
			rules:{
				plant_id:"required",
				inv_item_id:"required",
				consumption_date:"required",
				consumption_quantity:"required",
				added_by:"required"
			},
			messages:{
				plant_id:"Select Plant",
				inv_item_id:"select item",
				consumption_date:"Select Date",
				consumption_quantity:"Enter consumption quantity",
				added_by:"Enter Your name"
			},
			submitHandler:function(form){
				if(submit==false){
					submit=true;
					//now submit
					var invout_id=$('#invout_id').val();
					if(invout_id==0 || invout_id=='' || invout_id==null){
						var data=$('#myform').serialize();
						//now insert
						$http({
							  method: 'POST',
							  url: 'StockController?action=insertInventoryOutgoing&'+data
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
									$('#consumption_date').val("");
									$('#consumption_quantity').val("");
									$('#added_by').val("");
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
							url:'SupplierController?action=UpdateSupplier&'+data
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
    		url:'StockController?action=getSingleInventoryOutgoingForUpdate',
    		headers:{
    			Accept:"application/json;charset=utf-8",
    			"Content-Type":"application/json;charset=utf-8"
    		},
    		params:{
    			supplier_id:supplier_id
    		}
    	}).then(function(success){
    		$('#invout_id').val(success.data.invout_id);
    		$('#plant_id').val(success.data.plant_id);
    		$('#inv_item_id').val(success.data.inv_item_id);
    		$('#consumption_date').val(success.data.business_id);
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
