  $(document).ready(function() {
                $('form').parsley();
                
                $('.select2').css('width','100%').select2({allowClear:true})
				.on('change', function(){
				}); 
                
           $('#plant_id').on('change',function(){
        	   var plant_id=$('#plant_id').val();
        	   getMoistureDetails(plant_id); 
           }) ;    
              
                
                
                
});
  
  function getMoistureDetails(plant_id){
	  $.ajax({
		  type: "POST",
		  url: "SettingController?action=getMoistureDetails&plant_id="+plant_id,
		  headers:{
			  Accept: "application/json;charset=utf-8",
			  "Content-Type" : "application/json; charset=utf8"
		  },
		  success: function(result){
			 $('#aggr1_moi').val(result.aggr1_moi);
			 $('#aggr2_moi').val(result.aggr2_moi);
			 $('#aggr3_moi').val(result.aggr3_moi);
			 $('#aggr4_moi').val(result.aggr4_moi);
			 $('#aggr1_abs').val(result.aggr1_abs);
			 $('#aggr2_abs').val(result.aggr2_abs);
			 $('#aggr3_abs').val(result.aggr3_abs);
			 $('#aggr4_abs').val(result.aggr4_abs);
			 $('#update_plant_id').val(plant_id);
		  }
	  })
  }