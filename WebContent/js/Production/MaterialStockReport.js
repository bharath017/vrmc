$(document).ready(function(){
	
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
		   }else if(report_type=='stock'){
			   $('.date').show();
			   $('.date').prop('disabled',false);
			   
			   $('.no-date').hide();
			   $('.no-date').prop('disabled',true);
			   
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
				
				let product_id=$('#product_id').val();
				let plant_id=$('#plant_id').val();
				
				if(report_type=='date'){
					validateDateReport(from_date,to_date);
					getDateWiseReport(from_date,to_date,product_id,plant_id);
				}else if(report_type=='stock'){
					validateDateReport(from_date,to_date);
					getStockReport(from_date,to_date,product_id,plant_id);
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
		let getDateWiseReport= (from_date,to_date,product_id,plant_id) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'StockController?action=getDateWiseReport&from_date='
								+from_date+'&to_date='+to_date+'&product_id='+product_id+'&plant_id='+plant_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					console.log(res);
					$('#result').empty();
					row='<thead>'
					row+='<tr><td colspan="8" class="text-center"><strong>Date Wise Production Report</strong> ( From Date : '+from_date+' - To Date:'+to_date+')</td>'
					row+='</tr>'
					row+='<tr>'
					row+='<tr>'
					row+='<th>S/L No</th>'
					row+='<th>Date</th>'
					row+='<th>Material</th>'
					row+='<th>Unit</th>'
					row+='<th>Quantity</th>'
					row+='<th>Production cost</th>'
					row+='<th>Raw Material</th>'
					row+='<th>Added By</th>'
					row+='</tr>'
					row+='</thead>'
					
					row+='<tbody>'
					$('#result').append(row);
					//set calculation value
					let totalQuantity=0;
					let sl_no=0;
					$.each(res,function(i,rs){
						sl_no+=1;
						var data='<tr>'
							data+='<td>'+sl_no+'</td>'
							data+='<td>'+rs.date+'</td>'
							data+='<td>'+rs.product_name+'</td>'
							data+='<td>'+rs.unit_of_measurement+'</td>'
							data+='<td>'+rs.quantity+'</td>'
							data+='<td>'+(rs.production_cost || 0)+'</td>'
							data+='<td>'+rs.tquantity+'</td>'
							data+='<td>'+rs.added_by+'</td>'
							data+='</tr>'
							$('#result').append(data);
						totalQuantity+=Number(rs.quantity);
					});
					
					
					var tdata='<tr>';
						tdata+='<th colspan="4" class="text-right">Total</th>'
						tdata+='<th>'+totalQuantity+'</th>'
						tdata+='<th colspan="3"></th>'
						tdata+='</tr>'
					$('#result').append(tdata);
					$('#result').append('</tbody>');
					$('#result').show();
					$('#loader').hide();
				}
			});
		}
		
		
		//get stock report
		let getStockReport= (from_date,to_date,product_id,plant_id) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'StockController?action=getStockReport&from_date='
								+from_date+'&to_date='+to_date+'&product_id='+product_id+'&plant_id='+plant_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					console.log(res);
					$('#result').empty();
					row='<thead>'
					row+='<tr><td colspan="10" class="text-center"><strong>Production Stock Report</strong> ( From Date : '+from_date+' - To Date:'+to_date+')</td>'
					row+='</tr>'
					row+='<tr>'
					row+='<tr>'
					row+='<th>S/L No</th>'
					row+='<th>Item Name</th>'
					row+='<th>Unit</th>'
					row+='<th>Opening Quantity</th>'
					row+='<th>Production Quantity</th>'
					row+='<th>Outgoing Quantity(B)</th>'
					row+='<th>Outgoing Quantity(N)</th>'
					row+='<th>Remaining Stock</th>'
					row+='<th>Cost</th>'
					row+='<th>Total Amount</th>'
					row+='</tr>'
					row+='</thead>'
					
					row+='<tbody>'
					$('#result').append(row);
					//set calculation value
					let sl_no=0;
					$.each(res,function(i,rs){
						sl_no+=1;
						let remaining=((rs.opening_incoming-(rs.opening_outgoing+rs.opening_outgoing_gst))+rs.total_production)-(rs.total_sales+rs.total_sales_gst);
						
						var data='<tr>'
							data+='<td>'+sl_no+'</td>'
							data+='<td>'+rs.product_name+'</td>'
							data+='<td>'+rs.unit_of_measurement+'</td>'
							data+='<td>'+(Math.round((rs.opening_incoming-(rs.opening_outgoing+rs.opening_outgoing_gst))*100)/100)+'</td>'
							data+='<td>'+rs.total_production+'</td>'
							data+='<td>'+(Math.round(rs.total_sales*100)/100)+'</td>'
							data+='<td>'+(Math.round(rs.total_sales_gst*100)/100)+'</td>'
							data+='<td>'+Math.round(remaining*100)/100+'</td>'
							data+='<td>'+(rs.avg_price || 0).toFixed(2)+'</td>'
							data+='<td>'+((remaining*rs.avg_price) || 0).toFixed(2)+'</td>'
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