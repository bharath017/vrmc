$(document).ready(function(){
	
	$('.select2').css('width','100%').select2({allowClear:true})
		.on('change', function(){
	}); 
	
	var getItemDetailsForProduction=function(product_id){
		$.ajax({
			type:'post',
			url:'StockController?action=getItemDetails&product_id='+product_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(res){
				$('#stock-table tbody').empty();
				var row='';
				var slNo=0;
				$.each(res,function(i,v){
					var row='<tr>';
					row+='<td>'+(slNo+1)+'</td>';
					row+='<td><input type="hidden" name="inv_item_id['+slNo+']" class="inv_item_id" value="'+v.inv_item_id+'"/>'+v.inventory_name+'</td>';
					row+='<td><input type="hidden" class="unit_quantity" value="'+v.quantity+'"/>'+v.quantity+'</td>';
					row+='<td><input type="text" class="form-control quantity" name="quantity['+slNo+']" value="0"/></td>';
					row+='</tr>';
					$('#stock-table tbody').append(row);
					slNo++;
				});
				$('#count').val(slNo);
			}
		});
	}
	
	
	//get product details
	$('#product_id').on('change',function(){
		var product_id=$('#product_id').val();
		getItemDetailsForProduction(product_id);
		getConvertedQuantity(product_id);
	});
	
	
	
	let getConvertedQuantity=(product_id) => {
			fetch(`StockController?action=getConvertedQuantityDetails&product_id=${product_id}`,{
				method:'post',
				"Content-Type":"application/json"
			}).then(response => response.json())
			  .then((text) => {
				  
				  $('#conversion_value').val(text.conversion_value);
				 if(text.isConversionRequired){
					 $('.isConverted').show();
					 $('.isConverted').prop('disabled',false);
					 $('#converted_quantity').text('Converted ');
					 $('#quantity').prop('readonly',true);
					 $('#view-conv-value').text(`(Multiply by ${text.conversion_value})`);
				 }else{
					 $('.isConverted').hide();
					 $('.isConverted').prop('disabled',true);
					 $('#converted_quantity').text('');
					 $('#quantity').prop('readonly',false);
					 $('#view-conv-value').text('');
				 }
			  });
	}
	
	
	
	// this method is complitly related to edit production
	let isEdit=() => {
		let isEdit=$('#isEdit').val();
		isEdit=(isEdit)?+isEdit:0;
		if(isEdit==1){
			 $('.isConverted').show();
			 $('.isConverted').prop('disabled',false);
			 $('#converted_quantity').text('Converted ');
			 $('#quantity').prop('readonly',true);
			 let conversion_value=$('#conversion_value').val();
			 $('#view-conv-value').text(`(Multiply by ${conversion_value})`);
		}else{
			 $('.isConverted').hide();
			 $('.isConverted').prop('disabled',true);
			 $('#converted_quantity').text('');
			 $('#quantity').prop('readonly',false);
			 $('#view-conv-value').text('');
		}
	}
	
	isEdit();
	
	// edit production related code ends here
	
	
	$('#conv_quantity').on('keyup blur',function(){
		let conv_quantity=$('#conv_quantity').val();
		let convValue=$('#conversion_value').val();
		let totalValue=Number(conv_quantity)*Number(convValue);
		$('#quantity').val(isNaN(totalValue)?0:totalValue.toFixed(2));
		
	});
	
	
	var calculateQuantity=function(quantity){
		$('#stock-table tbody tr').each(function(){
			var unit_quantity=$(this).closest('tr')
									.find('.unit_quantity').val();
			unit_quantity=Number(unit_quantity);
			var total_quantity=unit_quantity*quantity;
			console.log(total_quantity);
			$(this).closest('tr').find('.quantity').val(total_quantity);
		});
	}
	
	
	$('#quantity').on('keyup blur',function(){
		var quantity=$(this).val();
		quantity=(quantity=='' ||
						quantity==null || quantity==undefined)?0:quantity;
		quantity=Number(quantity);
		calculateQuantity(quantity);
	});
	
	
	let submited=false;
	$('#myform').validate({
		debug:false,
		rules:{
			plant_id:"required",
			product_id:"required",
			quantity:{
				required:true,
				number:true
			},
			date:"required",
			production_cost:{
				required:true,
				number:true
			}
		},
		messages:{
			plant_id:"Select Plant",
			product_id:"Select Product",
			quantity:{
				required:"Enter Quantity",
				number:"Only numbers are allowed"
			},
			date:"Please Select Date",
			production_cost:{
				required:"Enter Production Cost",
				number:"Only numbers are allowed"
			}
		},
		submitHandler:function(form){
			if(!submited){
				submited=true;
				form.submit();
			}
		}
	});
	
});