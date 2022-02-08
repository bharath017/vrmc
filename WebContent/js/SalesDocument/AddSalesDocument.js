$(document).ready(function(){
	
	$('select').on('change', function() {  // when the value changes
	    $(this).valid(); // trigger validation on this element
	});

	
	let getTotalNetAmount=(customer_id) => {
		let invoice_date=$('input[name="invoice_date"]').val();
		fetch(`SalesDocumentController?action=getNetAmountOfPerticularCustomer&customer_id=${customer_id}&invoice_date=${invoice_date}`,{
			method:'post'
		}).then(response => response.text())
		  .then(text => {
			 let netAmount=Number(text);
			 if(netAmount>5000000){
				 $('input[name="tcs_applicable"]').prop('checked',true);
				 $('#tcs_reason').text('Tcs is applicable for this customer');
			 }else{
				 $('input[name="tcs_applicable"]').prop('checked',false);
				 $('#tcs_reason').empty();
			 }
		  });
	}
	
	
	$('#selectall').on("change",function(){
		if($(this).is(":checked")){
			$('.id').prop("checked",true);
			$('.idcls:checkbox').each(function(){
			});
			
		}else{
			$('.id').prop("checked",false);
		}
		arrengItems();
	});
	
	$('#customer_id').on('change',function(){
		var customer_id=$('#customer_id').val();
		getTotalNetAmount(customer_id);
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
	
	$('input[name="invoice_date"]').on('change blur',function(){
		let customer_id=$('#customer_id').val();
		if(customer_id)
			getTotalNetAmount(customer_id);
	});
	
	
	
	//get last invoice no here
	var getInvoice=function(){
		var plant_id=$('#plant_id').val();
			$.ajax({
				type:'post',
				url:'SalesDocumentController?action=getInvoiceNo&plant_id='+plant_id,
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
				$('#site_name_disp').text(result.site_address);
				getPendingDC();
				$.ajax({
					type:'post',
					url:'PurchaseOrderController?action=GetGradeList&site_id='+site_id+'&plant_id='+plant_id,
					headers:{
						Accept:"application/json;charset=utf-8",
						"Content-Type":"application/json;charset=utf-8"
					},
					success:function(res){
						setFirstValue();
						$('.poi_id').each(function(){
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
	
	var dc_data='';
	
	var getPendingDC=function(){
		var site_id=$('#site_id').val();
		var plant_id=$('#plant_id').val();
		var customer_id=$('#customer_id').val();
		$.ajax({
			type:'post',
			url:'DCController?action=getPendingDC&customer_id='+customer_id+'&site_id='+site_id+'&plant_id='+plant_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(res){
				dc_data='';
				dc_data=res;
				var html='';
				$('#example2').remove();
				$('#view-table tbody').empty();
						$.each(res, function(index, value) {
							html+=`<tr>
										<td>
										<input type="hidden" title="dc_id" class="dc_id" name="dc_id[${index}]" value="${value.dc_id}"/>
										<input type="hidden" name="product_name" class="product_name" value="${value.product_name}"/>
										<input type="hidden" name="poi_id" class="poi_id" value="${value.poi_id}"/>
										<input type="hidden" name="rate" class="rate" value="${value.rate}"/>
										<input type="hidden" name="quantity" class="quantity" value="${value.quantity}"/>
										<input type="hidden" name="net_amount" class="net_amount" value="${value.net_amount}"/>
										<input type="hidden" name="rate_include_tax" class="rate_include_tax" value="${value.rate_include_tax}"/>
										<input type="hidden" name="gst_percent" class="gst_percent" value="${value.gst_percent}"/>
										<input type="hidden" name="gst_category" class="gst_category" value="${value.gst_category}"/>
										${value.invoice_id}
										</td>
										<td>${value.invoice_date}</td>
										<td>${value.product_name}</td>
										<td>${value.quantity}</td>
										<td>${value.net_amount}</td>
										<td><input type="checkbox" class="id idcls" name="dc_id" value="${value.dc_id}"/></td>
									</tr>`
						});
					
				$('#view-table tbody').append(html);
			}
		});
	}
	
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
		var html = `<tr>
			<td>
				<select  class="form-control poi_id" required="required" title="poi_id" name="poi_id[${rowNumber}]">
			
				</select>
			</td>
			
			<td>
				<input type="text" class="form-control rate"  pattern="[^\&quot;:]*$"  title="rate" required="required" readonly style="background-color:white;" placeholder="Fetch Rate"   name="rate[${rowNumber}]"/>
			</td>
			<td style="width:12%">
				<input type="text" class="form-control quantity" pattern="[^\&quot;:]*$" title="quantity"  required="required" placeholder="Enter Quantity"  name="quantity[${rowNumber}]"/>
			</td>
			<td style="width:12%">
				<input type="text" class="form-control gst_percent" readonly pattern="[^\&quot;:]*$" title="gst_percent" required="required"  name="gst_percent[${rowNumber}]"/>
				<input type="hidden" name="gst[${rowNumber}]" class="gst" title="gst"/>
				<input type="hidden" name="rate_include_tax[${rowNumber}]" class="rate_include_tax" title="rate_include_tax"/>
			</td>
	        <td>
	            <input class="form-control gross_amount" name="gross_amount[${rowNumber}]" title="gross_amount" readonly="readonly" type="text"> 
	         </td>
	         <td>
		 		<input class="form-control tax_amount" name="tax_amount[${rowNumber}]" title="tax_amount" readonly="readonly" type="text"> 
		 	 </td>
		 	 <td>
				<input type="text" class="form-control tcs_amount" title="tcs_amount"  readonly="readonly"
						 pattern="[^\'&quot;:]*$"  required="required"   name="tcs_amount[${rowNumber}]"/>
			</td>
	         <td>
	            <input class="form-control net_amount" name="net_amount[${rowNumber}]" title="net_amount"  readonly="readonly" type="text"> 
	         </td>
			<td>
				<span class="text-danger removebtn"><i class="fa fa-trash"></i></span>
			</td>
		</tr>`
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
				$(this).find('select[title="poi_id"]').attr('name','poi_id['+i+']');
				$(this).find('input[title="quantity"]').attr('name','quantity['+i+']');
				$(this).find('input[title="rate"]').attr('name','rate['+i+']');
				$(this).find('input[title="gst_percent"]').attr('name','gst_percent['+i+']');
				$(this).find('input[title="gst"]').attr('name','gst['+i+']');
				$(this).find('input[title="rate_include_tax"]').attr('name','rate_include_tax['+i+']');
				$(this).find('input[title="gross_amount"]').attr('name','gross_amount['+i+']');
				$(this).find('input[title="tax_amount"]').attr('name','tax_amount['+i+']');
				$(this).find('input[title="net_amount"]').attr('name','net_amount['+i+']');
				$(this).find('input[title="tcs_amount"]').attr('name','tcs_amount['+i+']');
			});
		}
		let count=$('#Table1 tbody tr').length;
		$('#count').val(count);
	};
	
	myFunc();
	
	$('.BtnPlus').on('click',function(){
		var rowNumber=$('#Table1 tbody tr').length;
		addNewRow(rowNumber)
	});
	
	
	
	$(document).on('click','#view-table .idcls',function(){
		arrengItems();
	});
	
	
	
	let arrengItems=function(){
		$('#Table1 tbody').empty();
		$('#view-table tbody tr').find('.idcls:checked').each(function(){
			let poi_id=$(this).closest('tr').find('.poi_id').val();
			let rate=$(this).closest('tr').find('.rate').val();
			let rate_include_tax=$(this).closest('tr').find('.rate_include_tax').val();
			let gst_percent=$(this).closest('tr').find('.gst_percent').val();
			let gst_category=$(this).closest('tr').find('.gst_category').val();
			let product_name=$(this).closest('tr').find('.product_name').val();
			let quantity=$(this).closest('tr').find('.quantity').val();
			console.log(rate);
			let length=$('#Table1 tbody tr').length;
			let old_poi_id=$('#Table1 tbody tr').eq(0).find('.poi_id').val();
			
			if(length==0){
				var html = `<tr>
					<td>
						<select  class="form-control poi_id" required="required" title="poi_id" name="poi_id[${rowNumber}]">
							<option value="${poi_id}" selected>${product_name}</option>
						</select>
					</td>
					
					<td>
						<input type="text" class="form-control rate" value="${rate}"  pattern="[^\&quot;:]*$"  title="rate" required="required" readonly style="background-color:white;" placeholder="Fetch Rate"   name="rate[${rowNumber}]"/>
					</td>
					<td style="width:12%">
						<input type="text" class="form-control quantity" value="${quantity}" pattern="[^\&quot;:]*$" title="quantity"  required="required" placeholder="Enter Quantity"  name="quantity[${rowNumber}]"/>
					</td>
					<td style="width:12%">
						<input type="text" class="form-control gst_percent" readonly pattern="[^\&quot;:]*$"
							 value="${gst_category} @ ${gst_percent}%"	title="gst_percent" required="required"  name="gst_percent[${rowNumber}]"/>
						<input type="hidden" name="gst[${rowNumber}]" 
							 value="${gst_percent}"	class="gst" title="gst"/>
						<input type="hidden" name="rate_include_tax[${rowNumber}]"
							 value="${gst_category}" class="rate_include_tax" title="rate_include_tax"/>
					</td>
			        <td>
			            <input class="form-control gross_amount"
								name="gross_amount[${rowNumber}]" title="gross_amount" readonly="readonly" type="text"> 
			         </td>
			         <td>
				 		<input class="form-control tax_amount" name="tax_amount[${rowNumber}]" title="tax_amount" readonly="readonly" type="text"> 
				 	 </td>
				 	 <td>
						<input type="text" class="form-control tcs_amount" title="tcs_amount"  readonly="readonly"
								 pattern="[^\'&quot;:]*$"  required="required"   name="tcs_amount[${rowNumber}]"/>
					</td>
			         <td>
			            <input class="form-control net_amount" name="net_amount[${rowNumber}]" title="net_amount"  readonly="readonly" type="text"> 
			         </td>
					<td>
						<span class="text-danger removebtn"><i class="fa fa-trash"></i></span>
					</td>
				</tr>`
				$('#Table1 tbody').append(html);
				manageRow();
			}else{
				let data=findPOIIdExistance(poi_id);
				if(data.returnValue){
					let old_quantity=$('#Table1 tbody tr').eq(data.posFound).find('.quantity').val();
					let new_quantity=Number(old_quantity)+Number(quantity);
					$('#Table1 tbody tr').eq(data.posFound).find('.quantity').val(new_quantity);
				}else{
					var rowNumber=$('#Table1 tbody tr').length;
					var html = `<tr>
						<td>
							<select  class="form-control poi_id" required="required" title="poi_id" name="poi_id[${rowNumber}]">
								<option value="${poi_id}" selected>${product_name}</option>
							</select>
						</td>
						
						<td>
							<input type="text" class="form-control rate" value="${rate}"  pattern="[^\&quot;:]*$"  title="rate" required="required" readonly style="background-color:white;" placeholder="Fetch Rate"   name="rate[${rowNumber}]"/>
						</td>
						<td style="width:12%">
							<input type="text" class="form-control quantity" value="${quantity}" pattern="[^\&quot;:]*$" title="quantity"  required="required" placeholder="Enter Quantity"  name="quantity[${rowNumber}]"/>
						</td>
						<td style="width:12%">
							<input type="text" class="form-control gst_percent" readonly pattern="[^\&quot;:]*$"
								 value="${gst_category} @ ${gst_percent}%"	title="gst_percent" required="required"  name="gst_percent[${rowNumber}]"/>
							<input type="hidden" name="gst[${rowNumber}]" 
								 value="${gst_percent}"	class="gst" title="gst"/>
							<input type="hidden" name="rate_include_tax[${rowNumber}]"
								 value="${gst_category}" class="rate_include_tax" title="rate_include_tax"/>
						</td>
				        <td>
				            <input class="form-control gross_amount"
									name="gross_amount[${rowNumber}]" title="gross_amount" readonly="readonly" type="text"> 
				         </td>
				         <td>
					 		<input class="form-control tax_amount" name="tax_amount[${rowNumber}]" title="tax_amount" readonly="readonly" type="text"> 
					 	 </td>
					 	 <td>
							<input type="text" class="form-control tcs_amount" title="tcs_amount"  readonly="readonly"
									 pattern="[^\'&quot;:]*$"  required="required"   name="tcs_amount[${rowNumber}]"/>
						</td>
				         <td>
				            <input class="form-control net_amount" name="net_amount[${rowNumber}]" title="net_amount"  readonly="readonly" type="text"> 
				         </td>
						<td>
							<span class="text-danger removebtn"><i class="fa fa-trash"></i></span>
						</td>
					</tr>
					`
					$('#Table1 tbody').append(html);
					manageRow();
				}
			}
		});
		calculateAmount();
	}
	
	let findPOIIdExistance = function(poi_id){
		let returnValue=false;
		let posFound=-1;
		let count=0;
		$('#Table1 tbody tr').each(function(){
			let old_poi_id=$(this).closest('tr').find('.poi_id').val();
			if(old_poi_id==poi_id){
				returnValue=true;
				posFound=count;
			}
			count++;	
		});
		
		let data={
				"returnValue":returnValue,
				"posFound":posFound
		}
		console.log(data);
		return data;
	}
	
	
	let setFirstValue=function(){
		var rowNumber=$('#Table1 tbody tr').length;
		let html=`<tr>
			<td>
				<select required="required"  name="poi_id[0]" 
						  class="form-control poi_id" title="poi_id"  data-placeholder="Choose Item">
				</select>	
			</td>
			<td>
				<input type="number" class="form-control rate" 
	     			pattern="[^'&quot;:]*$" required="required" style="background-color: white;"
	     			 placeholder="Fetch Rete" readonly="readonly"  title="rate"  name="rate[0]"/>
			</td>
			<td>
				<input type="text" class="form-control quantity" 
	    			 pattern="[^'&quot;:]*$"  required="required" title="quantity"  placeholder="Enter Quantity" name="quantity[0]"/>
			</td>
			<td>
				<input type="text" class="form-control gst_percent" title="gst_percent" 
						 pattern="[^\'&quot;:]*$" readonly="readonly"  required="required" name="gst_percent[0]"/>
				<input type="hidden" name="gst[0]" class="gst" title="gst"/>
				<input type="hidden" name="rate_include_tax[0]" class="rate_include_tax" title="rate_include_tax"/>
			</td>
			<td>
				<input type="text" class="form-control gross_amount" title="gross_amount" pattern="[^\'&quot;:]*$"
						 readonly="readonly"  required="required" name="gross_amount[0]"/>
			</td>
			<td>
				<input type="text" class="form-control tax_amount" title="tax_amount"  readonly="readonly"
						 pattern="[^\'&quot;:]*$"  required="required"   name="tax_amount[0]"/>
			</td>
			<td>
				<input type="text" class="form-control tcs_amount" title="tcs_amount"  readonly="readonly"
						 pattern="[^\'&quot;:]*$"  required="required"   name="tcs_amount[0]"/>
			</td>
			<td>
				<input type="text" class="form-control net_amount" title="net_amount"  readonly="readonly"
						 pattern="[^\'&quot;:]*$"  required="required"   name="net_amount[0]"/>
			</td>
			<td></td>
		</tr>`
		$('#Table1 tbody').html(html);
		manageRow();
	}
	
	
	
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