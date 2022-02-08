$(document).ready(function(){
	
	$('#vehicle_no').on('change',function(){
		var vehicle_no=$('#vehicle_no').val();
		$.ajax({
			type:'POST',
			url:'DieselConsumptionController?action=checkDetails&vehicle_no='+vehicle_no,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(res){
				if(res!=null){
					$('#vehicle_no_view').text(res.vehicle_no);
					$('#opening_km_view').text(res.opning_km);
					$('#closing_km_view').text(res.closing_km);
					$('#last_milage_view').text(((res.closing_km-res.opning_km)/res.issued_quantity).toFixed(2));
					$('#opening_km').val(res.closing_km);
					$('#opening_km').prop('readonly',true);
				}else{
					$('#vehicle_no_view').text('');
					$('#opening_km_view').text('');
					$('#closing_km_view').text('');
					$('#last_milage_view').text('');
					$('#opening_km').val('');
					$('#opening_km').prop('readonly',false);
				}
			}
		});
	});
	
	
	//calculate recent mileage
	
	var calculateMilage=function(){
		var opening_km=$('#opening_km').val();
		opening_km=(opening_km==undefined || opening_km==null || opening_km=='')?0:opening_km;
		var closing_km=$('#closing_km').val();
		closing_km=(closing_km==undefined || closing_km==null || closing_km=='')?0:closing_km;
		var issued_quantity=$('#issued_quantity').val();
		issued_quantity=(issued_quantity==undefined || issued_quantity==null || issued_quantity=='')?0:issued_quantity;
		
		var recent_mileage=(closing_km-opening_km)/issued_quantity;
		$('#this_milage_view').text(recent_mileage.toFixed(2));
	};
	
	
	//call the mileage calculation method
	
	$('#closing_km').on('keyup blur',function(){
		calculateMilage();
	});
	
	$('#issued_quantity').on('keyup  blur',function(){
		calculateMilage();
	});
	
	
	$('#saveBtn').on('click',function(){
		$('#consumption-form').validate({
			debug:false,
			rules:{
				issued_date:"required",
				issued_time:"required",
				vehicle_no:"required",
				opening_km:{
					required:true,
					number:true
				},
				closing_km:{
					required:true,
					number:true
				},
				issued_quantity:{
					required:true,
					number:true
				}
			},
			messages:{
				issued_date:"Please select issued date",
				issued_time:"Please select issued time",
				vehicle_no:"Please select vehicle no",
				opening_km:{
					required:"Please enter opening km",
					number:"Please enter valid opening km"
				},
				closing_km:{
					required:"Please enter closing km",
					number:"Please enter valid closing km"
				},
				issued_quantity:{
					required:"Please enter issued quantity",
					number:"Please enter valid issued quantity"
				}
			},
			submitHandler:function(form){
				$('#saveBtn').prop("disabled",true);
				form.submit();
			}
		});
	});
	
	
	
});