$(document).ready(function(){
	
	//normal select and date format option here
	 $(document).ready(function() {
         $('.select2').css('width','100%').select2({allowClear:true})
			.on('change', function(){
		 }); 
         
         
         $('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true,
				"orientation":"bottom left"
		 });
			//show datepicker when clicking on the icon
			
         
         $("#id-date-picker-1").datepicker("setDate", new Date());
			$('#id-date-picker-1').datepicker({
			        "setDate": new Date(),
			        "autoclose": true,
			        "orientation":"bottom left"
		});
     });
	
	 
	 //add new Row here
	 
});




