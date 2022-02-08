$(document).ready(function(){
	
	var session=getSessionDetails();
	
	var submit=false;
	$('#myForm').validate({
		debug:false,
		rules:{
			bank_id:"required",
			transaction_amount:{
				required:true,
				number:true
			},
			transaction_type:"required",
			transaction_date:"required",
			transaction_time:"required",
			category_id:"required"
		},
		messages:{
			bank_id:"Select Bank",
			transaction_amount:{
				required:"Enter Amount",
				number:"Enter valid amount"
			},
			transaction_type:"Select Transaction Type",
			transaction_date:"Enter Transaction Date",
			transaction_time:"Enter Transaction Time",
			category_id:"Select Expenditure Account"
		},
		submitHandler:function(form){
			if(submit==false){
				submit=true;
				form.submit();
			}
		}
	});
	
	
	$('#transaction_type').on('change',function(){
		var transaction_type=$('#transaction_type').val();
		console.log(transaction_type);
		changeType(transaction_type);
	});
	
	var changeType=function(type){
		console.log(type);
		if(type=='cuspay'){
			$('#customer_id_view').show();
			$('#customer_id').show();
			$('#customer_id').prop('disabled',false);
			
			$('#supplier_id_view').hide();
			$('#supplier_id').hide();
			$('#supplier_id').prop('disabled',true);
			
			$('#category_type').val("Sales");
			$('#category_type').trigger("change");
		}else if(type=='suppay'){
			$('#supplier_id_view').show();
			$('#supplier_id').show();
			$('#supplier_id').prop('disabled',false);
			
			$('#customer_id_view').hide();
			$('#customer_id').hide();
			$('#customer_id').prop('disabled',true);
			
			$('#category_type').val("PURCHASE");
			$('#category_type').trigger("change");
		}else{
			$('#customer_id_view').hide();
			$('#customer_id').hide();
			$('#customer_id').prop('disabled',true);
			
			$('#supplier_id_view').hide();
			$('#supplier_id').hide();
			$('#supplier_id').prop('disabled',true);
		}
	}
	
	
	
	
	//load bank detail by payment type
	let getBankDetailsByBusinessGroupAndType=function(){
		let payment_type=$('#payment_type').val();
		let group_name='';
		console.log('hello world');
		if(payment_type=='CASH')
			group_name='cash'
		else if(payment_type=='CHEQUE/DD' || payment_type=='CHEQUE/DD' || 
					payment_type=='NEFT/RTGS' || payment_type=='BANK_TRANSFER' || payment_type=='CREDIT_CARD')
			group_name='bank'
		else
			group_name='other'
			
			
		$.ajax({
			type:'post',
			url:'../BankDetailController?action=getBankDetailByBankGroup&group_name='+group_name+'&business_id='+session.business_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(res){
					$('#bank_id').empty();
				$.each(res,function(i,v){
					$('#bank_id').append('<option value="'+v.bank_detail_id+'">'+v.bank_name+'</option>');
				});
			}
		});
	}
	
	getBankDetailsByBusinessGroupAndType();
	
	$('#payment_type').on('change',function(){
		getBankDetailsByBusinessGroupAndType();
	});
	
	
	//enable disable payment type
	$('#payment_type').on('change',function(){
		var payment_type=$('#payment_type').val();
		if(payment_type=='CHEQUE/DD'){
			$('.pt').prop('disabled',false);
			$('.neft').prop('disabled',true);
		}else if(payment_type=='NEFT/RTGS'){
			$('.pt').prop('disabled',true);
			$('.neft').prop('disabled',false);
		}else{
			$('.pt').prop('disabled',true);
			$('.neft').prop('disabled',true);
		}
	});
	
	
	fetch(`../ExpenseVoucherControllerTest?action=getExpenseCategoryType`,{
		method:'post'
	}).then(response => response.json())
	  .then(text => {
		  $('#category_type').empty();
		  $('#category_type').append('<option value="" selected disabled>Selected Group</option>');
		 $.each(text,function(i,v){
			$('#category_type').append(`<option value="${v}">${v}</option>`); 
		 }); 
	});
	
	
	$('#category_type').on('change',function(){
		let category_type=$('#category_type').val();
		fetch(`../ExpenseVoucherControllerTest?action=getCategoryList&category_type=${category_type}`,{
			method:'post'
		}).then(response => response.json())
		  .then(text => {
			$('#category_id').empty();
			 $('#category_id').append('<option value="" selected disabled>Selected Sub Group</option>')
			$.each(text,function(i,v){
				$('#category_id').append(`<option value="${v.category_id}">${v.category_name}</option>`);
			});
		});
	});
	
	
	
});