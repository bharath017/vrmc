$(document).ready(function(){
	
    
    $('.date-picker').datepicker({
		autoclose: true,
		todayHighlight: true,
		"orientation":"bottom left"
	});
    
	
	
	
	let submit=false;
    
	$('#emp-salary-form').validate({
		debug:false,
		rules:{
			basic_pay:{
				required:true,
				number:true
			},
			pf:{
				required:true,
				number:true
			},
			hra:{
				required:true,
				number:true
			},
			esic:{
				required:true,
				number:true
			},
			da:{
				required:true,
				number:true
			},
			prof_tax:{
				required:true,
				number:true
			},
			other:{
				required:true,
				number:true
			},
			tds:{
				required:true,
				number:true
			}
		},
		messages:{
			basic_pay:{
				required:"Enter  Baic Pay",
				number:"Only Number are accepted"
			},
			pf:{
				required:"Enter PF",
				number:"Only Number are accepted"
			},
			hra:{
				required:"Enter HRA",
				number:true
			},
			esic:{
				required:"Enter ESIC",
				number:"Only Number are accepted"
			},
			da:{
				required:"ENTER DA",
				number:"Only Number are accepted"
			},
			prof_tax:{
				required:"Enter Professional Tax",
				number:"Only Number are accepted"
			},
			other:{
				required:"Enter Other",
				number:"Only Number are accepted"
			},
			tds:{
				required:"Enter TDS",
				number:"Only Number are accepted"
			}
		},
		submitHandler:function(form){
			if(submit==false){
				submit=true;
				form.submit();
			}
		}
	});
	
	save_salary_structure.addEventListener("click", () => {
		let isValid=$('#emp-salary-form').valid();
		if(isValid){
			let data=$('#emp-salary-form').serialize();
			fetch(`EmployeeController?action=updateEmployeeSalaryStructure&${data}`,{
				method:'post'
			}).then(response => response.text())
			  .then(text => {
				 if(Number(text) > 0){
					 $.toast({
						    text: 'Saved!!!',
						    showHideTransition: 'fade',
						    icon: 'success',
						    position: 'top-right'
					  });
				 }else{
					 $.toast({
						    text: 'Failed!!!',
						    showHideTransition: 'fade',
						    icon: 'danger',
						    position: 'top-right'
					 });
				 }
			  });
		}
	});
	
	
	let calculateSalary= () => {
		let salary=document.getElementById('salary').value;
		salary=Number(salary);
		let basic_pay=(document.getElementById('basic_pay').value || 0);
		let pf=(document.getElementById('pf').value || 0);
		let hra=(document.getElementById('hra').value || 0);
		let esic=(document.getElementById('esic').value || 0);
		let da=(document.getElementById('da').value || 0);
		let prof_tax=(document.getElementById('prof_tax').value || 0);
		let other=(document.getElementById('other').value || 0);
		let tds=(document.getElementById('tds').value || 0);
		
		let sub_pay=Number(basic_pay)+Number(hra)+Number(da);
		let total_deduction=Number(pf)+Number(esic)+Number(prof_tax)+Number(tds);
		other=salary-(Number(sub_pay)+Number(total_deduction));
		document.getElementById('other').value=other;
		let total_pay=Number(basic_pay)+Number(hra)+Number(da)+Number(other);
		document.getElementById('total_pay')
					.value=total_pay;
		document.getElementById('total_deduction')
					.value=total_deduction;
		
	}
	
	calculateSalary();
	
	
	$('.salaryCalc').on('keyup blur',function(){
		calculateSalary();
	});
});