$(document).ready(function(){
	var session=getSessionDetails();
	//show added result
	console.log(session.plant_id);
	var result=$('#result').val();
	if(result=='insert'){
		$.toast({
		    heading: 'Indent inserted successfully',
		    showHideTransition: 'fade',
		    icon: 'success',
		    position: 'top-right'
		});
	}else if(result=='update'){
		$.toast({
		    heading: 'Indent updated successfully',
		    showHideTransition: 'fade',
		    icon: 'success',
		    position: 'top-right'
		});
	}else if(result=='insert_failed'){
		$.toast({
		    heading: 'Failed!!!',
		    showHideTransition: 'fade',
		    icon: 'success',
		    position: 'top-right'
		});
	}
	
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
	        	url:"../PurchaseOrderControllerTest?action=getPurchaesOrderList",
	        	type:"POST",
	        	 data 	: function ( d ) {
		                  return $.extend( {}, d, {
		                	  from_date:$('.from_date').val(),
		                	  to_date:$('.to_date').val(),
		                	  po_number:$('#po_number').val(),
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
	        	{"targets":[0],"data":"po_number"},
	        	{"targets":[1],"data":"po_date"},
	        	{"targets":[2],"data":"customer_name"},
	        	{"targets":[3],"data":"site_name"},
	        	{"targets":[4],"data":"rate_include_tax"},
	        	{"targets":[5],"data":"gst_percent"},
	        	{"targets":[6],"data":"gst_category"},
	        	{"targets":[7],"data":"mp_name"},
	        	{"targets":[8],"data":function(data){
	        		return data;
	        		},
	        	"render":function(data,row){
	        		return (data.plant_name=='' || data.plant_name==undefined)?'All Plant':data.plant_name;
	        		}
	        	},
	        	{"targets":[9],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		var html='';
	        		html+='<table class="table">'
	        		$.each(data.poItemList,function(i,v){
	        			html+='<tr style="border:1px solid black;">'
	        			html+='<td style="width:40%;" style="border:1px solid black;">'+v.product_name+'</td>'
	        			html+='<td style="width:20%;" style="border:1px solid black;">'+v.rate+'</td>'
	        			html+='<td style="width:20%;" style="border:1px solid black;">'+v.quantity+'</td>'
	        			html+='</tr>'
	        		});
	        		html+='</table>'
	        		return html;
	        	}},
	        	{"targets":[10],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		html='';
	        		html+='<div class="btn-group dropdown">'
	        		html+='<a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>'
	        		html+='<div class="dropdown-menu dropdown-menu-right" style="overflow-x: auto;">'

	        		//change recomanded user
		            html+='<a class="dropdown-item view-po" target="_blank" id="'+data.order_id+'"><i class="fa fa-eye mr-2 text-muted font-18 vertical-middle"></i>View PO</a>'
		            if(data.status=='active'){
		            	html+='<a class="dropdown-item" href="AddPurchaseOrder.jsp?action=update&order_id='+data.order_id+'"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Edit PO</a>'
			            html+='<a class="dropdown-item cancel-po" target="_blank" id="'+data.order_id+'" name="'+data.po_number+'"><i class="fa fa-close mr-2 text-muted font-18 vertical-middle"></i>Cancel PO</a>'
	        		}
	            	html+='</div>'
	        		html+='</div>'
	        		return html;
	        	}}  	 
	        ],
	        "fnRowCallback": function( row, data, dataIndex) {
	        	if(data.status=='cancelled'){
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
	
	    
	    $(document).on('click','#example .view-po',function(){
    			var order_id=$(this).attr('id');
    			var plant_id=$(this).attr('name');
    			$.confirm({
    			    title: 'View Purchase Order Detail\'s',
    			    content: '' +
    			   			'<div class="row">'+
    			   				'<div class="col-sm-1">'+
    			   				'</div>'+
    			   				'<div class="col-sm-10">'+
    			   					'<div class="row">'+
	    			   					'<table class="table table-bordered">'+
		    			   					'<tr><th style="width:15%;background-color:#17a2b8;color:white;">Customer Name</th><td id="customer_name"></td><th style="width:15%;background-color:#17a2b8;color:white;">Site Address</th><td id="site_address"></td></tr>'+
		    			   					'<tr><th style="width:15%;background-color:#17a2b8;color:white;">PO Date</th><td id="po_date"></td><th style="width:15%;background-color:#17a2b8;color:white;">Po Number</th><td id="po_no"></td></tr>'+ 
		    			   					'<tr><th style="width:15%;background-color:#17a2b8;color:white;">Marketing Person</th><td id="marketing_person"></td><th style="width:15%;background-color:#17a2b8;color:white;">Plant</th><td id="plant_name"></td></tr>'+
		    			   					'<tr><th style="width:15%;background-color:#17a2b8;color:white;">Business Group</th><td id="business_group"></td><th style="width:15%;background-color:#17a2b8;color:white;">GST Details</th><td id="gst_detail"></td></tr>'+
		    			   				'</table>'+
    			   					'</div>'+
    			   				'</div>'+
    			   				'<div class="col-sm-12">'+
    			   					'<table class="table table-bordered" id="stock-incoming">'+
    			   						'<thead>'+
    			   							'<tr>'+
    			   								'<th>S/L No</th><th>Grade</th><th>Quantity</th><th>Rate</th></th><th>Inv. Qty</th><th>Rem. Quantity</th>'
    			   							+'</tr>'
    			   						+'</thead>'
    			   						+'<tbody></tbody>'
    			   					+'</table>'
    			   				+'</div>'
    			   			+'</div>'
    			    ,
    			    type: 'red',
    			    columnClass: 'col-md-12',
    			    buttons: {
    			        close: function () {
    			            //close
    			        },
    			    },
    			    onContentReady: function () {
	   			    	var from_date=$('input[name="from_date"]').val();
	   		        	var to_date=$('input[name="to_date"]').val();
    			      $.ajax({
    			    	 type:'post',
    			    	 url:'../PurchaseOrderControllerTest?action=getSinglePoDetails&order_id='+order_id,
    			    	 headers:{
    			    		 Accept:"application/json;charset=utf-8",
    			    		 "Content-Type":"application/json;charset=utf-8"
    			    	 },
    			    	 success:function(res){
    			    		 var count=0;
    			    		 console.log(res.customer_name);
    			    		 $('#customer_name').text(res.customer_name);
    			    		 $('#site_address').text(res.site_address);
    			    		 $('#po_no').text(res.po_number);
    			    		 $('#po_date').text(res.po_date);
    			    		 $('#marketing_person').text(res.mp_name);
    			    		 $('#plant_name').text((res.mp_name=='' || res.mp_name==undefined)?'All Plant':res.mp_name);
    			    		 $('#business_group').text(res.group_name);
    			    		 $('#gst_detail').text(res.gst_category+" @ "+res.gst_percent+"%");
    			    		 $.each(res.itemList,function(i,v){
    			    			// console.log('coming');
    			    			 count++;
    			    			 var row='';
    			    			 row+='<tr>'
    			    			 row+='<td>'+count+'</td>'
    			    			 row+='<td>'+v.product_name+'</td>'
    			    			 row+='<td>'+v.quantity+'</td>'
    			    			 row+='<td>'+v.rate+'</td>'
    			    			 row+='<td>'+v.tquantity+'</td>'
    			    			 row+='<td>'+(v.quantity-v.tquantity)+'</td>'
    			    			 row+='</tr>'
    			    			 $('#stock-incoming tbody').append(row);
    			    		 });
    			    		 
    			    	 }
    			      });
    			    }
    			});
    		});	
	    
	    
	    
		    $(document).on('click','#example .cancel-po',function(){
		    	var order_id=$(this).attr('id');
		    	var po_number=$(this).attr('name');
		    	$.confirm({
		    	    title: '<span class="text-danger"><i class="fa fa-close"></i></span>Cancel Confirmation !!!',
		    	    content: 'Are you sure want to cancel PO Number : '+po_number+' ?',
		    	    buttons: {
		    	        confirm:{
		    	        	text: 'Cancel',
		    	            btnClass: 'btn-info',
		    	            keys: ['enter', 'shift'],
		    	            action: function(){
		    	                $.ajax({
		    	                	type:'post',
		    	                	url:'../PurchaseOrderControllerTest?action=cancelOrder&order_id='+order_id,
		    	                	success:function(res){
		    	                		table.draw();
		    	                		$.toast({
		    	        				    heading: 'PO Number  : '+po_number+' Cancelled',
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