<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Bank List - ${initParam.company_name}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico">

        <!-- DataTables -->
        <link href="../plugins/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="../plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <!-- Responsive datatable examples -->
        <link href="../plugins/datatables/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />

        <!-- Multi Item Selection examples -->
        <link href="../plugins/datatables/select.bootstrap4.min.css" rel="stylesheet" type="text/css" />

        <!-- App css -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css2/style.css" rel="stylesheet" type="text/css" />
		  <!-- Custom box css -->
        <link href="../plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../assets/css/select2.min.css" />
		
        <script src="../assets/js/modernizr.min.js"></script>

    </head>

    <body>

        <!-- Navigation Bar-->
        <!-- PUT HEADER.JSP HERE -->
       <%@ include file="../header.jsp" %>
        <!-- End Navigation Bar-->


        <div class="wrapper">
            <div class="container-fluid">

                <!-- Page-Title -->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="page-title-box">
                            <div class="btn-group pull-right">
                                <ol class="breadcrumb hide-phone p-0 m-0">
                                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                                    <li class="breadcrumb-item"><a href="#">Accounts</a></li>
                                    <li class="breadcrumb-item active">Bank Details</li>
                                    <li class="breadcrumb-item active">Bank Details</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Cash Detail's</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

				
				<sql:query var="gst" dataSource="jdbc/rmc">
					select b.*,g.group_name,b.group_name,
					(select sum(payment_amount) from test_customer_payment where bank_detail_id=b.bank_detail_id) as customer_payment,
					(select sum(payment_amount) from test_make_payment where bank_detail_id=b.bank_detail_id) as supplier_payment,
					(select sum(amount) from test_petty_cash where bank_detail_id=b.bank_detail_id) as petty_cash
					from bank_detail b,business_group g
					where b.business_id=g.business_id
					and b.business_id like if(?=0,'%%',?)
					<sql:param value="${bean.business_id}"/>
					<sql:param value="${bean.business_id}"/>
				</sql:query>
				<div class="row">
					<div class="col-sm-6">
						<table class="table table-bordered text-center">
                    		<thead>
                    			<tr style="background-color: #ce9401; color: white;">
                    				<td colspan="5">
                    					Cash Details
                    				</td>
                    			</tr>
                    			<tr style="background-color: #1a82cc; color: white;">
                    				<th>S/L No</th>
                    				<th>Name</th>
                    				<th>Balance</th>
                    				<th>Business Group</th>
                    				<th>Option</th>
                    			</tr>
                    		</thead>
                    			<c:set value="${gst.rows}" var="bk"/>
                    		<tbody>
                    			<c:forEach items="${bk}" var="bank">
                    				<c:if test="${bank.group_name=='cash'}">
                    					<tr>
	                    					<td>${bank.bank_detail_id}</td>
	                    					<td>${bank.bank_name}</td>
	                    					<td><fmt:formatNumber value="${(bank.customer_payment+bank.nb_amount)-(bank.supplier_payment+bank.petty_cash)}"
	                    							 maxFractionDigits="2" groupingUsed="false"/></td>
	                    					<td>${bank.group_name}</td>
											<td>
												<a href="#delete-model" class="text-danger" 
													onclick="deleteGSTPercent('${bank.bank_detail_id}','${bank.bank_name}',
														'${bank.ifsc_code}','${bank.account_no}','${bank.branch_name}','${bank.nb_amount}','${bank.business_id}');" 
													data-animation="blur" data-plugin="custommodal"  data-overlaySpeed="100" data-overlayColor="#36404a">
													<i class="fa fa-edit"></i>
												</a>
											</td>                    					
	                    				</tr>
                    				</c:if>
                    			</c:forEach>
                    		</tbody>
                    	</table>
					</div>
					
					<div class="col-sm-6">
						<table class="table table-bordered text-center">
                    		<thead>
                    			<tr style="background-color: #ce9401; color: white;">
                    				<td colspan="5">
                    					Other/Adjustment Details
                    				</td>
                    			</tr>
                    			<tr style="background-color: #1a82cc; color: white;">
                    				<th>S/L No</th>
                    				<th>Name</th>
                    				<th>Adjusted Balance</th>
                    				<th>Business Group</th>
                    				<th>Option</th>
                    			</tr>
                    		</thead>
                    			<c:set value="${gst.rows}" var="bk"/>
                    		<tbody>
                    			<c:forEach items="${bk}" var="bank">
                    				<c:if test="${bank.group_name=='other'}">
                    					<tr>
	                    					<td>${bank.bank_detail_id}</td>
	                    					<td>${bank.bank_name}</td>
	                    					<td><fmt:formatNumber value="${(bank.customer_payment+bank.nb_amount)-(bank.supplier_payment+bank.petty_cash)}"
	                    							 maxFractionDigits="2" groupingUsed="false"/></td>
	                    					<td>${bank.group_name}</td>
											<td>
												<a href="#delete-model" class="text-danger" 
													onclick="deleteGSTPercent('${bank.bank_detail_id}','${bank.bank_name}',
														'${bank.ifsc_code}','${bank.account_no}','${bank.branch_name}','${bank.nb_amount}','${bank.business_id}');" 
													data-animation="blur" data-plugin="custommodal"  data-overlaySpeed="100" data-overlayColor="#36404a">
													<i class="fa fa-edit"></i>
												</a>
											</td>                    					
	                    				</tr>
                    				</c:if>
                    			</c:forEach>
                    		</tbody>
                    	</table>
					</div>
				</div>

				 <!-- Delete of gst percent  -->
				<div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #491136;">Update Bank Details : <span class="gst_percent"></span> </h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" method="post" action="../BankDetailControllerTest?action=updateBankDetail">
		                	
		                	
		                			 <div class="col-sm-12" style="text-align: left;">
                                       <div class="form-group m-b-25">
                                          <div class="col-12">
                                              <label for="business-group">Business Group <span class="text-danger"></span></label>
											  <sql:query var="group" dataSource="jdbc/rmc">
											  	 select business_id,group_name
											  	 from business_group
											  	 where business_id like if(?=0,'%%',?)
											  	 <sql:param value="${bean.business_id}"/>
											  	 <sql:param value="${bean.business_id}"/>
											  </sql:query>
											  <select class="form-control" id="business_id" name="business_id">
											  		<c:forEach items="${group.rows}" var="group">
											  			<option value="${group.business_id}">${group.group_name}</option>
											  		</c:forEach>
											  </select>
                                          </div>
                                      </div>
                                     </div>
                                     
                                     <div class="col-sm-12" style="text-align: left;">
                                     	<div class="form-group m-b-25">
                                     		<label for="group">Group <span class="text-danger">*</span> </label>
                                     		<select name="group" class="form-control">
                                     			<option value="bank">Bank</option>
                                     			<option value="cash">Cash</option>
                                     			<option value="other">Other</option>
                                     		</select>
                                     	</div>
                                     </div>
                                      
                                      
		                			<div class="col-sm-12" style="text-align: left;">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Bank Name</label>
	                                              <input type="hidden" name="bank_detail_id" id="update_bank_detail_id"/>
	                                              <input class="form-control" type="text" id="update_bank_name" name="bank_name" required="" placeholder="Enter Bank Name">
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      <div class="col-sm-12" style="text-align: left;">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Account Number</label>
	                                              <input class="form-control" type="text" id="update_account_no" name="account_no" required="" placeholder="Enter Account Number">
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      <div class="col-sm-12" style="text-align: left;">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Branch Name</label>
	                                              <input class="form-control" type="text" id="update_branch_name" name="branch_name" required="" placeholder="Enter Branch Name">
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      <div class="col-sm-12" style="text-align: left;">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Account Balance</label>
	                                              <input class="form-control" type="number" step="0.01" id="update_amount" name="amount" required="" placeholder="Enter Account Balance">
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      <div class="col-sm-12" style="text-align: left;">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">IFSC Code</label>
	                                              <input class="form-control" type="text" id="update_ifsc_code" name="ifsc_code" required="" placeholder="Enter IFSC CODE">
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                               <button type="submit" id="comp_save" class="btn btn-custom waves-effect waves-light">
			                                            Submit
			                                        </button>
			                                        <button type="reset" data-dismiss="modal" aria-hidden="true" onclick="Custombox.close();" class="btn btn-light waves-effect m-l-5">
			                                            Cancel
			                                        </button>
	                                          </div>
	                                      </div>
                                      </div>
		                </form>
		            </div>
		        </div>
                <!--  PLANT DELETE MODAL END  -->
             
                <!-- MODAL FOR GRADE DETAILS -->
				<div id="add-comp"  class="modal fade" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true" style="display: none;">
                      <div class="modal-dialog" >
                          <div class="modal-content" style="width: 100%;">

                              <div class="modal-body" >
                                  <h2 class="text-uppercase text-center m-b-30 text-success">
                                     ADD BANK/CASH DETAILS
                                  </h2>

                                  <form class="form-horizontal" action="BankDetailController?action=insertBankDetail" method="post">
								     <div class="col-sm-12" style="text-align: left;">
                                       <div class="form-group m-b-25">
                                          <div class="col-12">
                                              <label for="business-group">Business Group <span class="text-danger"></span></label>
											  <sql:query var="group" dataSource="jdbc/rmc">
											  	 select business_id,group_name
											  	 from business_group
											  	 where business_id like if(?=0,'%%',?)
											  	 <sql:param value="${bean.business_id}"/>
											  	 <sql:param value="${bean.business_id}"/>
											  </sql:query>
											  <select class="form-control" id="business_id" name="business_id">
											  		<c:forEach items="${group.rows}" var="group">
											  			<option value="${group.business_id}">${group.group_name}</option>
											  		</c:forEach>
											  </select>
                                          </div>
                                      </div>
                                     </div>
                                     
                                     <div class="col-sm-12" style="text-align: left;">
                                     	<div class="form-group m-b-25">
                                     		<div class="col-12">
                                     			<label for="group">Group <span class="text-danger">*</span> </label>
	                                     		<select name="group"  id="group" class="form-control">
	                                     			<option value="bank">Bank</option>
	                                     			<option value="cash">Cash</option>
	                                     			<option value="other">Other</option>
	                                     		</select>
                                     		</div>	
                                     	</div>
                                     </div>
                                     
                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Bank/Cash Name</label>
	                                              <input class="form-control" type="text" id="bank_name" name="bank_name" required="" placeholder="Enter Bank Name">
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      <div class="col-sm-12 no-bank">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Account Number</label>
	                                              <input class="form-control no-bank" type="text" id="account_no" name="account_no" required="" placeholder="Enter Account Number">
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      <div class="col-sm-12 no-bank">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Branch Name</label>
	                                              <input class="form-control no-bank" type="text" id="branch_name" name="branch_name" required="" placeholder="Enter Branch Name">
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">Balance</label>
	                                              <input class="form-control" type="number" step="0.01" id="amount" name="amount" required="" placeholder="Enter Account Balance">
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      <div class="col-sm-12 no-bank">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="username">IFSC Code</label>
	                                              <input class="form-control no-bank" type="text" id="ifsc_code" name="ifsc_code" required="" placeholder="Enter IFSC CODE">
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                               <button type="submit" id="comp_save" class="btn btn-custom waves-effect waves-light">
			                                            Submit
			                                        </button>
			                                        <button type="reset" data-dismiss="modal" aria-hidden="true" class="btn btn-light waves-effect m-l-5">
			                                            Cancel
			                                        </button>
	                                          </div>
	                                      </div>
                                      </div>
                                  </form>
                              </div>
                          </div><!-- /.modal-content -->
                      </div><!-- /.modal-dialog -->
                  </div><!-- /.modal -->
                
                <!--END FOR GRADE MODAL  -->

            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->


        <!-- Footer -->
        <!-- PUT FOOTER.JSP HERE -->
        <%@ include file="../footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/popper.min.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/waves.js"></script>
        <script src="../assets/js/jquery.slimscroll.js"></script>
        <!-- Selection table -->
        <!-- App js -->
        <script src="../assets/js/jquery.core.js"></script>
        <script src="../assets/js/jquery.app.js"></script>

        <script type="text/javascript">
            $(document).ready(function() {

                $('#group').on('change',function(){
                	var group=$('#group').val();
                	changeGroup(group);
                });
                
                let changeGroup=(group) = > {
                	if(group=='bank'){
                		$('.no-bank').show();
                		$('.no-bank').attr('disabled',false);
                	}else{
                		$('.no-bank').hide();
                		$('.no-bank').attr('disabled',true);
                	}
                }
            } );
        </script>
        
        <!-- Modal-Effect -->
        <script src="../plugins/custombox/js/custombox.min.js"></script>
        <script src="../plugins/custombox/js/legacy.min.js"></script>
        <script src="../assets/js/select2.min.js"></script>
        <script type="text/javascript">
			function deleteGSTPercent(bank_detail_id,bank_name,ifsc_code,account_no,branch_name,amount,business_id){
				$('#update_bank_detail_id').val(bank_detail_id);
				$('#update_bank_name').val(bank_name);
				$('#update_ifsc_code').val(ifsc_code);
				$('#update_account_no').val(account_no);
				$('#update_branch_name').val(branch_name);
				$('#update_amount').val(amount);
				$('#business_id').val(business_id);
			}
		</script>
		
		<script type="text/javascript">
            $(document).ready(function() {
                $('.select2').css('width','60%').select2({allowClear:true})
				.on('change', function(){
				}); 
            });
        </script>
        
        
        

    </body>
</html>