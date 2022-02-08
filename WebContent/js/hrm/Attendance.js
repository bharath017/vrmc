$(document).ready(function(){
	
	 $('.date-picker').datepicker({
			autoclose: true,
			todayHighlight: true,
			"orientation":"bottom left"
	 });
	 
	 let initiateTimePicker = () => {
		 $('.timepicker1').timepicker({
				minuteStep: 1,
				showSeconds: false,
				showMeridian: true,
				disableFocus: true,
				defaultTime:false,
				icons: {
					up: 'fa fa-chevron-up',
					down: 'fa fa-chevron-down'
				}
			}).on('focus', function() {
				
			}).next().on('click', function(){
				$(this).prev().focus();
			});
	 }
	 
	 
	 let getEmployeeForAttedance= () => {
		 let business_id=$('#business_id').val();
		 let attendance_date=$('#attendance_date').val();
		 if(attendance_date == '' || attendance_date==null){
			 alert('Select Attendance Date');
			 return ;
		 }
		 fetch(`AttendanceController?action=getEmployeeForAttendance&business_id=${business_id}&attendance_date=${attendance_date}`,{
			method:'post',
			headers:{
				'Content-Type':'application/json;charset=utf-8'
			}
		 }).then(response => response.json())
		   .then(text => {
			   generateAttendanceList(text);
			   document.getElementById('attendance_date_result')
			           .value=attendance_date;
			   
		   });
	 }
	 
	 let generateAttendanceList= (data) => {
		 	$('#att-table tbody').empty();
		 	let count=0;
		 	data.forEach((item,index) => {
		 		let row='<tr>'
		 			row+=`<td>${item.e_id}
		 					<input type="hidden" name="e_id[${count}]" class="e_id" value="${item.e_id}"/>
		 					<input type="hidden" name="isAvailable[${count}]" value="${item.isAvailable}"
		 				  </td>`
		 			row+=`<td>${item.employee_id}</td>`
		 			row+=`<td>${item.employee_name}</td>`
		 			row+=`<td>${item.employee_phone}</td>`
		 			row+=`<td><input type="radio" value="p" name="status[${count}]" ${(item.status=='p')?'checked':''}/>Present
		 				  	  <input type="radio" value="a" name="status[${count}]" ${(item.status=='a')?'checked':''}/>Absent
		 				  	  <input type="radio" value="n" name="status[${count}]" ${(item.status=='n')?'checked':''}/>Not Taken
 		 				  </td>`
		 			row+=`<td>
		 				<div class="input-group">
                            <input type="text" name="start_time[${count}]" class="form-control timepicker1" required="required"
		 						   placeholder="HH:MM:SS" data-date-format="yyyy-mm-dd" value="${item.start_time}">
                            <div class="input-group-append">
                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
                            </div>
                        </div>
		 			</td>`
		 			row+=`<td>
		 				<div class="input-group">
                            <input type="text" name="end_time[${count}]" class="form-control timepicker1" required="required"
		 						   placeholder="HH:MM:SS"  data-date-format="yyyy-mm-dd" value="${item.end_time}">
                            <div class="input-group-append">
                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
                            </div>
                        </div>
		 			</td>`
		 			row+=`<td>
		 				<input type="text" name="description[${count}]" class="form-control" value="${(item.description || '')}"/>
		 			</td>`
		 			row+='</tr>'
		 			count++;
		 			$('#att-table tbody').append(row);
		 	});
		 	document.getElementById('count')
		 			.value=count;
		 	initiateTimePicker();
	 }
	 
	 $('#search').on('click',function(){
		 getEmployeeForAttedance();
	 });
	 
	 
	 $('#update_attendance').on('click',function(){
		 let length=$('#att-table tbody tr').length;
		 if(length==0){
			 alert('Please select atleast one employee');
			 return ;
		 }
		 let data=$('#attendance_form').serialize();
		fetch(`AttendanceController?action=updateEmployeeAttendance&${data}`,{
			method:'post'
		}).then(response => response.text())
		  .then(text => {
			  if(Number(text) > 0){
				  $.toast({
	  				    heading: 'Attendance Taken Successfully!!',
	  				    showHideTransition: 'fade',
	  				    icon: 'success',
	  				    position: 'top-right'
	  				});
				  $('#att-table tbody').empty();
			  }else{
				  $.toast({
  				    heading: 'Failed!!',
  				    showHideTransition: 'fade',
  				    icon: 'error',
  				    position: 'top-right'
  				});
			  }
		  });
	 });

	 
	 
});