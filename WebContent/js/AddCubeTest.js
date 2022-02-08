$(document).ready(function(){
	
	
	$(document).on("click","#add-cube",function(){
		addCube();
	});
	
	$("#cube-table").on('click','span[title="delete-cube"]', function() {
		$(this).closest('tr').remove();
		loopCubeNo();
	});
	var addCube=function(){
		//get length of the row
		var cubeNo=$('.cube-no').length;
		var row='<tr>'	
		row+='<td class="cube-no">'+(cubeNo+1)+'</td>'
		row+='<td><input type="text" required="required"  name="cube_id" class="form-control cube_id"></td>'
		row+='<td><input type="number" required="required"  step="0.001" name="mass1" class="form-control calc"></td>'
		row+='<td><input type="number" required="required"  step="0.001" name="maxld1" class="form-control calc"></td>'
		row+='<td><input type="number" required="required"  step="0.001" name="mass2"  class="form-control calc"></td>'
		row+='<td><input type="number" required="required"  step="0.001" name="maxld2" class="form-control calc"></td>'
		row+='<td><input type="number" required="required"  step="0.001" name="mass3"  class="form-control calc"></td>'
		row+='<td><input type="number" required="required"  step="0.001" name="maxld3" class="form-control calc"></td>'
		row+='<td><span class="text-danger" title="delete-cube"><i class="fa fa-trash"></i></span></td>'
		row+='</tr>'
		//now add to the table body
		
		$('#cube-table tbody').append(row);
	}
	
	//loop through cube and change serial no
	
	var loopCubeNo=function(){
		var cubeNo=$('.cube-no').length;
		var no=1;
		$('.cube-no').each(function(i){
			$(this).text(no);
			no+=1;
		});
	}
	
	$('.calc').on("keyup blur",function(){
		var diamension=$('#dimension').val();
		var maxld1=$(this).closest('tr').find('input[name="maxld1"]').val();
		var maxld2=$(this).closest('tr').find('input[name="maxld2"]').val();
		var maxld3=$(this).closest('tr').find('input[name="maxld3"]').val();
		
		//now calculate and 
	});
});