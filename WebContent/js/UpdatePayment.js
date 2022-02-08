$(document).ready(function(){
	
	
	var customer_id=$('#customer_id').val();
	var payment_id=$('#update_payment').val();
	$.ajax({
		type:'post',
		url: 'PaymentController?action=getInvoicesForPaymentUpdate&customer_id='+customer_id+"&payment_id="+payment_id,
		headers: {
			Accept: "application/json;charset=utf-8",
			"Content-Type" : "application/json;charset=utf-8"
		},
		success:function(res){
			$('#Table1 tbody').empty();
			var count=0;
			var slno=1;
			$.each(res,function(i,v){
				var table='<tr class="'+((v.payidd!=payment_id)?((v.payidd==0)?'':''):'')+'">'
					table+='<td>'+slno+'</td>'
					table+='<td>'+'CK/'+((v.plant_id==1)?"E":"N")+v.idd+'<input type="hidden" name="id['+count+']" value="'+v.id+'"/></td>'
					table+='<td>'+v.invoice_date+'</td>'
					table+='<td>'+v.overdue+'<input type="hidden" name="payidd['+count+']" value="'+v.payidd+'"/></td>'
					table+='<td>'+v.amount+'<input type="hidden" name="payid['+count+']" value="'+v.payid+'"/></td>'
					table+='<td>'+(v.amount-v.paid)+'<input type="number" class="form-control remaining"  value="'+(v.amount-v.paid)+'" name="remaining['+count+']"/></td>'
					table+='<td><input type="text" class="form-control inv" placeholder="Enter Amount" value="'+(v.paid)+'" name="inv_amount['+count+']"/><span class="error  valid-error"></span></td>'
					table+='</tr>'
				$('#Table1 tbody').append(table);
				count++;
				slno++;
			});
			//get advance payment
			var cnt=$('#Table1 tbody tr').length;
			$('#count').val(cnt);
		},
		error:function(error){
		}
	});
	
	
	
	
	//add money on calculation
	var syncOnAddPayment=function(){
		var payment_amount=$('#payment_amount').val();
		payment_amount=(payment_amount=='')?0:parseFloat(payment_amount);
		//add advance amount if checked
		$('.inv').each(function(){
			if(payment_amount>0){
				var inv_amount=$(this).closest('tr').find('.remaining').val();
				//convert to parseFloat
				inv_amount=parseFloat(inv_amount);
				var paid=(payment_amount-inv_amount)>0?inv_amount:payment_amount;
				$(this).closest('tr').find('.inv').val(paid);
				payment_amount=(payment_amount-inv_amount)>0?(payment_amount-inv_amount):0;
			}
		});
	}
	
	//keyup for synching
	$('#payment_amount').on('keyup blur',function(){
		$('.inv').each(function(){
			$(this).val('');
		});
		syncOnAddPayment();
	});
	
	//grn entry synching
	$(document).on('keyup blur','#Table1 .inv',function(){
		twoWaySync();
		validationSync(this);
	});
	
	
	//two way synching function
	var twoWaySync=function(){
		var payment_amount=0;
		var advance_amount=0;
		$('.inv').each(function(){
			var amount=($(this).val()==undefined || $(this).val()=='' || $(this).val()==null)?0:$(this).val();
			payment_amount+=parseFloat(amount);
		});
		
		$('#payment_amount').val((payment_amount<0)?0:payment_amount);
	}
	
	//two way sync validation
	var validationSync=function(e){
		var entered=$(e).closest('tr').find('.inv').val();
		var remaining=$(e).closest('tr').find('.remaining').val();
		if(parseFloat(remaining)-parseFloat(entered)<0){
			$(e).closest('tr').find('.valid-error').text('Excess entry amount');
			$('#savebtn').prop('disabled',true);
		}else{
			$(e).closest('tr').find('.valid-error').text('');
			$('#savebtn').prop('disabled',false);
		}
	}
	
	
});