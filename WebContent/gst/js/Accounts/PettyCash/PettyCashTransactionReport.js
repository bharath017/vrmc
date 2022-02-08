$(document).ready(function(){
	 var session=getSessionDetails();
	
	 $('.select2').css('width','100%').select2({allowClear:true})
		.on('change', function(){
	 }); 
	 
  
	 $('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true,
				"orientation":"bottom left",
				format: 'yyyy-mm-dd'
	  });
	 
		/*TIME PICKER START'S HERE*/
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
	  
	 
	  
	  fetch(`../ExpenseVoucherControllerTest?action=getExpenseCategoryType`,{
			method:'post'
		}).then(response => response.json())
		  .then(text => {
			  $('#category_type').empty();
			  $('#category_type').append('<option value="" selected disabled>Selected Group</option>')
			 $.each(text,function(i,v){
				$('#category_type').append(`<option value="${v}">${v}</option>`); 
			 }); 
		});
		
		
		$('#category_type').on('change',function(){
			let category_type=$('#category_type').val();
			fetch(`../ExpenseVoucherControllerTest?action=getCategoryList&category_type=${category_type}`,{
				method:'post'
			}).then(response => response.json())
			  .then(text => {
				 $('#category_id').empty();
				 $('#category_id').append('<option value="" selected disabled></option>')
				$.each(text,function(i,v){
					$('#category_id').append(`<option value="${v.category_id}">${v.category_name}</option>`);
				});
			});
		});
	  
	  
	  
	  //change report type
	   let changeReportType=function(report_type){
		   if(report_type=='dw'){
			   $('.dw').show();
			   $('.dw').prop('disabled',false);
			   
			   $('.no-dw').hide();
			   $('.no-dw').prop('disabled',true);
		   }else if(report_type=='sw'){
			   $('.sw').show();
			   $('.sw').prop('disabled',false);
			   
			   $('.no-sw').hide();
			   $('.no-sw').prop('disabled',true);
		   }else if(report_type=='swd'){
			   $('.swd').show();
			   $('.swd').prop('disabled',false);
			   
			   $('.no-swd').hide();
			   $('.no-swd').prop('disabled',true);
		   }else if(report_type=='dwgs'){
			   $('.dw').show();
			   $('.dw').prop('disabled',false);
			   
			   $('.no-dw').hide();
			   $('.no-dw').prop('disabled',true);
		   }else if(report_type=='dgs'){
			   $('.sw').show();
			   $('.sw').prop('disabled',false);
			   
			   $('.no-sw').hide();
			   $('.no-sw').prop('disabled',true);
		   }else if(report_type=='swdgi'){
			   $('.swd').show();
			   $('.swd').prop('disabled',false);
			   
			   $('.no-swd').hide();
			   $('.no-swd').prop('disabled',true);
		   }else if(report_type=='dwci'){
			   $('.dw').show();
			   $('.dw').prop('disabled',false);
			   
			   $('.no-dw').hide();
			   $('.no-dw').prop('disabled',true);
		   }else if(report_type=='stock'){
			   $('.dw').show();
			   $('.dw').prop('disabled',false);
			   
			   $('.no-dw').hide();
			   $('.no-dw').prop('disabled',true);
		   }
	   }
	   
	   let report_type=$('#report_type').val();
	   changeReportType(report_type);
	   
	   $('#report_type').on('change',function(){
		  let report_type=$('#report_type').val();
		  changeReportType(report_type);
	   });
	   
	 
	 
	  
	  //click to generate report
		$('#generate').on('click',function(){
				$('#show-excel').hide();
				var report_type=$('#report_type').val();
				var from_date=$('input[name="from_date"]').val();
				var to_date=$('input[name="to_date"]').val();
				var category_type=$('#category_type').val();
				var category_id=$('#category_id').val();
				var plant_id=$('select[name="plant_id"]').val();
				if(report_type=='dw'){
					validateDateReport(from_date,to_date);
					getDateWiseReport(from_date,to_date,category_type,category_id,plant_id);
				}else if(report_type=='at'){
					validateDateReport(from_date,to_date);
					getAccountTransactionReport(from_date,to_date,category_type,category_id,plant_id);
				}
				$('#show-excel').show();
			
		});
		
		
		//validate date report
		var validateDateReport=(from_date,to_date) => {
			if(from_date==''){
				$('#from_date-error').show();
				$('#from_date-error').text('Enter From Date');
				return false;
			}else{
				$('#from_date-error').hide();
			}
			
			if(to_date==''){
				$('#to_date-error').show();
				$('#to_date-error').text('Enter From Date');
				return false;
			}else{
				$('#to_date-error').hide();
			}
		}
		
		//get date wise report
		let getDateWiseReport= (from_date,to_date,category_type,category_id,plant_id) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'../PettyCashControllerTest?action=getPettyCashTransactionDateWiseReport&from_date='
					+from_date+'&to_date='+to_date+'&category_id='
					+category_id+'&category_type='+category_type+'&plant_id='+plant_id+'&business_id='+session.business_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					$('#result').empty();
					row='<thead>'
						row+='<tr><td colspan="17" class="text-center"><strong>Petty Cash Transaction Report</strong> ( From Date : '+from_date+' - To Date:'+to_date+')</td>'
						row+='</tr>'
						row+='<tr>'
						row+='<tr>'
						row+='<th>Date</th>'
						row+='<th>A/C Name</th>'
						row+='<th>Item</th>'
						row+='<th>Debit</th>'
						row+='<th>Credit</th>'
						row+='<th>Remaining</th>'
						row+='</tr>'
						row+='</thead>'
					
					row+='<tbody>'
					$('#result').append(row);
					//set calculation value
					let sl_no=0;
					let remaining=0;
					let tremaining=0;
					$.each(res,function(i,rs){
						sl_no+=1;
						remaining=remaining+(rs.debit-rs.credit);
						tremaining=remaining+tremaining
						var data='<tr>'
							data+='<td>'+rs.date+'</td>'
							data+='<td>'+rs.category_name+'</td>'
							data+='<td>'+rs.item_name+'</td>'
							data+=`<td>${(rs.debit==0)?'':rs.debit}</td>`
							data+=`<td>${(rs.credit==0)?'':rs.credit}</td>`
							data+='<td>'+Number(remaining).toFixed(2)+'</td>'
							data+='</tr>'
							$('#result').append(data);
					});
					var tdata='<tr>';
						tdata+='<th colspan="5" class="text-right">Total (Rs.) : </th>'
						tdata+='<th>'+Math.round((tremaining/1000)*100)/100+'</th>'
						tdata+='</tr>'
					$('#result').append(tdata);
					$('#result').append('</tbody>');
					$('#result').show();
					$('#loader').hide();
				}
			});
		}
		
		
		
		
		
		
		//get date wise report
		let getAccountTransactionReport= (from_date,to_date,category_type,category_id,plant_id) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'../PettyCashControllerTest?action=getAccountTransactionReport&from_date='
								+from_date+'&to_date='+to_date+'&category_id='+category_id+'&plant_id='+plant_id+'&category_type='+category_type,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					console.log(res);
					$('#result').empty();
					row='<thead>'
					row+='<tr><td colspan="8" class="text-center"><strong>Account Transaction Report</strong> ( From Date : '+from_date+' - To Date:'+to_date+')</td>'
					row+='</tr>'
					row+='<tr>'
					row+='<tr>'
					row+='<th>A/C Name</th>'
					row+='<th>Debit</th>'
					row+='<th>Credit</th>'
					row+='<th>Remaining</th>'
					row+='</tr>'
					row+='</thead>'
					
					row+='<tbody>'
					$('#result').append(row);
					//set calculation value
//					let totalQuantity=0;
					let sl_no=0;
					$.each(res,function(i,rs){
						var data='<tr>'
							data+='<td>'+rs.category_name+'</td>'
							data+=`<td>${(rs.debit==0)?'':rs.debit}</td>`
							data+=`<td>${(rs.credit==0)?'':rs.credit}</td>`
							data+=`<td>${(rs.debit-rs.credit).toFixed(2)}</td>`
							data+='</tr>'
							$('#result').append(data);
					});
					
					
					$('#result').append('</tbody>');
					$('#result').show();
					$('#loader').hide();
				}
			});
		}
		
		
		
		
		
		
		
		
		
		
	
		
		
		
		
		
		
		
});