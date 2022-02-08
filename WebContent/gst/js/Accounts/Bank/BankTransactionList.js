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
        	url:"BankDetailController?action=GetBankTransactionList",
        	type:"POST",
        	 data 	: function ( d ) {
	                  return $.extend( {}, d, {
	                	  type:$('#type').val(),
	                	  bank_id:$('#bnk_id').val(),
	                	  from_date:$('#from_date').val(),
	                	  to_date:$('#to_date').val()
	                  });
	              },
        	error:function(){
        	}
        },
        "columnDefs":[
        	{"targets":[0],"data":"transaction_id"},
        	{"targets":[1],"data":function(data){return data;},
        	  "render":function(data,row){
        		  return data.transaction_date+" "+data.transaction_time;
        	  }},
        	{"targets":[2],"data":"transaction_type"},
        	{"targets":[3],"data":"transaction_amount"},
        	{"targets":[4],"data":function(data){return data;},
        		"render":function(data,row){
        			return (data.added_by=='' || data.added_by==null)?'Admin':data.added_by;
        		}},
        	{"targets":[5],"data":"bank_name"},
        	{"targets":[6],"data":"remark"},
        	{"targets":[7],"data":"group_name"},
        	{"targets":[8],"data":function(data){
        		return data;
        	},
        	"render":function(data,row){
        		html='';
        		html+='<div class="btn-group dropdown">';
                html+='<a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>'
                	html+='<div class="dropdown-menu dropdown-menu-right">'
                		if(data.status=='active')
                			html+='<a class="dropdown-item" href="AddBankTransaction.jsp?action=update&transaction_id='+data.transaction_id+'"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Edit Transaction</a>';
                		if(data.status=='active' && session.usertype=='superadmin')
                			html+='<a class="dropdown-item delete-transaction" name="'+data.transaction_id+'" id="'+data.transaction_id+'"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>Cancel Transaction</a>';
                    html+='</div>'
            html+='</div>'
                 return html;
        	}}  	
        ],
        "fnRowCallback": function( row, data, dataIndex) {
        	if(data.status!='active'){
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
    $(document).on('click','#example .delete-transaction',function(){
    	var id=$(this).attr('name');
    	$.confirm({
    	    title: '<span class="text-danger"><i class="fa fa-window-close"></i></span>Cancel Confirmation !!!',
    	    content: 'Are you sure want to cancel Transaction ID : '+id+' ?',
    	    buttons: {
    	        confirm:{
    	        	text: 'CANCEL',
    	            btnClass: 'btn-info',
    	            keys: ['enter', 'shift'],
    	            action: function(){
    	                $.ajax({
    	                	type:'post',
    	                	url:'BankDetailController?action=cancelTransactionDetail&transaction_id='+id,
    	                	success:function(res){
    	                		table.draw();
    	                		$.toast({
    	        				    heading: 'Transaction ID: '+transaction_id+' cancelled',
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

    
   
});