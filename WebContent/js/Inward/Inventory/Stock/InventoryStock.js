$(document).ready(function(){
	
	var session=getSessionDetails();
	
	//get Plant details
	var plantList=$.ajax({
        async:false,
        url:'PlantController?button=GetPlantForSelect&business_id='+session.business_id+'&plant_id='+session.plant_id,
        type:'post',
        data:{'GetConfig':'YES'},
        dataType:"JSON"
        }).responseJSON;
	
	var itemList=$.ajax({
        async:false,
        url:'InventoryController?action=getItemList',
        type:'post',
        data:{'GetConfig':'YES'},
        dataType:"JSON"
        }).responseJSON;
	
	
	
	
	
	$(document).on('click','#stock-entry',function(){
		var dialog=$.dialog({
			title:'Enter Stock',
			icon:'fa fa-caret-square-o-up',
			columnClass:'col-sm-8',
			content:''+
			'<form class="formName" id="inventory-stock-form" action="">'+
				'<div class="row">'+
					'<div class="col-sm-6">'+
						'<div class="form-group">'+
							'<label for="plant_name">Plant <span class="text-danger">*</span></label>'+
							'<select class="form-control" name="plant_id" id="plant_id">'+
							'</select>'+
						'</div>'+
					'</div>'+
					'<div class="col-sm-6">'+
						'<div class="form-group">'+
							'<label for="item_name">Item  <span class="text-danger">*</span></label>'+
							'<select class="form-control" name="inv_item_id" id="inv_item_id">'+
							
							'</select>'+
						'</div>'+
					'</div>'+
					'<div class="col-sm-6">'+
						'<div class="form-group">'+
			                '<label>DC Date <span class="text-danger">*</span> </label>'+
			                '<div>'+
			                    '<div class="input-group">'+
			                        '<input type="text" name="date" class="form-control date-picker invoice_date"'+ 
			                        		'required="required" placeholder="dd/mm/yyyy" id="id-date-picker-1" readonly style="background-color: white;" data-date-format="dd/mm/yyyy">'+
			                        '<div class="input-group-append picker">'+
			                            '<span class="input-group-text"><i class="mdi mdi-calendar"></i></span>'+
			                        '</div>'+
			                    '</div>'+
			                    '<label id="id-date-picker-1-error" class="error" for="id-date-picker-1" style="display:none;"></label>'+
			                '</div>'+
			           '</div>'+
					'</div>'+
					'<div class="col-sm-6">'+
						'<div class="form-group">'+
			                '<label>Closing Stock <span class="text-danger">*</span> </label>'+
			                '<input type="text" name="quantity" id="quantity" class="form-control" placeholder="Enter Closing Stock"/>'+
			            '</div>'+
					'</div>'+
					'<div class="col-sm-12 text-center">'+
						'<button class="btn btn-success" type="submit" name="saveBtn" id="saveBtn" value="SaveStock">Save Stock</button>'+
					'</div>'+
				'</div>'+
			'</form>',
			buttons:{
				close:{
					text:'<span class="" style="display:none;"><i class="fa fa-close"></i></span>',
					btnClass:'btn-danger',
					action:function(){
					}
				}
			},
			closeIcon:true,
			closeIconClass:'fa fa-close text-danger',
			onContentReady: function () {
				//common setting goes here
				
				 $('.date-picker').datepicker({
						autoclose: true,
						todayHighlight: true,
						"orientation":"bottom left"
				 }).on('changeDate', function(ev) {
				        $(this).valid();  // triggers the validation test
				        // '$(this)' refers to '$("#datepicker")'
				    });;
			  
			    $("#id-date-picker-1").datepicker();
					$('#id-date-picker-1').datepicker({
					        "autoclose": true,
					        "orientation":"bottom left"
				}).on('changeDate', function(ev) {
			        $(this).valid();  // triggers the validation test
			        // '$(this)' refers to '$("#datepicker")'
			    });;
					
				$('.picker').on('click',function(){
					$(this).prev("input.date-picker").datepicker("show");
				});
				
				$('#plant_id').empty();
				$.each(plantList,function(i,v){
					$('#plant_id').append('<option value="'+i+'">'+v+'</option>');
				});
				
				
				$('#inv_item_id').empty();
				$.each(itemList,function(i,v){
					$('#inv_item_id').append('<option value="'+i+'">'+v+'</option>');
				});
				
				$('#inventory-stock-form').validate({
					debug:false,
					rules:{
						plant_id:"required",
						inv_item_id:"required",
						date:"required",
						quantity:"required"
					},
					messages:{
						plant_id:"Select Plant",
						inv_item_id:"Select Inventory Item",
						date:"Select Date",
						quantity:"Select Quantity"
					},
					submitHandler:function(form){
						var vall=$('#inventory-stock-form').serialize();
						console.log(vall);
						$.ajax({
							type:'post',
							url:'StockController?action=saveInventoryStock&'+vall,
							success:function(res){
								console.log(res);
							}
						});
						dialog.close();
					}
				});
		    }
		});
	});
	
	
	let getOpeningStockList=() => {
		$.ajax({
			type:'post',
			url:'StockController?action=getOpeningStockEntryDetails',
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(res){
				$('#example tbody').empty();
				let sl_no=0;
				$.each(res,function(i,v){
					sl_no+=1;
					let row='<tr>'
						row+='<td>'+sl_no+'</td>'
						row+='<td>'+v.inventory_name+'</td>'
						row+='<td>'+v.effective_date+'</td>'
						row+='<td>'+v.quantity+'</td>'
						row+='<td>'+v.plant_name+'</td>'
						row+='<td><a id="'+v.stk_id+'" class="edit-stock"><span class="text-success"><i class="fa fa-edit"></i></span></a>&nbsp;&nbsp;&nbsp;'+
						'<a class="delete-stock" id="'+v.stk_id+'" name="'+v.inventory_name+'"><span class="text-danger"><i class="fa fa-trash"></i></span></a>'+
						'</td>'
						row+='</tr>'
					$('#example tbody').append(row);
				});
			}
		});
	}
	
	getOpeningStockList();
	
	
	
	$(document).on('click','#example .edit-stock',function(){
		let stock_id=$(this).prop('id');
		var dialog=$.dialog({
			title:'Enter Stock',
			icon:'fa fa-caret-square-o-up',
			columnClass:'col-sm-8',
			content:''+
			'<form class="formName" id="inventory-stock-form" action="">'+
				'<div class="row">'+
					'<div class="col-sm-6">'+
						'<div class="form-group">'+
							'<label for="plant_name">Plant <span class="text-danger">*</span></label>'+
							'<input type="hidden" name="stock_id" id="stock_id" />'+
							'<select class="form-control" name="plant_id" id="plant_id">'+
							'</select>'+
						'</div>'+
					'</div>'+
					'<div class="col-sm-6">'+
						'<div class="form-group">'+
							'<label for="item_name">Item  <span class="text-danger">*</span></label>'+
							'<select class="form-control" name="inv_item_id" id="inv_item_id">'+
							
							'</select>'+
						'</div>'+
					'</div>'+
					'<div class="col-sm-6">'+
						'<div class="form-group">'+
			                '<label>DC Date <span class="text-danger">*</span> </label>'+
			                '<div>'+
			                    '<div class="input-group">'+
			                        '<input type="text" name="date" class="form-control date-picker invoice_date"'+ 
			                        		'required="required" placeholder="dd/mm/yyyy" id="id-date-picker-1" readonly style="background-color: white;" data-date-format="dd/mm/yyyy">'+
			                        '<div class="input-group-append picker">'+
			                            '<span class="input-group-text"><i class="mdi mdi-calendar"></i></span>'+
			                        '</div>'+
			                    '</div>'+
			                    '<label id="id-date-picker-1-error" class="error" for="id-date-picker-1" style="display:none;"></label>'+
			                '</div>'+
			           '</div>'+
					'</div>'+
					'<div class="col-sm-6">'+
						'<div class="form-group">'+
			                '<label>Closing Stock <span class="text-danger">*</span> </label>'+
			                '<input type="text" name="quantity" id="quantity" class="form-control" placeholder="Enter Closing Stock"/>'+
			            '</div>'+
					'</div>'+
					'<div class="col-sm-12 text-center">'+
						'<button class="btn btn-success" type="submit" name="saveBtn" id="saveBtn" value="SaveStock">Save Stock</button>'+
					'</div>'+
				'</div>'+
			'</form>',
			buttons:{
				close:{
					text:'<span class="" style="display:none;"><i class="fa fa-close"></i></span>',
					btnClass:'btn-danger',
					action:function(){
					}
				}
			},
			closeIcon:true,
			closeIconClass:'fa fa-close text-danger',
			onContentReady: function () {
				//common setting goes here
				
				 $('.date-picker').datepicker({
						autoclose: true,
						todayHighlight: true,
						"orientation":"bottom left"
				 }).on('changeDate', function(ev) {
				        $(this).valid();  // triggers the validation test
				        // '$(this)' refers to '$("#datepicker")'
				    });;
			  
			    $("#id-date-picker-1").datepicker();
					$('#id-date-picker-1').datepicker({
					        "autoclose": true,
					        "orientation":"bottom left"
				}).on('changeDate', function(ev) {
			        $(this).valid();  // triggers the validation test
			        // '$(this)' refers to '$("#datepicker")'
			    });;
					
				$('.picker').on('click',function(){
					$(this).prev("input.date-picker").datepicker("show");
				});
				
				$('#plant_id').empty();
				$.each(plantList,function(i,v){
					$('#plant_id').append('<option value="'+i+'">'+v+'</option>');
				});
				
				
				$('#inv_item_id').empty();
				$.each(itemList,function(i,v){
					$('#inv_item_id').append('<option value="'+i+'">'+v+'</option>');
				});
				
				
				$.ajax({
					type:'post',
					url:'StockController?action=getSingleOpeningStockDetails&stock_id='+stock_id,
					headers:{
						Accept:"application/json;charset=utf-8",
						"Content-Type":"application/json;charset=utf-8"
					},
					success:function(res){
						$('#plant_id').val(res.plant_id);
						$('#inv_item_id').val(res.inv_item_id);
						$('input[name="date"]').val(res.date);
						$('#quantity').val(res.quantity);
						$('#stock_id').val(res.stock_id);
					}
				});
				
				$('#inventory-stock-form').validate({
					debug:false,
					rules:{
						plant_id:"required",
						inv_item_id:"required",
						date:"required",
						quantity:"required"
					},
					messages:{
						plant_id:"Select Plant",
						inv_item_id:"Select Inventory Item",
						date:"Select Date",
						quantity:"Select Quantity"
					},
					submitHandler:function(form){
						var vall=$('#inventory-stock-form').serialize();
						console.log(vall);
						$.ajax({
							type:'post',
							url:'StockController?action=updateInventoryStock&'+vall,
							success:function(res){
								if(res>0){
									$.toast({
									    heading: 'Updated Successfully',
									    showHideTransition: 'fade',
									    icon: 'success',
									    position: 'top-right'
									});
									getOpeningStockList();
								}else{
									$.toast({
									    heading: 'Updation Failed!!',
									    showHideTransition: 'fade',
									    icon: 'danger',
									    position: 'top-right'
									});
								}
							}
						});
						dialog.close();
					}
				});
		    }
		});
	});
	
	
	
	 //For deleting opening stock
    $(document).on('click','#example .delete-stock',function(){
    	var stock_id=$(this).attr('id');
    	var item_name=$(this).attr('name');
    	$.confirm({
    	    title: '<span class="text-danger"><i class="fa fa-trash"></i></span>Delete Confirmation ?',
    	    content: 'Are you sure want to delete Stock Name : '+item_name+' ?',
    	    buttons: {
    	        confirm:{
    	        	text: 'DELETE',
    	            btnClass: 'btn-info',
    	            keys: ['enter', 'shift'],
    	            action: function(){
    	                $.ajax({
    	                	type:'post',
    	                	url:'StockController?action=deleteInventoryStock&stock_id='+stock_id,
    	                	success:function(res){
    	                		if(res>0){
    	                			$.toast({
        	        				    heading: 'Deleted Successfully',
        	        				    showHideTransition: 'fade',
        	        				    icon: 'warning',
        	        				    position: 'top-right'
        	        				});
    	                			getOpeningStockList();
    	                		}else{
    	                			$.toast({
									    heading: 'Updation Failed!!',
									    showHideTransition: 'fade',
									    icon: 'danger',
									    position: 'top-right'
									});
    	                		}
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
    
	
	
});