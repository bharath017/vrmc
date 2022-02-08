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
	
	
	
	var submit=false;
	$('#myform').validate({
		debug:false,
		rules:{
			plant_id:"required",
			date:"required",
			amount:{
				required:true,
				number:true
			},
			received_by:"required",
			purpose:"required"
		},messages:{
			plant_id:"Please select plant",
			date:"Please select payment date",
			amount:{
				required:"Please enter amount",
				number:"Please enter valid amount"
			},
			received_by:"Please select received person",
			purpose:"Please enter purpose"
		},
		submitHandler:function(form){
			if(submit==false){
				form.submit();
				submit=true;
			}
		}
	});
	
	
	var getPettyCashDetails=function(){
    	$.ajax({
        	type:'post',
        	url:'PettyCashController?action=GetPettyCashDetails&plant_id='+$('#plant_id').val(),
        	headers:{
        		Accept:"application/json;charset=utf-8",
        		"Content-Type":"application/json;charset=utf-8"
        	},
        	success:function(res){
        		$('#petty-cash-amount').text(res.totalpettycash);
        		$('#transaction-amount').text(res.totaltrans);
        		console.log(res.totalpettycash-res.totaltrans);
        		console.log('coming hre');
        		$('#remaining-amount').text(res.totalpettycash-res.totaltrans);
        	}
        });
    }
	$('#plant_id').on('change',function(){
		getPettyCashDetails();
	});
	getPettyCashDetails();
	
	
});