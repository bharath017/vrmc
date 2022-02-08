$(document).ready(function(){
	 $('.select2').css('width','100%').select2({allowClear:true})
		.on('change', function(){
		}); 
  
  
     $('.date-picker').datepicker({
			autoclose: true,
			todayHighlight: true,
			"orientation":"bottom left"
	 });
		//show datepicker when clicking on the icon
		
  
   $("#id-date-picker-1").datepicker();
		$('#id-date-picker-1').datepicker({
		        "autoclose": true,
		        "orientation":"bottom left"
	});
	
	//get last invoice no here
	var getInvoice=function(){
		var plant_id=$('#plant_id').val();
			$.ajax({	
				type:'post',
				url:'InvoiceController?action=getInvoiceNo&plant_id='+plant_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					$('#invoice_no').val(parseInt(res)+1);
				}
			});
	}
	getInvoice();
	$('#plant_id').on('change',function(){
		getInvoice();
	});
	
	
	
	
	//get customer detail's 
	$('#customer').on('change',function(){
		resetToZero();
		$('.nochange').text('');
		var customer_id=$('#customer').val();
		$.ajax({
			type:'POST',
			url:'CustomerController?action=GetCustomerDetails&customer_id='+customer_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(result){
				$('#show_customer').text(result.customer_name);
				$('#show_customer_address').text(result.customer_address);
				$.ajax({
					type:'POST',
					url:'CustomerController?action=getCustomerSiteDetails&customer_id='+customer_id,
					headers:{
						Accept:"application/json;charset=utf-8",
						"Content-Type":"application/json;charset=utf-8"
					},
					success:function(res){
						$('#select2-site_id-container').html('Choose Site Address');
						$('#site_id').html('');
		        		$('#site_id').html('<option value="">Choose Site Address.</option>');
		        		$.each(res, function(index, value) {
		        			   $('#site_id').append("<option value='"+ value.site_id+ "'>" + value.site_name + "</option>");
		        		});
					}
				});
			}
		});
	});
	
	
	//get all the grade list
	
	$('#site_id').on('change',function(){
		var site_id=$('#site_id').val();
		var plant_id=$('#plant_id').val();
		resetToZero();
		$.ajax({
			type:'post',
			url:'CustomerController?action=GetSiteName&site_id='+site_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(result){
				$('#show_site_name').text(result.site_name);
				$('#show_site_address').text(result.site_address);
				$.ajax({
					type:'post',
					url:'PurchaseOrderController?action=GetGradeList&site_id='+site_id+'&plant_id='+plant_id,
					headers:{
						Accept:"application/json;charset=utf-8",
						"Content-Type":"application/json;charset=utf-8"
					},
					success:function(res){
						$('#select2-poi_id-container').html('Choose Grade');
						$('#poi_id').html('');
		        		$('#poi_id').html('<option value="">Choose Grade</option>');
		        		$.each(res, function(index, value) {
		        			   $('#poi_id').append("<option value='"+ value.poi_id+ "'>" + value.product_name + "</option>");
		        		});
					}
				});
				
				$.ajax({
					type:'post',
					url:'CustomerController?action=getProjectBlocks&site_id='+site_id,
					headers:{
						Accept:"application/json;charset=utf-8",
						"Content-Type":"application/json;charset=utf-8"
					},
					success:function(res){
						$('#project_block').html("");
						$('#project_block').html("<option value=''>Choose Grade</option>");
						$.each(res,function(i,val){
							$('#project_block').append("<option value='"+val.block_name+"'>"+val.block_name+"</option>")
						});
					}
				});
				
			}
		})
	});
	
	
	//get po detail's
	
	$("#poi_id").change(function(){
		var poi_id=$('#poi_id').val();
		var date=$('.invoice_date').val();
    	$.ajax({
        	type:'POST',
        	url:'PurchaseOrderController?action=GetGradeDetails&poi_id='+poi_id+'&date='+date,
        	headers:{
        		Accept:"application/json;charset=utf-8",
        		"Content-Type":"application/json;charset=utf-8"
        	},
        	success:function(result){
        		//var inventory=jQuery.parseJSON(result);
                 $('#show_rate').html(result.rate);
                 $('#show_grade').html(result.product_name);
                 $('#tax_group').val(result.tax_group);
                 $('#rate_include').val(result.rate_include);
                 $('#tax_percent').val(result.gst_percent);
                 $('#rate').val(result.rate);
                 var gst_percent=result.gst_percent;
                 if(result.tax_group=='GST'){
                	 $('#show_cgst').text(parseFloat(gst_percent/2));
                	 $('#show_sgst').text(parseFloat(gst_percent/2));
                	 $('#show_igst').text('0');
                 }else{
                	 $('#show_cgst').text('0')
                	 $('#show_sgst').text('0');
                	 $('#show_igst').text(gst_percent);
                 }
                 calculateNetAmount();
        	}
        });
    });
	
	
	
	let getTcsDetails= () => {
		let poi_id=$('#poi_id').val();
		poi_id=(poi_id || 0)
		let invoice_date=$('input[name="invoice_date"]').val();
		let customer_id=$('#customer').val();
		customer_id=(customer_id || 0);
		if(poi_id==0 || invoice_date=='' || customer_id==0)
			return false;
		fetch(`PurchaseOrderController?action=getTcsDetails&poi_id=${poi_id}&invoice_date=${invoice_date}&customer_id=${customer_id}`,{
			method:'post',
			headers:{
				"Content-Type":"application/json;charset=utf-8"
			}
		}).then(response => response.json())
		  .then(text => {
			 $('#tcs_required').val(text.tcs_required);
			 $('#total_nt_amt').val(text.net_amount);
		  });
	}
	
	//get tcs details if any of the event appear
	
	$('#customer').on('change',function(){
		getTcsDetails();
	});
	
	$('#poi_id').on('change',function(){
		console.log('hello world');
		getTcsDetails();
	});
	
	$('#invoice_date').on('change blur',function(){
		getTcsDetails();
	});
	
	getTcsDetails();
	
	
	
	//calculate total price
	var resetToZero=function(){
		$('#grs_ammt').val(0);
		$('#show_grade').text('');
		$('#show_rate').text('');
		$('#gross_view').text('');
		$('#tax_view').text('');
		$('#net_view').text('');
		$('#show_cgst').text('');
		$('#view_cgst').text('');
		$('#show_sgst').text('');
		$('#view_sgst').text('');
		$('#show_igst').text('');
		$('#view_igst').text('');
		
		
	};
	
	//here calculate net amount
	var calculateNetAmount=function(){
		   var basic_rate=$('#rate').val();
	       basic_rate=(basic_rate=='')?0:parseFloat(basic_rate);
	       var quantity=$('#quantity').val();
	       quantity=(quantity=='')?0:parseFloat(quantity);
	       //set quantity
	       $('#show_quantity').text(quantity);
	       var include_tax=$('#rate_include').val();
	       //get gst value
	       var tax_price;
		   var gst=$('#tax_percent').val();
	       gst=(gst=='')?0:parseFloat(gst);
		   var tax=gst+100;
		   var tcs_percent=0.0;
		   let tcs_required=$('#tcs_required').val();
		   if(Number(tcs_required)==1){
			   tcs_percent=0.075;
		   }else{
			   tcs_percent=0.0;
		   }
		   
		   
		    if(include_tax=='yes'){
				   var val=basic_rate*quantity;
				   val=val.toFixed(2);
				   var gross_price=(val/tax)*100;
				   gross_price=gross_price.toFixed(2);
			       tax_price=parseFloat(gross_price/100)*gst;
			       tax_price=tax_price.toFixed(2);
			       var tcs_price=(gross_price/100)*tcs_percent;
			       var net_price=parseFloat(val)+parseFloat(tcs_price);
			       net_price=net_price.toFixed(2);
			       
		       }else{
		    	   var gross_price=basic_rate*quantity;
		    	   gross_price=gross_price.toFixed(2);
				   var tax_price=(gross_price/100)*gst;
				   tax_price=tax_price.toFixed(2);
			       var val=parseFloat(gross_price)+parseFloat(tax_price);
			       var tcs_price=(parseFloat(gross_price)/100)*tcs_percent;
			       var net_price=parseFloat(val)+parseFloat(tcs_price);
			       net_price=net_price.toFixed(2);
		       }
			   
			   tcs_price=tcs_price.toFixed(2);
		   
		   
		   var tax_group=$('#tax_group').val();
		   if(tax_group=='GST'){
	    	   $('#view_cgst').text((tax_price/2).toFixed(2));
	    	   $('#view_sgst').text((tax_price/2).toFixed(2));
	    	   $('#view_igst').text('0');
	       }else if(tax_group=='IGST'){
	    	   $('#view_cgst').text('0');
	    	   $('#view_sgst').text('0');
	    	   $('#view_igst').text(tax_price);
	       }
		   
		   
		   var word=inWords(parseInt(net_price));
	       $('#in-word').text(word);
	       $('#net_view').text(net_price);
	       $('#gross_view').text(gross_price);
	       $('#tax_view').text(tax_price);
	       $('#gross_price').val(gross_price);
	       $('#grs_ammt').val(net_price);
	       $('#net_price').val(net_price);
	       $('#tax_price').val(tax_price);
	       $('#tcs_price').val(tcs_price);
	       $('#tcs_view').text(tcs_price);
		   
		   /*console.log("Gross : "+gross_price);
		   console.log("Tax : "+tax_price);
		   console.log("Net : "+net_price);*/
	};
	
	
	//call calculate net amount
	
	$('#quantity').on('keyup blur',function(){
		calculateNetAmount();
	});
	
	
	//NOW get the balanced quantity
	
	$('#quantity').on('keyup blur',function(){
		var poi_id=$('#poi_id').val();
  		var quantity=$('#quantity').val();
  		var rate=$('#rate').val();
  		$.ajax({
  			type:'post',
  			url:'PurchaseOrderController?action=checkPOType&poi_id='+poi_id+'&quantity='+quantity,
  			headers:{
  				Accept:"application/json;charset=utf-8",
  				"Content-Type":"application/json;charset=utf-8"
  			},
  			success:function(res){
  				console.log(res);
  				$('#balanced_quantity').text(res.net_quantity);
  				if(res.order_type=='close'){
  					var quantity=$('#quantity').val();
  					quantity=(quantity=='' || quantity==undefined)?0.0:parseFloat(quantity);
  					var present_cost=parseFloat(res.invoice_amount+(rate*quantity));
  					if(quantity>res.net_quantity){
  						//$('#savebtn').prop("disabled",true);
  						$('#show-error').html("<td colspan='6' style='background-color:red;color:white;'>Total Po Quantity : "+res.order_quantity+" / Invoice Quantity : "+res.invoice_sum+" / Quantity Left : "+res.net_quantity+" Please Contact Incharge!!</td>");
  					}else if (res.credit_limit!=0 && present_cost > res.credit_limit){
  						//$('#savebtn').prop("disabled",true);
  						$('#show-error').html("<td colspan='6' style='background-color:red;color:white;'>Credit Limit : "+res.credit_limit+" /Total Invoice Amount : "+present_cost +" / Please Contact Incharge!!</td>");
  					}else{
  						//$('#savebtn').prop("disabled",false);
  						$('#show-error').html("")
  					}
  				}
  			}
  		});
	});
	
//set validation logic here
	
	var submited=false;
	$('#myform').validate({
		debug:true,
		rules:{
			plant_id:"required",
			customer_id:"required",
			site_id:"required",
			poi_id:"required",
			quantity:{
				required:true,
				number:true
			},
			invoice_date:"required",
			invoice_time:"required",
			vehicle_no:'required',
			grss:{
				required:true,
				min:1
			}
		},
		messages:{
			plant_id:"Please select plant",
			customer_id:"Please select customer",
			site_id:"Please select site",
			poi_id:"Please select grade",
			quantity:{
				required:"Please enter quantity",
				number:"Please enter valid quantity"
			},
			invoice_date:"Please select date",
			invoice_time:"Please select time",
			vehicle_no:"Please enter vehicle no",
			grss:{
				required:"Please select all above detail's to make invoice",
				min:"Net amount shouldn't be 0"
			}
		},
		submitHandler: function(form) {
		   if(submited==false){
			   //alert('submit the form');
			   form.submit();
			   submited=true;
			   console.log(submited);
		   }
		}
	});
	
	
	
	
});