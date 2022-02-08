$(document).ready(function(){

	var session=getSessionDetails();
	
	console.log(session);
	
	$('#customer_id').on('change',function(){
		var customer_id=$('#customer_id').val();
		$.ajax({
			type:'post',
			url:'CustomerController?action=getCustomerSiteDetails&customer_id='+customer_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(res){
				$('#site_id').empty();
				$('#site_id').append('<option value="0">All Site</option>')
				$.each(res,function(i,v){
					$('#site_id').append('<option value="'+v.site_id+'">'+v.site_name+'</option>')
				});
			}
		});
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
        	url:"DCController?action=getDCList",
        	type:"POST",
        	 data 	: function ( d ) {
	                  return $.extend( {}, d, {
	                	  dc_id:$('#dc_id').val(),
	                	  customer_id:$('#customer_id').val(),
	                	  from_date:$('#from_date').val(),
	                	  to_date:$('#to_date').val(),
	                	  site_id:$('#site_id').val()
	                  });
	              },
        	error:function(){
        	}
        },
        "columnDefs":[
        	{"targets":[0],"data":"dc_id"},
        	{"targets":[1],"data":"customer_name"},
        	{"targets":[2],"data":"site_name"},
        	{"targets":[3],"data":"dc_date"},
        	{"targets":[4],"data":"product_name"},
        	{"targets":[5],"data":"empty_weight"},
        	{"targets":[6],"data":"loaded_weight"},
        	{"targets":[7],"data":"net_weight"},
        	{"targets":[8],"data":"plant_name"},
        	{"targets":[9],"data":function(data){
        		return data;
        	},
        	"render":function(data,row){
        		html='';
        		html+='<div class="btn-group dropdown">';
                html+='<a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>'
                	html+='<div class="dropdown-menu dropdown-menu-right">'
                		if(data.dc_status=='active')
                			html+='<a class="dropdown-item" href="PrintDC.jsp?id='+data.id+'" target="_blank"><i class="fa fa-print mr-2 text-muted font-18 vertical-middle"></i>Print DC</a>';
                		if(data.dc_status=='active')
                			html+='<a class="dropdown-item" href="EditDC.jsp?action=update&id='+data.id+'"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Edit DC</a>';
                		if(data.dc_status=='active')
                			html+='<a class="dropdown-item cancel-dc" name="'+data.id+'" dc="'+data.dc_id+'"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>Cancel DC</a>';
                    html+='</div>'
            html+='</div>'
                 return html;
        	}}  	
        ],
        "fnRowCallback": function( row, data, dataIndex) {
        	if(data.dc_status!='active'){
        		$(row ).css( "background-color", "#f5c676" );
        		$(row ).css( "color", "white" );
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
    
   
   
    //calcel dc option goes here
    $(document).on('click','#example .cancel-dc',function(){
    	var id=$(this).attr('name');
    	var dc_id=$(this).attr('dc');
    	$.confirm({
    	    title: '<span class="text-danger"><i class="fa fa-window-close"></i></span>Cancel Confirmation !!!',
    	    content: 'Are you sure want to Cancel DC No : '+dc_id+' ?',
    	    buttons: {
    	        confirm:{
    	        	text: 'DELETE',
    	            btnClass: 'btn-info',
    	            keys: ['enter', 'shift'],
    	            action: function(){
    	                $.ajax({
    	                	type:'post',
    	                	url:'DCController?action=cancelDC&id='+id,
    	                	success:function(res){
    	                		table.draw();
    	                		$.toast({
    	        				    heading: 'DC No : '+dc_id+' cancelled',
    	        				    showHideTransition: 'fade',
    	        				    icon: 'warning',
    	        				    position: 'top-right'
    	        				});
    	                	},
    	                	error:function(error){
    	                		$.toast({
    	        				    heading: 'Failed!!',
    	        				    showHideTransition: 'fade',
    	        				    icon: 'error',
    	        				    position: 'top-right'
    	        				});
    	                	}
    	                });
    	            }
    	        },
    	        cancel:{
    	        	text: 'Close',
    	            btnClass: 'btn-danger',
    	            keys:['esc'],
    	            action: function(){
    	                
    	            }
    	        }
    	    }
    	});
    });
    
    
    
    
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
	
    
    
    
    $('#delete-btn').click(function(){
    	var payment_id=$('#payment_id-delete').val();
    	var comment=$('#comment').val();
    	if(comment.trim()!=''){
    		console.log(1);
	    	$.ajax({
	    		type:'post',
	    		url:'PaymentController?action=DeletePayment&payment_id='+payment_id+'&comment='+comment,
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
    	}else{
    		$('#comment-error').text('Please enter comment');
    	}
    });
    
    $('#comment').on('keyup blur',function(){
    	if($('#comment').val()=='')
    		$('#comment-error').text('Please enter comment');
    	else
    		$('#comment-error').text('');
    });
});