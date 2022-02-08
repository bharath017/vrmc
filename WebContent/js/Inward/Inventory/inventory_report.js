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
				var supplier_id=$('select[name="supplier_id"]').val();
				var inv_item_id=$('select[name="inv_item_id"]').val();
				var plant_id=$('select[name="plant_id"]').val();
				if(report_type=='dw'){
					validateDateReport(from_date,to_date);
					getDateWiseReport(from_date,to_date,supplier_id,inv_item_id,plant_id);
				}else if(report_type=='sw'){
					if(supplier_id==0){
						alert('Choose Supplier');
						return false;
					}
					
					let supplier_name=$('#supplier_id option:selected').text();
					//validateDateReport(from_date,to_date);
					getSupplierWiseReport(from_date,to_date,
							supplier_id,inv_item_id,plant_id,supplier_name);
				}else if(report_type=='swd'){
					validateDateReport(from_date,to_date);
					supplierwithDatewiseReport(from_date,
							to_date,supplier_id,inv_item_id,plant_id);	
				}else if(report_type=='stock'){
					validateDateReport(from_date,to_date);
					getStockReport(from_date,to_date,inv_item_id,plant_id);	
				}else if(report_type=='dwgs'){
					validateDateReport(from_date,to_date);
					getDateWithItemGroupWise(from_date,to_date,inv_item_id,plant_id);
				}else if(report_type=='dgs'){
					if(supplier_id==0){
						alert('Choose Supplier');
						return false;
					}
					let supplier_name=$('#supplier_id option:selected').text();
					getSupplierwithItemGroupBy(from_date,to_date,supplier_id,inv_item_id,plant_id,supplier_name);
				}else if(report_type=='swdgi'){
					validateDateReport(from_date,to_date);
					getSupplierWithDateWiseGroupReport(from_date,to_date,supplier_id,inv_item_id,plant_id);
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
		let getDateWiseReport= (from_date,to_date,supplier_id,inv_item_id,plant_id) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'InventoryController?action=GetInventoryReport&from_date='
					+from_date+'&to_date='+to_date+'&supplier_id='
					+supplier_id+'&inv_item_id='+inv_item_id+'&plant_id='+plant_id+'&business_id='+session.business_id,
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
		
		
		
		//get Supplier Wise Report
		let getSupplierWiseReport= (from_date,to_date,supplier_id,inv_item_id,plant_id,supplier_name) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'InventoryController?action=GetInventoryReport&from_date='
					+from_date+'&to_date='+to_date+'&supplier_id='
					+supplier_id+'&inv_item_id='+inv_item_id+'&plant_id='+plant_id+'&business_id='+session.business_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					console.log(res);
					$('#result').empty();
					row='<thead>'
						row+='<tr><td colspan="15" class="text-center"><strong>Supplier Wise Report</strong> ( Supplier Name : '+supplier_name+')</td>'
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
						tdata+='</tr>'
					$('#result').append(tdata);
					$('#result').append('</tbody>');
					$('#result').show();
					$('#loader').hide();
				}
			});
		}
		
		
		//get date wise report
		let supplierwithDatewiseReport= (from_date,to_date,supplier_id,inv_item_id,plant_id) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'InventoryController?action=getSupplierWithDateWiseReport&from_date='
					+from_date+'&to_date='+to_date+'&supplier_id='
					+supplier_id+'&inv_item_id='+inv_item_id+'&plant_id='+plant_id+'&business_id='+session.business_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					console.log(res);
					$('#result').empty();
					row='<thead>'
						row+='<tr><td colspan="17" class="text-center"><strong>Supplier With Date Wise Report</strong> ( From Date : '+from_date+' - To Date:'+to_date+')</td>'
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
					    row+='<th>Vehicle No</th>'
					    row+='<th>Plant</th>'
						row+='</tr>'
						row+='</thead>'
					
					row+='<tbody>'
					$('#result').append(row);
					//set calculation value
					let sl_no=0;
					let sup_id=0;
					let sup_loaded=0;
					let sup_empty=0;
					let sup_net=0;
					let sup_sup=0;
					let total_empty=0;
					let total_loaded=0;
					let total_net=0;
					let total_sup=0;
					$.each(res,function(i,rs){
						sl_no+=1;
						
						
						if(sup_id!=0 && sup_id!=rs.supplier_id){
							let html='<tr style="color:#fd7e14;">'
								html+='<th class="text-right" colspan="4">Total </th>'
								html+='<th>'+Math.round(sup_empty*100)/100+'</th>'
								html+='<th>'+Math.round(sup_loaded*100)/100+'</th>'
								html+='<th>'+Math.round(sup_net*100)/100+'</th>'
								html+='<th>'+Math.round(sup_sup*100)/100+'</th>'
								html+='<th></th>'
								html+='<th></th>'
								html+='<th></th>'
								html+'</tr>'
								
								$('#result').append(html);
						}
						
						if(sup_id!=rs.supplier_id){
							let html='<tr>'
								html+='<th style="color:#02c0ce;" colspan="11" class="text-left">'+rs.supplier_name+'</th>'
								html+='</tr>'
								$('#result').append(html);
							sup_id=rs.supplier_id;
						}
						
						
						
						
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
							data+='<td>'+(rs.vehicle_no || "")+'</td>'
							data+='<td>'+rs.plant_name+'</td>'
							data+='</tr>'
							$('#result').append(data);
						
						sup_loaded+=Number(rs.loaded_weight);
						sup_empty+=Number(rs.empty_weight);
						sup_net+=Number(rs.net_weight);
						sup_sup+=Number(rs.supplier_weight);
						
						
						 total_empty+=Number(rs.empty_weight);
						 total_loaded+=Number(rs.loaded_weight);
						 total_net+=Number(rs.net_weight);
						 total_sup+=Number(rs.supplier_weight);
						
					});
					
					
					
					let html='<tr>'
						html+='<th class="text-right" colspan="4">Total IN (TON) </th>'
						html+='<th>'+Math.round((total_empty/1000)*100)/100+'</th>'
						html+='<th>'+Math.round((total_loaded/1000)*100)/100+'</th>'
						html+='<th>'+Math.round((total_net/1000)*100)/100+'</th>'
						html+='<th>'+Math.round((total_sup/1000)*100)/100+'</th>'
						html+='<th></th>'
						html+='<th></th>'
						html+='<th></th>'
						html+'</tr>'
						
					$('#result').append(html);
					$('#result').append('</tbody>');
					$('#result').show();
					$('#loader').hide();
				}
			});
		}
		
		
		
		
		//get date wise report
		let getStockReport= (from_date,to_date,inv_item_id,plant_id) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'InventoryController?action=getStockReport&from_date='
								+from_date+'&to_date='+to_date+'&inv_item_id='+inv_item_id+'&plant_id='+plant_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					console.log(res);
					$('#result').empty();
					row='<thead>'
					row+='<tr><td colspan="8" class="text-center"><strong>Inventory stock Report</strong> ( From Date : '+from_date+' - To Date:'+to_date+')</td>'
					row+='</tr>'
					row+='<tr>'
					row+='<tr>'
					row+='<th>S/L No</th>'
					row+='<th>Item Name</th>'
					row+='<th>Unit</th>'
					row+='<th>Opening Stock</th>'
					row+='<th>Incoming Stock</th>'
					row+='<th>Outgoing Stock</th>'
					row+='<th>Closing Stock</th>'
					row+='</tr>'
					row+='</thead>'
					
					row+='<tbody>'
					$('#result').append(row);
					//set calculation value
//					let totalQuantity=0;
					let sl_no=0;
					$.each(res,function(i,rs){
						sl_no+=1;
						let opening_stock=(rs.opening_incoming || 0)-(rs.opening_outgoing || 0);
						let closeing_stock=(opening_stock+(rs.total_incoming || 0))-(rs.total_outgoing || 0)
						var data='<tr>'
							data+='<td>'+sl_no+'</td>'
							data+='<td>'+rs.inventory_name+'</td>'
							data+='<td>TON</td>'
							data+='<td>'+Math.round((opening_stock/1000)*100)/100+'</td>'
							data+='<td>'+(Math.round((rs.total_incoming/1000)*100)/100 || 0)+'</td>'
							data+='<td>'+(Math.round((rs.total_outgoing/1000)*100)/100 || 0)+'</td>'
							data+='<td>'+Math.round((closeing_stock/1000)*100)/100+'</td>'
							data+='</tr>'
							$('#result').append(data);
					});
					
					
					$('#result').append('</tbody>');
					$('#result').show();
					$('#loader').hide();
				}
			});
		}
		
		
		
		//get date wise item report
		let getDateWithItemGroupWise= (from_date,to_date,inv_item_id,plant_id) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'InventoryController?action=getDateWithItemGroupBy&from_date='
								+from_date+'&to_date='+to_date+'&inv_item_id='+inv_item_id+'&plant_id='+plant_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					console.log(res);
					$('#result').empty();
					row='<thead>'
					row+='<tr><td colspan="8" class="text-center"><strong>Date With Item Group By </strong> ( From Date : '+from_date+' - To Date:'+to_date+')</td>'
					row+='</tr>'
					row+='<tr>'
					row+='<tr>'
					row+='<th>S/L No</th>'
					row+='<th>Date</th>'
					row+='<th>Inventory Name</th>'
					row+='<th>Quantity</th>'
					row+='<th>Quantity (TON)</th>'
					row+='</tr>'
					row+='</thead>'
					
					row+='<tbody>'
					$('#result').append(row);
					//set calculation value
					let sl_no=0;
					$.each(res,function(i,rs){
						sl_no+=1;
						var data='<tr>'
							data+='<td>'+sl_no+'</td>'
							data+='<td>'+rs.inventory_date+'</td>'
							data+='<td>'+rs.inventory_name+'</td>'
							data+='<td>'+rs.net_weight+'</td>'
							data+='<td>'+((Math.round((rs.net_weight/1000)*100)/100) || 0)+'</td>'
							data+='</tr>'
							$('#result').append(data);
					});
					$('#result').append('</tbody>');
					$('#result').show();
					$('#loader').hide();
				}
			});
		}
		
		
		
		//get supplier with item group wise report
		let getSupplierwithItemGroupBy= (from_date,to_date,supplier_id,inv_item_id,plant_id,supplier_name) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'InventoryController?action=getGroupBySupplierName&from_date='
								+from_date+'&to_date='+to_date+'&inv_item_id='+inv_item_id+'&plant_id='+plant_id+'&supplier_id='+supplier_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					console.log(res);
					$('#result').empty();
					row='<thead>'
					row+='<tr><td colspan="7" class="text-center"><strong>Supplier With Item Group By </strong> ( Supplier Name : '+supplier_name+')</td>'
					row+='</tr>'
					row+='<tr>'
					row+='<tr>'
					row+='<th>S/L No</th>'
					row+='<th>Inventory Name</th>'
					row+='<th>Quantity</th>'
					row+='<th>Quantity (TON)</th>'
					row+='</tr>'
					row+='</thead>'
					
					row+='<tbody>'
					$('#result').append(row);
					//set calculation value
					let sl_no=0;
					$.each(res,function(i,rs){
						sl_no+=1;
						var data='<tr>'
							data+='<td>'+sl_no+'</td>'
							data+='<td>'+rs.inventory_name+'</td>'
							data+='<td>'+rs.net_weight+'</td>'
							data+='<td>'+((Math.round((rs.net_weight/1000)*100)/100) || 0)+'</td>'
							data+='</tr>'
							$('#result').append(data);
					});
					$('#result').append('</tbody>');
					$('#result').show();
					$('#loader').hide();
				}
			});
		}
		
		
		
		
		
		//get Supplier with date wise group report
		let getSupplierWithDateWiseGroupReport= (from_date,to_date,supplier_id,inv_item_id,plant_id) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'InventoryController?action=getSupplierWithDateWiseGroupBy&from_date='
					+from_date+'&to_date='+to_date+'&supplier_id='
					+supplier_id+'&inv_item_id='+inv_item_id+'&plant_id='+plant_id+'&business_id='+session.business_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					console.log(res);
					$('#result').empty();
					row='<thead>'
						row+='<tr><td colspan="5" class="text-center"><strong>Supplier With Date Wise Report (Group By Item)</strong> ( From Date : '+from_date+' - To Date:'+to_date+')</td>'
						row+='</tr>'
						row+='<tr>'
						row+='<tr>'
						row+='<th>S/L No</th>'
						row+='<th>Date</th>'
						row+='<th>Item name</th>'
						row+='<th>Quantity</th>'
					    row+='<th>Quantity(TON)</th>'
						row+='</tr>'
						row+='</thead>'
					
					row+='<tbody>'
					$('#result').append(row);
					//set calculation value
					let sl_no=0;
					let sup_id=0;
					$.each(res,function(i,rs){
						sl_no+=1;
						
						/*
						if(sup_id!=0 && sup_id!=rs.supplier_id){
							let html='<tr style="color:#fd7e14;">'
								html+='<th class="text-right" colspan="4">Total </th>'
								html+='<th>'+Math.round(sup_empty*100)/100+'</th>'
								html+='<th>'+Math.round(sup_loaded*100)/100+'</th>'
								html+='<th>'+Math.round(sup_net*100)/100+'</th>'
								html+='<th>'+Math.round(sup_sup*100)/100+'</th>'
								html+='<th></th>'
								html+='<th></th>'
								html+='<th></th>'
								html+'</tr>'
								
								$('#result').append(html);
						}*/
						
						if(sup_id!=rs.supplier_id){
							let html='<tr>'
								html+='<th style="color:#02c0ce;" colspan="5" class="text-left">'+rs.supplier_name+'</th>'
								html+='</tr>'
								$('#result').append(html);
							sup_id=rs.supplier_id;
						}
						
						
						
						
						var data='<tr>'
							data+='<td>'+sl_no+'</td>'
							data+='<td>'+rs.date+'</td>'
							data+='<td>'+rs.inventory_name+'</td>'
							data+='<td>'+Math.round(rs.net_weight*100)/100+'</td>'
							data+='<td>'+Math.round((rs.net_weight/1000)*100)/100+'</td>'
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