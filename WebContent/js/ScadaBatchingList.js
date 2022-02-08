$(document).ready(function(){
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
        url:'BatchingListController?action=GetCustomerList',
        type:'post',
        data:{'GetConfig':'YES'},
        dataType:"JSON"
        }).responseJSON;
	

	//set for insertion plant details
	$('#plant_id-transaction').html("");
	$.each(BaseConfig,function(i,v){
		$('#customer_name').append('<option value="'+v+'">'+v+'</option>')
	});
	
	
	$.ajax({
		type:'post',
		url:'BatchingListController?action=getTodayStock',
		headers:{
			Accept:"application/json;charset=utf-8",
			"Content-Type":"application/json;charset=utf-8"
		},
		success:function(res){
			$('.count').text(res.COUNT);
			$('.rsand').text(res.RSAND);
			$('.crusher').text(res.CRUSHER);
			$('.20mm').text(res.jjj);
			$('.10mm').text(res.kkk);
			$('.cem1').text(res.CEMENT1);
			$('.cem2').text(res.CEMENT2);
			$('.flyash').text(res.FLYASH);
			$('.add1').text(res.ADDITIVE1);
			$('.add2').text(res.ADDITIVE2);
			$('.water').text(res.WATER);
			$('.total').text(res.TOTAL); 
		}
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
        	url:"BatchingListController?action=GET_BATCH_LIST",
        	type:"POST",
        	 data 	: function ( d ) {
	                  return $.extend( {}, d, {
	                	  customer_name:$('#customer_name').val(),
	                	  from_date:$('#from_date').val(),
	                	  to_date:$('#to_date').val()
	                  });
	              },
        	error:function(){
        	}
        },
        "columnDefs":[
        	{"targets":[0],"data":"BATCHID"},
        	{"targets":[1],"data":"TRIPNO"},
        	{"targets":[2],"data":"BATCHNO"},
        	{"targets":[3],"data":"CUSTOMER"},
        	{"targets":[4],"data":"RECIPE"},
        	{"targets":[5],"data":"SITE"},
        	{"targets":[6],"data":"TRUCK"},
        	{"targets":[7],"data":"BATCHDATE"},
        	{"targets":[8],"data":"GRANDTOTAL"},
        	{"targets":[9],"data":function(data){
        		return data;
        	},"render":function(data,row){
        		return '<a class="view-batch" id="'+data.TRIPNO+'"><span class="text-danger"><i class="fa fa-eye"></i></span></a>';
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
    
    
    $(document).on('click','#example .view-batch',function(){
    	console.log("hello world");
    	var BatchId=$(this).attr('id');
    	console.log(BatchId);
    	$.ajax({
    		type:'post',
    		url:'BatchingListController?action=GetBatchSheet&BatchID='+BatchId,
    		headers:{
    			Accept:"application/json;charset=utf-8",
    			"Content-Type":"application/json;charset=utf-8"
    		},
    		success:function(res){
    			$('#batch-tbl tbody').html('');
    			$('#customer').text(res.batch.CUSTOMER);
    			$('#site').text(res.batch.SITE);
    			$('#tripno').text(res.batch.TRIPNO);
    			$('#truck').text(res.batch.TRUCK);
    			$('#setbatches').text(res.batch.BATCHNO);
    			$('#recipe').text(res.batch.RECIPE);
    			$('#actbatches').text(res.batch.ACTBATCH);
    			$('#tripdate').text(res.batch.BATCHDATE);
    			$('#agg1').text(res.batch.AGG1);
    			$('#agg2').text(res.batch.AGG2);
    			$('#agg3').text(res.batch.AGG3);
    			$('#agg4').text(res.batch.AGG5);
    			$('#agg5').text(res.batch.AGG6);
    			$('#agg6').text(res.batch.AGG7);
    			$('#agg7').text(res.batch.AGG8);
    			$('#agg8').text(res.batch.AGG9);
    			$('#agg9').text(res.batch.AGG10);
    			$('#agg10').text(res.batch.AGG11); 
    			$('#total1').text(res.batch.total1);
    			$('#total2').text(res.batch.total2);
    			$('#total3').text(res.batch.total3);
    			$('#total4').text(res.batch.total4);
    			$('#total5').text(res.batch.total5);
    			$('#total6').text(res.batch.total6);
    			$('#total7').text(res.batch.total7);
    			$('#total8').text(res.batch.total8);
    			$('#total9').text(res.batch.total9);
    			$('#total10').text(res.batch.total10);
    			$('#totalmain').text(parseFloat(res.batch.total1)+parseFloat(res.batch.total2)+parseFloat(res.batch.total3)+
    					parseFloat(res.batch.total4)+parseFloat(res.batch.total5)+parseFloat(res.batch.total6)+parseFloat(res.batch.total7)+
    					parseFloat(res.batch.total8)+parseFloat(res.batch.total9)+parseFloat(res.batch.total10));
    			
    			$('#set1').text(res.batch.set1);
    			$('#set2').text(res.batch.set2);
    			$('#set3').text(res.batch.set3);
    			$('#set4').text(res.batch.set4);
    			$('#set5').text(res.batch.set5);
    			$('#set6').text(res.batch.set6);
    			$('#set7').text(res.batch.set7);
    			$('#set8').text(res.batch.set8);
    			$('#set9').text(res.batch.set9);
    			$('#set10').text(res.batch.set10);
    			$('#setmain').text(parseFloat(res.batch.set1)+parseFloat(res.batch.set2)+parseFloat(res.batch.set3)+
    					parseFloat(res.batch.set4)+parseFloat(res.batch.set5)+parseFloat(res.batch.set6)+parseFloat(res.batch.set7)+
    					parseFloat(res.batch.set8)+parseFloat(res.batch.set9)+parseFloat(res.batch.set10));
    			
    			
    			var html='';
    			var count=0;
    			var totalflyash=0;
    			$.each(res.list,function(i,v){
    				count++;
    				$('#batch-tbl tbody').append('<tr><td>'+count+'</td><td>'+v.bin1+'</td><td>'+v.bin2+'</td><td>'+v.bin3+'</td><td>'+v.bin4+'</td><td>'+v.cem1+'</td><td>'+v.cem2+'</td><td>'+v.flyash+'</td><td>'+v.water+'</td><td>'+v.add1+'</td><td>'+v.add2+'</td><td>'+v.totalweight+'</td></tr>');
    				totalflyash=v.flyash+totalflyash;
    			});
    			$('#total7').text(totalflyash);
    			
    			
    			$('#exampleModalCenter').modal('show');
    		}
    	});
    });
    
	
	
	
});