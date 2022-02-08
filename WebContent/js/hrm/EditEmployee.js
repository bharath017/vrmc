$(document).ready(function(){
    $('.date-picker').datepicker({
		autoclose: true,
		todayHighlight: true,
		"orientation":"bottom left"
	})
	
	let submit=false;
	$('#employee-form').validate({
		debug:false,
		rules:{
			employee_id:{
				required:true,
				remote:{
					url:'EmployeeController?action=checkEmployeeIdForUpdate',
					type:'POST',
					data:{
						employee_id:function(){
							return $('#employee_id').val();
						},
						e_id:function(){
							return $('#e_id').val();
						}
					},
					dataType:"json",
					dataFilter:function(res){
						if(res.trim()=='exist')
							return false;
						else
							return true;
					}
				}
			},
			employee_name:"required",
			current_address:"required",
			residental_address:"required",
			employee_phone:{
				required:true,
				rangelength:[10,10]
			},
			contact_number:"required",
			designation_id:"required",
			department_id:"required",
			employee_aadhar_number:{
				required:true,
				rangelength:[12,12]
			}
		},
		messages:{
			employee_id:{
				required:"Enter Employee ID",
				remote:'Employee ID is already exist'
			},
			employee_name:"Enter Name",
			current_address:"Enter Current Address",
			residental_address:"Enter Residential Address",
			employee_phone:{
				required:"Enter Phone Number",
				rangelength:"Enter Valid Number"
			},
			contact_number:"Enter Emergency Contact Number",
			designation_id:"Choose Designation",
			department_id:"Choose Department",
			employee_aadhar_number:{
				required:"Enter Adhar Number",
				rangelength:"Enter Proper Adhar Number"
			}
		},
		submitHandler:function(form){
			if(submit==false){
				submit=true;
				form.submit();
			}
		}
	});
});