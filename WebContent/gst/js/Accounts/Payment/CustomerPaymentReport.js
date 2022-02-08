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
		
	/*TIME PICKER START'S HERE*/
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
	
	$('#get-from_date').on('click',function(){
		 $('#id-date-picker-1').datepicker('show');
	});
		
	$('#get-to_date').on('click',function(){
	  $('#id-date-picker-2').datepicker('show');
	});
	
	
	
	var getCustomerListByBusinessGroup=function(business_id){
		$.ajax({
			type:'post',
			url:'../CustomerControllerTest?action=getCustomerListByBusinessGroup&business_id='+business_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(res){
				$('#customer_id').empty();
				$('#customer_id').append('<option value="0" selected >All Customer</option>');
				$('#select2-customer_id-container').text('All Customer');
				$.each(res,function(i,v){
					$('#customer_id').append('<option value="'+v.customer_id+'">'+v.customer_name+'</option>');
				});
				
			}
		});
	}
	
	
	var business_id=$('#business_id').val();
	getCustomerListByBusinessGroup(business_id);
	
	$('#business_id').on('change',function(){
		var business_id=$('#business_id').val();
		getCustomerListByBusinessGroup(business_id);
	});
	
});