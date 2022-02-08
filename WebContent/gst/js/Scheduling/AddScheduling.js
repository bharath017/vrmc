$(document).ready(function(){
	var session=getSessionDetails();
	//common setting goes here
	 $('.select2').css('width','100%').select2({allowClear:true})
		.on('change', function(){
	 });
	 
	 $('.date-picker').datepicker({
			autoclose: true,
			todayHighlight: true,
			"orientation":"bottom left"
	 }).on('changeDate', function(ev) {
	        $(this).valid();  // triggers the validation test
	        // '$(this)' refers to '$("#datepicker")'
	    });;

	 $("#id-date-picker-1").datepicker();
			$('#id-date-picker-1').datepicker({
			        "autoclose": true,
			        "orientation":"bottom left"
		}).on('changeDate', function(ev) {
	     $(this).valid();  // triggers the validation test
	     // '$(this)' refers to '$("#datepicker")'
	 });;
		
	$('.picker').on('click',function(){
		$(this).prev("input.date-picker").datepicker("show");
	});
	
	$('select').on('change', function() {  // when the value changes
	    $(this).valid(); // trigger validation on this element
	});
	
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
	
	
	$('#timepicker2').timepicker({
		minuteStep: 1,
		showSeconds: true,
		showMeridian: false,
		disableFocus: true,
		icons: {
			up: 'fa fa-chevron-up',
			down: 'fa fa-chevron-down'
		}
	}).on('focus', function() {
		$('#timepicker2').timepicker('showWidget');
	}).next().on('click', function(){
		$(this).prev().focus();
	});
	
	
	
	 //Getting Address details here
	$('#customer_id').on('change',function(){
		var customer_id=$('#customer_id').val();
		$.ajax({
			type:'POST',
			url:'../CustomerControllerTest?action=getCustomerSiteDetails&customer_id='+customer_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(result){
				$('#select2-site_id-container').html('Choose Site Address');
				$('#site_id').html('');
        		$('#site_id').html('<option value="">Choose Site Address.</option>');
        		$.each(result, function(index, value) {
        			   $('#site_id').append("<option value='"+ value.site_id+ "'>" + value.site_name + "</option>");
        		});
        		
			}
		});
	});
	
	
	var getProductDetails= function(site_id,date,plant_id){
		$.ajax({
			type:'POST',
			url:'../SchedulingControllerTest?action=GetGradeDetails&site_id='+site_id+'&date='+date+'&plant_id='+plant_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(res){
				var count=0;
				$('#scheduling_id').val(res.scheduling_id);
				$('#schedule_item tbody').html("");
				$.each(res.list,function(i,v){
					$('#schedule_item tbody').append('<tr><td>'+
							'<input type="hidden" name="product_id['+count+']" value="'+v.product_id+'"/>'+v.product_name+'</td><td>'+v.totalquantity+'</td><td>'+v.totalinvoice+'</td><td>'+(v.totalquantity-v.totalinvoice)+'</td>'+
							'<td><input type="text" name="quantity['+count+']" value="'+v.quantity+'" class="form-control quantity"/></td></tr>');
					count++;
				});
				$('input[name="count"]').val(count);
				myFunc();
			}
		});
	}
	
	
	$('#plant,#site_id,#id-date-picker-1').on('change',function(){
		var site_id=$('#site_id').val();
		if(site_id=="" || site_id == null || site_id==undefined)
			return false;
		
		var plant_id=$('#plant').val();
		if(plant_id=="" || plant_id== null || plant_id==undefined)
			return false;
		
		var date=$('.scheduling_date').val();
		if(date=="" || date==null || date == undefined)
			return false;
		
		getProductDetails(site_id,date,plant_id);
	});
	
	
	var submited=false;
	$('#scheduling-form').validate({
		debug:false,
		rules:{
			plant_id:{
				required:true,
				countRow:true
			},
			customer_id:"required",
			site_id:"required",
			scheduling_date:"required"
		},
		messages:{
			plant_id:{
				required:"Please select plant"
			},
			customer_id:"Please select customer",
			site_id:"Please select site",
			scheduling_date:"Please select date"
		},
		submitHandler:function(form){
			if(submited==false){
				form.submit();
				submited=true;
			}
		}
	});
	
	jQuery.validator.addMethod("countRow", function(value, element) {
			var count=$('#schedule_item tbody tr').length;
			if(count>0)
				return true;
			else
				return false;
	}, 'Scheduling item must contain atleast one row');
	
	
	var myFunc=function(){
		$('.quantity').each(function(){
			$(this).rules('add',{
				required:true,
				number:true,
				messages:{
					required:"Please add 0 or some quantity",
					number:"Please enter valid amount"
				}
			});
		});
	}
	
	
	$('#site_id').on('change',function(){
		$('#scheduling-form').valid();
	});
	
});