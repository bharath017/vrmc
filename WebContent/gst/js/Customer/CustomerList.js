$(document).ready(function(){
   var session=getSessionDetails();
	
	//console.log(session_plant);
	$('.select2').css('width','100%').select2({allowClear:true})
		.on('change', function(){
	});
	
	
	//console.log("hello world");
	
	//proper proper option visibility
	$('.table-responsive').on('shown.bs.dropdown', function (e) {
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
        	url:"../CustomerControllerTest?action=GetAllCustomerList",
        	type:"POST",
        	 data 	: function ( d ) {
	                  return $.extend( {}, d, {
	                	  customer_name:$('#customer_name').val(),
	                	  customer_phone:$('#customer_phone').val(),
	                	  status:$('input[name="status"]:checked').val(),
	                	  alp:$('#alp').val(),
	                	  business_id:session.business_id
	                  });
	              },
        	error:function(){
        	}
        },
        "columnDefs":[
        	{"targets":[0],"data":function(data){
        		return data;
        	},
        	"render":function(data,row){
        		return '<b><a href="../CustomerViewControllerTest?customer_id='+data.customer_id+'">'+data.customer_name+'</a></b>'
        	}},
        	{"targets":[1],"data":"customer_address"},
        	{"targets":[2],"data":"customer_phone"},
        	{"targets":[3],"data":"customer_gstin"},
        	{"targets":[4],"data":"opening_balance"},
        	{"targets":[5],"data":function(data,row){
        		if(data.last_dispatch_date=='' || data.last_dispatch_date==null){
        			return 'N/A';
        		}else{
        			return data.last_dispatch_date;
        		}
        	}},
        	{"targets":[6],"data":function(data,row){
        		if(data.mp_name=='' || data.mp_name==null){
        			return 'N/A';
        		}else{
        			return data.mp_name;
        		}
        	}},
        	{"targets":[7],"data":function(data){
        		return data;
        	},
        	"render":function(data,row){
        		html='';
        		html+='<div class="btn-group dropdown">';
                html+='<a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>'
                	html+='<div class="dropdown-menu dropdown-menu-right">'
                		var status=(data.customer_status=="active")?"inactive":"active";
                		if(session.usertype=='sgst' || session.usertype=='gst' || session.usertype=='gstaccount' || session.usertype=='gstbilling')
                			html+='<a class="dropdown-item" href="CustomerViewController?customer_id='+data.customer_id+'"><i class="fa fa-eye mr-2 text-muted font-18 vertical-middle"></i>View Customer</a>';
                		if(session.usertype=='sgst' || session.usertype=='gst' || session.usertype=='gstaccount' || session.usertype=='gstbilling')
                			html+='<a class="dropdown-item" href="AddCustomer.jsp?action=update&customer_id='+data.customer_id+'"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Edit Customer</a>';
                		if(session.usertype=='sgst' || session.usertype=='gstaccount')
                			html+='<a class="dropdown-item delete-customer" name="'+data.customer_id+'" id="'+data.customer_name+'" status="'+((data.customer_status=="active")?"inactive":"active")+'"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>'+((data.customer_status=="active")?"Deactivate":"Activate")+'</a>';
                    html+='</div>'
            html+='</div>'
                 return html;
        	}}  	
        ],
        "fnRowCallback": function( row, data, dataIndex) {
        	if(data.customer_status!='active'){
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
    
    $('#customer_name').on('keyup',function(){
    	table.draw();
    });
    
    $('#customer_phone').on('keyup',function(){
    	table.draw();
    });
    
    $('input[name="status"]').on('click',function(){
    	table.draw();
    });
    
    
    $('#alp').on('change',function(){
    	table.draw();
    });
    
    
    $(document).on('click','#example .delete-customer',function(){
    	$('.show_status').text($(this).attr('status'));
    	$('.customer_status').text($(this).attr('name'));
    	$('.customer_name').text($(this).attr('id'));
    	$('#customer_id-delete').val($(this).attr('name'));
    	$('#customer_status-delete').val($(this).attr('status'));
    	Custombox.open({
    		target:'#delete-model',
    		effect:'blur'
    	});
    });
    
    $('#delete-btn').click(function(){
    	var customer_id=$('#customer_id-delete').val();
    	var customer_status=$('#customer_status-delete').val();
	    	$.ajax({
	    		type:'post',
	    		url:'../CustomerControllerTest?action=changeCustomerStatus&customer_id='+customer_id+'&customer_status='+customer_status,
	    		headers:{
	    			Accept:"application/json;charset=utf-8",
	    			"Content-Type":"application/json;charset=utf-8"
	    		},
	    		success:function(res){
	    			table.draw();
					Custombox.close();
					$.toast({
					    heading: 'Status Changed Successfully',
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