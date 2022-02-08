$(document).ready(function(){
	
	var categoryList=(category_type)=>{
		var data=$.ajax({
	        async:false,
	        url:'ExpenseVoucherController?action=getCategoryList&category_type='+category_type,
	        type:'post',
	        data:{'GetConfig':'YES'},
	        dataType:"JSON"
	    }).responseJSON;
		return data;
	}
	
	
	var getGstList=()=>{
		var data=$.ajax({
	        async:false,
	        url:'SettingController?action=getGstList',
	        type:'post',
	        data:{'GetConfig':'YES'},
	        dataType:"JSON"
	    }).responseJSON;
		return data;
	}
	
	
	
	$('#category_type').on('change',function(){
		var category_type=$('#category_type').val();
		var data=categoryList(category_type);
		$('.category_id').each(function(){
			var that=$(this);
			that.empty();
			$.each(data,function(i,v){
				that.append('<option value="'+v.category_id+'">'+v.category_name+'</option>');
			});
		});
	});
	
	
	//add new row
	
	$(document).on('click','#clicked .BtnPlus',function(){
		let length=$('#Table1 tbody tr').length;
		let row='<tr>'
			row+='<td style="width:12%">'
				row+='<select class="form-control category_id" title="category_id" name="category_id['+length+']">'
				row+='</select>'
			row+='</td>'
			row+='<td style="width:12%">'
				row+='<input class="form-control item_name" title="item_name" name="item_name['+length+']" placeholder="Enter Item name"/>'
			row+='</td>'
			row+='<td style="width:10%">'
				row+='<input class="form-control item_quantity" title="item_quantity"' 
					row+='required="required" placeholder="Enter Quantity"'
						row+='name="item_quantity['+length+']" type="text"/>'
			row+='</td>'
			row+='<td style="width:10%">'
			row+='<input class="form-control item_price" title="item_price"  required="required"'
				row+='placeholder="Enter Rate" name="item_price['+length+']" type="text">'
			row+='</td>'
			row+='<td style="width:8%">'
				row+='<select class="form-control gst_percent" title="gst_percent"  name="gst_percent['+length+']">'
				row+='</select>'                                				
			row+='</td>'
			row+='<td style="width:10%">'
				row+='<input class="form-control gross_amount" title="gross_amount" name="gross_amount['+length+']"' 
					row+=' readonly="readonly" type="text"/>'
			row+='</td>'
			row+='<td style="width:10%">'
				row+='<input class="form-control tax_amount" title="tax_amount" name="tax_amount['+length+']"'
					row+=' readonly="readonly" type="text"/>'
			row+='</td>'
			row+='<td style="width:10%"	>'
				row+='<input class="form-control net_amount" title="net_amount" name="net_amount['+length+']"' 
					row+='readonly="readonly" type="text"/>'
			row+='</td>'
			row+='<td style="width:3%">'
				row+='<a class="text-danger removeRow"><span class="text-danger"><i class="fa fa-trash"></i></span></a>'
			row+='</td>'
		row+='</tr>'
		//append to table body
		$('#Table1 tbody').append(row);
		myFunc();
		//set category
		$.each(data,function(i,v){
			console.log(v);
			$('select[name="category_id['+length+']"]')
				.append('<option value="'+v.category_id+'">'+v.category_name+'</option>');
		});
		
		$.each(gstData,function(i,v){
			$('select[name="gst_percent['+length+']"]')
						.append('<option value="'+v.gst_percent+'">'+v.gst_percent+'</option>');
		});
		setCountValue();
	});
	
	
	//remove row
	
	$(document).on('click','#Table1 .removeRow',function(){
		$(this).closest('tr').remove();
		manageRow();
		setCountValue();
	});
	

	let setCountValue=() => {
		let rowCount=$('#Table1 tbody tr').length;
		$('#count').val(rowCount);
	}
	
	var manageRow=function(){
		var result=$('#Table1 tbody tr');
		console.log(result);
		if(result.length>0){
			result.each(function(i){
				$(this).find('select[title="category_id"]').attr('name','category_id['+i+']');
				$(this).find('input[title="item_name"]').attr('name','item_name['+i+']');
				$(this).find('input[title="item_quantity"]').attr('name','item_quantity['+i+']');
				$(this).find('input[title="item_price"]').attr('name','item_price['+i+']');
				$(this).find('select[title="gst_percent"]').attr('name','gst_percent['+i+']');
				$(this).find('input[title="gross_amount"]').attr('name','gross_amount['+i+']');
				$(this).find('input[title="tax_amount"]').attr('name','tax_amount['+i+']');
				$(this).find('input[title="net_amount"]').attr('name','net_amount['+i+']');
			});
		}
	};
	
	
	//validate expense voucher
	let submited=false;
	$('#myForm').validate({
		debug:false,
		rules:{
			bill_date:"required",
			supplier_id:"required",
			plant_id:"required"
		},
		messages:{
			bill_date:"Select Date",
			supplier_id:"Select Supplier",
			plant_id:"select Plant"
		},
		submitHandler:function(form){
			if(!submited){
				submited=true;
				form.submit();
			}
		}
	});
	
	var myFunc=function(){
		$('.category_id').each(function(){
			$(this).rules('add',{
				required:true,
				messages:{
					required:"select Category"
				}
			});
		});
		
		$('.item_name').each(function(){
			$(this).rules('add',{
				required:true,
				messages:{
					required:"Enter Item Name"
				}
			});
		});
		
		$('.item_quantity').each(function(){
			$(this).rules('add',{
				required:true,
				number:true,
				messages:{
					required:"Please Enter Quantity",
					number:"Please enter Valid quantity"
				}
			});
		});
		
		$('.item_price').each(function(){
			$(this).rules('add',{
				required:true,
				messages:{
					required:"Please Enter Price"
				}
			});
		});
		
		$('.gst_percent').each(function(){
			$(this).rules('add',{
				required:true,
				messages:{
					required:"Please Enter Price"
				}
			});
		});
		
		$('.gross_amount').each(function(){
			$(this).rules('add',{
				required:true,
				messages:{
					required:"Gross Amount is Mandetory"
				}
			});
		});
		
		$('.tax_amount').each(function(){
			$(this).rules('add',{
				required:true,
				messages:{
					required:"Tax Amount is Mandetory"
				}
			});
		});
		
		$('.net_amount').each(function(){
			$(this).rules('add',{
				required:true,
				messages:{
					required:"Net Amount is mandetory"
				}
			});
		});
	}
	myFunc();
	
	
	
	//for calculation
	let calculateTotalAmount=() => {
		let tgross=0;
		let ttax=0;
		let tnet=0;
		
		let include_tax=$('#include_tax:checked').length>0?true:false;
		$('#Table1 tbody tr').each(function(){
			//declare amount variables
			let net_amount=0;
			let tax_amount=0;
			let gross_amount=0;
			///////////////
			let quantity=$(this).find('.item_quantity').val();
			let price=$(this).find('.item_price').val();
			let gst_percent=$(this).find('.gst_percent').val();
			gst_percent=Number(gst_percent);
			let amount=Number(isNaN(quantity)?0:quantity)*Number(isNaN(price)?0:price);
			if(include_tax){
				net_amount=amount;
				gross_amount=(net_amount/(100+gst_percent))*100;
				tax_amount=net_amount-gross_amount;
			}else{
				gross_amount=amount;
				tax_amount=gross_amount*(gst_percent/100);
				net_amount=gross_amount+tax_amount;
			}
			
			net_amount=Math.round(net_amount*100)/100;
			tax_amount=Math.round(tax_amount*100)/100;
			gross_amount=Math.round(gross_amount*100)/100;
			
			$(this).find('.gross_amount').val(gross_amount);
			$(this).find('.tax_amount').val(tax_amount);
			$(this).find('.net_amount').val(net_amount);
			
			//calculate
			tgross=tgross+gross_amount;
			ttax=ttax+tax_amount;
			tnet=tnet+net_amount;
		});
		
		tgross=Math.round(tgross*100)/100;
		ttax=Math.round(ttax*100)/100;
		tnet=Math.round(tnet*100)/100;
		
		$('#tgross').text(tgross);
		$('#ttax').text(ttax);
		$('#tnet').text(tnet);
	}
	
	$(document).on('keyup blur','#Table1 .item_quantity',function(){
		calculateTotalAmount(); 
	});
	
	$(document).on('keyup blur','#Table1 .item_price',function(){
		calculateTotalAmount();
	});
	
	$(document).on('change','#Table1 .gst_percent',function(){
		calculateTotalAmount();
	});
	
	$('#include_tax').on('click',function(){
		calculateTotalAmount();
	});
	
	
	calculateTotalAmount();
	
});