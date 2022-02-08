$(document).ready(function(){
	 var session=getSessionDetails();
	
	 $('.select2').css('width','100%').select2({allowClear:true})
		.on('change', function(){
	 }); 
	 
  
	 $('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true,
				"orientation":"bottom left",
				format: 'dd/mm/yyyy'
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
	  
	 
	  
	  
	  
	  //change report type
	   let changeReportType=function(report_type){
		   if(report_type=='date'){
			   $('.date').show();
			   $('.date').prop('disabled',false);
			   
			   $('.no-date').hide();
			   $('.no-date').prop('disabled',true);
		   }else if(report_type=='sw'){
			   $('.sw').show();
			   $('.sw').prop('disabled',false);
			   
			   $('.no-sw').hide();
			   $('.no-sw').prop('disabled',true);
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
				let report_type=$('#report_type').val();
				let from_date=$('input[name="from_date"]').val();
				let to_date=$('input[name="to_date"]').val();
				let e_id=document.
						 getElementById('e_id').value;
				
				if(report_type=='date'){
					validateDateReport(from_date,to_date);
					generateDateWiseForEmployeeReport(from_date,to_date,e_id);
				}else if(report_type=='sw'){
					getSupplierWiseReport(from_date,to_date,
							supplier_id,inv_item_id,plant_id,supplier_name);
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
		let generateDateWiseForEmployeeReport= (from_date,to_date,e_id) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'AttendanceController?action=getEmployeeAttendance&from_date='
					+from_date+'&to_date='+to_date+'&e_id='
					+e_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					console.log(res);
					$('#result').empty();
					row='<thead>'
						row+='<tr><td colspan="17" class="text-center"><strong>Date wise  batching Report</strong> ( From Date : '+from_date+' - To Date:'+to_date+')</td>'
						row+='</tr>'
						row+='<tr>'
						row+='<tr>'
						row+='<th>S/L No</th>'
						row+='<th>Inventory id</th>'
						row+='<th>Date</th>'
						row+='<th>Item name</th>'
						row+='<th>Empty weight</th>'
						row+='<th>Loaded weight</th>'
						row+='<th>Net weight</th>'
				        row+='<th>Supplier weight</th>'
						row+='<th>Bill no</th>'
						row+='<th>Supplier</th>'
					    row+='<th>Vehicle No</th>'
					    row+='<th>Plant</th>'
						row+='</tr>'
						row+='</thead>'
					
					row+='<tbody>'
					$('#result').append(row);
					//set calculation value
					let sl_no=0;
					let total_empty=0;
					let total_loaded=0;
					let total_net=0;
					let total_weight=0;
					$.each(res,function(i,rs){
						sl_no+=1;
						var data='<tr>'
							data+='<td>'+sl_no+'</td>'
							data+='<td>'+rs.inventory_id+'</td>'
							data+='<td>'+rs.date+'</td>'
							data+='<td>'+rs.inventory_name+'</td>'
							data+='<td>'+rs.empty_weight+'</td>'
							data+='<td>'+rs.loaded_weight+'</td>'
							data+='<td>'+rs.net_weight+'</td>'
							data+='<td>'+rs.supplier_weight+'</td>'
							data+='<td>'+rs.bill_no+'</td>'
							data+='<td>'+rs.supplier_name+'</td>'
							data+='<td>'+(rs.vehicle_no || "")+'</td>'
							data+='<td>'+rs.plant_name+'</td>'
							data+='</tr>'
							$('#result').append(data);
							total_empty+=Number(rs.empty_weight);//total_empty=total_empty+rs.empty_weight;
							total_loaded+=Number(rs.loaded_weight);
							total_net+=Number(rs.net_weight);
							total_weight+=Number(rs.supplier_weight);

					});
					var tdata='<tr>';
						tdata+='<th colspan="4" class="text-right">Total (TON) : </th>'
						tdata+='<th>'+Math.round((total_empty/1000)*100)/100+'</th>'
						tdata+='<th>'+Math.round((total_loaded/1000)*100)/100+'</th>'
						tdata+='<th>'+Math.round((total_net/1000)*100)/100+'</th>'
						tdata+='<th>'+Math.round((total_weight/1000)*100)/100+'</th>'
						tdata+='<td></td>'
						tdata+='<td></td>'
						tdata+='<td></td>'
						tdata+='<td></td>'
						tdata+='</tr>'
					$('#result').append(tdata);
					$('#result').append('</tbody>');
					$('#result').show();
					$('#loader').hide();
				}
			});
		}
		
		
});