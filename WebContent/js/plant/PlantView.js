$(document).ready(function(){
	$('input[name="isAutoInventory"]').on('click',function(){
		var checked=$('input[name="isAutoInventory"]').prop('checked');
		var plant_id=$('#plant_id_view').val();
		$.ajax({
			type:'post',
			url:'PlantController?action=changeAutoWeightInventory&isAutoInventory='+checked,
			success:function(res){
				$.toast({
				    heading: 'Your Setting <br> changed successfully',
				    showHideTransition: 'fade',
				    icon: 'success',
				    position: 'top-right'
				});
			},error:function(res){
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