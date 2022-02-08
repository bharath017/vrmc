$(document).ready(function(){
	
	$('select').on('change', function() {  // when the value changes
	    $(this).valid(); // trigger validation on this element
	});

	
	$('#customer_id').on('change',function(){
		var customer_id=$('#customer_id').val();
		$.ajax({
			type:'POST',
			url:'CustomerController?action=getCustomerSiteDetails&customer_id='+customer_id,
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
			url:'CustomerController?action=GetSiteName&site_id='+site_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(result){
				$('#site_address').val(result.site_address);
				$.ajax({
					type:'post',
					url:'PurchaseOrderController?action=GetGradeList&site_id='+site_id+'&plant_id='+plant_id,
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
		 		'<input class="form-control tcs_amount" name="tcs_amount['+rowNumber+']" title="tcs_amount" readonly="readonly" type="text">'+ 
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
			url:'PurchaseOrderController?action=GetGradeList&site_id='+site_id+'&plant_id='+plant_id,
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
        	url:'PurchaseOrderController?action=GetGradeDetails&poi_id='+poi_id+'&date='+date,
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
		var t_tcs=0;
		
		 let tcs_applicable = $('input[name="tcs_applicable"]').is(':checked');
		 let tcs_percent=0;
		 if(tcs_applicable) {
			 tcs_percent=0.075;
		 }
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
			
		   var tcs_amount=net_price*(tcs_percent/100);
		   var netPriceWithTcs=net_price+tcs_amount;
		   
		   
			
			
			t_gross+=gross_price;
			t_net+=netPriceWithTcs;
			t_tax+=tax_price;
			t_tcs+=tcs_amount;
			$(this).closest('tr').find('.gross_amount').val(gross_price.toFixed(2));
			$(this).closest('tr').find('.tax_amount').val(tax_price.toFixed(2));
			$(this).closest('tr').find('.tcs_amount').val(tcs_amount.toFixed(2));
			$(this).closest('tr').find('.net_amount').val(netPriceWithTcs.toFixed(2));
		});
		
		
	  
	   
	   $('#tcs_percent').text(tcs_percent);
	   $('#tcs_amount').text(t_tcs.toFixed(2));
	   
	   let netAmountBeforeRound=Number(t_net);
	   
	   let round_off=Math.round(netAmountBeforeRound)-netAmountBeforeRound;
	   round_off=round_off.toFixed(2);
	   $('#round_off').text(round_off);
	   
	   $('#total_gross_amount').html(t_gross.toFixed(2));
	   $('#total_tax_amount').html(t_tax.toFixed(2));
	   $('#total_net_total').html(Math.round(netAmountBeforeRound)); 
	   
	   $('input[name="tcs_percent"]').val(tcs_percent);
	   $('input[name="round_off"]').val(round_off);
	}
	
	
	
	$(document).on('keyup blur','#Table1 .quantity',function(){
		calculateAmount();
	});
	
	
	
	$('input[name="tcs_applicable"]').on('click',function(){
		calculateAmount();
	});
	
	
	calculateAmount();
	
	
	//for document upload option here
	
	let uploadDocument = () => {
		//get loader image
		var data = new FormData();
		 	jQuery.each(jQuery('#documents')[0].files, function(i, file) {
    	     data.append('file-'+i, file);
    	 });
    	 var opts = {
			    url: 'SalesDocumentController?action=uploadDocument',
			    data: data,
			    cache: false,
			    contentType: false,
			    processData: false,
			    type: 'POST',
			    success: function(data){
			    	$('input[name="documents"]').val(data);
			    	let html=`
			    		<a href="document/sales/${data}" target="_blank">Download Uploaded Document</a>
			    	`
			    	$('#upload_document_value').html(html);
			    	$('#upload_document_btn').html('<span class="input-group-text" style="background-color: #02c0ce;color: white;">Upload</span>');
			    }
			};
			if(data.fake) {
			    // Make sure no text encoding stuff is done by xhr
			    opts.xhr = function() { var xhr = jQuery.ajaxSettings.xhr(); xhr.send = xhr.sendAsBinary; return xhr; }
			    opts.contentType = "multipart/form-data; boundary="+data.boundary;
			    opts.data = data.toString();
			}
			jQuery.ajax(opts);
	}
	
	
	$('#upload_document_btn').on('click',function(){
		let documents=$('#documents').val();
		if(!documents){
			alert('Please select file');
			return false;
		}
		let loaderImage=`
			<img src="image/loader/loader.gif" width="30" height="30"/>
		`
		$('#upload_document_btn').html(loaderImage);
		uploadDocument();
	});

		
	
});