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
        "searching":false,
        "dom": 'Blfrtip',
        "buttons": [
            'copyHtml5',
            'excelHtml5',
            'csvHtml5',
            'pdfHtml5'
        ],
        lengthChange: true,
        "ajax":{
        	url:"PettyCashController?action=GetPettyCashList",
        	type:"POST",
        	 data 	: function ( d ) {
	                  return $.extend( {}, d, {
	                	  cash_id:$('#cash_id').val(),
	                	  plant_id:$('#plant_id').val(),
	                	  from_date:$('#from_date').val(),
	                	  to_date:$('#to_date').val()
	                  });
	              },
        	error:function(){
        	}
        },
        "columnDefs":[
        	{"targets":[0],"data":"cash_id"},
        	{"targets":[1],"data":"date"},
        	{"targets":[2],"data":"amount"},
        	{"targets":[3],"data":"received_by"},
        	{"targets":[4],"data":"purpose"},
        	{"targets":[5],"data":"plant_name"},
        	{"targets":[6],"data":function(data){
        		return data;
        	},
        	"render":function(data,row){
        		html='';
        		html+='<div class="btn-group dropdown">';
                html+='<a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>'
                	html+='<div class="dropdown-menu dropdown-menu-right">'
                		if((session.usertype=='superadmin' || session.usertype=='admin') && data.approve_status=='pending')
                			html+='<a class="dropdown-item" href="AddPettyCash.jsp?action=update&cash_id='+data.cash_id+'"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Edit Petty Cash</a>';
                		if(data.approve_status=='pending')
                			html+='<a class="dropdown-item delete-payment-details" name="'+data.cash_id+'"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>Delete Petty Cash</a>';
                    html+='</div>'
            html+='</div>'
                 return html;
        	}}  	 
        ],
        "fnRowCallback": function( row, data, dataIndex) {
        	if(data.approve_status=='pending'){
        		 $( row ).css( "background-color", "#f5cdae" );
                 $( row ).addClass( "warning" );
        	}        
        }
    });
	
    
    $('#search').on( 'click', function () {
		 table.draw();
    } );
    
    $('#clear').on('click',function(){
    	$('#clear-form').trigger('reset');
    	table.draw();
    });
    
    $(document).on('click','#example .delete-payment-details',function(){
    	$('.cash_id-delete').text($(this).attr('name'));
    	$('.cash_id-delete').val($(this).attr('name'));
    	Custombox.open({
    		target:'#dele-model',
    		effect:'blur'
    	});
    });
    
    $('#delete-btn').click(function(){
    	var cash_id=$('#cash_id-delete').val();
	    	$.ajax({
	    		type:'post',
	    		url:'PettyCashController?action=DeletePettyCash&cash_id='+cash_id,
	    		headers:{
	    			Accept:"application/json;charset=utf-8",
	    			"Content-Type":"application/json;charset=utf-8"
	    		},
	    		success:function(res){
	    			table.draw();
					Custombox.close();
					$.toast({
					    heading: 'Cash ID : '+cash_id+' <br>Deleted successfully',
					    showHideTransition: 'fade',
					    icon: 'success',
					    position: 'top-right'
					});
	    		}
	    	});
    });
    
    $('#comment').on('keyup blur',function(){
    	if($('#comment').val()=='')
    		$('#comment-error').text('Please enter comment');
    	else
    		$('#comment-error').text('');
    });
});