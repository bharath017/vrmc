$(document).ready(function(){

	var session=getSessionDetails();
	
	//console.log(session);
	
	//Date picker is here
	$('.date-picker').datepicker({
		autoclose: true,
		todayHighlight: true,
		"orientation": "bottom left"
 	}).on('change',function(){
 		$(this).valid();
 	});
	
	
	$('.picker').on('click',function(){
		$(this).prev("input.date-picker").datepicker("show");
	});
	
	$('.select2').css('width','100%').select2({allowClear:true})
		.on('change', function(){
	});
	
	
	
	var BaseConfig=$.ajax({
        async:false,
        url:'../PlantController?button=GetPlantForSelect&plant_id='+session.plant_id+'&business_id='+session.business_id,
        type:'post',
        data:{'GetConfig':'YES'},
        dataType:"JSON"
        }).responseJSON;
	

	//set for insertion plant details
	$('#plant_id-transaction').html("");
	$.each(BaseConfig,function(i,v){
		$('#plant_id-transaction').append('<option value="'+i+'">'+v+'</option>')
	});
		
	
	//set for updation plant details
	$('#plant_id-transaction-update').html("");
	$.each(BaseConfig,function(i,v){
		$('#plant_id-transaction-update').append('<option value="'+i+'">'+v+'</option>')
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
        	url:"../PettyCashControllerTest?action=GetPettyCashList",
        	type:"POST",
        	 data 	: function ( d ) {
	                  return $.extend( {}, d, {
	                	  cash_id:$('#cash_id').val(),
	                	  plant_id:session.plant_id,
	                	  from_date:$('#from_date').val(),
	                	  to_date:$('#to_date').val()
	                  });
	              },
        	error:function(){
        	}
        },
        "columnDefs":[
        	{"targets":[0],"data":"cash_id"},
        	{"targets":[1],"data":"date"},
        	{"targets":[2],"data":"amount"},
        	{"targets":[3],"data":"received_by"},
        	{"targets":[4],"data":"purpose"},
        	{"targets":[5],"data":"plant_name"},
        	{"targets":[6],"data":function(data){
        		return data;
        	},
        	"render":function(data,row){
        		console.log(data);
        		html='';
        		if(data.approve_status=='pending')
        			html+='<a  class="text-success approve-option" name="'+data.cash_id+'"><i class="fa fa-check-square-o"></i></a>';
                 return html;
        	}}  	 
        ],
        "fnRowCallback": function( row, data, dataIndex) {
        	if(data.approve_status=='pending'){
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
    
    
   //view hide bill received or not 
    if(session.usertype=='admin' || session.usertype.trim()=='sadmin'){
    	
    }else{
    	//console.log(session.usertype);
    	//console.log('coming hreekdhfkjdhfkjddhfdkjhkj');
    	$('#is_bill_received_view').remove();
    }
    
    
    
    
    var table1 =   $('#example-2').DataTable({
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
        	url:"../PettyCashControllerTest?action=GetPettyCashTransactionList",
        	type:"POST",
        	 data 	: function ( d ) {
	                  return $.extend( {}, d, {
	                	  from_date:$('#from_date-transaction').val(),
	                	  to_date:$('#to_date-transaction').val(),
	                	  plant_id:$('#plnt-id').val(),
	                	  status:$('#pending-transaction-status').val()
	                  });
	              },
        	error:function(){
        	}
        },
        "columnDefs":[
        	{"targets":[0],"data":"transaction_id"},
        	{"targets":[1],"data":"date"},
        	{"targets":[2],"data":"amount"},
        	{"targets":[3],"data":"description"},
        	{"targets":[4],"data":"plant_name"},
        	{"targets":[5],"data":function(data){
        		return data;
        	},
        	"render":function(data,row){
        		if(data.is_bill_received==true)
        			return '<input type="checkbox" checked  class="is_bill_received" name="'+data.transaction_id+'"/>';
        		else
        			return '<input type="checkbox"  class="is_bill_received" name="'+data.transaction_id+'"/>';
        	},
        	"visible": (session.usertype=='sadmin' || session.usertype=='admin')?true:false
        	},
        	{"targets":[6],"data":function(data){
        		return data;
        	},
        	"render":function(data,row){
        		html='';
        		if(data.is_bill_received==false)
        			html+='<a  class="text-success edit-transacton-detail" name="'+data.transaction_id+'"  title="Edit Petty Cash Transaction"><i class="fa fa-edit"></i></a>&nbsp;&nbsp;&nbsp;';
        			html+='<a class="text-danger delete-transacton-detail" name="'+data.transaction_id+'" title="Delete Petty Cash Transaction"><i class="fa fa-trash"></i></a>'
                 return html;
        	}}  	 
        ],
        "fnRowCallback": function( row, data, dataIndex) {
        	/*if(data.is_bill_received==false){
        		 $( row ).css( "background-color", "#f5c676" );
                 $( row ).addClass( "warning" );
        	}    */    
        }
    });
    
    
    $('#search_transaction').on( 'click', function () {
		 table1.draw();
   } );
   
   $('#clear-transaction').on('click',function(){
   	$('#clear1-form').trigger('reset');
   	$('#pending-transaction-status').val("");
   	table1.draw();
   });
   
   
   //click to get pending transaction details
   
   $('#pending-transaction-btn').on('click',function(){
	   $('#pending-transaction-status').val("checked");
	   table1.draw();
   });
    
   
   //to search amount wise
   $('#transaction-amount-pending').on('keyup',function(){
	   //console.log('hello java');
	   table1.draw();
   });
   
   
   //to search without bill sie
   
   
    //validate form here
    $('#transaction-form').validate({
    	debug:false,
    	rules:{
    		plant_id:"required",
    		date:"required",
    		amount:{
    			required:true,
    			number:true
    		},
    		received_person:"required",
    		purpose: "required",
    		description:"required"
    	},
    	messages:{
    		plant_id:"Please select plant",
    		date:"Please select date",
    		amount:{
    			required:"Please enter amount",
    			number:"Please enter valid amount"
    		},
    		received_person:"Please enter received person",
    		description:"Please enter description",
    		purpose: "Please select purpose"
    	},
    	submitHandler:function(form){
    		var transaction_id=$('#transaction_id').val();
    		if(transaction_id==null || transaction_id==0 || transaction_id==""){
    			Custombox.close();
    			$.ajax({
    				type:'GET',
    				url:'../PettyCashControllerTest?action=InsertPettyCashTransaction',
    				data: $.param({
  	                	  plant_id:$('#plant_id-transaction').val(),
  	                	  date:$('#date-transaction').val(),
  	                	  amount:$('#amount-transaction').val(),
  	                	  received_person:$('#received_person-transaction').val(),
  	                	  description:$('#description-transaction').val(),
  	                	  purpose:$('#purpose').val()
  	               }),
  	              headers:{
  	            	  Accept:"application/json;charset=utf-8",
  	            	  "Content-Type":"application/json;charset=utf-8"
  	              },
  	              success:function(res){
  	            	if(res!=0){
  	            		$.toast({
  						    heading: 'Petty Cash Transaction<br> Inserted Successfully',
  						    showHideTransition: 'fade',
  						    icon: 'success',
  						    position: 'top-right'
  						});
  	            		$('#transaction-form').trigger('reset');
  	            		table1.draw();
  	            		getPettyCashDetails();
  	            	}
  	              }
    			});
    		}else{
    			console.log("kan kala se");
    		}
    	}
    });
    
    
    
  //validate transaction update form here
    $('#transaction-update-form').validate({
    	debug:false,
    	rules:{
    		plant_id:"required",
    		date:"required",
    		amount:{
    			required:true,
    			number:true
    		},
    		received_person:"required",
    		description:"required"
    	},
    	messages:{
    		plant_id:"Please select plant",
    		date:"Please select date",
    		amount:{
    			required:"Please enter amount",
    			number:"Please enter valid amount"
    		},
    		received_person:"Please enter received person",
    		description:"Please enter description"
    	},
    	submitHandler:function(form){
    			$.ajax({
    				type:'GET',
    				url:'../PettyCashControllerTest?action=UpdatePettyCashTransaction',
    				data: $.param({
  	                	  plant_id:$('#plant_id-transaction-update').val(),
  	                	  date:$('#date-transaction-update').val(),
  	                	  amount:$('#amount-transaction-update').val(),
  	                	  received_person:$('#received_person-transaction-update').val(),
  	                	  description:$('#description-transaction-update').val(),
  	                	  transaction_id:$('#transaction_id').val(),
  	                	 purpose:$('#purpose-update').val()
  	               }),
  	              headers:{
  	            	  Accept:"application/json;charset=utf-8",
  	            	  "Content-Type":"application/json;charset=utf-8"
  	              },
  	              success:function(res){
  	            	if(res!=0){
  	            		$.toast({
  						    heading: 'Petty Cash Transaction<br> Updated Successfully',
  						    showHideTransition: 'fade',
  						    icon: 'success',
  						    position: 'top-right'
  						});
  	            		$('#transaction-form').trigger('reset');
  	            		Custombox.close();
  	            		table1.draw();
  	            		getPettyCashDetails();
  	            	}
  	              }
    			});
    	}
    });
    
    
    $(document).on('click','#example-2 .edit-transacton-detail',function(){
    	var transaction_id=$(this).attr('name');
    	$.ajax({
    		type:'post',
    		url:'../PettyCashControllerTest?action=GetSinglePettyCashTransaction&transaction_id='+transaction_id,
    		headers:{
    			Accept:"application/json;charset=utf-8",
    			"Content-Type":"application/json;charset=utf-8"
    		},
    		success:function(res){
    			
    			$('#plant_id-transaction-update').val(res.plant_id);
    			$('#transaction_id').val(res.transaction_id);
    			$('#date-transaction-update').val(res.date);
    			$('#amount-transaction-update').val(res.amount);
    			$('#purpose-update').val(res.purpose);
    			$('#received_person-transaction-update').val(res.received_person);
    			$('#description-transaction-update').val(res.description);
    			Custombox.open({
    	    		target:'#transaction-update-model',
    	    		effect:'blur'
    	    	});
    			
    		}
    	});
    });
    
    
    
    
    //view new transaction modal
    $('#newTransBtn').on('click',function(){
    	Custombox.open({
    		target:'#transaction-model',
    		effect:'blur'
    	});
    });
    
    
    //view transaction delete modal
    $(document).on('click','#example-2 .delete-transacton-detail',function(){
    	$('.transaction_id-delete').text($(this).attr('name'));
    	$('.transaction_id-delete').val($(this).attr('name'));
    	Custombox.open({
    		target:'#delete-model',
    		effect:'blur'
    	});
    });
    
    
  //view petty cash approve option model
    $(document).on('click','#example .approve-option',function(){
    	$('#cash_id-status').val($(this).attr('name'));
    	Custombox.open({
    		target:'#approve-modal',
    		effect:'blur'
    	});
    });
    
    
  //Transaction bill received or not option
    $(document).on('click','#example-2 .is_bill_received',function(){
    	var clicked=$(this);
    	var transaction_id=$(this).attr('name');
    	var status=$(this).prop('checked');
    	$.ajax({
    		type:'post',
    		url:'../PettyCashControllerTest?action=changeTransactionBillStatus&transaction_id='+transaction_id+'&status='+status,
    		headers:{
    			Accept:'application/json;charset=utf-8',
    			"Content-Type":"application/json;charset=utf-8"
    		},
    		success:function(res){
    			if(res.count>0 && res.status==true){
    				clicked.closest('tr').css('background-color','white');
    			}else{
    				clicked.closest('tr').css('background-color','#f5c676');
    			}
    			getPettyCashDetails();
    		}
    	});
    });
    
    
    //make delete transaction work option
    $('#delete-btn').click(function(){
    	var transaction_id=$('#transaction_id-delete').val();
	    	$.ajax({
	    		type:'post',
	    		url:'../PettyCashControllerTest?action=DeletePettyCashTransaction&transaction_id='+transaction_id,
	    		headers:{
	    			Accept:"application/json;charset=utf-8",
	    			"Content-Type":"application/json;charset=utf-8"
	    		},
	    		success:function(res){
	    			table1.draw();
					Custombox.close();
					$.toast({
					    heading: 'Cash ID : '+transaction_id+' <br>Deleted successfully',
					    showHideTransition: 'fade',
					    icon: 'warning',
					    position: 'top-right'
					});
					getPettyCashDetails();
	    		}
	    	});
    });
    
    
	  //make delete transaction work option
	    $('#approve-btn').click(function(){
	    	var cash_id=$('#cash_id-status').val();
		    	$.ajax({
		    		type:'post',
		    		url:'../PettyCashControllerTest?action=ApprovePettyCash&cash_id='+cash_id,
		    		headers:{
		    			Accept:"application/json;charset=utf-8",
		    			"Content-Type":"application/json;charset=utf-8"
		    		},
		    		success:function(res){
		    			table.draw();
						Custombox.close();
						$.toast({
						    heading: 'Approved Successfully',
						    showHideTransition: 'fade',
						    icon: 'success',
						    position: 'top-right'
						});
						getPettyCashDetails();
		    		}
		    	});
	    });
    
    $('#comment').on('keyup blur',function(){
    	if($('#comment').val()=='')
    		$('#comment-error').text('Please enter comment');
    	else
    		$('#comment-error').text('');
    });
    
    
    var getPettyCashDetails=function(){
    	$.ajax({
        	type:'post',
        	url:'../PettyCashControllerTest?action=GetPettyCashDetails&plant_id='+session.plant_id,
        	headers:{
        		Accept:"application/json;charset=utf-8",
        		"Content-Type":"application/json;charset=utf-8"
        	},
        	success:function(res){
        		$('#petty-cash-amount').text(res.totalpettycash);
        		$('#transaction-amount').text(res.totaltrans);
        		$('#remaining-amount').text(res.totalpettycash-res.totaltrans);
        		$('#pending-petty-cash').text(res.pendingpettycash);
        		$('#pending-transaction').text(res.pendingtransaction);
        	}
        });
    }
    
    getPettyCashDetails();
});