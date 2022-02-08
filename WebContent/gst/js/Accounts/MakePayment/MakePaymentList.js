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
	
	
	//proper proper option visibility
	
	
	  $('.table-responsive').on('shown.bs.dropdown', function (e) {
		  console.log('clicking');
	    var $table = $(this),
	        $menu = $(e.target).find('.dropdown-menu'),
	        tableOffsetHeight = $table.offset().top + $table.height(),
	        menuOffsetHeight = $menu.offset().top + $menu.outerHeight(true);
	    if (menuOffsetHeight+100 > tableOffsetHeight)
	      $('.dataTables_scrollBody').css('padding-bottom',(menuOffsetHeight - tableOffsetHeight)+50);
	  });
	
	  $('.table-responsive').on('hide.bs.dropdown', function () {
	      $('.dataTables_scrollBody').css("padding-bottom", 0);
	  })
	
	
	
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
        	url:"../MakePaymentControllerTest?action=GetMakePaymentList",
        	type:"POST",
        	 data 	: function ( d ) {
	                  return $.extend( {}, d, {
	                	  payment_id:$('#payment_id').val(),
	                	  supplier_id:$('#supplier_id').val(),
	                	  from_date:$('#from_date').val(),
	                	  to_date:$('#to_date').val(),
	                	  business_id:session.business_id
	                  });
	              },
        	error:function(){
        	}
        },
        "columnDefs":[
        	{"targets":[0],"data":"payment_id"},
        	{"targets":[1],"data":"supplier_name"},
        	{"targets":[2],"data":"payment_amount"},
        	{"targets":[3],"data":"payment_date"},
        	{"targets":[4],"data":"payment_time"},
        	{"targets":[5],"data":"payment_mode"},
        	{"targets":[6],"data":"mode_no"},
        	{"targets":[7],"data":"bank_name"},
        	{"targets":[8],"data":function(data){
        		return data;
        	},
        	"render":function(data,row){
        		html='';
        		html+='<div class="btn-group dropdown">';
                html+='<a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>'
                	html+='<div class="dropdown-menu dropdown-menu-right">'
        			html+='<a class="dropdown-item" href="AddMakePayment.jsp?action=update&payment_id='+data.payment_id+'"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Edit Payment</a>';
        			html+='<a class="dropdown-item delete-payment-details" name="'+data.payment_id+'"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>Delete Payment</a>';
                    html+='</div>'
            html+='</div>'
                 return html;
        	}}  	 
        ]
    });
	
    
    $('#search').on( 'click', function () {
		 table.draw();
    } );
    
    $('#clear').on('click',function(){
    	$('#clear-form').trigger('reset');
    	table.draw();
    });
    
    $(document).on('click','#example .delete-payment-details',function(){
    	$('.payment_id').text($(this).attr('name'));
    	$('.payment_id').val($(this).attr('name'));
    	Custombox.open({
    		target:'#dele-model',
    		effect:'blur'
    	});
    });
    
    
    
    
    
    $('#delete-btn').click(function(){
    	var payment_id=$('#payment_id-delete').val();
	    	$.ajax({
	    		type:'post',
	    		url:'MakePaymentController?action=DeleteMakePayment&payment_id='+payment_id,
	    		headers:{
	    			Accept:"application/json;charset=utf-8",
	    			"Content-Type":"application/json;charset=utf-8"
	    		},
	    		success:function(res){
	    			table.draw();
					Custombox.close();
					$.toast({
					    heading: 'Payment ID : '+payment_id+' <br>Deleted successfully',
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