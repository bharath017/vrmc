$(document).ready(function(){

	var session=getSessionDetails();
	
	
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
        	url:"StockController?action=getProductionList",
        	type:"POST",
        	 data 	: function ( d ) {
	                  return $.extend( {}, d, {
	                	  product_id:$('#product_id').val(),
	                	  from_date:$('#from_date').val(),
	                	  to_date:$('#to_date').val(),
	                	  plant_id:session.plant_id
	                  });
	              },
        	error:function(){
        	}
        },
        "columnDefs":[
        	{"targets":[0],"data":"invout_id"},
        	{"targets":[1],"data":"product_name"},
        	{"targets":[2],"data":"date"},
        	{"targets":[3],"data":"quantity"},
        	{"targets":[4],"data":"totalquantity"},
        	{"targets":[5],"data":function(data){return data;},
        	 "render":function(data,row){
        		 return Number(data.quantity)*Number(data.production_cost);
        	 }},
        	{"targets":[6],"data":"comment"},
        	{"targets":[7],"data":"added_by"},
        	{"targets":[8],"data":"plant_name"},
        	{"targets":[9],"data":function(data){
        		return data;
        	},
        	"render":function(data,row){
        		html='';
        		html+='<div class="btn-group dropdown">';
                html+='<a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>'
                	html+='<div class="dropdown-menu dropdown-menu-right">'
        			html+='<a class="dropdown-item" href="AddProductStock.jsp?action=update&invout_id='+data.invout_id+'"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Edit Production</a>';
        			html+='<a class="dropdown-item delete-production" name="'+data.invout_id+'"><i class="fa fa-trash mr-2 text-muted font-18 vertical-middle"></i>Delete Production</a>';
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
    $(document).on('click','#example .delete-production',function(){
    	let invout_id=$(this).attr('name');
    	$.confirm({
    	    title: '<span class="text-danger"><i class="fa fa-trash"></i></span>Delete Confirmation !!!',
    	    content: 'Are you sure want to Delete Production No : '+invout_id+' ?',
    	    buttons: {
    	        confirm:{
    	        	text: 'DELETE',
    	            btnClass: 'btn-info',
    	            keys: ['enter', 'shift'],
    	            action: function(){
    	                $.ajax({
    	                	type:'post',
    	                	url:'StockController?action=deleteProductionDetails&invout_id='+invout_id,
    	                	success:function(res){
    	                		table.draw();
    	                		$.toast({
    	        				    heading: 'Production ID : '+invout_id+' Deleted Successfully',
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
    	var payment_id=$('#invout_id-delete').val();
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