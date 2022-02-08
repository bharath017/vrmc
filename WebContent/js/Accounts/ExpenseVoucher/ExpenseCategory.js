var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http) {
	$(document).ready(function(){
		
		
	
	var session=getSessionDetails();
		
	$('.select2').css('width','100%').select2({allowClear:true})
			.on('change', function(){
    }); 
	
	
	
	let fetchCategoryType = ()=>{
		fetch(`ExpenseVoucherController?action=getExpenseCategoryType`,{
        	method:'post',
        	headers:{
	        	'Content-Type':'application/json'
	        }
        })
        .then(response => response.json())
        .then(data => {
        	$('#expense_type-table tbody').empty();
        	let count=0;
        	$.each(data,function(i,v){
        		count++;
        		let tr=`
        			<tr>
        				<td>${count}</td>
        				<td>${v}</td>
        				<td>
        					<a class="edit-category-type" name="${v}"><span class="text-success"><i class="fa fa-edit"></i></span></a>
        				</td>
        			</tr>
        		`
        		$('#expense_type-table tbody').append(tr);
        	});
        });
	}
	
	  //Change Supplier Status
    $(document).on('click','#add_category_type_btn',function(){
    	$.dialog({
    	    title: '<span class="text-danger"><i class="fa fa-plus"></i></span> Expense Category Type',
    	    content: `
    	    	<div class="row">
    	    		<div class="col-sm-6">
    	    			<input type="hidden" name="old_expense_type" id="old_expense_type"/>
    	    			<input type="text" class="form-control" id="expense_type" name="expense_type" placeholder="Enter expense category"/>
    	    		</div>
    	    		<div class="col-sm-4">
    	    			<button class="btn btn-success" name="saveExpensetype" id="saveExpensetype" type="button">Save Expense Type</button>
    	    			<button class="btn btn-info" name="updateExpenseType" id="updateExpenseType" type="button" style="display:none;">Update Expense Type</button>
    	    		</div>
    	    	</div>
    	    	<div class="row">
    	    		<div class="col-sm-12">
    	    			<br/>
    	    			<br/>
    	    			<table class="table table-bordered table-hover" id="expense_type-table">
    	    				<thead>
    	    					<tr>
    	    						<th>S/L No</th>
    	    						<th>Category Type</th>
    	    						<th>Option</th>
    	    					</tr>
    	    				</thead>
    	    				<tbody></tbody>
    	    			</table>
    	    		</div>
    	    	</div>
    	    `,
    	    columnClass: 'col-md-6',
    	    onContentReady: function () {
    	    	fetchCategoryType();
    	    }
    	});
    });

	
    //add expense category type
    $(document).on('click','#saveExpensetype',function(){
    	let expense_type=$('#expense_type').val();
    	fetch(`ExpenseVoucherController?action=addExpenseType&expense_type=${expense_type}`,{
    		method:'post'
    	})
    	.then(response => response.text())
    	.then(text => {
    		fetchCategoryType();
    	});
    });
    
    
    //update expense category type
    $(document).on('click','#updateExpenseType',function(){
    	let expense_type=$('#expense_type').val();
    	let old_expense_type=$('#old_expense_type').val();
    	fetch(`ExpenseVoucherController?action=updateExpenseType&expense_type=${expense_type}&old_expense_type=${old_expense_type}`,{
    		method:'post'
    	})
    	.then(response => response.text())
    	.then(text => {
    		fetchCategoryType();
    		$('#updateExpenseType').hide();
        	$('#saveExpensetype').show();
    	});
    });
    
    //set for expense category type update
    $(document).on('click','#expense_type-table .edit-category-type',function(){
    	let category_type=$(this).attr('name');
    	$('#expense_type').val(category_type);
    	$('#old_expense_type').val(category_type);
    	$('#updateExpenseType').show();
    	$('#saveExpensetype').hide();
    	
    });
    
    
    
	
		//get all the item details
		
		var table =   $('#example').DataTable({
			"order": [],
	        "info":true,
	        "scrollX":true,
	        "processing":true,
	        "serverSide" : true,
	        "iDisplayLength":10,
	        "lengthMenu":[10,20,25,50,75,100],
	        "ordering":false,
	        "searching":true,
	        "ajax":{
	        	url:"ExpenseVoucherController?action=getExpenseCategoryList",
	        	type:"POST",
	        	 data 	: function ( d ) {
		                  return $.extend( {}, d, {
		                  });
		              },
	        	error:function(){
	        	}
	        },
	        "columnDefs":[
	        	{"targets":[0],"data":"category_name"},
	        	{"targets":[1],"data":"category_description"},
	        	{"targets":[2],"data":"category_type"},
	        	{"targets":[3],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		var html='';
	        			html+='<a id="'+data.category_id+'" style="cursor:pointer;" class="edit-category"><span class="text-success"><i class="fa fa-edit"></i></span></a>&nbsp&nbsp';
	        			html+='<a id="'+data.category_id+'" name="'+data.category_name+'" style="cursor:pointer;" class="delete-category"><span class="text-danger"><i class="fa fa-trash"></i></span></a>&nbsp&nbsp';
	                 return html;
	        	}}  	
	        ]
	    });
		
		
	
    
	    $('#search').on( 'click', function () {
			 table.draw();
	    } );
		
	
	    
	    //Change Supplier Status
	    $(document).on('click','#example .delete-category',function(){
	    	var category_id=$(this).attr('id');
	    	var category_name=$(this).attr('name');
	    	$.confirm({
	    	    title: '<span class="text-danger"><i class="fa fa-trash"></i></span> Delete Confirmation !!!',
	    	    content: 'Are you sure want to delete Category '+category_name+' ?',
	    	    buttons: {
	    	        confirm:{
	    	        	text: 'CHANGE STATUS',
	    	            btnClass: 'btn-info',
	    	            keys: ['enter', 'shift'],
	    	            action: function(){
	    	                $.ajax({
	    	                	type:'post',
	    	                	url:'ExpenseVoucherController?action=deleteCategory&category_id='+category_id,
	    	                	success:function(res){
	    	                		table.draw();
	    	                		if(res==1){
	    	                			$.toast({
		    	        				    heading: 'Deleted Successfully',
		    	        				    showHideTransition: 'fade',
		    	        				    icon: 'warning',
		    	        				    position: 'top-right'
		    	        				});
	    	                		}else if(res==-1){
	    	                			$.toast({
		    	        				    heading: 'Cann\'t delete already in use!!',
		    	        				    showHideTransition: 'fade',
		    	        				    icon: 'danger',
		    	        				    position: 'top-right'
		    	        				});
	    	                		}
	    	                	},
	    	                	error:function(error){
	    	                		$.toast({
	    	        				    heading: 'Failed!!',
	    	        				    showHideTransition: 'fade',
	    	        				    icon: 'error',
	    	        				    position: 'top-right'
	    	        				});
	    	                	}
	    	                });
	    	            }
	    	        },
	    	        cancel:{
	    	        	text: 'Close',
	    	            btnClass: 'btn-danger',
	    	            keys:['esc'],
	    	            action: function(){
	    	            }
	    	        }
	    	    }
	    	});
	    });
	    
	    
	    
	  
	    
	    
	   
	
		var submit=false;
		
		//Insert fleet item details here
		$('#myform').validate({
			debug:true,
			rules:{
				category_type:"required",
				category_name:"required",
				category_description:"required"
			},
			messages:{
				category_type:"Select Category",
				category_name:"Enter Category Name",
				category_description:"Enter Description"
			},
			submitHandler:function(form){
				if(submit==false){
					submit=true;
					//now submit
					var category_id=$('#category_id').val();
					if(category_id==0 || category_id=='' || category_id==null){
						var data=$('#myform').serialize();
						//now insert
						$http({
							  method: 'POST',
							  url: 'ExpenseVoucherController?action=insertExpenseCategory&'+data
							})
							.then(function (success) {
								//console.log(success);
								if(success.data>0){
									$.toast({
				    				    heading: 'supplier Added Successfully',
				    				    showHideTransition: 'fade',
				    				    icon: 'success',
				    				    position: 'top-right'
				    				});
									$('#category_name').val("");
									$('#category_description').val("");
									submit=false;
									table.draw();
								}else if(success.data==-1){
									$.toast({
				    				    heading: 'Category Already Exist',
				    				    showHideTransition: 'fade',
				    				    icon: 'error',
				    				    position: 'top-right'
				    				});
									submit=false;
								}
							}, function (error) {
							  
							});
					}else{
						var data=$('#myform').serialize();
						$http({
							method:'post',
							url:'ExpenseVoucherController?action=updateExpenseCategory&'+data
						}).then(function(success){
							if(success.data>0){
								$.toast({
			    				    heading: 'Supplier Updated Successfully',
			    				    showHideTransition: 'fade',
			    				    icon: 'success',
			    				    position: 'top-right'
			    				});
								$('#category_id').val(0);
								$('#category_name').val("");
								$('#category_description').val("");
								submit=false;
								table.draw();
							}else if(success.data==-1){
								$.toast({
			    				    heading: 'Category already exist',
			    				    showHideTransition: 'fade',
			    				    icon: 'error',
			    				    position: 'top-right'
			    				});
								submit=false;
							}
						},function(error){})
					}
				}
				
			}
		});
	
		
		
	
	$('#reset').click(function(){
		$('.edit').hide();
		$('.no-edit').show();
		$('#submit').addClass('btn-success')
					 .removeClass('btn-info')
					 .empty()
					 .text('Save Grade');
	});
	
	
	
	$(document).on('click','#example .edit-category',function(){
    	var category_id=$(this).attr('id');
    	$http({
    		method:'post',
    		url:'ExpenseVoucherController?action=getSingleCategory',
    		headers:{
    			Accept:"application/json;charset=utf-8",
    			"Content-Type":"application/json;charset=utf-8"
    		},
    		params:{
    			category_id:category_id
    		}
    	}).then(function(success){
    		$('#category_type').val(success.data.category_type);
    		$('#category_id').val(success.data.category_id);
    		$('#category_name').val(success.data.category_name);
    		$('#category_description').val(success.data.category_description);
    		$('#submit').removeClass('btn-success')
			.addClass('btn-info').text('Update');
    	},function(error){});
    });
	
	
	
	
	
	
//document ends here	
 });

//angular controller code ends here
});
