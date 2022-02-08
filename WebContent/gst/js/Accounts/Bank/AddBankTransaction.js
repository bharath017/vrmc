$(document).ready(function(){
	
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
			transaction_time:"required"
		},
		messages:{
			bank_id:"Select Bank",
			transaction_amount:{
				required:"Enter Amount",
				number:"Enter valid amount"
			},
			transaction_type:"Select Transaction Type",
			transaction_date:"Enter Transaction Date",
			transaction_time:"Enter Transaction Time"
		},
		submitHandler:function(form){
			if(submit==false){
				submit=true;
				form.submit();
			}
		}
	});
});