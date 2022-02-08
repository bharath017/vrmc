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
			purpose:"required",
			category_type:"required",
			category_id:"required"
		},messages:{
			plant_id:"Please select plant",
			date:"Please select payment date",
			amount:{
				required:"Please enter amount",
				number:"Please enter valid amount"
			},
			received_by:"Please select received person",
			purpose:"Please enter purpose",
			category_type:"Select Expenditure Group",
			category_id:"Select Expenditure Account"
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
        	url:'../PettyCashControllerTest?action=GetPettyCashDetails&plant_id='+$('#plant_id').val(),
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
	
	
	fetch(`../ExpenseVoucherControllerTest?action=getExpenseCategoryType`,{
		method:'post'
	}).then(response => response.json())
	  .then(text => {
		  $('#category_type').empty();
		  $('#category_type').append('<option value="" selected disabled>Selected Group</option>')
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
			 $('#category_id').append('<option value="" selected disabled></option>')
			$.each(text,function(i,v){
				$('#category_id').append(`<option value="${v.category_id}">${v.category_name}</option>`);
			});
		});
	});
	
	
});