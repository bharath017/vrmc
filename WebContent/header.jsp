<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<input type="hidden" id="session_usertype" value="${bean.usertype}"/>
<input type="hidden" id="session_username" value="${bean.username}"/>
<input type="hidden" id="session_plant_id" value="${bean.plant_id}">
<input type="hidden" id="session_user_id" value="${bean.user_id}">
<input type="hidden" id="session_roles" value="${bean.roles}"/>
<input type="hidden" id="session_business_id" value="${bean.business_id}"/>
<script type="text/javascript">
function getSessionDetails(){
	var obj={
		plant_id:$('#session_plant_id').val(),
		usertype:$('#session_usertype').val(),
		username:$('#session_username').val(),
		user_id:$('#session_user_id').val(),
		roles:$('#session_roles').val(),
		business_id:$('#session_business_id').val(),
	}
	return obj;
}
</script>

<link rel="stylesheet" href="${((bean.usertype=='sgst') || 
					(bean.usertype=='gstbilling') || (bean.usertype=='gstqc') || (bean.usertype=='gstadmin')
					|| (bean.usertype=='gstadmin') || (bean.usertype=='gstaccount') || (bean.usertype=='gst'))?'../':''}loader/myloader.css">
<header id="topnav">
            <div class="topbar-main">
                <div class="container-fluid">

                    <!-- Logo container-->
                    <div class="logo">
               
                        <!-- Image Logo -->
                        <a href="dashboard.jsp" class="logo">
                            <img src="${((bean.usertype=='sgst') || 
								(bean.usertype=='gstbilling') || (bean.usertype=='gstqc') || (bean.usertype=='gstadmin')
								|| (bean.usertype=='gstadmin') || (bean.usertype=='gstaccount') || (bean.usertype=='gst'))?'../':''}image/buildrmc.jpg" alt="" height="50" width="150" class="logo-large">
                        </a>
                    </div>
                    <!-- End Logo container-->

                    <div class="menu-extras topbar-custom">
                        <ul class="list-unstyled topbar-right-menu float-right mb-0">
                            <li class="menu-item">
                                <!-- Mobile menu toggle-->
                                <a class="navbar-toggle nav-link">
                                    <div class="lines">
                                        <span></span>
                                        <span></span>
                                        <span></span>
                                    </div>
                                </a>
                                <!-- End mobile menu toggle-->
                            </li>
							
							
                            <li class="dropdown notification-list">
                                <a class="nav-link dropdown-toggle waves-effect nav-user" data-toggle="dropdown" href="#" role="button"
                                   aria-haspopup="false" aria-expanded="false">
                                    <img src="${((bean.usertype=='sgst') || 
									(bean.usertype=='gstbilling') || (bean.usertype=='gstqc') || (bean.usertype=='gstadmin')
									|| (bean.usertype=='gstadmin') || (bean.usertype=='gstaccount') || (bean.usertype=='gst'))?'../':''}image/buildrmc.jpg"
									 alt="user" class="rounded-circle"> <span class="ml-1 pro-user-name">${bean.users_name}<i class="mdi mdi-chevron-down"></i> </span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right profile-dropdown ">
                                    <!-- item-->
                                    <div class="dropdown-item noti-title">
                                        <h6 class="text-overflow m-0">Welcome !${bean.users_name}</h6>
                                    </div>

                                    <!-- item-->
                                   <!--  <a href="javascript:void(0);" class="dropdown-item notify-item">
                                        <i class="fi-head"></i> <span>My Account</span>
                                    </a> -->

                                    <!-- item-->
                                    <a href="OtherSetting.jsp" class="dropdown-item notify-item">
                                        <i class="fi-cog"></i> <span>General Setting</span>
                                    </a>
                                    <a href="Security.jsp" class="dropdown-item notify-item">
                                        <i class="fi-lock"></i> <span>Change Password</span>
                                    </a>

                                    <!-- item-->
                                    <a href="${((bean.usertype=='sgst') || 
									(bean.usertype=='gstbilling') || (bean.usertype=='gstqc') || (bean.usertype=='gstadmin')
									|| (bean.usertype=='gstadmin') || (bean.usertype=='gstaccount') || (bean.usertype=='gst'))?'../':''}LoginController?button=logout" class="dropdown-item notify-item">
                                        <i class="fi-power"></i> <span>Logout</span>
                                    </a>

                                </div>
                            </li>
                        </ul>
                    </div>
                    <!-- end menu-extras -->

                    <div class="clearfix"></div>

                </div> <!-- end container -->
            </div>
            <!-- end topbar-main -->
			
			<c:forEach items="${bean.roles}" var="role">
				<c:if test="${role==1}"><c:set var="billing" value="true"/></c:if>
				<c:if test="${role==2}"><c:set var="invoice" value="true"/></c:if>
				<c:if test="${role==3}"><c:set var="salesdocument" value="true"/></c:if>
				<c:if test="${role==5}"><c:set var="report" value="true"/></c:if>
				
				<c:if test="${role==6}"><c:set var="customerpo" value="true"/></c:if>
				<c:if test="${role==7}"><c:set var="customer" value="true"/></c:if>
				<c:if test="${role==8}"><c:set var="salesorder" value="true"/></c:if>
				<c:if test="${role==9}"><c:set var="scheduling" value="true"/></c:if>
				<c:if test="${role==10}"><c:set var="quotation" value="true"/></c:if>
				
				<c:if test="${role==11}"><c:set var="dc" value="true"/></c:if>
				<c:if test="${role==12}"><c:set var="deliverychallan" value="true"/></c:if>
				<c:if test="${role==13}"><c:set var="dcreport" value="true"/></c:if>
				
				<c:if test="${role==15}"><c:set var="qc" value="true"/></c:if>
				<c:if test="${role==16}"><c:set var="mixdesign" value="true"/></c:if>
				<c:if test="${role==17}"><c:set var="recipe" value="true"/></c:if>
				<c:if test="${role==18}"><c:set var="cubetest" value="true"/></c:if>
				<c:if test="${role==19}"><c:set var="batchlist" value="true"/></c:if>
				<c:if test="${role==20}"><c:set var="moisture" value="true"/></c:if>
				
				<c:if test="${role==21}"><c:set var="account" value="true"/></c:if>
				<c:if test="${role==22}"><c:set var="customerpayment" value="true"/></c:if>
				<c:if test="${role==23}"><c:set var="makepayment" value="true"/></c:if>
				<c:if test="${role==24}"><c:set var="purchasevoucher" value="true"/></c:if>
				<c:if test="${role==25}"><c:set var="expensevoucher" value="true"/></c:if>
				<c:if test="${role==26}"><c:set var="pettycash" value="true"/></c:if>
				
				<c:if test="${role==27}"><c:set var="hrm" value="true"/></c:if>
				<c:if test="${role==28}"><c:set var="employeedetail" value="true"/></c:if>
				<c:if test="${role==29}"><c:set var="employeeattendance" value="true"/></c:if>
				<c:if test="${role==30}"><c:set var="hrmsetting" value="true"/></c:if>
				
				<c:if test="${role==31}"><c:set var="inventory" value="true"/></c:if>
				<c:if test="${role==32}"><c:set var="supplier" value="true"/></c:if>
				<c:if test="${role==33}"><c:set var="inentoryitem" value="true"/></c:if>
				<c:if test="${role==34}"><c:set var="inventory" value="true"/></c:if>
				<c:if test="${role==35}"><c:set var="inventoryoutgoing" value="true"/></c:if>
				<c:if test="${role==36}"><c:set var="indent" value="true"/></c:if>
				<c:if test="${role==37}"><c:set var="supplierpo" value="true"/></c:if>
				<c:if test="${role==38}"><c:set var="inventoryreport" value="true"/></c:if>
				
				<c:if test="${role==39}"><c:set var="fleet" value="true"/></c:if>
				<c:if test="${role==40}"><c:set var="fleetitem" value="true"/></c:if>
				<c:if test="${role==41}"><c:set var="fleetincoming" value="true"/></c:if>
				<c:if test="${role==42}"><c:set var="fleetoutgoing" value="true"/></c:if>
				<c:if test="${role==43}"><c:set var="fleetreport" value="true"/></c:if>
				
				<c:if test="${role==44}"><c:set var="other" value="true"/></c:if>
				<c:if test="${role==43}"><c:set var="plant" value="true"/></c:if>
				<c:if test="${role==46}"><c:set var="marketing" value="true"/></c:if>
				<c:if test="${role==47}"><c:set var="general" value="true"/></c:if>
				<c:if test="${role==48}"><c:set var="user" value="true"/></c:if>
				
				<c:if test="${role==49}"><c:set var="trnaport" value="true"/></c:if>
				<c:if test="${role==50}"><c:set var="vehicle" value="true"/></c:if>
				<c:if test="${role==51}"><c:set var="diesel" value="true"/></c:if>
				<c:if test="${role==52}"><c:set var="vehicleservice" value="true"/></c:if>
				
				
				
				
				
				
				<c:if test="${role==501}"><c:set var="gstbilling" value="true"/></c:if>
				<c:if test="${role==502}"><c:set var="gstinvoice" value="true"/></c:if>
				<c:if test="${role==503}"><c:set var="gstsalesdocument" value="true"/></c:if>
				<c:if test="${role==504}"><c:set var="gstreport" value="true"/></c:if>
				
				<c:if test="${role==505}"><c:set var="gstcustomerpo" value="true"/></c:if>
				<c:if test="${role==506}"><c:set var="gstcustomer" value="true"/></c:if>
				<c:if test="${role==507}"><c:set var="gstsalesorder" value="true"/></c:if>
				<c:if test="${role==508}"><c:set var="gstscheduling" value="true"/></c:if>
				
				<c:if test="${role==509}"><c:set var="gstdc" value="true"/></c:if>
				<c:if test="${role==510}"><c:set var="gstdeliverychallan" value="true"/></c:if>
				<c:if test="${role==511}"><c:set var="gstdcreport" value="true"/></c:if>
				
				<c:if test="${role==512}"><c:set var="gstaccount" value="true"/></c:if>
				<c:if test="${role==513}"><c:set var="gstcustomerpayment" value="true"/></c:if>
				<c:if test="${role==514}"><c:set var="gstmakepayment" value="true"/></c:if>
				<c:if test="${role==515}"><c:set var="gstpurchasevoucher" value="true"/></c:if>
				<c:if test="${role==516}"><c:set var="gstexpensevoucher" value="true"/></c:if>
				<c:if test="${role==517}"><c:set var="gstpettycash" value="true"/></c:if>
				<c:if test="${role==517}"><c:set var="gstbankdetail" value="true"/></c:if>
				
				<c:if test="${role==518}"><c:set var="gstinventory" value="true"/></c:if>
				<c:if test="${role==519}"><c:set var="gstsupplier" value="true"/></c:if>
				<c:if test="${role==520}"><c:set var="gstinentoryitem" value="true"/></c:if>
				<c:if test="${role==521}"><c:set var="gstinventory" value="true"/></c:if>
				<c:if test="${role==522}"><c:set var="gstinventoryoutgoing" value="true"/></c:if>
				<c:if test="${role==523}"><c:set var="gstindent" value="true"/></c:if>
				<c:if test="${role==524}"><c:set var="gstsupplierpo" value="true"/></c:if>
				<c:if test="${role==525}"><c:set var="gstinventoryreport" value="true"/></c:if>
				
				<c:if test="${role==526}"><c:set var="gstqc" value="true"/></c:if>
				<c:if test="${role==527}"><c:set var="gstrecipe" value="true"/></c:if>
				<c:if test="${role==528}"><c:set var="gstcubetest" value="true"/></c:if>
				<c:if test="${role==529}"><c:set var="gstbatchlist" value="true"/></c:if>
				
				<c:if test="${role==548}"><c:set var="gstother" value="true"/></c:if>
				<c:if test="${role==549}"><c:set var="gstuser" value="true"/></c:if>
			</c:forEach>

            <div class="navbar-custom">
                <div class="container-fluid">
                    <div id="navigation">
                        <!-- Navigation Menu-->
                      		<ul class="navigation-menu text-center">
	                            <li class="has-submenu">
	                                <a href="dashboard.jsp"><i class="icon-speedometer"></i>Dashboard</a>
	                            </li>
								<c:if test="${bean.usertype=='superadmin' || billing}">
									<li class="has-submenu">
		                                <a href="#"><i class="icon-layers"></i>Billing</a>
		                               <ul class="submenu">
		                               		<c:if test="${bean.usertype=='superadmin' || invoice}">
			                                    <li class="has-submenu">
			                                        <a href="#">RMC Invoice</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddInvoice.jsp">Add Invoice</a></li>
			                                            <li><a href="InvoiceList.jsp">Invoice List</a></li>
			                                            <li><a href="ModifiedInvoiceList.jsp">Modified Invoice List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    
											<c:if test="${bean.usertype=='superadmin' || salesdocument}">
												<li class="has-submenu">
			                                        <a href="#">Sales Invoice</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddSalesDocument.jsp">Add Sales Document</a></li>
			                                            <li><a href="SalesDocumentList.jsp">Sales Document List</a></li>
			                                            <li><a href="SalesDocumentReport.jsp">Sales Document Report</a></li>
			                                            <li><a href="SalesDocumentReportBulk.jsp">Bulk Report</a></li>
			                                            <li><a href="SalesConsolidateInvoiceList.jsp">Sales Consolidate Invoice List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    
		                                    <c:if test="${bean.usertype=='superadmin' || transportinvoice}">
			                                    <li class="has-submenu">
			                                        <a href="#">Transport Invoice</a>
			                                        <ul class="submenu">
			                                            <li><a href="TranportCharge.jsp">Transport Invoice</a></li>
			                                            <li><a href="TranportChargeList.jsp">Transport Invoice List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
						
											<c:if test="${bean.usertype=='superadmin' || report}">
			                                    <li class="has-submenu">
			                                        <a href="#">RMC Report</a>
			                                        <ul class="submenu">
			                                            <li><a href="InvoiceReport.jsp">Invoice Report</a></li>
			                                            <li><a href="CallReport.jsp">Call Report</a></li>
			                                            <c:if test="${usertype=='superadmin'}">
			                                            <li><a href="WInvoiceReport.jsp">Esugam Report</a></li>
			                                             
			                                            </c:if>
			                                            <li><a href="OldInvoiceReport.jsp">Old Invoice Report</a></li>
			                                            <li><a href="ConsolidateInvoiceList.jsp">Consolidate Invoice List</a></li>
			                                            <li><a href="ProductionReport.jsp">Production Report</a></li>
			                                            <li><a href="marketing_person_report.jsp">Marketing Person Report</a></li>
			                                            <li><a href="generate_annexure.jsp">Generate Annexire</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                </ul>
		                            </li>
							   </c:if>
								
							   <c:if test="${bean.usertype=='superadmin' || dc }">
		                           <li class="has-submenu">
		                                <a href="#"><i class="fa fa-dashcube"></i>DC</a>
		                               <ul class="submenu">
		                                    <c:if test="${bean.usertype=='superadmin' || deliverychallan}">
			                                    <li class="has-submenu">
			                                        <a href="#">Delivery Challan</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddDC.jsp">Add DC</a></li>
			                                            <li><a href="DCList.jsp">DC List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                     <c:if test="${bean.usertype=='superadmin' || dcreport}">
			                                     <li class="has-submenu">
			                                        <a href="#">DC Report</a>
			                                        <ul class="submenu">
			                                            <li><a href="DCReport.jsp">DC Report</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                </ul>
		                            </li>
	                           </c:if>
								
								<c:if test="${bean.usertype=='superadmin' || customerpo}">
		                            <li class="has-submenu">
		                                <a href="#"><i class="fa fa-flag-checkered"></i>Customer &amp; PO</a>
		                               <ul class="submenu">
		                               		<c:if test="${bean.usertype=='superadmin' || customer}">
			                                    <li class="has-submenu">
			                                        <a href="#">Customer</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddCustomer.jsp">New Customer</a></li>
			                                            <li><a href="CustomerList.jsp">Customer List</a></li>
			                                            <li><a href="godowns.jsp">Godown's</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    
		                                    <c:if test="${bean.usertype=='superadmin' || salesorder}">
			                                     <li class="has-submenu">
			                                        <a href="#">Sales Order</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddPurchaseOrder.jsp">Add Sales Order</a></li>
			                                            <li><a href="PurchaseOrderList.jsp">Sales Order List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    
		                                    <c:if test="${bean.usertype=='superadmin' || scheduling}">
			                                    <li class="has-submenu">
			                                        <a href="#">Scheduling</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddScheduling.jsp">Add Scheduling</a></li>
			                                            <li><a href="SchedulingList.jsp">Scheduling List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='superadmin' || quotation}">
			                                    <li class="has-submenu">
			                                        <a href="#">Customer Quotation</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddCustomerQuotation.jsp">Add Customer Quotation</a></li>
			                                            <li><a href="CustomerQuotationList.jsp">Customer Quotation List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    
		                                </ul>
		                            </li>
	                          </c:if>
	                          
	                           <c:if test="${sales}">
		                           <li class="has-submenu">
		                                <a href="#"><i class="fa fa-skype"></i>Sales</a>
		                               <ul class="submenu">
										   <c:if test="${bean.usertype=='superadmin' || report}">	                                    
			                                   <li class="has-submenu">
			                                        <a href="#">Reports</a>
			                                        <ul class="submenu">
			                                       		 <li><a href="SalesVisitReport.jsp">Sales Visit Report</a></li>
			                                            <li><a href="TargetTracker.jsp">Target Tracker</a></li>
			                                            <li><a href="BookedVsScheduled.jsp">Booked V/s Scheduled</a></li>
			                                            <li><a href="ScoreCard.jsp">Score Card</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    
		                                    <c:if test="${bean.usertype=='superadmin' || forecast}">
			                                    <li class="has-submenu">
			                                        <a href="#">Forecast</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddForecast.jsp">Add Forecast</a></li>
			                                            <li><a href="ForecastList.jsp">Forecast List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='superadmin' || pipeline}">
			                                     <li class="has-submenu">
			                                        <a href="#">Customer Pipeline</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddPipeline.jsp">Add Customer Pipeline</a></li>
			                                            <li><a href="PipelineList.jsp">Customer Pipeline List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                </ul>
		                            </li>
	                           </c:if>
	                            
	                            <c:if test="${bean.usertype=='superadmin' || qc}">
		                            <li class="has-submenu">
		                               <a href="#"><i class="fa fa-quora"></i>QC</a>
		                               <ul class="submenu">
		                               		 <c:if test="${bean.usertype=='superadmin' || mixdesign}">
			                                    <li class="has-submenu">
			                                        <a href="#">Mix Design</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddMixDesign.jsp">Add Mix Design</a></li>
			                                            <li><a href="MixDesignList.jsp">Mix Design List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='superadmin' || recipe}">
			                                     <li class="has-submenu">
			                                        <a href="#">Recipe</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddReceipe.jsp">Add Recipe</a></li>
			                                            <li><a href="ReceipeList.jsp">Recipe List</a></li>
			                                        </ul>
			                                     </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='superadmin' || cubetest}">
			                                    <li class="has-submenu">
			                                        <a href="#">Cube Test</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddCubeTest.jsp">Add Cube Test</a></li>
			                                            <li><a href="CubeTestList.jsp">Cube Test List</a></li>
			                                       	    <li><a href="CubeTestReport.jsp">Cube Test Report</a></li>
								 					</ul>
			                                    </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='superadmin' || batchlist}">
			                                   <li class="has-submenu">
			                                        <a href="#">Batch List</a>
			                                        <ul class="submenu">
			                                            <li><a href="SchweingStetterData.jsp">Batching List</a></li>
			                                            <li><a href="SchwingStetterReport.jsp">Batching Report</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='superadmin' || moisture}">
			                                    <li class="has-submenu">
			                                        <a href="#">Moisture Correction</a>
			                                        <ul class="submenu">
			                                            <li><a href="MoistureCorrection.jsp">Moisture Correction</a></li>
			                                        </ul>
			                                    </li>
		                                   </c:if>
		                                </ul>
		                            </li>
								</c:if>	
	                            
								<c:if test="${bean.usertype=='superadmin' || account}">
		                            <li class="has-submenu">
		                                <a href="#"><i class="fa fa-money"></i>Accounts</a>
		                                <ul class="submenu">
		                                	<c:if test="${bean.usertype=='superadmin' || customerpayment}">
			                                    <li class="has-submenu">
			                                        <a href="#">Customer Payment</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddPayment.jsp">Add payment</a></li>
			                                            <li><a href="CustomerPaymentList.jsp">Payment List</a></li>
			                                            <li><a href="PaymentModificationList.jsp">Recent Modified List</a></li>
			                                            <li><a href="CustomerPaymentReport.jsp">Payment Report</a></li>
			                                            <li><a href="CreditReport.jsp">Credit Report</a></li> 
			                                            <li><a href="OverallReport.jsp">Overall Credit Report</a></li>            
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='superadmin' || makepayment}">
			                                    <li class="has-submenu">
			                                        <a href="#">Make Payment</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddMakePayment.jsp">Add Make Payment</a></li>
			                                            <li><a href="MakePaymentList.jsp">Make Payment List</a></li>
			                                            <li><a href="MakePaymentReport.jsp">Make Payment Report</a></li>
			                                            <li><a href="MakePaymentModificationList.jsp">Recent Modified List</a></li>
			                                            <li><a href="SupplierCreditReport.jsp">Supplier Credit Report</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='superadmin' || purchasevoucher}">
			                                    <li class="has-submenu">
			                                        <a href="#">Purchase Voucher</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddPurchaseVoucher.jsp">Add Purchase Voucher</a></li>
			                                            <li><a href="PurchaseVoucherList.jsp">Purchase Voucher List</a></li>
			                                            <li><a href="PurchaseVoucherReport.jsp">Purchase Voucher Report</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
										    <c:if test="${bean.usertype=='superadmin' || expensevoucher}">
			                                    <li class="has-submenu">
			                                        <a href="#">Journal Voucher</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddExpenseVoucher.jsp">Add Journal Voucher</a></li>
			                                            <li><a href="ExpenseVoucherList.jsp">Journal Voucher List</a></li>
			                                            <li><a href="ExpenseVoucherReport.jsp">Journal Voucher Report</a></li>
			                                            <li><a href="ExpenseCategory.jsp">Journal Voucher Categorys</a></li> 
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='superadmin' || pettycash}">
			                                    <li class="has-submenu">
			                                        <a href="#">Petty Cash</a>
			                                        <ul class="submenu">
			                                        	<c:if test="${bean.plant_id==0}">
				                                            <li><a href="AddPettyCash.jsp">Add Petty Cash</a></li>
				                                            <li><a href="PettyCashList.jsp">Petty Cash List</a></li>
			                                            </c:if>
			                                            <li><a href="PettyCashReport.jsp">Petty Cash Report</a></li>
			                                            <li><a href="PettyCashTransaction.jsp">Petty Cash Transaction</a></li>
			                                        </ul>
			                                    </li> 
		                                    </c:if> 
		                                </ul>
		                            </li>
	                            </c:if>
	
								<c:if test="${bean.usertype=='superadmin' || inventory}">
					    			<li class="has-submenu">
		                                <a href="#"><i class="fa fa-info-circle"></i>Inventory</a>
		                               <ul class="submenu">
		                                	<c:if test="${bean.usertype=='superadmin' || supplier}">
			                                	<li class="has-submenu">
			                                        <a href="#">Supplier</a>
			                                        <ul class="submenu">
			                                            <li><a href="Suppliers.jsp">Supplier's</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                     <c:if test="${bean.usertype=='superadmin' || inentoryitem}">
			                                    <li class="has-submenu">
			                                        <a href="#">Inventory Item</a>
			                                        <ul class="submenu">
			                                            <li><a href="inventory_item.jsp">Inventory Items</a></li>
		<!-- 	                                            <li><a href="InventoryStock.jsp">Inventory Stock</a></li> -->
		<!-- 	                                            <li><a href="InventoryModifiedList.jsp">Recent Stock Modified</a></li> -->
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                     <c:if test="${bean.usertype=='superadmin' || inventory}">
			                                     <li class="has-submenu">
			                                        <a href="#">Inventory</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddInventory.jsp">Add Inventory</a></li>
			                                            <li><a href="InventoryList.jsp">Inventory List</a></li>
			                                             <li><a href="AddInventoryOutgoing.jsp">Material Consumption</a></li>
			                                            <li><a href="ModifiedInventoryList.jsp">Inventory Modified List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                     <c:if test="${bean.usertype=='superadmin' || indent}">
			                                    <li class="has-submenu">
			                                        <a href="#">Indent</a>
			                                        <ul class="submenu">
			                                            <li><a href="RaiseIndent.jsp">Raise Indent</a></li>
			                                            <li><a href="IndentList.jsp">Indent List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
											<c:if test="${bean.usertype=='superadmin' || supplierpo}">
			                                    <li class="has-submenu">
			                                        <a href="#">Supplier PO</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddSupplierPurchaseOrder.jsp">Add Supplier PO</a></li>
			                                            <li><a href="SupplierPurchaseOrderList.jsp">Supplier PO List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                     <c:if test="${bean.usertype=='superadmin' || inventoryreport}">
			                                    <li class="has-submenu">
			                                        <a href="#">Report</a>
			                                        <ul class="submenu">
			                                            <li><a href="InventoryReport.jsp">Inventory Report</a></li>
			                                            <li><a href="InventoryOutGoingReport.jsp">Inventory OutGoing Report</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                </ul>
		                            </li>
	                            </c:if>
	                             
	                            <c:if test="${bean.usertype=='superadmin' || fleet}">
		                             <li class="has-submenu">
		                                <a href="#"><i class="fa fa-facebook"></i>Fleet</a>
		                               <ul class="submenu">
		                               		<c:if test="${bean.usertype=='superadmin' || fleetitem}">
			                                    <li class="has-submenu">
			                                        <a href="#">Fleet Item</a>
			                                        <ul class="submenu">
			                                         <li><a href="FleetItemList.jsp">Fleet Item List</a></li>
					                                <li><a href="FleetItemModifiedList.jsp">Fleet Item Modified List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                     <c:if test="${bean.usertype=='superadmin' || fleetincoming}">
			                                    <li class="has-submenu">
			                                        <a href="#">Fleet Incoming</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddFleet.jsp">Add Fleet Incoming</a></li>
			                                            <li><a href="FleetList.jsp">Incoming List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                     <c:if test="${bean.usertype=='superadmin' || fleetoutgoing}">
			                                    <li class="has-submenu">
			                                        <a href="#">Fleet OutGoing</a>
			                                        <ul class="submenu">
			                                            <li><a href="FleetOutgoing.jsp">Add OutGoing</a></li>
			                                            <li><a href="FleetOutgoingList.jsp">OutGoing List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                     <c:if test="${bean.usertype=='superadmin' || fleetreport}">
			                                    <li class="has-submenu">
			                                        <a href="#">Fleet Report</a>
			                                        <ul class="submenu">
			                                            <li><a href="IncomingFleetReport.jsp">Incoming Fleet Report</a></li>
			                                            <li><a href="FleetOutgoingReport.jsp">Outgoing Fleet Report</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                </ul>
		                            </li>
	                            </c:if>
	                             
	                            <c:if test="${bean.usertype=='superadmin' || other}">
		                            <li class="has-submenu">
		                                <a href="#"><i class="fa fa-cog"></i>Other</a>
		                                <ul class="submenu">
		                                	 <c:if test="${bean.usertype=='superadmin' || plant}">
			                                     <li class="has-submenu">
			                                        <a href="#">Plant</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddPlant.jsp">New Plant</a></li>
			                                            <li><a href="PlantList.jsp">Plant List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                     <c:if test="${bean.usertype=='superadmin' || marketing}">
			                                    <li class="has-submenu">
			                                        <a href="#">Marketing Person</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddMarketingPerson.jsp">Add Marketing Person</a></li>
			                                            <li><a href="MarketingPersonList.jsp">Marketing Person List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                     <c:if test="${bean.usertype=='superadmin' || general}">
			                                    <li class="has-submenu">
			                                        <a href="#">General Setting</a>
			                                        <ul class="submenu">
			                                        	<li><a href="Grades.jsp">Grades</a></li>
			                                            <li><a href="CompanySetting.jsp">Company Setting</a></li>
			                                            <li><a href="MailSetting.jsp">Mail Setting</a></li>
			                                            <li><a href="GSTSetting.jsp">GST Setting</a></li>
			                                            <li><a href="GSTPercent.jsp">GST Percent</a></li>
			                                            <li><a href="Units.jsp">Unit Setting</a></li>
			                                            <c:if test="${usertype=='superadmin'}">
			                                            <li><a href="SmsSetting.jsp">SMS Setting</a></li>
			                                            <li><a href="BusinessGroup.jsp">Business Groups</a></li>
			                                            </c:if>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                     <c:if test="${bean.usertype=='superadmin' || user}">
			                                    <li class="has-submenu">
			                                        <a href="#">Users</a>
			                                        <ul class="submenu">
			                                            <li><a href="Users.jsp">Users</a></li>
			                                            <li><a href="UserRole.jsp">User Role</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                </ul>
		                            </li>
	                            </c:if>
	                            
	                            <c:if test="${bean.usertype=='superadmin' || trnaport}">
		                            <li class="has-submenu">
		                                <a href="#"><i class="mdi mdi-truck-delivery"></i>Transport</a>
		                                <ul class="submenu">
		                                	<c:if test="${bean.usertype=='superadmin' || vehicle}">
			                                    <li class="has-submenu">
			                                        <a href="#">Vehicle</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddVehicle.jsp">New Vehicle</a></li>
			                                            <li><a href="VehicleList.jsp">Vehicle List</a></li>
			                                        </ul>
			                                    </li>
	
			                                     <li class="has-submenu">
			                                        <a href="#">Driver</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddDriver.jsp">New Driver</a></li>
			                                            <li><a href="DriverList.jsp">Driver List</a></li>
			                                        </ul>
			                                    </li>
		                                    
			                                    <li class="has-submenu">
			                                        <a href="#">Pump &amp; DG</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddPumpDG.jsp">Add Pump &amp; DG</a></li>
			                                            <li><a href="PumpDGList.jsp">Pump &amp; DG List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    
		                                    <c:if test="${bean.usertype=='superadmin' || diesel}">
			                                    <li class="has-submenu">
			                                        <a href="#">Diesel Consumption</a>
			                                        <ul class="submenu">
			                                            <li><a href="Consumption.jsp">Diesel Consumption</a></li>
			                                            <li><a href="consumption_list.jsp">Consumption List</a></li>
			                                            <li><a href="diesel_modification_list.jsp">Consumption Modified List</a></li>
			                                            <li><a href="ConsumptionSheet.jsp">Consumption Report</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='superadmin' || vehicleservice}">
			                                    <li class="has-submenu">
			                                        <a href="#">Vehicle Service</a>
			                                        <ul class="submenu">
			                                            <li><a href="VehicleService.jsp">Add Vehicle Service</a></li>
			                                            <li><a href="VehicleServiceList.jsp">Vehicle Service List</a></li>
			                                            <li><a href="AddRepair.jsp">Repair</a></li>
			                                            <li><a href="VehicleRepairList.jsp">Repair List</a></li>
			                                     
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                </ul>
		                            </li>
	                            </c:if>
	                           
	                            <c:if test="${bean.usertype=='superadmin' || hrm }"> 
		                            <li class="has-submenu">
		                                <a href="#"><i class="fa fa-users"></i><b>HRM</b></a>
		                               <ul class="submenu">
		                               		<c:if test="${bean.usertype=='superadmin' || employeedetail }"> 
			                                    <li class="has-submenu">
			                                        <a href="#"><b>Employee</b></a>
			                                        <ul class="submenu">
			                                            <li><a href="AddEmployee.jsp"><b>Add Employee</b></a></li>
			                                            <li><a href="EmployeeList.jsp"><b>Employee List</b></a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='superadmin' || employeeattendance }">
			                                    <li class="has-submenu">
			                                        <a href="#"><b>Emp Attendance</b></a>
			                                        <ul class="submenu">
			                                            <li><a href="AddAttendance.jsp"><b>Take Attendance</b></a></li>
			                                            <li><a href="AttendanceReport.jsp"><b>Attendance Report</b></a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='superadmin' || employeesalary }">
			                                    <li class="has-submenu">
			                                        <a href="#"><b>Employee Salary</b></a>
			                                        <ul class="submenu">
			                                            <li><a href="AddEmployeeSalary.jsp"><b>Add Employee Salary</b></a></li>
			                                            <li><a href="EmployeeSalarylist.jsp"><b>Employee Salary List</b></a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='superadmin' || hrmsetting }">
			                                    <li class="has-submenu">
			                                        <a href="#"><b>HRM Setting</b></a>
			                                        <ul class="submenu">
			                                            <li><a href="HRMSetting.jsp"><b>Settings</b></a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                </ul>
		                            </li>
	                            </c:if>
	                            
	                            <c:if test="${bean.usertype=='superadmin'}"> 
		                            <li class="has-submenu">
		                                <a href="#"><i class="fa fa-users"></i><b>Reports</b></a>
		                               <ul class="submenu">
		                                    <li class="has-submenu">
		                                        <a href="#"><b>Invoice Report</b></a>
		                                        <ul class="submenu">
		                                            <li><a href=InvoiceReport.jsp><b>RMC Invoice Report</b></a></li>
		                                            <li><a href="CallReport.jsp">Call Report</a></li>
		                                            <li><a href="ProductionReport.jsp">Production Report</a></li>
		                                            <li><a href="marketing_person_report.jsp">Marketing Person Report</a></li>
		                                            <li><a href="generate_annexure.jsp">Generate Annexire</a></li>
		                                        </ul>
		                                    </li>
		                                    <li class="has-submenu">
		                                        <a href="#"><b>Sales Document Report</b></a>
		                                        <ul class="submenu">
		                                            <li><a href="SalesDocumentReport.jsp"><b>Sales Document Report</b></a></li>
		                                        </ul>
		                                    </li>
		                                    
		                                    <li class="has-submenu">
		                                        <a href="#"><b>DC Report</b></a>
		                                        <ul class="submenu">
		                                            <li><a href="DCReport.jsp"><b>DC Report</b></a></li>
		                                        </ul>
		                                    </li>
		                                    
		                                    <li class="has-submenu">
		                                        <a href="#"><b>Payment Report</b></a>
		                                        <ul class="submenu">
		                                            <li><a href="CustomerPaymentReport.jsp">Payment Received Report</a></li>
		                                            <li><a href="CreditReport.jsp">Credit Report</a></li>
		                                        </ul>
		                                    </li>
		                                    <li class="has-submenu">
		                                        <a href="#"><b>Supplier Payment Report</b></a>
		                                        <ul class="submenu">
		                                            <li><a href="MakePaymentReport.jsp">Supplier Payment Report</a></li>
		                                            <li><a href="SupplierCreditReport.jsp">Supplier Credit Report</a></li>
		                                        </ul>
		                                    </li>
		                                    <li class="has-submenu">
		                                        <a href="#"><b>Accounts Report</b></a>
		                                        <ul class="submenu">
		                                            <li><a href="PurchaseVoucherReport.jsp">Purchase Voucher Report</a></li>
		                                            <li><a href="ExpenseVoucherReport.jsp">Expense Voucher Report</a></li>
		                                        </ul>
		                                    </li>
		                                </ul>
		                            </li>
	                            </c:if>
	                            
	                            
							   <c:if test="${bean.usertype=='sgst' || gstbilling}">
									<li class="has-submenu">
		                                <a href="#"><i class="icon-layers"></i>Billing</a>
		                               <ul class="submenu">
		                               		<c:if test="${bean.usertype=='sgst' || gstinvoice}">
			                                    <li class="has-submenu">
			                                        <a href="#">RMC Invoice</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddInvoice.jsp">Add Invoice</a></li>
			                                            <li><a href="InvoiceList.jsp">Invoice List</a></li>
			                                            <li><a href="ModifiedInvoiceList.jsp">Modified Invoice List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    
											<c:if test="${bean.usertype=='sgst' || gstsalesdocument}">
												<li class="has-submenu">
			                                        <a href="#">Sales Invoice</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddSalesDocument.jsp">Add Sales Document</a></li>
			                                            <li><a href="SalesDocumentList.jsp">Sales Document List</a></li>
			                                            <li><a href="SalesDocumentReport.jsp">Sales Document Report</a></li>
			                                            <li><a href="SalesDocumentReportBulk.jsp">Bulk Report</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
						
											<c:if test="${bean.usertype=='sgst' || gstreport}">
			                                    <li class="has-submenu">
			                                        <a href="#">RMC Report</a>
			                                        <ul class="submenu">
			                                            <li><a href="InvoiceReport.jsp">Invoice Report</a></li>
			                                            <li><a href="CallReport.jsp">Call Report</a></li>
			                                            <li><a href="OldInvoiceReport.jsp">Old Invoice Report</a></li>
			                                            <li><a href="OldCustomerPaymentReport.jsp">Old Customer Payment Report</a></li>
														<li><a href="OldCustomerPaymentList.jsp">Old Customer Payment List</a></li>
			                                            
			                                            <c:if test="${usertype=='sgst'}">
			                                            <li><a href="WInvoiceReport.jsp">Esugam Report</a></li>
			                                            </c:if>
			                                            <li><a href="ConsolidateInvoiceList.jsp">Consolidate Invoice List</a></li>
			                                            <li><a href="ProductionReport.jsp">Production Report</a></li>
			                                            <li><a href="marketing_person_report.jsp">Marketing Person Report</a></li>
			                                            <li><a href="generate_annexure.jsp">Generate Annexire</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                </ul>
		                            </li>
							   </c:if>
							   
							  <c:if  test="${bean.usertype=='sgst' || gstdc }">
		                           <li class="has-submenu">
		                                <a href="#"><i class="fa fa-dashcube"></i>DC</a>
		                               <ul class="submenu">
		                                    <c:if test="${bean.usertype=='sgst' || gstdeliverychallan }">
		                                    <li class="has-submenu">
		                                        <a href="#">Delivery Challan</a>
		                                        <ul class="submenu">
		                                            <li><a href="AddDC.jsp">Add DC</a></li>
		                                            <li><a href="DCList.jsp">DC List</a></li>
		                                        </ul>
		                                    </li>
		                                    </c:if>
		                                     <c:if test="${bean.usertype=='sgst' || gstdcreport}">
		                                     <li class="has-submenu">
		                                        <a href="#">DC Report</a>
		                                        <ul class="submenu">
		                                            <li><a href="DCReport.jsp">DC Report</a></li>
		                                        </ul>
		                                    </li>
		                                    </c:if>
		                                </ul>
		                            </li>
	                           </c:if>
							   
							  <c:if test="${bean.usertype=='sgst' || gstcustomerpo}">
		                            <li class="has-submenu">
		                                <a href="#"><i class="fa fa-user-plus"></i>Customer &amp; PO</a>
		                               <ul class="submenu">
		                               		<c:if test="${bean.usertype=='sgst' || gstcustomer}">
			                                    <li class="has-submenu">
			                                        <a href="#">Customer</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddCustomer.jsp">New Customer</a></li>
			                                            <li><a href="CustomerList.jsp">Customer List</a></li>
			                                            <li><a href="CustomerAddressDetails.jsp">Address &amp; Details</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    
		                                    <c:if test="${bean.usertype=='sgst' || gstsalesorder}">
			                                     <li class="has-submenu">
			                                        <a href="#">Sales Order</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddPurchaseOrder.jsp">Add Sales Order</a></li>
			                                            <li><a href="PurchaseOrderList.jsp">Sales Order List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    
		                                    <c:if test="${bean.usertype=='sgst' || gstscheduling}">
			                                    <li class="has-submenu">
			                                        <a href="#">Scheduling</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddScheduling.jsp">Add Scheduling</a></li>
			                                            <li><a href="SchedulingList.jsp">Scheduling List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                </ul>
		                            </li>
	                          </c:if>
	                          
	                          <c:if test="${bean.usertype=='sgst' || gstaccount}">
		                            <li class="has-submenu">
		                                <a href="#"><i class="fa fa-money"></i>Accounts</a>
		                                <ul class="submenu">
		                                	<c:if test="${bean.usertype=='sgst' || gstcustomerpayment}">
			                                    <li class="has-submenu">
			                                        <a href="#">Customer Payment</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddPayment.jsp">Add payment</a></li>
			                                            <li><a href="CustomerPaymentList.jsp">Payment List</a></li>
			                                            <li><a href="PaymentModificationList.jsp">Recent Modified List</a></li>
			                                            <li><a href="CustomerPaymentReport.jsp">Payment Report</a></li>
			                                            <li><a href="CreditReport.jsp">Credit Report</a></li> 
			                                            <li><a href="OverallReport.jsp">Overall Credit Report</a></li>            
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='sgst' || gstmakepayment}">
			                                    <li class="has-submenu">
			                                        <a href="#">Make Payment</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddMakePayment.jsp">Add Make Payment</a></li>
			                                            <li><a href="MakePaymentList.jsp">Make Payment List</a></li>
			                                            <li><a href="MakePaymentReport.jsp">Make Payment Report</a></li>
			                                            <li><a href="MakePaymentModificationList.jsp">Recent Modified List</a></li>
			                                            <li><a href="SupplierCreditReport.jsp">Supplier Credit Report</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='sgst' || gstpurchasevoucher}">
			                                    <li class="has-submenu">
			                                        <a href="#">Purchase Voucher</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddPurchaseVoucher.jsp">Add Purchase Voucher</a></li>
			                                            <li><a href="PurchaseVoucherList.jsp">Purchase Voucher List</a></li>
			                                            <li><a href="PurchaseVoucherReport.jsp">Purchase Voucher Report</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
										    <c:if test="${bean.usertype=='sgst' || gstexpensevoucher}">
			                                    <li class="has-submenu">
			                                        <a href="#">Expense Voucher</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddExpenseVoucher.jsp">Add Expense Voucher</a></li>
			                                            <li><a href="ExpenseVoucherList.jsp">Expense Voucher List</a></li>
			                                            <li><a href="ExpenseVoucherReport.jsp">Expense Voucher Report</a></li> 
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='sgst' || gstpettycash}">
			                                    <li class="has-submenu">
			                                        <a href="#">Petty Cash</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddPettyCash.jsp">Add Petty Cash</a></li>
			                                            <li><a href="PettyCashList.jsp">Petty Cash List</a></li>
			                                            <li><a href="PettyCashTransaction.jsp">Petty Cash Transaction</a></li>
			                                            <li><a href="PettyCashReport.jsp">Petty Cash Report</a></li>
			                                            <li><a href="PettyCashTransactionReport.jsp">Petty Cash Transaction</a></li>
			                                        </ul>
			                                    </li> 
		                                    </c:if> 
		                                    
		                                    
		                                    <c:if test="${bean.usertype=='sgst' || gstbankdetail}">
			                                    <li class="has-submenu">
			                                        <a href="#">BANK DETAIL'S</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddBankDetail.jsp">BANK/CASH DETAILS</a></li>
			                                            <li><a href="AddBankTransaction.jsp">Cash Register</a></li>
			                                            <li><a href="BankTransactionReport.jsp">Cash Transaction Report</a></li>
			                                        </ul>
			                                    </li> 
		                                    </c:if> 
		                                </ul>
		                            </li>
	                            </c:if>
							   
							   <c:if test="${bean.usertype=='sgst' || gstinventory}">
					    			<li class="has-submenu">
		                                <a href="#"><i class="fa fa-info-circle"></i>Inventory</a>
		                               <ul class="submenu">
		                                	<c:if test="${bean.usertype=='sgst' || gstsupplier}">
			                                	<li class="has-submenu">
			                                        <a href="#">Supplier</a>
			                                        <ul class="submenu">
			                                            <li><a href="Suppliers.jsp">Supplier's</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                     <c:if test="${bean.usertype=='sgst' || gstinentoryitem}">
			                                    <li class="has-submenu">
			                                        <a href="#">Inventory Item</a>
			                                        <ul class="submenu">
			                                            <li><a href="inventory_item.jsp">Inventory Items</a></li>
		<!-- 	                                            <li><a href="InventoryItemList.jsp">Item Stocks</a></li> -->
		<!-- 	                                            <li><a href="InventoryModifiedList.jsp">Recent Stock Modified</a></li> -->
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                     <c:if test="${bean.usertype=='sgst' || gstinventory}">
			                                     <li class="has-submenu">
			                                        <a href="#">Inventory</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddInventory.jsp">Add Inventory</a></li>
			                                            <li><a href="InventoryList.jsp">Inventory List</a></li>
			                                            <li><a href="ModifiedInventoryList.jsp">Inventory Modified List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                     <c:if test="${bean.usertype=='sgst' || gstinventoryoutgoing}">
			                                    <li class="has-submenu">
			                                        <a href="#">Inventory OutGoing</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddInventoryOutGoing.jsp">Add Inventory OutGoing</a></li>
			                                            <li><a href="InventoryOutGoingList.jsp">Inventory OutGoing List</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
	
		                                     <c:if test="${bean.usertype=='sgst' || gstinventoryreport}">
			                                    <li class="has-submenu">
			                                        <a href="#">Report</a>
			                                        <ul class="submenu">
			                                            <li><a href="InventoryReport.jsp">Inventory Report</a></li>
			                                            <li><a href="InventoryOutGoingReport.jsp">Inventory OutGoing Report</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                </ul>
		                            </li>
	                            </c:if>
							   
							    <c:if test="${bean.usertype=='sgst' || gstother}">
									<li class="has-submenu">
		                                <a href="#"><i class="icon-layers"></i>Other</a>
		                               <ul class="submenu">
		                               		 <c:if test="${bean.usertype=='sgst' || gstuser}">
			                                    <li class="has-submenu">
			                                        <a href="#">Users</a>
			                                        <ul class="submenu">
			                                            <li><a href="Users.jsp">Users</a></li>
			                                            <li><a href="UserRole.jsp">User Role</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                </ul>
		                            </li>
							   </c:if>
								
								<c:if test="${bean.usertype=='sgst' || gstqc}">
		                            <li class="has-submenu">
		                               <a href="#"><i class="fa fa-quora"></i>QC</a>
		                               <ul class="submenu">
		                                    <c:if test="${bean.usertype=='sgst' || gstrecipe}">
			                                     <li class="has-submenu">
			                                        <a href="#">Recipe</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddReceipe.jsp">Add Recipe</a></li>
			                                            <li><a href="ReceipeList.jsp">Recipe List</a></li>
			                                        </ul>
			                                     </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='sgst' || gstcubetest}">
			                                    <li class="has-submenu">
			                                        <a href="#">Cube Test</a>
			                                        <ul class="submenu">
			                                            <li><a href="AddCubeTest.jsp">Add Cube Test</a></li>
			                                            <li><a href="CubeTestList.jsp">Cube Test List</a></li>
			                                       	    <li><a href="CubeTestReport.jsp">Cube Test Report</a></li>
								 					</ul>
			                                    </li>
		                                    </c:if>
		                                    <c:if test="${bean.usertype=='sgst' || gstbatchlist}">
			                                   <li class="has-submenu">
			                                        <a href="#">Batch List</a>
			                                        <ul class="submenu">
			                                            <li><a href="SchweingStetterData.jsp">Batching List</a></li>
			                                            <li><a href="SchwingStetterReport.jsp">Batching Report</a></li>
			                                        </ul>
			                                    </li>
		                                    </c:if>
		                                    
		                                </ul>
		                            </li>
								</c:if>	
	                            
								
								
	                        </ul>
                        <!-- End navigation menu -->
                    </div> <!-- end #navigation -->
                </div> <!-- end container -->
            </div> <!-- end navbar-custom -->
           <div class="" id="loadme"></div>
        </header>