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
				
				let bank_detail_id=$('#bank_detail_id').val();
				let bank_name=$('#bank_detail_id option:selected').text();
				
				if(report_type=='date'){
					validateDateReport(from_date,to_date);
					getDateWiseReport(from_date,to_date,bank_detail_id,bank_name);
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
		let getDateWiseReport= (from_date,to_date,bank_detail_id,bank_name) => {
			$('#result').hide();
			$('#loader').show();
			$.ajax({
				type:'post',
				url:'BankDetailController?action=getTransactionReport&from_date='
								+from_date+'&to_date='+to_date+'&bank_detail_id='+bank_detail_id+'&business_id='+session.business_id,
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					let balance=0;
					let tcredit=Number(res.opening);
					let tdebit=0;
					balance=Number(res.opening);
					$('#result').empty();
					row='<thead>'
					row+='<tr><td colspan="7" class="text-center"><span style="color:#fd7e14;"><strong>Transaction Report Report</strong></span> <br>( From Date : '+from_date+' - To Date:'+to_date+' )<br><strong style="color:#02c0ce;">'+bank_name+'<strong></td>'
					row+='</tr>'
					row+='<tr>'
					row+='<tr style="color:#fd7e14;">'
					row+='<th>Date</th>'
					row+='<th>Particular</th>'
					row+='<th>Credit</th>'
					row+='<th>Debit</th>'
					row+='<th>Balance</th>'
					row+='<th>Mode</th>'
					row+='<th>Remarks</th>'
					row+='</tr>'
					row+='</thead>'
					
					
					row+='<tbody>'
					row+='<tr>';
					row+='<td colspan="2">Opening Balance Before '+from_date+'</td>'
					row+=`<td>${Math.round(res.opening*100)/100}</td>`
					row+=`<td></td>`
					row+=`<td>${Math.round(balance*100)/100}</td>`
					row+=`<td></td>`
					row+=`<td></td>`
					row+=`</tr>`
					$('#result').append(row);
					$.each(res.list,function(i,rs){
						balance+=(Number(rs.credit)-Number(rs.debit));
						var data='<tr>'
							data+='<td>'+rs.payment_date+'</td>'
							data+='<td>'+rs.person+'</td>'
							data+='<td>'+Math.round(rs.credit*100)/100+'</td>'
							data+='<td>'+Math.round(rs.debit*100)/100+'</td>'
							data+='<td>'+Math.round(balance*100)/100+'</td>'
							data+='<td>'+(rs.mode || "")+'</td>'
							data+='<td>'+rs.remarks+'</td>'
							data+='</tr>'
							$('#result').append(data);
						tcredit+=Number(rs.credit);
						tdebit+=Number(rs.debit);
					});
					
					
					var tdata='<tr style="color:#02c0ce;">';
						tdata+='<th colspan="2" class="text-right">Total</th>'
						tdata+=`<th>${Math.round(tcredit*100)/100}</th>`
						tdata+=`<th>${Math.round(tdebit*100)/100}</th>`
						tdata+=`<th>${Math.round(balance*100)/100}</th>`
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