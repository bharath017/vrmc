$(document).ready(function(){
	
	//clear all check box
	var clearRole=function(){
		$('input[name="role"]').each(function(){
			$(this).prop('checked',false);
		});
	}
	
	$('#user_id').on('change',function(){
		//clear checkbox here
		clearRole();
		var user_id=$('#user_id').val();
		$.ajax({
			type:'post',
			url:'../UserController?action=getSingleUserDetails&user_id='+user_id,
			headers:{
				Access:"application/json;charset=utf-8",
				"Content-Type":"application/json;charset=utf-8"
			},
			success:function(res){
				$('#user_name').text(res.user_name);
				$('#user_type').text(res.user_type);
				$('#user_phone').text(res.user_phone);
				getRoles(res.user_id);
			},
			error:function(res){
				console.log(res);
				alert('Please check your internet connection');
			}
		});
	});
	
	
	
	
	//get user roles detail's and assign
	
	var getRoles=function(user_id){
		$.ajax({
			type:'post',
			url:'../UserController?action=getSingleRoles&user_id='+user_id,
			headers:{
				Accept:"application/json;charset=utf-8",
				"Content-Type":"application/json"
			},
			success:function(res){
				var rolearray=res.roles.split(',');
				$('input[name="role"]').each(function(){
					var role=$(this);
					$.each(rolearray,function(i,v){
						if(role.val()==v){
							role.prop('checked',true);
						}
					});
				});
			}
		});
	}
	
	
	$('#saveRole').on('click',function(){
		var user_id=$('#user_id').val();
		if(user_id==null || user_id==''){
			alert('Please select user');
			return false;
		}
		var roles=$('input[name="role"]:checked').map(function() {return this.value;}).get().join(',');
		$.ajax({
			type:'post',
			url:'../UserController?action=updateRole&user_id='+user_id+'&roles='+roles,
			success:function(success){
				if(success>0){
					$.toast({
					    text: 'Role Assigned Successfully',
					    showHideTransition: 'fade',
					    icon: 'success',
					    position: 'top-right'
					});
				}else{
					$.toast({
					    text: 'Failed!!! Some error occured',
					    showHideTransition: 'fade',
					    icon: 'error',
					    position: 'top-right'
					});
				}
			},error:function(error){
				alert('check your internet connection');
			}
		});
	});
	
	
});