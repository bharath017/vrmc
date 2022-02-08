$(document).ready(function(){
	var session=getSessionDetails();
	console.log(session);
	var table =   $('#example').DataTable({
		"order": [],
        "info":true,
        "scrollX":true,
        "processing":true,
        "serverSide" : true,
        "iDisplayLength":10,
        "lengthMenu":[10,20,25,50,75,100],
        "ordering":false,
        "searching":false,
        "dom": 'Blfrtip',
        "buttons": [
            'copyHtml5',
            'excelHtml5',
            'csvHtml5',
            'pdfHtml5'
        ],
        lengthChange: true,
        "ajax":{
        	url:"../BankDetailControllerTest?action=GetBankTransactionList",
        	type:"POST",
        	 data 	: function ( d ) {
	                  return $.extend( {}, d, {
	                	  type:$('#type').val(),
	                	  bank_id:$('#bnk_id').val(),
	                	  from_date:$('#from_date').val(),
	                	  to_date:$('#to_date').val(),
	                	  business_id: session.business_id
	                  });
	              },
        	error:function(){
        	}
        },
        "columnDefs":[
        	{"targets":[0],"data":"id"},
        	{"targets":[1],"data":function(data){return data;},
        	  "render":function(data,row){
        		  return data.date;
        	  }},
        	{"targets":[2],"data":"type"},
        	{"targets":[3],"data":"amount"},
        	{"targets":[4],"data":"bank_name"},
        	{"targets":[5],"data":"remark"},
        	{"targets":[6],"data":"group_name"},
        	{"targets":[7],"data":function(data){
        		return data;
        	},
        	"render":function(data,row){
        		html='';
        		html+='<div class="btn-group dropdown">';
                html+='<a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>'
                	html+='<div class="dropdown-menu dropdown-menu-right">'
                			//print option
                			if(data.type=='suppay')
                				html+=`<a class="dropdown-item" href="PrintSupplierPayment.jsp?payment_id=${data.id}" target="_blank"><i class="fa fa-print mr-2 text-muted font-18 vertical-middle"></i>Print Transaction</a>`
                			if(data.type=='Pettycash')
                        		html+=`<a class="dropdown-item" href="PrintPettyCash.jsp?cash_id=${data.id}" target="_blank"><i class="fa fa-print mr-2 text-muted font-18 vertical-middle"></i>Print Transaction</a>`
                        	if(data.type=='cuspay')
                                html+=`<a class="dropdown-item" href="PrintCustomerPayment.jsp?payment_id=${data.id}" target="_blank"><i class="fa fa-print mr-2 text-muted font-18 vertical-middle"></i>Print Transaction</a>`
                        	
                        	//edit option below
                			if(data.type=='cuspay')
                				html+='<a class="dropdown-item" href="AddPayment.jsp?action=update&payment_id='+data.id+'"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Edit Transaction</a>';
                			if(data.type=='suppay')
                				html+='<a class="dropdown-item" href="AddMakePayment.jsp?action=update&payment_id='+data.id+'"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Edit Transaction</a>';
                			if(data.type=='Pettycash')
                				html+='<a class="dropdown-item" href="AddPettyCash.jsp?action=update&cash_id='+data.id+'"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Edit Transaction</a>';
                			
                			html+='<a class="dropdown-item upload-document" name="'+data.type+'" id="'+data.id+'"><i class="fa fa-upload mr-2 text-muted font-18 vertical-middle"></i>Upload Doc</a>';
                			html+='<a class="dropdown-item delete-transaction" name="'+data.type+'" id="'+data.id+'"><i class="fa fa-trash mr-2 text-muted font-18 vertical-middle"></i>Delete</a>';
                    html+='</div>'
            html+='</div>'
                 return html;
        	}}  	
        ],
        "fnRowCallback": function( row, data, dataIndex) {
        	/*if(data.status!='active'){
        		$(row ).css( "background-color", "#f5c676" );
        		$(row ).css( "color", "white" );
        	}*/
        }
    });
	
    
    $('#search').on( 'click', function () {
		 table.draw();
    } );
    
    $('#clear').on('click',function(){
    	$('#clear-form').trigger('reset');
    	table.draw();
    });
   
    
    
    //calcel dc option goes here
    $(document).on('click','#example .delete-transaction',function(){
    	let id=$(this).attr('id');
    	let type=$(this).attr('name');
    	$.confirm({
    	    title: '<span class="text-danger"><i class="fa fa-trash"></i></span>Delete Confirmation !!!',
    	    content: 'Are you sure want to Delete Transaction ID : '+id+' ?',
    	    buttons: {
    	        confirm:{
    	        	text: 'CANCEL',
    	            btnClass: 'btn-info',
    	            keys: ['enter', 'shift'],
    	            action: function(){
    	                $.ajax({
    	                	type:'post',
    	                	url:'../BankDetailControllerTest?action=deleteTransaction&id='+id+'&type='+type,
    	                	success:function(res){
    	                		table.draw();
    	                		$.toast({
    	        				    heading: 'Transaction ID: '+id+' Deleted',
    	        				    showHideTransition: 'fade',
    	        				    icon: 'warning',
    	        				    position: 'top-right'
    	        				});
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
    
    
    
    
  //proper proper option visibility
	
		
  $('.table-responsive').on('shown.bs.dropdown', function (e) {
    var $table = $(this),
        $menu = $(e.target).find('.dropdown-menu'),
        tableOffsetHeight = $table.offset().top + $table.height(),
        menuOffsetHeight = $menu.offset().top + $menu.outerHeight(true);

    if (menuOffsetHeight+100 > tableOffsetHeight)
      $('.dataTables_scrollBody').css('padding-bottom',(menuOffsetHeight - tableOffsetHeight)+50);
  });

  $('.table-responsive').on('hide.bs.dropdown', function () {
      $('.dataTables_scrollBody').css("padding-bottom", 0);
  })

  
  let path='../document'
  let getDocList = (id,type) => {
	  fetch(`../BankDetailControllerTest?action=getDocuments&id=${id}&type=${type}`,{
   	   method:'post'
      }).then(response => response.json())
      	 .then(data => {
      		$('#uploaded_document_tbl tbody').empty();
      		let count=0;
      		$.each(data,function(i,v){
      			console.log(v['doc_id']);
      			count++;
      			let row = `
      				<tr>
      					<td>${count}</td>
      					<td><a href="${path}/${v['fileName']}" target="_blank">${v['fileName']}</a></td>
      					<td>
      						<a href="${path}/${v['fileName']}" target="_blank"><span class="text-success"><i class="fa fa-download"></i></span></a>
      						&nbsp;&nbsp;&nbsp;
      						<a id="${v['id']}" name="${v['doc_id']}" type="${v['doc_type']}" 
      						   class="delete_document"><span class="text-danger"><i class="fa fa-trash"></i></span></a>
      					</td>
      				</tr>
      			`;
      			$('#uploaded_document_tbl tbody').append(row);
      		});
      });
  }
  
  //Document upload option
  $(document).on('click','#example .upload-document',function(){
  	let id=$(this).attr('id');
  	let type=$(this).attr('name');
  	$.dialog({
  	    title: '',
  	    content: `
  	    	<div class="row" id="upload-option">
  	    		<div class="col-sm-1"></div>
  	    		<div class="col-sm-10">
  	    			<div class="form-group">
		                <label>Upload PO Document<span class="text-danger"></span> </label>
		                <div>
		                    <div class="input-group">
		                    	<input type="hidden" readonly="readonly"  class="form-control"  
		                    			name="bill_photo" id="bill_photo"/>
		                        <input type="file" class="form-control"
  	    									accept="application/msword,text/plain, application/pdf" 
  	    									class="find" id="id-input-file-1"/>
		                        <div class="input-group-append">
		                            <button type="button" id="uploadBtn" style="cursor:pointer;" 
		                            		class="input-group-text bg-custom text-white"
		                                    name="${id}" value="${type}">Click here to upload</button>
		                        </div>
		                    </div>
		                </div>
		            </div>
		            <div class="row">
		            	<div class="col-sm-8">
		            		<div class="progress">
			        			<div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
			        		</div>
		            	</div>
		            	<div class="col-sm-4">
		            		<a class=""  target="_blank" href="" id="viewPreview" style="display: none;">Preview Here</a>
		            	</div>
		            </div>
  	    		</div>
  	    	</div>
  	    	<div class="row">
  	    		<div class="col-sm-12">
  	    			<table class="table table-bordered" id="uploaded_document_tbl">
	  	    			<thead>
	  	    				<tr>
	  	    					<th>S/L No.</th>
	  	    					<th>File Name</th>
	  	    					<th>Option</th>
	  	    				</tr>
	  	    			</thead>
	  	    			<tbody>
	  	    			
	  	    			</tbody>
	  	    		</table>
  	    		</div>
  	    	</div>
  	    `,
  	    columnClass: 'col-md-8',
  	    onContentReady: function () {
  	    	getDocList(id,type); 
        }
  	});
  });
  
 
  //upload option here
  $(document).on('click','#upload-option #uploadBtn',function(){
	  if($('#id-input-file-1').val()){
		  	let id=$(this).prop('name');
		  	let type=$(this).prop('value');
			var data = new FormData();
	   		 jQuery.each(jQuery('#id-input-file-1')[0].files, function(i, file) {
		    	     data.append('file-'+i, file);
	   		 });
	   		 $.ajax({
	   			    url: `../BankDetailControllerTest?action=upload_file&id=${id}&type=${type}`,
				    data: data,
				    cache: false,
				    contentType: false,
				    processData: false,
				    type: 'POST',
				    target:'#targetLayer',
				    beforeSubmit:function(){
				    	$('.progress-bar').width('0%');
				    },xhr: function() {
				        var xhr = new window.XMLHttpRequest();
				        xhr.upload.addEventListener("progress", function(evt) {
				            if (evt.lengthComputable) {
				                var percentComplete = (evt.loaded / evt.total) * 100;
				                $('.progress-bar').width(percentComplete+'%');
						    	$('.progress-bar').html('<div id="progress-status">'+Math.ceil(percentComplete)+'%'+'</div>')
				            }
				       }, false);
				       return xhr;
				    },
				    success:function(res){
				    	$('#viewPreview').attr('href','../documents/'+res);
				    	$('#bill_photo').val(res);
				    	if($('#viewPreview').attr('href')){
				    		$('#viewPreview').show();
				    	}else{
				    		$('#viewPreview').hide();
				    	}
				    	getDocList(id,type); 
				   }
	   		 });
		}else{
			alert('Please choose file');
		} 
  });
  
  
  $(document).on('click','#uploaded_document_tbl .delete_document',function(){
	  let id=$(this).prop('id');
	  let name=$(this).prop('name');
	  let type=$(this).prop('type').substring(1);
	  $.confirm({
		    title: 'Delete Confirmation',
		    content: `Are you sure want to delete ${name} ?`,
		    buttons: {
		        confirm: function () {
		            fetch(`../BankDetailControllerTest?action=deleteFile&id=${id}&name=${name}`,{
		            	method:'post'
		            }).then(response => response.text())
		              .then(data => {
		            	  if(data>0){
		            		  getDocList(name,type); 
		            		  $.toast({
  	        				    heading: 'Document Deleted Successfully',
  	        				    showHideTransition: 'fade',
  	        				    icon: 'warning',
  	        				    position: 'top-right'
  	        				});
		            	  }else{
		            		  $.toast({
  	        				    heading: 'Failed!!!',
  	        				    showHideTransition: 'fade',
  	        				    icon: 'danger',
  	        				    position: 'top-right'
  	        				});
		            	  }
		              });
		           
		        },
		        cancel: function () {
		           
		        }
		    }
		});
	  
  });
  
    
   
});