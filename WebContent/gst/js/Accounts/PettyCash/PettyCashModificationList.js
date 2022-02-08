$(document).ready(function(){

	var session=getSessionDetails();
	
	//console.log(session_plant);
	
	//Date picker is here
	$('.date-picker').datepicker({
		autoclose: true,
		todayHighlight: true,
		"orientation": "bottom left"
 	});
	

	
	$('.picker').on('click',function(){
		$(this).prev("input.date-picker").datepicker("show");
	});
	
	$('.select2').css('width','100%').select2({allowClear:true})
		.on('change', function(){
	});
	
	
	
	var table =   $('#example').DataTable({
		"order": [],
        "info":true,
        "scrollX":true,
        "processing":true,
        "serverSide" : true,
        "iDisplayLength":10,
        "lengthMenu":[10,20,25,50,75,100],
        "ordering":false,
        "searching":true,
        lengthChange: true,
        "ajax":{
        	url:"../PettyCashControllerTest?action=PettyCashModificationList",
        	type:"POST",
        	 data 	: function ( d ) {
	                  return $.extend( {}, d, {
	                  });
	              },
        	error:function(){
        	}
        },
        "columnDefs":[
        	{"targets":[0],"data":"cash_id"},
        	{"targets":[1],"data":"date"},
        	{"targets":[2],"data":"amount"},
        	{"targets":[3],"data":"new_amount"},
        	{"targets":[4],"data":"modified_by"},
        	{"targets":[5],"data":"modification_timestamp"},
        	{"targets":[6],"data":"plant_name"},
        	{"targets":[7],"data":"modification_type"}
        ]
    });
	
    
    $('#search').on( 'click', function () {
		 table.draw();
    } );
    
    $('#clear').on('click',function(){
    	$('#clear-form').trigger('reset');
    	table.draw();
    });
    
    
    
});