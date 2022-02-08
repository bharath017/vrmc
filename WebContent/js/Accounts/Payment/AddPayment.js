$(document).ready(function(){
	
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
	
	//enable disable payment type
	$('#payment_type').on('change',function(){
		var payment_type=$('#payment_type').val();
		if(payment_type=='CHEQUE/DD'){
			$('.pt').prop('disabled',false);
			$('.neft').prop('disabled',true);
		}else if(payment_type=='NEFT/RTGS'){
			$('.pt').prop('disabled',true);
			$('.neft').prop('disabled',false);
		}else{
			$('.pt').prop('disabled',true);
			$('.neft').prop('disabled',true);
		}
	});
	
	
	
	//get credit balance detail's
	$('#customer_id').on('change',function(){
		var customer_id=$('#customer_id').val();
		$.ajax({
			type:'POST',
			url:'PaymentController?action=GetCreditAmount&customer_id='+customer_id,
			headers:{
				Accept:"text/html;charset=utf-8",
				"Content-Type":"text/html;charset=utf-8"
			},
			success:function(res){
				console.log(res);
				$('#credit_balance').text(res);
			}
		})    			
	});
	
	//get site details
	$('#customer_id').on('change',function(){
		var customer_id=$('#customer_id').val();
		$.ajax({
			type:'POST',
			url:'CustomerController?action=getCustomerSiteDetails&customer_id='+customer_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(result){
				$('#select2-site_id-container').html('Choose Site Address');
				$('#site_id').html('');
        		$('#site_id').html('<option value="">Choose Site Address.</option>');
        		$('#site_id').append("<option value='0'>All Site</option>");
        		$.each(result, function(index, value) {
        			   $('#site_id').append("<option value='"+ value.site_id+ "'>" + value.site_name + "</option>");
        		});
        		
			}
		});
	});
	
	
	
	//now validation goes on here
	
	var submit=false;
	$('#myform').validate({
		debug:false,
		rules:{
			customer_id:"required",
			site_id:"required",
			payment_amount:{
				required:true,
				number:true
			},
			payment_date:"required",
			payment_mode:"required",
			mp_id:"required"
		},
		messages:{
			customer_id:"Plese select customer",
			site_id:"Please select site address",
			payment_amount:{
				required:"Please enter payment amount",
				number:"Please enter proper amount"
			},
			payment_date:"Please enter Payment date",
			payment_mode:"Please select payment type",
			mp_id:"Please select maketing person"
		},
		submitHandler:function(form){
			if(submit==false){
				form.submit();
				submit=true;
			}else{
				alert('submited successfully');
			}
		}
	});
	
});


function uploadImage(e){
	 var data = new FormData();
	 jQuery.each(jQuery('#id-input-file-1')[0].files, function(i, file) {
	     data.append('file-'+i, file);
	 });
	 var opts = {
		    url: 'PaymentController?action=upload_file',
		    data: data,
		    cache: false,
		    contentType: false,
		    processData: false,
		    type: 'POST',
		    success: function(data){
		    	var src = (data == '' || data==undefined || data==null || data.trim()=='null')? 'assets/images/gallery/unknown.jpg': ''+data;
 	        	 $('#photo-image').attr('src', "document/"+src);
 	        	 $('#bill_photo').val(data.trim());
		    }
		};
		if(data.fake) {
		    // Make sure no text encoding stuff is done by xhr
		    opts.xhr = function() { var xhr = jQuery.ajaxSettings.xhr(); xhr.send = xhr.sendAsBinary; return xhr; }
		    opts.contentType = "multipart/form-data; boundary="+data.boundary;
		    opts.data = data.toString();
		}
		jQuery.ajax(opts);
	 
} 

