$(document).ready(function(){
	
	var submit=false;
	$('#add-user').validate({
		debug:false,
		rules:{
			user_name:"required",
			user_phone:{
				required:true,
				maxlength:10
			},
			user_email:{
				email:true
			},
			user_address:"required",
			business_id:"required",
			plant_id:"required",
			user_type:"required",
			user_login_id:"required",
			user_password:"required"
		},
		messages:{
			user_name:"Enter User's Name",
			user_phone:{
				required:"Enter User Phone",
				maxlength:"Phone number should be 10 digit"
			},
			user_email:{
				email:"Enter proper email"
			},
			user_address:"Enter user address",
			business_id:"Select business group",
			plant_id:"Select Plant",
			user_type:"Select User Type",
			user_login_id:"Enter user login id",
			user_password:"Enter user password"
		},
		submitHandler:function(form){
			if(submit==false){
				submit=true;
				form.submit();
			}
		}
	});
	
	
});