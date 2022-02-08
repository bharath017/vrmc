$(document).ready(function(){
	var session=getSessionDetails();
	
	
	
	//show added result
	var result=$('#result').val();
	
	if(result=='insert'){
		$.toast({
		    heading: 'Purchase Voucher <br> Inserted successfully',
		    showHideTransition: 'fade',
		    icon: 'success',
		    position: 'top-right'
		});
	}else if(result=='update'){
		$.toast({
		    heading: 'Purchase Voucher <br> updated successfully',
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
	}else if(result=='cancel'){
		$.toast({
		    heading: 'Purchase Voucher <br> Cancelled Successfully',
		    showHideTransition: 'fade',
		    icon: 'danger',
		    position: 'top-right'
		});
	}else if(result=='material_failed'){
		$.toast({
		    heading: 'Failed!!!',
		    showHideTransition: 'fade',
		    icon: 'error',
		    position: 'top-right'
		});
	}else if(result=='material_update'){
		$.toast({
		    heading: 'Material updated successfully',
		    showHideTransition: 'fade',
		    icon: 'success',
		    position: 'top-right'
		});
	}else if(result=='material_update_failed'){
		$.toast({
		    heading: 'Material update failed!!!',
		    showHideTransition: 'fade',
		    icon: 'error',
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
	 
	 
	 //Getting Address details here
		$('#customer_id').on('change',function(){
			var customer_id=$('#customer_id').val();
			$.ajax({
				type:'POST',
				url:'CustomerController?action=getCustomerSiteDetails&customer_id='+customer_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(result){
					$('#select2-site_id-container').html('Choose Site Address');
					$('#site_id').html('');
	        		$('#site_id').html('<option value="0">Choose Site Address.</option>');
	        		$.each(result, function(index, value) {
	        			   $('#site_id').append("<option value='"+ value.site_id+ "'>" + value.site_name + "</option>");
	        		});
	        		
				}
			});
		});
	 
	 var total_net=0;
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
	        	url:"SchedulingController?action=getSchedulingList",
	        	type:"POST",
	        	 data 	: function ( d ) {
		                  return $.extend( {}, d, {
		                	  from_date:$('.from_date').val(),
		                	  to_date:$('.to_date').val(),
		                	  site_id:$('#site_id').val(),
		                	  supplier_id:$('#customer_id').val()
		                  });
		              },
	        	error:function(){
	        	}
	        },
	        "columnDefs":[
	        	{"targets":[0],"data":"scheduling_id"},
	        	{"targets":[1],"data":"scheduling_date"},
	        	{"targets":[2],"data":"customer_name"},
	        	{"targets":[3],"data":"site_name"},
	        	{"targets":[4],"data":"start_time"},
	        	{"targets":[5],"data":"end_time"},
	        	{"targets":[8],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		var html='';
	        		html+='<table class="table" style="background-color:'+((data.status=="pending")?"#f0b930;":(data.status=="cancelled")?"red":"")+'">'
	        		$.each(data.itemList,function(i,v){
	        			html+='<tr style="border:1px solid black;">'
	        			html+='<td style="width:40%;" style="border:1px solid black;">'+v.product_name+'</td>'
	        			html+='<td style="width:20%;" style="border:1px solid black;">'+v.production_quantity+'</td>'
	        			html+='</tr>'
	        		});
	        		html+='</table>'
	        		return html;
	        	}},
	        	{"targets":[6],"data":"pump1"},
	        	{"targets":[7],"data":"schStatus"},
	        	{"targets":[9],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		html='';
	        		html+='<div class="btn-group dropdown">'
	        		html+='<a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>'
	        		html+='<div class="dropdown-menu dropdown-menu-right" style="overflow-x: auto;">'
	                	    
	                //Cancel   option
	                if(data.schStatus=='pending' || data.schStatus=='cancelled')
	            	    html+='<a class="dropdown-item cancel_voucher" name="'+data.schStatus+'" target="_blank"  id="'+data.scheduling_id+'"><i class="fa fa-check-circle-o mr-2 text-muted font-18 vertical-middle"></i>Change Status</a>'
	            	if(session.user_id==data.added_by)
		 		        html+='<a class="dropdown-item delete-voucher" target="_blank" id="'+data.scheduling_id+'"><i class="fa fa-trash mr-2 text-muted font-18 vertical-middle"></i>Delete Scheduling</a>'
	        		html+='</div>'
	        		html+='</div>'
	        		return html;
	        	}}  	 
	        ],
	        "fnRowCallback": function( row, data, dataIndex) {
	        	if(data.schStatus=='pending'){
	                 $(row).css( "background-color","#f0b930");
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
	    

	    
	    
	  //Cancel purchase voucher here
	    $(document).on('click','#example .cancel_voucher',function(){
	    	var scheduling_id=$(this).attr('id');
	    	$.confirm({
	    	    title: '<span class="text-danger"></span> Change Scheduling Status',
	    	    content: '',
	    	    buttons: {
	    	        approve:{
	    	        	text: 'Approve',
	    	            btnClass: 'btn-success',
	    	            keys: ['enter', 'shift'],
	    	            action: function(){
	    	                $.ajax({
	    	                	type:'post',
	    	                	url:'SchedulingController?action=changeStatus&scheduling_id='+scheduling_id+'&schStatus=approved',
	    	                	success:function(res){
	    	                		table.draw();
	    	                		$.toast({
	    	        				    heading: 'Voucher No : '+purchase_voucher_id+' Rejected',
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
	    	        confirm:{
	    	        	text: 'Reject',
	    	            btnClass: 'btn-warning',
	    	            keys: ['enter', 'shift'],
	    	            action: function(){
	    	                $.ajax({
	    	                	type:'post',
	    	                	url:'SchedulingController?action=changeStatus&scheduling_id='+scheduling_id+'&schStatus=rejected',
	    	                	success:function(res){
	    	                		table.draw();
	    	                		$.toast({
	    	        				    heading: 'Voucher No : '+purchase_voucher_id+' Rejected',
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
	    
	    
	    //delete confirmation
	    $(document).on('click','#example .delete-voucher',function(){
	    	var scheduling_id=$(this).attr('id');
	    	$.confirm({
	    	    title: '<span class="text-danger"><i class="fa fa-times"></i></span> Delete Confirmation !!!',
	    	    content: 'Are you sure want to Delete Scheduling ID : '+scheduling_id+' ?',
	    	    buttons: {
	    	        confirm:{
	    	        	text: 'Delete',
	    	            btnClass: 'btn-warning',
	    	            keys: ['enter', 'shift'],
	    	            action: function(){
	    	                $.ajax({
	    	                	type:'post',
	    	                	url:'SchedulingController?action=DeleteScheduling&scheduling_id='+scheduling_id,
	    	                	success:function(res){
	    	                		table.draw();
	    	                		$.toast({
	    	        				    heading: 'Scheduling No : '+scheduling_id+' Deleted',
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

	    $(document).on('click','#example .activate_voucher',function(){
	    	var purchase_voucher_id=$(this).attr('id');
	    	$.confirm({
	    	    title: '<span class="text-danger"><i class="fa fa-times"></i></span> Activate Confirmation !!!',
	    	    content: 'Are you sure want to Activete Voucher No : '+purchase_voucher_id+' ?',
	    	    buttons: {
	    	        confirm:{
	    	        	text: 'Activate',
	    	            btnClass: 'btn-success',
	    	            keys: ['enter', 'shift'],
	    	            action: function(){
	    	                $.ajax({
	    	                	type:'post',
	    	                	url:'PurchaseVoucherController?action=activatePurchaseVoucher&purchase_voucher_id='+purchase_voucher_id,
	    	                	success:function(res){
	    	                		table.draw();
	    	                		$.toast({
	    	        				    heading: 'Voucher No : '+purchase_voucher_id+' Activated',
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
	 
	 
	 
});