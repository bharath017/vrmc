$(document).ready(function(){
	
	var FetchDetails=function(){
		var attendance_date=$('input[name="attendance_date"]').val();
		var shift_id=$('#shift_id').val();
		$.ajax({
			type:'POST',
			url:'AttendanceController?action=FetchDetails&attendance_date='+attendance_date+'&shift_id='+shift_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(res){
				$('#att-table tbody').html("");
				//shift detais
				var shift=res.shift;
				$('#shift_start_view').text(shift.start_time);
				$('#shift_end_view').text(shift.end_time);
				$('#noofemp').text(res.shiftdetails.noofemp);
				$('#noofpres').text(res.shiftdetails.noofpres);
				$('#noofabs').text(res.shiftdetails.noofabs);
				$('#noleft').text(res.shiftdetails.noofemp-(res.shiftdetails.noofpres+res.shiftdetails.noofabs));
				//get all employee
				$('#emp_id').html('<option value="" disabled selected>Select Employee</option>');
				$('#select2-emp_id-container').text("Select Employee");
				$('#emp_id').append('<option value="0">All Employee</option>');
				for (const [key, value] of Object.entries(res.employee)) {
					  $('#emp_id').append('<option value="'+key+'">'+value+'</option>');
				}
				
			}
		});
	};
	
	
	var fetchEmployee=function(){
		var emp_id=$('#emp_id').val();
		var shift_id=$('#shift_id').val();
		var attendance_date=$('input[name="attendance_date"]').val();
		$.ajax({
			type:'POST',
			url:'AttendanceController?action=getAttendanceDetails&emp_id='+emp_id+'&attendance_date='+attendance_date+'&shift_id='+shift_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(res){
				var row='';
				$('#att-table tbody').html("");
				$.each(res,function(i,v){
					var start_time=(v.start_time==undefined)?$('#shift_start_view').text():v.start_time;
					var end_time=(v.end_time==undefined)?$('#shift_end_view').text():v.end_time;
					var status=(v.status==undefined)?'A':v.status;
					var p_selected=(status=='P')?'checked':'';
					var a_selected=(status=='A')?'checked':'';
					//console.log(p_selected);
					//console.log(a_selected);
					var row='<tr>'
						row+='<td>'+v.employee_id+'<input type="hidden" name="e_id" value="'+v.e_id+'"/></td>'
						row+='<td>'+v.employee_name+'</td>'
						row+='<td><input type="time" value="'+start_time+'" name="start_time'+v.e_id+'"/></td>'
						row+='<td><input type="time" value="'+end_time+'" name="end_time'+v.e_id+'"/></td>'
						row+='<td><input type="radio" value="P" '+p_selected+' name="status'+v.e_id+'"/>P&nbsp;&nbsp;<input type="radio" value="A" '+a_selected+'  name="status'+v.e_id+'"/>A</td>'
						row+='</tr>'
					$('#att-table tbody').append(row);
				});
				
			}
		});
	};
	
	$('#shift_id').on('change',function(){
		FetchDetails();
	});
	
	$('#emp_id').on("change",function(){
		fetchEmployee();
	});
	
	
	
	$.validator.addMethod("lents", function(value, element) {
		var len=$('#att-table tbody tr').length;
		if(len>0)
			return true;
		else 
			return false;
    }, "Please select atleast one employee");

	
	
	$('#saveBtn').on('click',function(){
		$('#attendance-form').validate({
			debug:true,
			rules:{
				attendance_date:"required",
				shift_id:"required",
				emp_id:"required",
				length:{
					lents:true,
				}
			},
			messages:{
				attendance_date:"Please select attendance date",
				shift_id:"Please Select shift",
				emp_id:"Please select employee",
				lents:"Please select atleast one employee"
			},
			submitHandler:function(form){
				document.createElement('form').submit.call(document.attend)
				//document.getElementById("attendance-form").submit();
			}
		});
	});
	
	$('#saveBtn').on('click',function(){
		var vall=$('#attendance-form').valid();
		console.log(vall);
		if($('#attendance-form').valid()==true){
			console.log("coming");
			$('#attendance-form').submit();
		}
	});
	
});