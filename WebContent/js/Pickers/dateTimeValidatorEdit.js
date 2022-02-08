 $(document).ready(function() {
	 	
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
		
	 
         $('.select2').css('width','100%').select2({allowClear:true})
			.on('change', function(){
		 }); 
         
         

			
        
         $('.date-picker').datepicker({
        	    "autoclose": true,
				todayHighlight: true,
				"orientation":"bottom left"
		 });
         
         $("#id-date-picker-1").datepicker();
			$('#id-date-picker-1').datepicker({
			        "autoclose": true,
			        "orientation":"bottom left"
		});
         
		
		$('.picker').on('click',function(){
			$(this).prev("input.date-picker").datepicker("show");
		});
		
 });
	





