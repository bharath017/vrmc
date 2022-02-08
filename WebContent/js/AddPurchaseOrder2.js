$(document).ready(function(){
	
	//normal select and date format option here
	 $(document).ready(function() {
         $('form').parsley();
         
         $('.select2').css('width','100%').select2({allowClear:true})
			.on('change', function(){
			}); 
         
         
         $('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
		 });
			//show datepicker when clicking on the icon
			
         
         $("#id-date-picker-1").datepicker("setDate", new Date());
			$('#id-date-picker-1').datepicker({
			        "setDate": new Date(),
			        "autoclose": true
		});
     });
	
	 
	 //add new Row here
	 
	 
		 
	
	 //Getting Address details here
	$('#customer_id').on('change',function(){
		var customer_id=$('#customer_id').val();
		$.ajax({
			type:'POST',
			url:'../CustomerControllerTest?action=getCustomerSiteDetails&customer_id='+customer_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(result){
				$('#select2-site_id-container').html('Choose Site Address');
				$('#site_id').html('');
        		$('#site_id').html('<option value="">Choose Site Address.</option>');
        		$.each(result, function(index, value) {
        			   $('#site_id').append("<option value='"+ value.site_id+ "'>" + value.site_name + "</option>");
        		});
        		
			}
		});
	});
});




