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
		   }else if(report_type=='supplier'){
			   $('.supplier').show();
			   $('.supplier').prop('disabled',false);
			   
			   $('.no-supplier').hide();
			   $('.no-supplier').prop('disabled',true);
		   }else if(report_type=='supplierdate'){
			   $('.supplierdate').show();
			   $('.supplierdate').prop('disabled',false);
			   
			   $('.no-supplierdate').hide();
			   $('.no-supplierdate').prop('disabled',true);
		   }else if(report_type=='bank'){
			   $('.bank').show();
			   $('.bank').prop('disabled',false);
			   
			   $('.no-bank').hide();
			   $('.no-bank').prop('disabled',true);
			   
		   }else if(report_type=='transaction'){
			   $('.transaction').show();
			   $('.transaction').prop('disabled',false);
			   
			   $('.no-transaction').hide();
			   $('.no-transaction').prop('disabled',true);
		   }
		   
	   }
	   
	   let report_type=$('#report_type').val();
	   changeReportType(report_type);
	   
	   $('#report_type').on('change',function(){
		  let report_type=$('#report_type').val();
		  changeReportType(report_type);
	   });
	   
	   
	   //get supplier
	   let getSupplierByBusinessGroup=(business_id) => {
		   if(business_id!=undefined && !isNaN(business_id)){
				$.ajax({
   				type:'post',
   				url:'SupplierController?action=getSupplierListByBusinessGroup&business_id='+business_id,
   				headers:{
   					Accept:"application/json;charset=utf-8",
   					"Content-Type":"application/json;charset=utf-8"
   				},
   				success:function(res){
   					$('#supplier_id').empty();
   					$('#supplier_id').append('<option value="0" selected >All Supplier</option>');
   					$('#select2-supplier_id-container').text('All Supplier');
   					$.each(res,function(i,v){
   						$('#supplier_id').append('<option value="'+v.supplier_id+'">'+v.supplier_name+'</option>');
   					});
   					
   				}
   			});
			}
	   }
	   
	   var business_id=$('#business_id').val();
	   getSupplierByBusinessGroup(business_id);
		
	  $('#business_id').on('change',function(){
			var business_id=$('#business_id').val();
			getSupplierByBusinessGroup(business_id);
	  });
	  
	  //get bank details
	  let getBankListByBusinessGroup=(business_id) => {
		  if(business_id!=undefined && !isNaN(business_id)){
				$.ajax({
 				type:'post',
 				url:'BankDetailController?action=getBankListByBusinessGroup&business_id='+business_id,
 				headers:{
 					Accept:"application/json;charset=utf-8",
 					"Content-Type":"application/json;charset=utf-8"
 				},
 				success:function(res){
 					$('#bank_detail_id').empty();
 					$('#bank_detail_id').append('<option value="0" selected >All Bank</option>');
 					$('#select2-bank_detail_id-container').text('All Bank');
 					$.each(res,function(i,v){
 						$('#bank_detail_id').append('<option value="'+v.bank_detail_id+'">'+v.bank_name+'('+v.group_name+')</option>');
 					});
 					
 				}
 			});
		}
	  }
	  
	  var business_id=$('#business_id').val();
	  getBankListByBusinessGroup(business_id);
		
	  $('#business_id').on('change',function(){
			var business_id=$('#business_id').val();
			getBankListByBusinessGroup(business_id);
	  });
	  
	  
	  //click to generate report
		$('#generate').on('click',function(){
				$('#show-excel').hide();
				var report_type=$('#report_type').val();
				var from_date=$('input[name="from_date"]').val();
				var to_date=$('input[name="to_date"]').val();
				
				let supplier_id=$('#supplier_id').val();
				let bank_detail_id=$('#bank_detail_id').val();
				let business_id=$('#business_id').val();
				
				if(report_type=='date'){
					validateDateReport(from_date,to_date);
					getDateWiseReport(from_date,to_date,business_id);
				}else if(report_type=='supplier'){
					let supplier_name=$('#supplier_id option:selected').text();
					if(supplier_id==0){
						alert('select supplier');
						return false;
					}
					getSupplierWiseReport(supplier_id,supplier_name,business_id);
				}else if(report_type=='supplierdate'){
					validateDateReport(from_date,to_date);
					let supplier_name=$('#supplier_id option:selected').text();
					getSupplierWithDateWiseReport(supplier_id,supplier_name,from_date,to_date,business_id)
				}else if(report_type=='bank'){
					if(bank_detail_id==0){
						alert('Select Bank');
						return false;
					}
					let bank_name=$('#bank_detail_id option:selected').text();
					getBankWiseReport(bank_detail_id,bank_name,from_date,to_date,business_id);
				}else if(report_type=='transaction'){
					validateDateReport(from_date,to_date);
					getTransactionReport(from_date,to_date,business_id);
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
		let getDateWiseReport= (from_date,to_date,business_id) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'MakePaymentController?action=getDateWiseReport&from_date='+from_date+'&to_date='+to_date+'&business_id='+business_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					console.log(res);
					$('#result').empty();
					row='<thead>'
					row+='<tr><td colspan="7" class="text-center"><strong>Date Wise Report</strong> ( From Date : '+from_date+' - To Date:'+to_date+')</td>'
					row+='</tr>'
					row+='<tr>'
					row+='<tr>'
					row+='<th>Date</th>'
					row+='<th>Payment ID</th>'
					row+='<th>Amount</th>'
					row+='<th>Mode</th>'
					row+='<th>Supplier</th>'
					row+='<th>Bank</th>'
					row+='<th>Remark</th>'
					row+='</tr>'
					row+='</thead>'
					
					row+='<tbody>'
					$('#result').append(row);
					//set calculation value
					let totalAmount=0;
					$.each(res,function(i,rs){
						var data='<tr>'
							data+='<td>'+rs.payment_date+'</td>'
							data+='<td>'+rs.payment_id+'</td>'
							data+='<td>'+rs.payment_amount+'</td>'
							data+='<td>'+rs.payment_mode+'</td>'
							data+='<td>'+rs.supplier_name+'</td>'
							data+='<td>'+rs.bank_name+'</td>'
							if(rs.payment_mode=='CASH')
								data+='<td>Payment Recived By Cash</td>'
							else if(rs.payment_mode=='CHEQUE/DD')
								data+='<td>Cheque No :'+rs.check_dd_no+' With Validity Date : '+rs.check_dd_validity+'</td>'
							else if(rs.payment_mode=='NEFT/RTGS')
								data+='<td>Neft No :'+rs.check_dd_no+'</td>'
							data+='</tr>'
							$('#result').append(data);
						totalAmount+=Number(rs.payment_amount);
					});
					
					
					var tdata='<tr>';
						tdata+='<th colspan="2">Total</th>'
						tdata+='<th>'+totalAmount+'</th>'
						tdata+='<th colspan="7"></th>'
						tdata+='</tr>'
					$('#result').append(tdata);
					$('#result').append('</tbody>');
					$('#result').show();
					$('#loader').hide();
				}
			});
		}
		
		
		
		
		
		//supplier with date wise report
		let getSupplierWiseReport= (supplier_id,supplier_name,business_id) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'MakePaymentController?action=getSupplierWiseReport&supplier_id='+supplier_id+'&business_id='+business_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					console.log(res);
					$('#result').empty();
					row='<thead>'
					row+='<tr><td colspan="7" class="text-center"><strong>Supplier Wise Report</strong> ( Supplier : '+supplier_name+')</td>'
					row+='</tr>'
					row+='<tr>'
					row+='<tr>'
					row+='<th>Date</th>'
					row+='<th>Payment ID</th>'
					row+='<th>Amount</th>'
					row+='<th>Mode</th>'
					row+='<th>Supplier</th>'
					row+='<th>Bank</th>'
					row+='<th>Remark</th>'
					row+='</tr>'
					row+='</thead>'
					
					row+='<tbody>'
					$('#result').append(row);
					//set calculation value
					let totalAmount=0;
					$.each(res,function(i,rs){
						var data='<tr>'
							data+='<td>'+rs.payment_date+'</td>'
							data+='<td>'+rs.payment_id+'</td>'
							data+='<td>'+rs.payment_amount+'</td>'
							data+='<td>'+rs.payment_mode+'</td>'
							data+='<td>'+rs.supplier_name+'</td>'
							data+='<td>'+rs.bank_name+'</td>'
							if(rs.payment_mode=='CASH')
								data+='<td>Payment Recived By Cash</td>'
							else if(rs.payment_mode=='CHEQUE/DD')
								data+='<td>Cheque No :'+rs.check_dd_no+' With Validity Date : '+rs.check_dd_validity+'</td>'
							else if(rs.payment_mode=='NEFT/RTGS')
								data+='<td>Neft No :'+rs.check_dd_no+'</td>'
							data+='</tr>'
							$('#result').append(data);
						totalAmount+=Number(rs.payment_amount);
					});
					
					
					var tdata='<tr>';
						tdata+='<th colspan="2">Total</th>'
						tdata+='<th>'+totalAmount+'</th>'
						tdata+='<th colspan="7"></th>'
						tdata+='</tr>'
					$('#result').append(tdata);
					$('#result').append('</tbody>');
					$('#result').show();
					$('#loader').hide();
				}
			});
		}
		
		
		
		//supplier with date wise report
		let getSupplierWithDateWiseReport= (supplier_id,supplier_name,from_date,to_date,business_id) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'MakePaymentController?action=getSupplierWithDateWise&supplier_id='
							+supplier_id+'&business_id='+business_id+'&from_date='+from_date+'&to_date='+to_date,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					console.log(res);
					$('#result').empty();
					row='<thead>'
					row+='<tr><td colspan="6" class="text-center"><strong>Supplier With Date Wise Report</strong> (From Date : '+from_date+' -  To Date : '+to_date+' -  Supplier : '+supplier_name+')</td>'
					row+='</tr>'
					row+='<tr>'
					row+='<tr>'
					row+='<th>Date</th>'
					row+='<th>Payment ID</th>'
					row+='<th>Amount</th>'
					row+='<th>Mode</th>'
					row+='<th>Bank</th>'
					row+='<th>Remark</th>'
					row+='</tr>'
					row+='</thead>'
					
					row+='<tbody>'
					$('#result').append(row);
					//set calculation value
					let totalAmount=0;
					let supplier_id=0;
					let supplierTotal=0;
					$.each(res,function(i,rs){
						console.log(rs.supplier_id);
						var data='';
						if(rs.supplier_id==supplier_id){
							data+='<tr>'
							data+='<td>'+rs.payment_date+'</td>'
							data+='<td>'+rs.payment_id+'</td>'
							data+='<td>'+rs.payment_amount+'</td>'
							data+='<td>'+rs.payment_mode+'</td>'
							data+='<td>'+rs.bank_name+'</td>'
							if(rs.payment_mode=='CASH')
								data+='<td>Payment Recived By Cash</td>'
							else if(rs.payment_mode=='CHEQUE/DD')
								data+='<td>Cheque No :'+rs.check_dd_no+' With Validity Date : '+rs.check_dd_validity+'</td>'
							else if(rs.payment_mode=='NEFT/RTGS')
								data+='<td>Neft No :'+rs.check_dd_no+'</td>'
							data+='</tr>'
						}else{
							if(supplier_id!=0){
								data='<tr>';
								data+='<th colspan="2">Supplier Total</th>'
								data+='<th>'+supplierTotal+'</th>'
								data+='<th colspan="3"></th>'
								data+='</tr>'
							}
							supplier_id=rs.supplier_id;
							data+='<tr>'
							data+='<td colspan="6" class="text-left"><strong>'+rs.supplier_name+'</strong></td>'
							data+='</tr>'
							data+='<tr>'
							data+='<td>'+rs.payment_date+'</td>'
							data+='<td>'+rs.payment_id+'</td>'
							data+='<td>'+rs.payment_amount+'</td>'
							data+='<td>'+rs.payment_mode+'</td>'
							data+='<td>'+rs.bank_name+'</td>'
							if(rs.payment_mode=='CASH')
								data+='<td>Payment Recived By Cash</td>'
							else if(rs.payment_mode=='CHEQUE/DD')
								data+='<td>Cheque No :'+rs.check_dd_no+' With Validity Date : '+rs.check_dd_validity+'</td>'
							else if(rs.payment_mode=='NEFT/RTGS')
								data+='<td>Neft No :'+rs.check_dd_no+'</td>'
							data+='</tr>'
								
							supplierTotal=0;
						}
						 $('#result').append(data);
						 supplierTotal+=Number(rs.payment_amount);
						 totalAmount+=Number(rs.payment_amount);
					});
					
					
					var tdata='<tr>';
						tdata+='<th colspan="2">Overall Total</th>'
						tdata+='<th>'+totalAmount+'</th>'
						tdata+='<th colspan="3"></th>'
						tdata+='</tr>'
					$('#result').append(tdata);
					$('#result').append('</tbody>');
					$('#result').show();
					$('#loader').hide();
				}
			});
		}
	  
		
		
		
		//get bankwise report
		let getBankWiseReport= (bank_detail_id,bank_name,from_date,to_date,business_id) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'MakePaymentController?action=getBankWiseReport&bank_detail_id='
							+bank_detail_id+'&business_id='+business_id+'&from_date='+from_date+'&to_date='+to_date,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					console.log(res);
					$('#result').empty();
					row='<thead>'
					row+='<tr><td colspan="7" class="text-center"><strong>Bank Wise Report</strong> (From Date : '+from_date+' - To Date : '+to_date+' - Bank : '+bank_name+')</td>'
					row+='</tr>'
					row+='<tr>'
					row+='<tr>'
					row+='<th>Date</th>'
					row+='<th>Payment ID</th>'
					row+='<th>Amount</th>'
					row+='<th>Mode</th>'
					row+='<th>Supplier</th>'
					row+='<th>Bank</th>'
					row+='<th>Remark</th>'
					row+='</tr>'
					row+='</thead>'
					
					row+='<tbody>'
					$('#result').append(row);
					//set calculation value
					let totalAmount=0;
					$.each(res,function(i,rs){
						var data='<tr>'
							data+='<td>'+rs.payment_date+'</td>'
							data+='<td>'+rs.payment_id+'</td>'
							data+='<td>'+rs.payment_amount+'</td>'
							data+='<td>'+rs.payment_mode+'</td>'
							data+='<td>'+rs.supplier_name+'</td>'
							data+='<td>'+rs.bank_name+'</td>'
							if(rs.payment_mode=='CASH')
								data+='<td>Payment Recived By Cash</td>'
							else if(rs.payment_mode=='CHEQUE/DD')
								data+='<td>Cheque No :'+rs.check_dd_no+' With Validity Date : '+rs.check_dd_validity+'</td>'
							else if(rs.payment_mode=='NEFT/RTGS')
								data+='<td>Neft No :'+rs.check_dd_no+'</td>'
							data+='</tr>'
							$('#result').append(data);
						totalAmount+=Number(rs.payment_amount);
					});
					
					
					var tdata='<tr>';
						tdata+='<th colspan="2">Total</th>'
						tdata+='<th>'+totalAmount+'</th>'
						tdata+='<th colspan="7"></th>'
						tdata+='</tr>'
					$('#result').append(tdata);
					$('#result').append('</tbody>');
					$('#result').show();
					$('#loader').hide();
				}
			});
		}
		
		
		
		//get Transaction report
		let getTransactionReport= (from_date,to_date,business_id) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'MakePaymentController?action=getPurchaseTransaction&business_id='+business_id+'&from_date='+from_date+'&to_date='+to_date,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					console.log(res);
					$('#result').empty();
					row='<thead>'
					row+='<tr><td colspan="7" class="text-center"><strong>Purchase Transaction Report</strong> (From Date : '+from_date+' - To Date : '+to_date+')</td>'
					row+='</tr>'
					row+='<tr>'
					row+='<tr>'
					row+='<th>Supplier Name</th>'
					row+='<th>Total Purchase</th>'
					row+='<th>Total Paid</th>'
					row+='<th>Remaining Amount</th>'
					row+='</tr>'
					row+='</thead>'
					
					row+='<tbody>'
					$('#result').append(row);
					//set calculation value
					let totalPurchase=0;
					let totalPaid=0;
					$.each(res,function(i,rs){
						if(((Math.round(rs.totalPurchase*100)/100)-(Math.round(rs.totalPaid*100)/100))!=0){
							let remainingAmount=((Math.round(rs.totalPurchase*100)/100)-(Math.round(rs.totalPaid*100)/100));
						var data='<tr>'
							data+='<td>'+rs.supplier_name+'</td>'
							data+='<td>'+(Math.round(rs.totalPurchase*100)/100)+'</td>'
							data+='<td>'+(Math.round(rs.totalPaid*100)/100)+'</td>'
							data+='<td>'+(Math.round(remainingAmount*100)/100)+'</td>'
							data+='</tr>'
							$('#result').append(data);
						totalPurchase+=Math.round(rs.totalPurchase*100)/100;
						totalPaid+=Math.round(rs.totalPaid*100)/100;
						}
					});
					
					
					var tdata='<tr>';
						tdata+='<th colspan="1">Total</th>'
						tdata+='<th>'+(Math.round(totalPurchase*100)/100)+'</th>'
						tdata+='<th>'+(Math.round(totalPaid*100)/100)+'</th>'
						tdata+='<th>'+(Math.round((totalPurchase-totalPaid)*100)/100)+'</th>'
						tdata+='</tr>'
					$('#result').append(tdata);
					$('#result').append('</tbody>');
					$('#result').show();
					$('#loader').hide();
				}
			});
		}
		
	
		
		
		

	   
	   
	   
	   
});