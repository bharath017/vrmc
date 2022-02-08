$(document).ready(function(){
	
	$('#customer_id').on('change', function(){
		getInvoices();
	});
	

	function getInvoices(){
		var customer_id=$('#customer_id').val();
		$.ajax({
			type:'post',
			url: 'PaymentController?action=getInvoicesForPayment&customer_id='+customer_id,
			headers: {
				Accept: "application/json;charset=utf-8",
				"Content-Type" : "application/json;charset=utf-8"
			},
			success:function(res){
				$('#Table1 tbody').empty();
				var count=0;
				var slno=1;
				$.each(res,function(i,v){
					var table='<tr class="'+((v.amount-v.paid==0)?'hide':'')+'">'
						table+='<td>'+slno+'</td>'
						table+='<td>'+'CK/'+((v.plant_id==1)?"E":"N")+v.idd+'<input type="hidden" name="id['+count+']" value="'+v.id+'"/></td>'
						table+='<td>'+v.invoice_date+'</td>'
						table+='<td>'+v.overdue+'</td>'
						table+='<td>'+v.amount+'</td>'
						table+='<td>'+(v.amount-v.paid)+'<input type="hidden" class="form-control remaining" value="'+(v.amount-v.paid)+'" name="remaining['+count+']"/></td>'
						table+='<td><input type="text" class="form-control inv" placeholder="Enter Amount" name="inv_amount['+count+']"/><span class="error  valid-error"></span></td>'
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
	}
	
	
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