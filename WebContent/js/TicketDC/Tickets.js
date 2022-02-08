var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http) {
	$(document).ready(function(){
		
	var session=getSessionDetails();
		
	$('.select2').css('width','100%').select2({allowClear:true})
			.on('change', function(){
    }); 
	
	//get all vehicls
	var getAllVehicles=function(){
		var vData= $.ajax({
	        async:false,
	        url:'VehicleController?button=getAllVehicle',
	        type:'post',
	        data:{'GetConfig':'YES'},
	        dataType:"JSON"
	    }).responseJSON;
		
		$('#vehicle_no').empty();
			$('#vehicle_no').append('<option value="" selected disabled></option>')
		$.each(vData,function(i,value){
			$('#vehicle_no').append('<option value="'+value+'">'+value+'</option>');
		});
	}
	
	getAllVehicles();
	
	
		
	   //load all the item
		var BaseConfig=$.ajax({
	        async:false,
	        url:'ProductController?action=GetNameSuggestion',
	        type:'post',
	        data:{'GetConfig':'YES'},
	        dataType:"JSON"
	        }).responseJSON;
		
		//console.log(BaseConfig);
		
		
		$('#product_name').autocomplete({
		    lookup: BaseConfig
		});
		
		
		//add new vehicle
		$(document).on('click','#doc #add-new-vehicle',function(){
	    	$.confirm({
			    title: '<span class="text-info">Add New Vehicle<span>',
			    content: '' +
			    '<form action="" class="formName">' +
			    '<div class="form-group">' +
			    '<label>Vehicle No <span class="text-danger">*</span></label>' +
			    '<input class="form-control" id="vehicle_no_new" name="vehicle_no"/>' +
			    '</div>' +
			    '</form>',
			    buttons: {
			        formSubmit: {
			            text: 'Submit',
			            btnClass: 'btn-blue',
			            action: function () {
			                var vehicle_no = this.$content.find('#vehicle_no_new').val();
			                if(!vehicle_no){
			                    $.alert('provide a vehicle no');
			                    return false;
			                }else{
			                	$.ajax({
			                		type:'post',
			                		url:'VehicleController?button=addedByJavaScript&vehicle_no='+vehicle_no,
			                		success:function(res){
			                			if(res>0){
			                				$.toast({
			    	        				    heading: 'Vehicle Added',
			    	        				    showHideTransition: 'fade',
			    	        				    icon: 'success',
			    	        				    position: 'top-right'
			    	        				});
			                				getAllVehicles();
			                			}else if(res==-1){
			                				$.toast({
			    	        				    heading: 'Vehicle Already Exist!!',
			    	        				    showHideTransition: 'fade',
			    	        				    icon: 'warning',
			    	        				    position: 'top-right'
			    	        				});
			                			}else{
			                				$.toast({
			    	        				    heading: 'Failed!!',
			    	        				    showHideTransition: 'fade',
			    	        				    icon: 'error',
			    	        				    position: 'top-right'
			    	        				});
			                			}
			                			//redraw the table
			                			table.draw();
			                		},
			                		error:function(res){
			                			alert('Please check your internet connection');
			                		}
			                	});
			                }
			               
			            }
			        },
			        cancel: function () {
			            //close
			        },
			    },
			    onContentReady: function () {
			        var jc = this;
			        this.$content.find('form').on('submit', function (e) {
			            e.preventDefault();
			            
			            jc.$$formSubmit.trigger('click'); // reference the button and click it
			        });
			    }
			});
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
	        	url:"TicketController?action=getTicketList",
	        	type:"POST",
	        	 data 	: function ( d ) {
		                  return $.extend( {}, d, {
		                	  plant_id:session.plant_id,
		                	  business_id:session.business_id
		                  });
		              },
	        	error:function(){
	        	}
	        },
	        "columnDefs":[
	        	{"targets":[0],"data":function(data){return data;},"render":function(data,row){
	        		return '<a style="font-weight:bold;color:blue;" href="PrintTicket.jsp">TKT/'+data.ticket_id+'</a>'
	        	}},
	        	{"targets":[1],"data":"product_name"},
	        	{"targets":[2],"data":"vehicle_no"},
	        	{"targets":[3],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		if(data.empty_weight>0)
	        			return 'Empty Weight';
	        		else 
	        			return 'Loaded Weight';
	        	}},
	        	{"targets":[4],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		return  data.loaded_weight+data.empty_weight;
	        	}},
	        	{"targets":[5],"data":"date"},
	        	{"targets":[6],"data":function(data){
	        		return data;
	        	},
	        	"render":function(data,row){
	        		
	        		html='<a href="PrintTicket.jsp?t_id='+data.t_id+'" target="_blank"><span class="text-info"><i class="fa fa-print"></i></span></a>';
	                 return html;
	        	}}  	
	        ],
	        "createdRow": function( row, data, dataIndex){
                if(data.product_status ==  'inactive'){
                    $(row).addClass('redClass');
                }else if(data.product_status=='active'){
                	 $(row).removeClass('redClass');
                }
            }
	    });
		
		
	
    
	    $('#search').on( 'click', function () {
			 table.draw();
	    } );
		
	
		/*var loadUnits=function(){
			$.ajax({
				type:'post',
				url:'SettingController?action=getUnitListForOption',
				headers:{
					Accept:"application/json;charset=utf-8",
					"Content-Type":"application/json;charset=utf-8"
				},
				success:function(res){
					$('#unit').html("");
					$.each(res,function(i,v){
						$('#unit').append('<option value="'+v+'">'+v+'</option>');
					});
				}
			});
		};
		loadUnits();*/
	
	
		/*$.validator.addMethod('nospecial', function (value) { 
		    return /^[^']*$/.test(value); 
		}, 'Please remove ( \' ) here');*/
	
	
		var submit=false;
		
		//Insert fleet item details here
		$('#myform').validate({
			debug:true,
			rules:{
				plant_id:"required",
				vehicle_no:"required",
				product_id:"required",
				weight_type:"required",
				weight:"required"
				
			},
			messages:{
				plant_id:"Select Plant",
				vehicle_no:"Select Vehicle No",
				product_id:"Choose Product",
				weight_type:"Choose Weight Type",
				weight:"Enter Weight"
			},
			submitHandler:function(form){
				console.log('hello world');
				if(submit==false){
					console.log('coming here');
					submit=true;
					//now submit
						var data = $('#myform').serialize();
						console.log(data);
						$http({
							  method: 'POST',
							  url: 'TicketController?action=addTicket&'+data
							})
							.then(function (success) {
								//console.log(success);
								if(success.data>0){
									$.toast({
				    				    heading: 'Ticket Generated Successfully',
				    				    showHideTransition: 'fade',
				    				    icon: 'success',
				    				    position: 'top-right'
				    				});
									$('#weight').val("");
									$('#vehicle_no').val("");
									submit=false;
									table.draw();
								}else if(success.data==-1){
									$.toast({
				    				    heading: 'Problem appeared',
				    				    showHideTransition: 'fade',
				    				    icon: 'error',
				    				    position: 'top-right'
				    				});
									submit=false;
								}
							}, function (error) {
							  
						});
					
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
	
	
	
	
	
	
	
	
	
	
	
	
//document ends here	
 });

//angular controller code ends here
});
