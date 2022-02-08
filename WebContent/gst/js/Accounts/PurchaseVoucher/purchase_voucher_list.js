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
	        	url:"../PurchaseVoucherControllerTest?action=getAllPurchaseVoucherList",
	        	type:"POST",
	        	 data 	: function ( d ) {
		                  return $.extend( {}, d, {
		                	  from_date:$('.from_date').val(),
		                	  to_date:$('.to_date').val(),
		                	  bill_no:$('#bill_no').val(),
		                	  supplier_id:$('#supplier_id').val(),
		                	  business_id:session.business_id
		                  });
		              },
	        	error:function(){
	        	}
	        },
	        "columnDefs":[
	        	{"targets":[0],"data":"purchase_voucher_id"},
	        	{"targets":[1],"data":"supplier_name"},
	        	{"targets":[2],"data":"bill_no"},
	        	{"targets":[3],"data":"purchase_date"},
	        	{"targets":[4],"data":function(data){return data;},
	        	"render":function(data,row){
	        		
	        		if(data.rate_include_tax==undefined || data.rate_include_tax=='' || data.rate_include_tax==null){
	        			return 'N/A';
	        		}else{
	        			return data.rate_include_tax;
	        		}
	        	}},
	        	{"targets":[5],"data":function(data){
	        		return data;
	        	},
	        	  "render":function(data,row){
	        		  return (data.plant_name==null || data.plant_name=='')?"All Plant":data.plant_name;
	        	  }
	        	},
	        	{"targets":[6],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		  total_net=0;
	        		var html='';
	        		html+='<table class="table" style="background-color:'+((data.status=="pending")?"#f0b930;":(data.status=="cancelled")?"red":"")+'">'
	        		$.each(data.itemlist,function(i,v){
					total_net=(v.net_amount+total_net);
	        			html+='<tr style="border:1px solid black;">'
	        			html+='<td style="width:40%;" style="border:1px solid black;">'+v.item_name+'</td>'
	        			html+='<td style="width:20%;" style="border:1px solid black;">'+v.item_quantity+'</td>'
	        			html+='<td style="width:20%;" style="border:1px solid black;">'+v.item_price+'</td>'
	        			html+='<td style="width:20%;" style="border:1px solid black;">'+v.net_amount+'</td>'
	        			html+='</tr>'
	        		});
	        		html+='</table>'
	        		return html;
	        	}},
	        	{"targets":[7],"data":"discount_amount"},
	        	{"targets":[8],"data":function(data){
	        		var net=parseFloat(total_net-data.discount_amount).toFixed(2);
	        		return net;
	        	}},
	        	{"targets":[9],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		html='';
	        		html+='<div class="btn-group dropdown">'
	        		html+='<a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>'
	        		html+='<div class="dropdown-menu dropdown-menu-right" style="overflow-x: auto;">'
	        			
	        		//Edit Purchase voucher
	        		if((session.usertype=='sgst' || session.usertype=='gstadmin' || session.usertype=='accountStore'  || session.usertype=='gstaccount') && data.voucher_status=='active')
	        	    	html+='<a class="dropdown-item" href="AddPurchaseVoucher.jsp?action=update&purchase_voucher_id='+data.purchase_voucher_id+'"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Edit  voucher</a>'
	                	    
	                //Cancel   option
	                if((session.usertype=='sgst' || session.usertype=='gstadmin' || session.userype=='gstaccount' || session.usertype=='accountsStore') && data.voucher_status=='active')
	            	    html+='<a class="dropdown-item cancel_voucher" target="_blank" id="'+data.purchase_voucher_id+'"><i class="fa fa-check-circle-o mr-2 text-muted font-18 vertical-middle"></i>Cancel Voucher</a>'
	            	    
	            	//Reactivate   option
		           if((session.usertype=='sgst' || session.usertype=='gstadmin' || session.userype=='gstaccount' || session.usertype=='accountsStore') && data.voucher_status=='cancelled')
		            	    html+='<a class="dropdown-item activate_voucher" target="_blank" id="'+data.purchase_voucher_id+'"><i class="fa fa-check-circle-o mr-2 text-muted font-18 vertical-middle"></i>Activate Voucher</a>'
		             
		            //Delete   option
		 		   if((session.usertype=='sgst' || session.usertype=='gstadmin' || session.userype=='gstaccount' || session.usertype=='accountsStore') && data.voucher_status=='active')
		 		            html+='<a class="dropdown-item delete-voucher" target="_blank" id="'+data.purchase_voucher_id+'"><i class="fa fa-trash mr-2 text-muted font-18 vertical-middle"></i>Delete Voucher</a>'
	        		html+='</div>'
	        		html+='</div>'
	        		return html;
	        	}}  	 
	        ],
	        "fnRowCallback": function( row, data, dataIndex) {
	        	if(data.voucher_status=='cancelled'){
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
	    	var purchase_voucher_id=$(this).attr('id');
	    	$.confirm({
	    	    title: '<span class="text-danger"><i class="fa fa-times"></i></span> Cancel Confirmation !!!',
	    	    content: 'Are you sure want to Cancel Voucher No : '+purchase_voucher_id+' ?',
	    	    buttons: {
	    	        confirm:{
	    	        	text: 'Reject',
	    	            btnClass: 'btn-warning',
	    	            keys: ['enter', 'shift'],
	    	            action: function(){
	    	                $.ajax({
	    	                	type:'post',
	    	                	url:'../PurchaseVoucherControllerTest?action=CancelPurchaseVoucher&purchase_voucher_id='+purchase_voucher_id,
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
	    
	    $(document).on('click','#example .delete-voucher',function(){
	    	var purchase_voucher_id=$(this).attr('id');
	    	$.confirm({
	    	    title: '<span class="text-danger"><i class="fa fa-times"></i></span> Delete Confirmation !!!',
	    	    content: 'Are you sure want to Delete Voucher No : '+purchase_voucher_id+' ?',
	    	    buttons: {
	    	        confirm:{
	    	        	text: 'Delete',
	    	            btnClass: 'btn-warning',
	    	            keys: ['enter', 'shift'],
	    	            action: function(){
	    	                $.ajax({
	    	                	type:'post',
	    	                	url:'../PurchaseVoucherControllerTest?action=deletePurchaseVoucher&purchase_voucher_id='+purchase_voucher_id,
	    	                	success:function(res){
	    	                		table.draw();
	    	                		$.toast({
	    	        				    heading: 'Voucher No : '+purchase_voucher_id+' Deleted',
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
	    	                	url:'../PurchaseVoucherControllerTest?action=activatePurchaseVoucher&purchase_voucher_id='+purchase_voucher_id,
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