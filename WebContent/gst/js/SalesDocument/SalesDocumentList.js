$(document).ready(function(){
	var session=getSessionDetails();
	//show added result
	var result=$('#result').val();
	$('#timepicker1').timepicker({
		minuteStep: 1,
		showSeconds: true,
		showMeridian: false,
		disableFocus: true,
		icons: {
			up: 'fa fa-chevron-up',
			down: 'fa fa-chevron-down'
		}
	}).on('focus', function() {
		$('#timepicker1').timepicker('showWidget');
	}).next().on('click', function(){
		$(this).prev().focus();
	});
	
	
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
	 
	 
	 $('#customer_id').on('change',function(){
			var customer_id=$('#customer_id').val();
			$.ajax({
				type:'POST',
				url:'../CustomerControllerTest?action=getCustomerSiteDetails&customer_id='+customer_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(result){
	        		$('#site_id').html('<option value="0">All Site</option>');
	        		$.each(result, function(index, value) {
	        			   $('#site_id').append("<option value='"+ value.site_id+ "'>" + value.site_name + "</option>");
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
	        "searching":true,
	        lengthChange: true,
	        "ajax":{
	        	url:"../SalesDocumentControllerTest?action=getSalesDocumentList",
	        	type:"POST",
	        	 data 	: function ( d ) {
		                  return $.extend( {}, d, {
		                	  from_date:$('.from_date').val(),
		                	  to_date:$('.to_date').val(),
		                	  invoice_id:$('#invoice_id').val(),
		                	  customer_id:$('#customer_id').val(),
		                	  site_id:$('#site_id').val(),
		                	  business_id:session.business_id,
		                	  plant_id:session.plant_id
		                  });
		              },
	        	error:function(){
	        	}
	        },
	        "columnDefs":[
	        	{"targets":[0],"data":"invoice_id"},
	        	{"targets":[1],"data":"invoice_date"},
	        	{"targets":[2],"data":"invoice_time"},
	        	{"targets":[3],"data":"customer_name"},
	        	{"targets":[4],"data":"site_name"},
	        	{"targets":[5],"data":"vehicle_no"},
	        	{"targets":[6],"data":function(data){
	        		return data;
	        		},
	        	"render":function(data,row){
	        		return (data.plant_name=='' || data.plant_name==undefined)?'All Plant':data.plant_name;
	        		}
	        	},
	        	{"targets":[7],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		var html='';
	        		html+='<table class="table">'
	        		$.each(data.itemList,function(i,v){
	        			html+='<tr style="border:1px solid #d0e9f2;">'
	        			html+='<td style="border:1px solid #d0e9f2;width: 44%;">'+v.product_name+'</td>'
	        			html+='<td style="border:1px solid #d0e9f2;width: 10%;">'+v.item_price+'</td>'
	        			html+='<td style="border:1px solid #d0e9f2;width: 10%;">'+v.item_quantity+'</td>'
	        			html+='<td style="border:1px solid #d0e9f2;width: 12%;">'+v.gross_price+'</td>'
	        			html+='<td style="border:1px solid #d0e9f2;width: 12%;">'+v.tax_price+'</td>'
	        			html+='<td style="border:1px solid #d0e9f2; width: 12%;">'+v.net_price+'</td>'
	        			html+='</tr>'
	        		});
	        		html+='</table>'
	        		return html;
	        	}},
	        	{"targets":[8],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		html='';
	        		html+='<div class="btn-group dropdown">'
	        		html+='<a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>'
	        		html+='<div class="dropdown-menu dropdown-menu-right" style="overflow-x: auto;">'

	        		//change recomanded user
	        		if(data.invoice_status=='active'){
	        			 html+='<a class="dropdown-item view-po" target="_blank"  href="PrintSalesDocument.jsp?id='+data.id+'"><i class="fa fa-print mr-2 text-muted font-18 vertical-middle"></i>Print Sales Document</a>'
	        			 html+='<a class="dropdown-item view-po" target="_blank"  href="PrintSalesDocumentDC.jsp?id='+data.id+'"><i class="fa fa-print mr-2 text-muted font-18 vertical-middle"></i>Print Sales Document DC</a>'
		            	html+='<a class="dropdown-item" href="EditSalesDocument.jsp?id='+data.id+'"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Edit Sales Document</a>'
			            html+='<a class="dropdown-item cancel-sales-document" target="_blank" id="'+data.id+'" name="'+data.invoice_id+'"><i class="fa fa-close mr-2 text-muted font-18 vertical-middle"></i>Cancel Sales Document</a>'
	        		}
	            	html+='</div>'
	        		html+='</div>'
	        		return html;
	        	}}  	 
	        ],
	        "fnRowCallback": function( row, data, dataIndex) {
	        	if(data.invoice_status=='cancelled'){
	        		$(row).css("background-color","#f0b930");
	        		$(row).closest('.table').css("background-color","#f0b930");
	        	}
	        }
	    });
	    
	    
	    $('#search').on( 'click', function () {
	    	getNotificationView();
			 table.draw();
	    } );
	    
	    $('#clear').on('click',function(){
	    	$('#clear-form').trigger('reset');
	    	getNotificationView();
	    	table.draw();
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
	
	    
	    
		    $(document).on('click','#example .cancel-sales-document',function(){
		    	var id=$(this).attr('id');
		    	var invoice_id=$(this).attr('name');
		    	$.confirm({
		    	    title: '<span class="text-danger"><i class="fa fa-close"></i></span>Cancel Confirmation !!!',
		    	    content: 'Are you sure want to cancel Invoice : '+invoice_id+' ?',
		    	    buttons: {
		    	        confirm:{
		    	        	text: 'Cancel',
		    	            btnClass: 'btn-info',
		    	            keys: ['enter', 'shift'],
		    	            action: function(){
		    	                $.ajax({
		    	                	type:'post',
		    	                	url:'../SalesDocumentControllerTest?action=CancelInvoice&id='+id,
		    	                	success:function(res){
		    	                		table.draw();
		    	                		$.toast({
		    	        				    heading: 'Invoice Id  : '+invoice_id+' Cancelled',
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
	    
	   var getNotificationView=function(){
	    	$.ajax({
	    		type:'post',
	    		url:'../PurchaseVoucherControllerTest?action=getNotificationDetails',
	    		headers:{
	    			Accept:"application/json;charset=utf-8",
	    			"Content-Type":"application/json;charset=utf-8"
	    		},
	    		success:function(res){
	    			$('#inactive').text(res.inactive);
	    			$('#recomanded').text(res.recomanded);
	    			$('#thismonthindent').text(res.thismonthindent);
	    			$('#thismonthactive').text(res.thismonthactive);
	    		}
	    	});
	     }
	    
	    
	    getNotificationView();
	    
});