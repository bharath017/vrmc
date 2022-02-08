var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http) {
	$(document).ready(function(){
		
    var session=getSessionDetails();
	//load all the item
		var BaseConfig=$.ajax({
	        async:false,
	        url:'ProductController?action=GetNameSuggestion',
	        type:'post',
	        data:{'GetConfig':'YES'},
	        dataType:"JSON"
	        }).responseJSON;
		
		//console.log(BaseConfig);
		
		
		$('#product_name').autocomplete({
		    lookup: BaseConfig
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
	        	url:"ProductController?action=getProductList",
	        	type:"POST",
	        	 data 	: function ( d ) {
		                  return $.extend( {}, d, {
		                	  business_id:session.business_id
		                  });
		              },
	        	error:function(){
	        	}
	        },
	        "columnDefs":[
	        	{"targets":[0],"data":function(data){return data;},"render":function(data,row){
	        		return '<a style="font-weight:bold;color:blue;" title="Click to view more detail\'s" class="view-detail-btn" name="'+data.product_name+'" id="'+data.product_id+'">'+data.product_name+'</a>'
	        	}},
	        	{"targets":[1],"data":"product_detail"},
	        	{"targets":[2],"data":function(data){return data;},"render":function(data,row){
	        		if(data.unit_of_measurement==undefined || data.unit_of_measurement==null || data.unit_of_measurement=="")
	        			return "";
	        		else 
	        			return data.unit_of_measurement;
	        	}},
	        	{"targets":[3],"data":"group_name"},
	        	{"targets":[4],"data":"product_status"},
	        	{"targets":[5],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		
	        		html='<a href="#" title="View More details" class="view-detail-btn" id="'+data.product_id+'" name="'+data.product_name+'"><span class="text-info"><i class="fa fa-eye"></i></span></a>&nbsp;&nbsp;&nbsp;&nbsp;'+
	        			'<a href="#" title="Edit Grade" class="edit-product" id="'+data.product_id+'"><span class="text-success"><i class="fa fa-edit"></i></span></a>&nbsp;&nbsp;&nbsp;&nbsp;'+
	        			'<a href="#" title="Change Grade Status" class="changeProductStatus" id="'+data.product_id+'" name="'+data.product_name+'" status="'+((data.product_status=="active")?"inactive":"active")+'"><span class="text-danger"><i class="'+((data.product_status=="active")?"fa fa-ban":"fa fa-check")+'"></i></span></a>'
	                 return html;
	        	}}  	
	        ],
	        "createdRow": function( row, data, dataIndex){
                if(data.product_status ==  'inactive'){
                    $(row).addClass('redClass');
                }else if(data.product_status=='active'){
                	 $(row).removeClass('redClass');
                }
            }
	    });
		
		
	
    
	    $('#search').on( 'click', function () {
			 table.draw();
	    } );
		
	
		var loadUnits=function(){
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
		loadUnits();
	
	
		$.validator.addMethod('nospecial', function (value) { 
		    return /^[^']*$/.test(value); 
		}, 'Please remove ( \' ) here');
	
	
		$('#isConversionRequired').on('click',function(){
			let isClicked=$('#isConversionRequired:checked').length>0?true:false;
			if(isClicked)
				$('#conversion_value').prop('disabled',false);
			else
				$('#conversion_value').prop('disabled',true);
			
		});
		
		var submit=false;
		
		//Insert fleet item details here
		$('#myform').validate({
			debug:false,
			rules:{
				product_name:{
					required:true,
					nospecial:true
				},
				unit_of_measurement:"required",
				business_id:"required",
				conversion_value:{
					required:{
						depends:$('#isConversionRequired').is(":checked")
					}
				}
			},
			messages:{
				product_name:{
					required:"Please enter Grade name",
					nospecial:"Please remove ( ' ) here"
				},
				unit_of_measurement:"Please select measuring unit",
				business_id:"Please select business unit",
				conversion_value:"Enter conversion value"
			},
			submitHandler:function(form){
				if(submit==false){
					submit=true;
					//now submit
					var product_id=$('#product_id').val();
					if(product_id==0 || product_id=='' || product_id==null){
						let data=$('#myform').serialize();
						//now insert
						$http({
							  method: 'POST',
							  url: 'ProductController?action=addNewProduct&'+data
							})
							.then(function (success) {
								//console.log(success);
								if(success.data>0){
									$.toast({
				    				    heading: 'Grade added successfully',
				    				    showHideTransition: 'fade',
				    				    icon: 'success',
				    				    position: 'top-right'
				    				});
									$('#product_name').val("");
									$('#product_detail').val("");
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
							}, function (error) {
							  
							});
					}else{
						let data=$('#myform').serialize();
						$http({
							method:'post',
							url:'ProductController?action=updateProduct&'+data
						}).then(function(success){
							if(success.data>0){
								$.toast({
			    				    heading: 'Grade updated successfully',
			    				    showHideTransition: 'fade',
			    				    icon: 'success',
			    				    position: 'top-right'
			    				});
								$('#product_id').val(0);
								$('#product_name').val("");
								$('#product_detail').val("");
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
					 .text('Save Grade');
	});
	
	
	
	$(document).on('click','#example .edit-product',function(){
    	var product_id=$(this).attr('id');
    	$http({
    		method:'post',
    		url:'ProductController?action=getSingleProductDetails',
    		headers:{
    			Accept:"application/json;charset=utf-8",
    			"Content-Type":"application/json;charset=utf-8"
    		},
    		params:{
    			product_id:product_id
    		}
    	}).then(function(success){
    		$('#product_id').val(success.data.product_id);
    		$('#product_name').val(success.data.product_name);
    		$('#product_detail').val(success.data.product_detail);
    		$('#business_id').val(success.data.business_id);
    		$('#unit').val(success.data.unit_of_measurement);
    		$('#hsn_code').val(success.data.hsn_code);
    		$('#isConversionRequired').prop('checked',success.data.isConversionRequired);
    		
    		//enable conversion value
    		
    		if(success.data.isConversionRequired==true)
    			$('#conversion_value').prop('disabled',false);
    		else
    			$('#conversion_value').prop('disabled',true);
    		
    		$('#conversion_value').val(success.data.conversion_value);
    		$('#submit').removeClass('btn-success')
			.addClass('btn-info').text('Update');
    	},function(error){});
    });
	
	
	
	
	//delete product details open custom box
	$(document).on('click','#example .delete-branch-details',function(){
    	$('#item_name-delete').text($(this).attr('name'));
    	$('#fleet_item_id-delete').val($(this).attr('id'));
    	Custombox.open({
    		target:'#delete-model',
    		effect:'blur'
    	});
    });
	
	//make for change product status
	$('#delete-btn').click(function(){
		var fleet_item_id=$('#fleet_item_id-delete').val();
		$.ajax({
			type:'post',
			url:'FleetController?action=DeleteFleetItem&fleet_item_id='+fleet_item_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(res){
				table.draw();
				Custombox.close();
				$.toast({
				    heading: 'Deleted successfully',
				    showHideTransition: 'fade',
				    icon: 'warning',
				    position: 'top-right'
				});
			}
		});
	});
	
	
	
	//view product details
	$(document).on('click','#example .view-detail-btn',function(){
		$('#product_id-view').val($(this).attr('id'));
		$('#product_name-view').text($(this).attr('name'));
		var product_id=$(this).attr('id');
		$('#product_id_component').val(product_id);
		Custombox.open({
			target:'#view-model',
			effect:'blur'
		});
		
		//now get all detail's for view
		$http({
			method:'post',
			url:'ProductController?action=ViewProductDetails',
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			params:{
				product_id:product_id
			}
		}).then(function(success){
			//render details
			$('#cem_type').val(success.data.detail.cem_type);
			$('#cem_quantity').val(success.data.detail.cem_quantity);
			$('#max_aggregate').val(success.data.detail.max_aggregate);
			$('#max_wc').val(success.data.detail.max_wc);
			
			$('#comp-table tbody').empty();
			count=0;
			$.each(success.data.view,function(i,v){
				count++;
				$('#comp-table tbody').append('<tr><td>'+count+'</td><td>'+v.inventory+'</td><td>'+v.comp_weight+'</td><td><a id="'+v.comp_id+'" class="deleteComp"><span class="text-danger"><i class="fa fa-trash"></i></span></a></td></tr>')
			});
			console.log(success.data);
		},function(error){})
		
	});
	
	
	
	//get all composition list
	var getCompositionList=function(){
		$http({
			method:'post',
			url:'ProductController?action=getCompositionList',
			params:{
				product_id:$('#product_id_component').val()
			}
		}).then(function(success){
			$('#comp-table tbody').empty();
			count=0;
			$.each(success.data,function(i,v){
				count++;
				$('#comp-table tbody').append('<tr><td>'+count+'</td><td>'+v.inventory+'</td><td>'+v.comp_weight+'</td><td><a id="'+v.comp_id+'" class="deleteComp"><span class="text-danger"><i class="fa fa-trash"></i></span></a></td></tr>')
			});
		},function(error){console.log(error)});
	}
	
	//add new composition
	$('#addComp').on('click',function(){
		 var inv_item_id=$('#inventory_item').val();
		 var quantity=$('#quantity').val();
		 if(inv_item_id==null || inv_item_id==''){
			 alert('Please select Item')
			 return false; 
		 }
		 
		 if(quantity==''){
			 alert('Please enter quantity');
			 return false;
		 }	 
	
		 $http({
			method:'post',
			url:'ProductController?action=insertComposition',
			params:{
				product_id:$('#product_id_component').val(),
				inv_item_id:inv_item_id,
				quantity:quantity
			}
		 }).then(function(success){
			 if(success.data==-10){
				 $.toast({
 				    heading: 'Composition already exist!!!',
 				    showHideTransition: 'fade',
 				    icon: 'error',
 				    position: 'top-right'
 				});
			 }else{
				 getCompositionList();
			 }
			 
		 },function(error){console.log(error);});
	});
	
	
	
	
	$('#other-form').validate({
		debug:false,
		rules:{
			cem_quantity:{
				number:true
			},
			max_wc:{
				number:true
			}
		},
		messages:{
			cem_quantity:{
				number:"Please enter proper data"
			},
			max_wc:{
				number:"Please enter proper data"
			}
		},submitHandler:function(res){
			var cem_type=$('#cem_type').val();
			var cem_quantity=($('#cem_quantity').val()=='' || $('#cem_quantity').val()==null)?
														0:$('#cem_quantity').val();
			var max_aggregate=$('#max_aggregate').val();
			var max_wc=($('#max_wc').val()=='' || $('#max_wc').val()==null)?0:$('#max_wc').val();
			
			//close custombox
			Custombox.close();
			$http({
				method:'post',
				url:'ProductController?action=updateOtherDetails',
				params:{
					cem_type:cem_type,
					cem_quantity:cem_quantity,
					max_aggregate:max_aggregate,
					max_wc:max_wc,
					product_id:$('#product_id_component').val()
				}
			}).then(function(success){
				if(success.data>0){
					$.toast({
	 				    heading: 'Other Detail<br>Updated Successfully',
	 				    showHideTransition: 'fade',
	 				    icon: 'success',
	 				    position: 'top-right'
	 				});
				}else{
					$.toast({
	 				    heading: 'Updation failed!!',
	 				    showHideTransition: 'fade',
	 				    icon: 'danger',
	 				    position: 'top-right'
	 				});
				}
			},function(error){console.log(error);});			
		}
	});
	
	
	//delete composition
	$(document).on('click','#comp-table .deleteComp',function(){
		var id=$(this).attr('id');
		$.ajax({
			type:'post',
			url:'ProductController?action=deleteComp&comp_id='+id,
			success:function(res){
				getCompositionList();
			}
		});
	});
	
	
	//deactivate product
	
	$(document).on('click','#example .changeProductStatus',function(){
		var thisdata=$(this);
		var product_id=$(this).attr('id');
		var product_name=$(this).attr('name');
		var status=$(this).attr('status');
		$.confirm({
		    title: '<span class="text-danger"><i class="'+((status=='inactive')?"fa fa-ban":"fa fa-check")+'"></i></span> '+((status=='inactive')?"Deactivate":"Activate")+' !!',
		    content: 'Are you sure want to deactivate '+product_name+' !!',
		    buttons: {
		        confirm: {
		            btnClass:'btn-success',
		            keys:['enter','shift'],
		            action:function(){
		            	$.ajax({
		            		type:'post',
		            		url:'ProductController?action=changeProductStatus&product_id='+product_id+'&status='+status,
		            		success:function(res){
		            			//change change icons
		            			if(res>0){
		            				$.toast({
		        	 				    heading: 'Grade Status Changed!!!',
		        	 				    showHideTransition: 'fade',
		        	 				    icon: 'success',
		        	 				    position: 'top-right'
		        	 				});
		            				table.draw();
		            			}else{
		            				$.toast({
		        	 				    heading: 'Error occured!!!',
		        	 				    showHideTransition: 'fade',
		        	 				    icon: 'error',
		        	 				    position: 'top-right'
		        	 				});
		            			}
		            		}
		            	});
		            }
		        },
		        cancel: {
		            text: 'CANCEL',
		            btnClass: 'btn-danger',
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
