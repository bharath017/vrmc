$(document).ready(function(){
	
	
	//get last invoice no here
	var getInvoice=function(){
		var plant_id=$('#plant_id').val();
			$.ajax({
				type:'post',
				url:'DCController?action=getInvoiceNo&plant_id='+plant_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					$('#invoice_no').val(parseInt(res));
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
			}
		})
	});
	
	
	
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
	       quantity=(quantity=='')?0:parseFloat(quantity/1000);
	       //set quantity
	       $('#show_quantity').text(quantity);
	       var include_tax=$('#rate_include').val();
	       //get gst value
	       var tax_price;
		   var gst=$('#tax_percent').val();
	       gst=(gst=='')?0:parseFloat(gst);
		   var tax=gst+100;
		   
		   if(include_tax=='yes'){
	    	   var net_price=basic_rate*quantity;
			   net_price=net_price.toFixed(2);
			   var gross_price=(net_price/tax)*100;
			   gross_price=gross_price.toFixed(2);
		       tax_price=parseFloat(gross_price/100)*gst;
		       tax_price=tax_price.toFixed(2);
	       }else{
	    	   var gross_price=basic_rate*quantity;
	    	   gross_price=gross_price.toFixed(2);
			   var tax_price=(gross_price/100)*gst;
			   tax_price=tax_price.toFixed(2);
		       net_price=parseFloat(gross_price)+parseFloat(tax_price);
	       }
		   
		   
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
  		$.ajax({
  			type:'post',
  			url:'PurchaseOrderController?action=checkPOType&poi_id='+poi_id+'&quantity='+quantity,
  			headers:{
  				Accept:"application/json;charset=utf-8",
  				"Content-Type":"application/json;charset=utf-8"
  			},
  			success:function(res){
  				console.log(res.order_quantity);
  				$('#balanced_quantity').text(res.net_quantity);
  				if(res.order_type=='close'){
  					var quantity=$('#quantity').val();
  					quantity=(quantity=='' || quantity==undefined)?0.0:parseFloat(quantity);
  					if(quantity>res.net_quantity){
  						$('#savebtn').prop("disabled",true);
  						$('#show-error').html("<td colspan='6' style='background-color:red;color:white;'>Total Po Quantity : "+res.order_quantity+" / Invoice Quantity : "+res.invoice_sum+" / Quantity Left : "+res.net_quantity+" Please Contact Incharge!!</td>");
  					}else{
  						$('#savebtn').prop("disabled",false);
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
	
	
	var calculateWeight=function(){
  		var empty_weight=$('#empty_weight').val();
  		empty_weight=(empty_weight=='')?0.0:parseFloat(empty_weight);
  		var loaded_weight=$('#loaded_weight').val();
  		loaded_weight=(loaded_weight=='')?0.0:parseFloat(loaded_weight);
  		var quantity=loaded_weight-empty_weight;
  		console.log(quantity);
  		$('#net_weight').val(quantity);
  	}
	
	
	$('#loaded_weight').on('blur keyup',function(){
		calculateWeight();
	});
	
	$('#empty_weight').on('blur keyup',function(){
		calculateWeight();
	});
	
	
});