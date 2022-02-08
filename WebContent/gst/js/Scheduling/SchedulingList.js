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
				$('#select2-site_id-container').html('All Site');
				$('#site_id').html('');
        		$('#site_id').html('<option value="">All Site</option>');
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
        "searching":false,
        lengthChange: true,
        "ajax":{
        	url:"../SchedulingControllerTest?action=getAllSchedulingList",
        	type:"POST",
        	 data 	: function ( d ) {
	                  return $.extend( {}, d, {
	                	  date:$('input[name="scheduling_date"]').val(),
	                	  customer_id:$('#customer_id').val(),
	                	  site_id:$('#site_id').val()
	                  });
	              },
        	error:function(){
        	}
        },
        "columnDefs":[
        	{"targets":[0],"data":"date"},
        	{"targets":[1],"data":"customer_name"},
        	{"targets":[2],"data":"site_name"},
        	{"targets":[3],"data":"start_time"},
        	{"targets":[4],"data":"end_time"},
        	{"targets":[5],"data":"plant_name"},
        	{"targets":[6],"data":function(data){return data;},
        	"render":function(data,row){
        		return "1."+data.pump1+"<br>2."+data.pump2
        	}},
        	{"targets":[7],"data":function(data){
        		return data;
        	},
        	"render":function(data,row){
        			var tquant=0;
	        		html='';
	        		html+='<table class="table table-bordered">'
	        		$.each(data.grades,function(i,v){
	        			html+='<tr><td>'+v.grade+'</td><td>'+v.quantity+'</td></tr>';
	        			tquant+=v.quantity;
	        		});
	        		html+='</table>'
	        		html+='<input type="hidden" class="tschedule" id="'+tquant+'"/>';
        		return html;
        	}
        	},
        	{"targets":[8],"data":function(data){
        		return data;
        	},
        	"render":function(data,row){
        		html='';
        		html+='<a class="view-invoice" id="'+data.scheduling_id+'"><span class="text-info"><i class="fa fa-eye"></i></span></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
        		if(session.user_id==data.added_by)
        			html+='<a class="delete-scheduling" id="'+data.scheduling_id+'"><span class="text-danger"><i class="fa fa-trash"></i></span></a>'
                return html;
        	}}  	 
        ]
    });
	
    
    $('#search').on( 'click', function () {
		 table.draw();
    } );
    
    $('#clear').on('click',function(){
    	$('#search-form').trigger('reset');
    	table.draw();
    });
    
    $(document).on('click','#example .view-invoice',function(){
    	var tschedule=$(this).closest('tr').find('input.tschedule').attr('id');
    	console.log(tschedule);
    	var id=$(this).attr('id');
    	$.ajax({
    		type:'post',
    		url:'../SchedulingControllerTest?action=GetScheduledGrades&scheduling_id='+id,
    		headers:{
    			Accept:"application/json;charset=utf-8",
    			"Content-Type":"application/json;charset=utf-8"
    		},
    		success:function(res){
    			
    			$('#invoice-list tbody').html("");
    			$('#tquantity').html("");
    			var tquantity=0;
    			$.each(res,function(i,v){
    				$('#invoice-list tbody').append('<tr><td>'+v.invoice_id+'</td><td>'+v.product_name+'</td><td>'+v.quantity+'</td><td>'+v.rate+'</td><td>'+v.net_amount+'</td></tr>');
    				tquantity=tquantity+v.quantity;
    			});
    			$('#tquantity').html(tquantity);
    			$('#tschedule').html(tschedule);
    			$('#leftquant').text(tschedule-tquantity);
    			Custombox.open({
    	    		target:'#view-invoice-modal',
    	    		effect:'blur'
    	    	});
    		}
    	});
    });
    
    
    $(document).on('click','#example .delete-scheduling',function(){
    	$('#scheduling_id_delete').val($(this).attr('id'));
    	Custombox.open({
    		target:'#delete-model',
    		effect:'blur'
    	});
    });
    
    $('#delete-button').on('click',function(){
    	var scheduling_id=$('#scheduling_id_delete').val();
    	$.ajax({
    		type:'post',
    		url:'../SchedulingControllerTest?action=DeleteScheduling&scheduling_id='+scheduling_id,
    		headers:{
    			Accept:"text/html;charset=utf-8",
    			"Content-Type":"text/html;charset=utf-8"
    		},
    		success:function(res){
    			Custombox.close();
    			if(res>0){
    				$.toast({
    				    heading: 'Scheduling  <br>Deleted successfully',
    				    showHideTransition: 'fade',
    				    icon: 'success',
    				    position: 'top-right'
    				});
    				table.draw();
    			}else{
    				$.toast({
    				    heading: 'Deletion Failed!!!',
    				    showHideTransition: 'fade',
    				    icon: 'error',
    				    position: 'top-right'
    				});
    			}
    			
    		}
    	});
    });
    
    
    
    
    $.ajax({
    	type:'post',
    	url:'../SchedulingControllerTest?action=ShowScheduleDashboard',
    	headers:{
    		Accept:"application/json;charset=utf-8",
    		"Content-Type":"application/json"
    	},
    	success:function(res){
    		$('#today').text(res.todayschedule);
    		$('#tomorrow').text(res.tomorrowschedule);
    		$('#months').text(res.thismonthschedule);
    		$('#monthi').text(res.thismonthinvoice);
    	}
    });
    
	
});