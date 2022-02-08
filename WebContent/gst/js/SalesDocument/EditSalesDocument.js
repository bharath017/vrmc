$(document).ready(function(){
	
	$('select').on('change', function() {  // when the value changes
	    $(this).valid(); // trigger validation on this element
	});

	
	$('#customer_id').on('change',function(){
		var customer_id=$('#customer_id').val();
		$.ajax({
			type:'POST',
			url:'../CustomerControllerTest?action=getCustomerSiteDetails&customer_id='+customer_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(result){
				$('#site_id').empty();
        		$('#site_id').html('<option value="" selected disabled>Choose Site Address</option>');
        		$.each(result, function(index, value) {
        			   $('#site_id').append("<option value='"+ value.site_id+ "'>" + value.site_name + "</option>");
        		});
        		
			}
		});
	});
	
	
	
	
	
	//get all Po List
	
	$('#site_id').on('change',function(){
		var site_id=$('#site_id').val();
		var plant_id=$('#plant_id').val();
		$.ajax({
			type:'post',
			url:'../CustomerControllerTest?action=GetSiteName&site_id='+site_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(result){
				$('#site_address').val(result.site_address);
				$.ajax({
					type:'post',
					url:'../PurchaseOrderControllerTest?action=GetGradeList&site_id='+site_id+'&plant_id='+plant_id,
					headers:{
						Accept:"application/json;charset=utf-8",
						"Content-Type":"application/json;charset=utf-8"
					},
					success:function(res){
						$('.poi_id').each(function(){
							console.log('coming ehre');
							var that=this;
							$(this).empty('');
			        		var html='<option value="" selected disabled>Choose Item</option>';
			        		$.each(res, function(index, value) {
			        			  html+='<option value="'+value.poi_id+'">'+value.product_name+'</option>';
			        		});
			        		$(this).html(html);
			        		html='';
						});
					}
				});
				
			}
		})
	});
	

	
// Validation Started here
	var submited=false;
	$('#sales-document-form').validate({
		debug:false,
		rules:{
			plant_id:"required",
			invoice_no:"required",
			plant_id:"required",
			invoice_date:"required",
			invoice_time:"required",
			customer_id:"required",
			site_id:"required",
			vehicle_no:"required"
		},
		messages:{
			plant_id:"Select Plant",
			invoice_no:"Enter Invoice No",
			invoice_date:"Select Invoice Date",
			invoice_time:"Select Invoice Item",
			customer_id:"Select Customer",
			site_id:"Select Site",
			vehicle_no:"Select Vehicle No"
		},
		submitHandler:function(form){
			if(submited==false){
				submited=true;
				form.submit();
			}
		}
	});
	
	
	var myFunc=function(){
		$('.poi_id').each(function(){
			$(this).rules('add',{
				required:true,
				messages:{
					required:"Please select item"
				}
			});
		});
		
		$('.rate').each(function(){
			$(this).rules('add',{
				required:true,
				messages:{
					required:"Please Enter Unit Price"
				}
			});
		});
		
		$('.quantity').each(function(){
			$(this).rules('add',{
				required:true,
				messages:{
					required:"Please Enter Quantity"
				}
			});
		});
	}

	//add new row
	
	var addNewRow=function(rowNumber){
		var customer_id= $('#customer_id').val();
	 	var site_id=$('#site_id').val();
	 	var plant_id=$('#plant_id').val();
	 	if(customer_id==''){alert('Select Customer'); return false;}
	 	else if(site_id==''){alert('Select Site'); return  false;}
		var html = '<tr>'+
			'<td>'+
				'<select  class="form-control poi_id" required="required" title="poi_id" name="poi_id['+rowNumber+']">'+
			
				'</select>'+
			'</td>'+
			
			'<td>'+
				'<input type="text" class="form-control rate"  pattern="[^\'&quot;:]*$"  title="rate" required="required" readonly style="background-color:white;" placeholder="Fetch Rate"   name="rate['+rowNumber+']"/>'+
			'</td>'+
			'<td style="width:12%">'+
				'<input type="text" class="form-control quantity" pattern="[^\'&quot;:]*$" title="quantity"  required="required" placeholder="Enter Quantity"  name="quantity['+rowNumber+']"/>'+
			'</td>'+
			'<td style="width:12%">'+
				'<input type="text" class="form-control gst_percent" readonly pattern="[^\'&quot;:]*$" title="gst_percent" required="required"  name="gst_percent['+rowNumber+']"/>'+
				'<input type="hidden" name="gst[0]" class="gst" title="gst"/>'+
				'<input type="hidden" name="rate_include_tax[0]" class="rate_include_tax" title="rate_include_tax"/>'+
			'</td>'+
	        '<td>'+
	            '<input class="form-control gross_amount" name="gross_amount['+rowNumber+']" title="gross_amount" readonly="readonly" type="text">'+ 
	         '</td>'+
	         '<td>'+
		 		'<input class="form-control tax_amount" name="tax_amount['+rowNumber+']" title="tax_amount" readonly="readonly" type="text">'+ 
		 	 '</td>'+
	         '<td>'+
	            '<input class="form-control net_amount" name="net_amount['+rowNumber+']" title="net_amount"  readonly="readonly" type="text">'+ 
	         '</td>'+
			'<td>'+
				'<span class="text-danger removebtn"><i class="fa fa-trash"></i></span>'+
			'</td>'+
		'</tr>'
		$('#Table1 tbody').append(html);
		 
		 
	 //add category wise product here
		
		$.ajax({
			type:'post',
			url:'../PurchaseOrderControllerTest?action=GetGradeList&site_id='+site_id+'&plant_id='+plant_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(res){
				$('select[name="poi_id['+rowNumber+']"]').html('');
				$('select[name="poi_id['+rowNumber+']"]').html("<option value=''>Select Item</option>'+");
        		$.each(res, function(index, value) {
        			$('select[name="poi_id['+rowNumber+']"]').append("<option value='"+ value.poi_id+ "'>" + value.product_name + "</option>")
        		});
			}
		});
		
		var count=$('#Table1 tbody tr').length;
		$('#count').val(count);
		$('.select2').css('width','100%').select2({allowClear:true})
			.on('change', function(){
		 });
		myFunc();
	}
	
	$(document).on('click', '#Table1 .removebtn', function() {
		$(this).closest("tr").remove();
		var count=$('#Table1 tbody tr').length;
		$('#count').val(count);
		manageRow();
	});
	
	
	
	//then manage all the table index by loop through it
	var manageRow=function(){
		var result=$('#Table1 tbody tr');
		console.log(result);
		if(result.length>0){
			result.each(function(i){
				$(this).find('select[title="poi_id"]').attr('name','indent_product_id['+i+']');
				$(this).find('input[title="quantity"]').attr('name','quantity['+i+']');
				$(this).find('input[title="rate"]').attr('name','rate['+i+']');
				$(this).find('input[title="gst_percent"]').attr('name','gst_percent['+i+']');
				$(this).find('input[title="gst"]').attr('name','gst['+i+']');
				$(this).find('input[title="rate_include_tax"]').attr('name','rate_include_tax['+i+']');
				$(this).find('input[title="gross_amount"]').attr('name','gross_amount['+i+']');
				$(this).find('input[title="tax_amount"]').attr('name','tax_amount['+i+']');
				$(this).find('input[title="net_amount"]').attr('name','net_amount['+i+']');
			});
		}
	};
	
	myFunc();
	
	$('.BtnPlus').on('click',function(){
		var rowNumber=$('#Table1 tbody tr').length;
		addNewRow(rowNumber)
	});
	
	
	
	$(document).on('change','#Table1 .poi_id',function(){
		var that=$(this);
		var poi_id=$(this).val();
		var date=$('input[name="invoice_date"]').val();
    	$.ajax({
        	type:'POST',
        	url:'../PurchaseOrderControllerTest?action=GetGradeDetails&poi_id='+poi_id+'&date='+date,
        	headers:{
        		Accept:"application/json;charset=utf-8",
        		"Content-Type":"application/json;charset=utf-8"
        	},
        	success:function(result){
        		that.closest('tr').find('.rate').val(result.rate);
        		that.closest('tr').find('.rate_include_tax').val(result.rate_include);
        		that.closest('tr').find('.gst_percent').val(result.tax_group+" @ "+result.gst_percent+" %");
        		that.closest('tr').find('.gst').val(result.gst_percent);
        		
        	}
        });
	});
	
   var calculateAmount=function(){
			var t_gross=0;
			var t_net=0;
			var t_tax=0;
			$('#Table1 tbody tr').each(function(){
				var quantity=$(this).closest('tr').find('.quantity').val();
				quantity=(quantity==undefined || quantity==null || quantity=='')?0:parseFloat(quantity);
				var rate=$(this).closest('tr').find('.rate').val();
				rate=(rate==undefined || rate==null || rate=='')?0:parseFloat(rate);
				var amount=quantity*rate;
				var gst_percent=$(this).closest('tr').find('.gst').val();
				gst_percent=(gst_percent==undefined || gst_percent==null || gst_percent=='')?0:parseFloat(gst_percent);
				
			   var include_tax=$(this).closest('tr').find('.rate_include_tax').val();
				
			   if(include_tax=='yes'){
				    var net_price=amount;
					var gross_price=(amount/(100+gst_percent))*100;
					var tax_price=net_price-gross_price;
		       }else{
		    	    var gross_price=amount;
					var tax_price=amount*(gst_percent/100);
					var net_price=gross_price+tax_price;
		       }
				
				
				
				t_gross+=gross_price;
				t_net+=net_price;
				t_tax+=tax_price;
				$(this).closest('tr').find('.gross_amount').val(gross_price.toFixed(2));
				$(this).closest('tr').find('.tax_amount').val(tax_price.toFixed(2));
				$(this).closest('tr').find('.net_amount').val(net_price.toFixed(2));
			});
			
		   
		   $('#total_gross_amount').html(t_gross.toFixed(2));
		   $('#total_tax_amount').html(t_tax.toFixed(2));
		   $('#total_net_total').html(t_net.toFixed(2)); 
		}
		
		
		
		$(document).on('keyup blur','#Table1 .quantity',function(){
			calculateAmount();
		});
		
		
		$(document).on('click','#Table1 .deleteSalesDocumentItem',function(){
			var sditem_id=$(this).attr('id');
			$.ajax({
				type:'post',
				url:'../SalesDocumentControllerTest?action=deleteSalesDocumentSingleItem&sditem_id='+sditem_id,
				success:function(res){
					location.reload();
				}
			});
		});
	
});