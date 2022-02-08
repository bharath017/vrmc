$(document).ready(function(){
	
	//common setting goes here
	 $('.select2').css('width','100%').select2({allowClear:true})
		.on('change', function(){
	 });
	 
	 $('.date-picker').datepicker({
			autoclose: true,
			todayHighlight: true,
			"orientation":"bottom left"
	 }).on('changeDate', function(ev) {
	        $(this).valid();  // triggers the validation test
	        // '$(this)' refers to '$("#datepicker")'
	    });;
 
   $("#id-date-picker-1").datepicker();
		$('#id-date-picker-1').datepicker({
		        "autoclose": true,
		        "orientation":"bottom left"
	}).on('changeDate', function(ev) {
       $(this).valid();  // triggers the validation test
       // '$(this)' refers to '$("#datepicker")'
   });;
		
	$('.picker').on('click',function(){
		$(this).prev("input.date-picker").datepicker("show");
	});
	
	$('select').on('change', function() {  // when the value changes
	    $(this).valid(); // trigger validation on this element
	});
	
	
	$('#timepicker1').timepicker({
		minuteStep: 1,
		showSeconds: true,
		showMeridian: false,
		disableFocus: true,
		icons: {
			up: 'fa fa-chevron-up',
			down: 'fa fa-chevron-down'
		}
	}).on('focus', function() {
		$('#timepicker1').timepicker('showWidget');
	}).next().on('click', function(){
		$(this).prev().focus();
	});
	
	
	//disable if payment mode is not cheque/dd
	$('#payment_mode').on('change',function(){
		changeMode();
	});
	
	var changeMode=function(){
		var payment_type=$('#payment_mode').val();
		if(payment_type=='CHEQUE/DD'){
			$('.pt').prop('disabled',false);
		}else{
			$('.pt').prop('disabled',true);
		}
	}
	changeMode();
	
	
	//get credit balance detail's
	$('#supplier_id').on("change",function(){
		var supplier_id=$('#supplier_id').val();
		$.ajax({
			type:'POST',
			url:'MakePaymentController?action=checkBalance&supplier_id='+supplier_id,
			headers:{
				Accept:"text/html;charset=utf-8",
				"Content-Type":"text/html;charset=utf-8"
			},
			success:function(res){
				$('#credit_balance').text(res.toFixed(2));
			}
		});
	});
	
	
	//validate make payment form
	
	
	var submit=false;
	$('#myform').validate({
		debug:false,
		rules:{
			supplier_id:"required",
			payment_amount:{
				required:true,
				number:true
			},
			payment_date:"required",
			payment_mode:"required"
		},
		messages:{
			supplier_id:"Please select supplier",
			payment_amount:{
				required:"Please enter amount",
				number:"Please enter valid value for amount"
			},
			payment_date:"Please enter payment date",
			payment_mode:"Please select payment type"
		},
		submitHandler:function(form){
			if(submit==false){
				form.submit();
				submit=true;
			}
		}
	});
	
	
	
});
