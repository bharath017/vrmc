$(document).ready(function(){

	var session=getSessionDetails();
	
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
        	url:"SalesDocumentController?action=getConsolidateINvoiceList",
        	type:"POST",
        	 data 	: function ( d ) {
	                  return $.extend( {}, d, {
	                	  cons_id:$('#cons_id').val(),
	                	  customer_id:$('#customer_id').val(),
	                	  from_date:$('#from_date').val(),
	                	  to_date:$('#to_date').val(),
	                	  business_id: session.business_id,
	                	  plant_id: session.plant_id
	                  });
	              },
        	error:function(){
        	}
        },
        "columnDefs":[
        	{"targets":[0],"data":"cons_id"},
        	{"targets":[1],"data":"customer_name"},
        	{"targets":[2],"data":"realdate"},
        	{"targets":[3],"data":"noofinvoice"},
        	{"targets":[4],"data":"plant_name"},
        	{"targets":[5],"data":function(data){
        		return data;
        	},
        	"render":function(data,row){
        		html='';
        		html+='<div class="btn-group dropdown">';
                html+='<a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>'
                	html+='<div class="dropdown-menu dropdown-menu-right">'
                		if(data.invoice_status=='active')
                			html+='<a class="dropdown-item" href="PrintSalesConsolidateInvoice.jsp?id='+data.consolidate_invoice_id+'" target="_blank"><i class="fa fa-print mr-2 text-muted font-18 vertical-middle"></i>Print</a>';
                		if(data.dc_status=='active')
                			html+='<a class="dropdown-item cancel-dc" name="'+data.consolidate_invoice_id+'" dc="'+data.dc_id+'"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>Delete Consolidate Invoice</a>';
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