package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.willka.soft.dao.FleetDAOImpl;
import com.google.gson.Gson;
import com.willka.soft.bean.FleetIncomingBean;
import com.willka.soft.bean.FleetIncomingEditBean;
import com.willka.soft.bean.FleetIncomingItemBean;
import com.willka.soft.bean.FleetItemBean;
import com.willka.soft.bean.FleetItemModificationBean;
import com.willka.soft.bean.FleetOutgoingBean;
import com.willka.soft.bean.FleetOutgoingItemBean;
import com.willka.soft.bean.SiteDetailBean;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.dao.FleetDAO;

/**
 * Servlet implementation class FleetController
 */
@WebServlet("/FleetController")
public class FleetController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		FleetDAO dao = new FleetDAOImpl();
		PrintWriter writer = response.getWriter();

		try {

			String action = request.getParameter("action");
			if (action.equals("InsertFleetItem")) {
				String item_name = request.getParameter("item_name");
				double item_cost = (request.getParameter("item_cost") == null
						|| request.getParameter("item_cost").trim().equals("")) ? 0.0
								: Double.parseDouble(request.getParameter("item_cost"));
				double item_stock_quantity = (request.getParameter("item_stock_quantity") == null
						|| request.getParameter("item_stock_quantity").trim().equals("")) ? 0.0
								: Double.parseDouble(request.getParameter("item_stock_quantity"));
				int plant_id = Integer.parseInt(request.getParameter("plant_id"));

				FleetItemBean bean = new FleetItemBean();
				bean.setItem_name(item_name);
				bean.setItem_cost(item_cost);
				bean.setItem_stock_quantity(item_stock_quantity);
				bean.setPlant_id(plant_id);

				int count = dao.insertFleetItem(bean);

				if (count > 0) {
					session.setAttribute("res", "Fleet Item Inserted Successfully");
					response.sendRedirect("FleetItemList.jsp");
				} else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("FleetItemList.jsp");
				}
			}

			else if (action.equals("UpdateFleetItem")) {
				String item_name = request.getParameter("item_name");
				double item_cost = (request.getParameter("item_cost") == null
						|| request.getParameter("item_cost").trim().equals("")) ? 0.0
								: Double.parseDouble(request.getParameter("item_cost"));
				int plant_id = Integer.parseInt(request.getParameter("plant_id"));
				int fleet_item_id = Integer.parseInt(request.getParameter("fleet_item_id"));

				FleetItemBean bean = new FleetItemBean();
				bean.setItem_name(item_name);
				bean.setItem_cost(item_cost);
				bean.setPlant_id(plant_id);
				bean.setFleet_item_id(fleet_item_id);

				int count = dao.updateFleetItem(bean);
				if (count > 0) {
					session.setAttribute("res", "Fleet Updated Successfully");
					response.sendRedirect("FleetItemList.jsp");
				} else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("FleetItemList.jsp");
				}
			}

			else if (action.equals("ChangeFleetItemStatus")) {
				String item_status = request.getParameter("item_status");
				int fleet_item_id = Integer.parseInt(request.getParameter("fleet_item_id"));
				int count = dao.changeFleetItemStatus(fleet_item_id, item_status);

				if (count > 0) {
					session.setAttribute("res", "Fleet Status Changed Successfully");
					response.sendRedirect("FleetItemList.jsp");
				} else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("FleetItemList.jsp");
				}
			}

			else if (action.equals("UpdateFleetQuanitty")) {

				int fleet_item_id = Integer.parseInt(request.getParameter("fleet_item_id"));
				double item_quantity = (request.getParameter("item_stock_quantity") == null
						|| request.getParameter("item_stock_quantity").trim().equals("")) ? 0.0
								: Double.parseDouble(request.getParameter("item_stock_quantity"));
				double old_quantity = (request.getParameter("old_stock") == null
						|| request.getParameter("old_stock").trim().equals("")) ? 0.0
								: Double.parseDouble(request.getParameter("old_stock"));
				String comment = request.getParameter("comment");
				int count = dao.updateFleetItemQuantity(fleet_item_id, item_quantity);
				if (count > 0) {
					FleetItemModificationBean bean = new FleetItemModificationBean();
					UserDetailBean ubean = (UserDetailBean) session.getAttribute("bean");
					bean.setModified_user(ubean.getUsername());
					bean.setFleet_item_id(fleet_item_id);
					bean.setModification_comment(comment);
					bean.setOld_stock_quantity(old_quantity);
					bean.setNew_stock_quantity(item_quantity);
					dao.addFleetItemQuantityModification(bean);
					session.setAttribute("res", "Stock Changed Successfully");
					response.sendRedirect("FleetItemList.jsp");
				} else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("FleetItemList.jsp");
				}

			}

			else if (action.equals("getFleetItemDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson = new Gson();
				int fleet_item_id = Integer.parseInt(request.getParameter("fleet_item_id"));
				FleetItemBean bean = dao.getSingleItemDetails(fleet_item_id);
				writer.print(gson.toJson(bean));
			}

			else if (action.equals("AddFleetIncoming")) {
				synchronized (this) {
					String bill_no = request.getParameter("bill_no");
					String incoming_date = request.getParameter("incoming_date");
					String incoming_time = request.getParameter("incoming_time");
					String fleet_type = request.getParameter("fleet_type");
					String purchaser_name = request.getParameter("purchaser_name");
					String supplier_name = request.getParameter("vendor_name");
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					String fleet_item_id[] = request.getParameterValues("fleet_item_id");
					String quantity[] = request.getParameterValues("quantity");
					String rate[] = request.getParameterValues("rate");
					String net_amount[] = request.getParameterValues("net_amount");
					String gross_amount[] = request.getParameterValues("gross_amount");
					String tax_amount[] = request.getParameterValues("tax_amount");
					String gst_percent[] = request.getParameterValues("gst_percent");

					FleetIncomingBean bean = new FleetIncomingBean();
					bean.setBill_no(bill_no);
					bean.setIncoming_date(incoming_date);
					bean.setIncoming_time(incoming_time);
					bean.setFleet_type(fleet_type);
					bean.setPurchaser_name(purchaser_name);
					bean.setFleet_supplier(supplier_name);
					bean.setPlant_id(plant_id);
					int count = dao.insertFleetIncoming(bean);
					int fleet_id = dao.getMaxFleetId();
					if (count > 0) {
						for (int i = 0; i < fleet_item_id.length; i++) {
							FleetIncomingItemBean ibean = new FleetIncomingItemBean();
							ibean.setFleet_id(fleet_id);
							ibean.setFleet_item_id(Integer.parseInt(fleet_item_id[i]));
							ibean.setQuantity(Double.parseDouble(quantity[i]));
							ibean.setRate(Double.parseDouble(rate[i]));
							ibean.setGross_amount(Double.parseDouble(gross_amount[i]));
							ibean.setNet_amount(Double.parseDouble(net_amount[i]));
							ibean.setTax_amount(Double.parseDouble(tax_amount[i]));
							ibean.setGst_percent(Double.parseDouble(gst_percent[i]));
							dao.insertFleetIncomingItem(ibean);

							// update item stock quantity here
							FleetItemBean fibean = dao.getSingleItemDetails(Integer.parseInt(fleet_item_id[i]));
							double old_quantity = fibean.getItem_stock_quantity();
							dao.updateFleetItemQuantity(Integer.parseInt(fleet_item_id[i]),
									old_quantity + Double.parseDouble(quantity[i]));
						}

						session.setAttribute("res", "Fleet Added Successfully");
						response.sendRedirect("FleetList.jsp");
					} else {
						session.setAttribute("res", "<span class='text-danger'>Failed!!<span>");
						response.sendRedirect("FleetList.jsp");
					}
				}
			}

			else if (action.equals("UpdateFleetIncoming")) {

				String bill_no = request.getParameter("bill_no");
				String incoming_date = request.getParameter("incoming_date");
				String incoming_time = request.getParameter("incoming_time");
				String fleet_type = request.getParameter("fleet_type");
				String purchaser_name = request.getParameter("purchaser_name");
				String supplier_name = request.getParameter("vendor_name");
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String fleet_item_id[] = request.getParameterValues("fleet_item_id");
				String quantity[] = request.getParameterValues("quantity");
				String rate[] = request.getParameterValues("rate");
				String net_amount[] = request.getParameterValues("net_amount");
				String gross_amount[] = request.getParameterValues("gross_amount");
				String tax_amount[] = request.getParameterValues("tax_amount");
				String gst_percent[] = request.getParameterValues("gst_percent");
				int fleet_id = Integer.parseInt(request.getParameter("fleet_id"));
				String fi_item_id[] = request.getParameterValues("fi_item_id");
				String comment = request.getParameter("comment");

				FleetIncomingBean bean = new FleetIncomingBean();

				bean.setBill_no(bill_no);
				bean.setIncoming_date(incoming_date);
				bean.setIncoming_time(incoming_time);
				bean.setFleet_type(fleet_type);
				bean.setPurchaser_name(purchaser_name);
				bean.setFleet_supplier(supplier_name);
				bean.setFleet_id(fleet_id);
				bean.setPlant_id(plant_id);
				FleetIncomingBean fbean = dao.getSingleFleetIncomingDetails(fleet_id);
				int count = dao.updateFleetIncoming(bean);
				double net_total = 0.0;
				if (count > 0) {

					for (int i = 0; i < fleet_item_id.length; i++) {
						try {
							FleetIncomingItemBean ibean = new FleetIncomingItemBean();
							ibean.setFleet_id(fleet_id);
							ibean.setFi_item_id(Integer.parseInt(fi_item_id[i]));
							ibean.setFleet_item_id(Integer.parseInt(fleet_item_id[i]));
							ibean.setQuantity(Double.parseDouble(quantity[i]));
							ibean.setRate(Double.parseDouble(rate[i]));
							ibean.setGross_amount(Double.parseDouble(gross_amount[i]));
							ibean.setNet_amount(Double.parseDouble(net_amount[i]));
							ibean.setTax_amount(Double.parseDouble(tax_amount[i]));
							ibean.setGst_percent(Double.parseDouble(gst_percent[i]));
							dao.updateFleetIncomingItem(ibean);
							net_total = net_total + Double.parseDouble(net_amount[i]);

							double old_quantity = dao.getSingleItemDetails(Integer.parseInt(fleet_item_id[i]))
									.getItem_stock_quantity();
							dao.updateFleetItemQuantity(Integer.parseInt(fleet_item_id[i]),
									old_quantity - (old_quantity - Double.parseDouble(quantity[i])));
							// update stock
						} catch (Exception e) {
							e.printStackTrace();
							FleetIncomingItemBean ibean = new FleetIncomingItemBean();
							ibean.setFleet_id(fleet_id);
							ibean.setFleet_item_id(Integer.parseInt(fleet_item_id[i]));
							ibean.setQuantity(Double.parseDouble(quantity[i]));
							ibean.setRate(Double.parseDouble(rate[i]));
							ibean.setGross_amount(Double.parseDouble(gross_amount[i]));
							ibean.setNet_amount(Double.parseDouble(net_amount[i]));
							ibean.setTax_amount(Double.parseDouble(tax_amount[i]));
							ibean.setGst_percent(Double.parseDouble(gst_percent[i]));
							dao.insertFleetIncomingItem(ibean);
							net_total = net_total + Double.parseDouble(net_amount[i]);
							double old_quantity = dao.getSingleItemDetails(Integer.parseInt(fleet_item_id[i]))
									.getItem_stock_quantity();
							dao.updateFleetItemQuantity(Integer.parseInt(fleet_item_id[i]),
									old_quantity + Double.parseDouble(quantity[i]));

						}
					}
					// Now save modification details
					UserDetailBean ubean = (UserDetailBean) session.getAttribute("bean");
					// fleet modification bean create
					FleetIncomingEditBean editbean = new FleetIncomingEditBean();
					editbean.setEdited_comment(comment);
					editbean.setEdited_user(ubean.getUser_email());
					editbean.setOld_amount(fbean.getTotal_net_amount());
					editbean.setNew_amount(net_total);
					dao.insertFletIncomingEdit(editbean);

					session.setAttribute("res", "Fleet Updated Successfully");
					response.sendRedirect("FleetList.jsp");
				} else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!<span>");
					response.sendRedirect("FleetList.jsp");
				}
			}

			else if (action.equals("CancelIncomingFleet")) {
				int fleet_id = Integer.parseInt(request.getParameter("fleet_id"));

				int count = dao.cancelFleetIncoming(fleet_id);

				if (count > 0) {

					session.setAttribute("res", "Fleet Cancelled Successfully");
					response.sendRedirect("FleetList.jsp");
				} else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!<span>");
					response.sendRedirect("FleetList.jsp");
				}

			}

			else if (action.equals("QuantityDetailsUsingId")) {
				int fleet_item_id = Integer.parseInt(request.getParameter("fleet_item_id"));
				FleetItemBean bean = dao.getQuantityDetailsUsingId(fleet_item_id);
				writer.println(bean.getItem_stock_quantity());
			}
			
			
			else if (action.equals("AddFleetOutgoing")) {
				synchronized (this) {
					// get request parameter value
					String issued_date = request.getParameter("dispatch_date");
					String issued_time = request.getParameter("dispatch_time");
					String received_person = request.getParameter("received_person");
					String outgoing_comment = request.getParameter("outgoing_comment");
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					String returnable[] = request.getParameterValues("returnable");
					String return_val = (returnable == null) ? "no" : "yes";
					String return_status = (return_val.equals("yes")) ? "NOT RETURNED" : "NO";

					/* GET ALL FLEET OUTGOING DETAILS */
					String fleet_item_id[] = request.getParameterValues("fleet_item_id");
					String quantity[] = request.getParameterValues("quantity");

					FleetOutgoingBean bean = new FleetOutgoingBean();
					bean.setIssued_date(issued_date);
					bean.setIssued_time(issued_time);
					bean.setReceived_person(received_person);
					bean.setOutgoing_comment(outgoing_comment);
					bean.setReturnable(return_val);
					bean.setReturn_status(return_status);
					bean.setPlant_id(plant_id);

					// now insert the value
					int count = dao.insertFleetOutgoing(bean);
					int fleet_outgoing_id = dao.getMaxFleetOutgoingId();
					if (count > 0) {
						int res = 0;
						for (int i = 0; i < fleet_item_id.length; i++) {
							res++;
							FleetOutgoingItemBean ibean = new FleetOutgoingItemBean();

							ibean.setFleet_outgoing_id(fleet_outgoing_id);
							ibean.setFleet_item_id(Integer.parseInt(fleet_item_id[i]));
							ibean.setQuantity(Integer.parseInt(quantity[i]));
							dao.insertFleetOutgoingItem(ibean);

							// update item stock quantity here
							FleetItemBean fibean = dao.getSingleItemDetails(Integer.parseInt(fleet_item_id[i]));
							double old_quantity = fibean.getItem_stock_quantity();
							dao.updateFleetItemQuantity(Integer.parseInt(fleet_item_id[i]),
									old_quantity - Double.parseDouble(quantity[i]));
						}
						if (res > 0) {
							session.setAttribute("res", "FLEET OUTGOING INSERTED SUCCESSFULLY");
							response.sendRedirect("FleetOutgoingList.jsp");
						} else {
							session.setAttribute("res", "<span class='text-danger'>Failed!!<span>");
							response.sendRedirect("FleetOutgoingList.jsp");
						}
					}
				}
			}

			else if (action.equals("return_item")) {
				// get request parameter value
				int fleet_outgoing_id = Integer.parseInt(request.getParameter("fleet_outgoing_id"));
				String time = request.getParameter("time");
				// now update return status
				int count = dao.updateReturnStatus(fleet_outgoing_id, time);
				ArrayList<FleetOutgoingItemBean> fi_list = dao.getAllFleetItemUsingFleet(fleet_outgoing_id);
				if (count > 0) {
					for (FleetOutgoingItemBean been : fi_list) {
						// now update store
						FleetItemBean olditembean = dao.getSingleItemDetails(been.getFleet_item_id());
						dao.updateFleetItemQuantity(been.getFleet_item_id(),
								olditembean.getItem_stock_quantity() + been.getQuantity());
					}
					session.setAttribute("result", "FLEET RETURNED SUCCESSFULLY");
					response.sendRedirect("store_returnable.jsp?button=returned");
				} else {
					session.setAttribute("result",
							"<span style='color:red;'>SOME INTERNAL SERVER ERROR OCCURED</span>");
					response.sendRedirect("store_returnable.jsp?button=returned");
				}

			}

			else if (action.equals("UpdateFleetOutgoing")) {
				// get request parameter value
				String issued_date = request.getParameter("dispatch_date");
				String issued_time = request.getParameter("dispatch_time");
				String received_person = request.getParameter("received_person");
				String outgoing_comment = request.getParameter("outgoing_comment");
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String returnable[] = request.getParameterValues("returnable");
				String return_val = (returnable == null) ? "no" : "yes";
				String return_status = (return_val.equals("yes")) ? "NOT RETURNED" : "NO";
				int fleet_outgoing_id=Integer.parseInt(request.getParameter("fleet_outgoing_id"));
				
				/* GET ALL FLEET OUTGOING DETAILS */
				String fleet_item_id[] = request.getParameterValues("fleet_item_id");
				String quantity[] = request.getParameterValues("quantity");
				String fo_item_id[]=request.getParameterValues("fo_item_id");

				FleetOutgoingBean bean = new FleetOutgoingBean();
				bean.setIssued_date(issued_date);
				bean.setIssued_time(issued_time);
				bean.setReceived_person(received_person);
				bean.setOutgoing_comment(outgoing_comment);
				bean.setReturnable(return_val);
				bean.setReturn_status(return_status);
				bean.setPlant_id(plant_id);
				// now insert the value
				int count = dao.updateFleetOutgoing(bean);
				if (count > 0) {
					for (int i = 0; i < fleet_item_id.length; i++) {
						try {
							FleetOutgoingItemBean ibean = new FleetOutgoingItemBean();
							ibean.setFleet_outgoing_id(fleet_outgoing_id);
							ibean.setFleet_item_id(Integer.parseInt(fleet_item_id[i]));
							ibean.setQuantity(Integer.parseInt(quantity[i]));
							ibean.setFo_item_id(Integer.parseInt(fo_item_id[i]));
							FleetItemBean fibean = dao.getSingleItemDetails(Integer.parseInt(fleet_item_id[i]));
							FleetOutgoingItemBean foibean=dao.getSingleFleetOutgoingItemDetails(Integer.parseInt(fo_item_id[i]));
							double old_quantity=fibean.getItem_stock_quantity()-(Double.parseDouble(quantity[i])-foibean.getQuantity());
							int food=dao.updateFleetOutgoing(bean);
							if(food>0) {
								dao.updateFleetItemQuantity(Integer.parseInt(fleet_item_id[i]), old_quantity);
							}

						}catch(Exception e) {
							FleetOutgoingItemBean ibean = new FleetOutgoingItemBean();

							ibean.setFleet_outgoing_id(fleet_outgoing_id);
							ibean.setFleet_item_id(Integer.parseInt(fleet_item_id[i]));
							ibean.setQuantity(Integer.parseInt(quantity[i]));

							dao.insertFleetOutgoingItem(ibean);

							// update item stock quantity here
							FleetItemBean fibean = dao.getSingleItemDetails(Integer.parseInt(fleet_item_id[i]));
							double old_quantity = fibean.getItem_stock_quantity();
							dao.updateFleetItemQuantity(Integer.parseInt(fleet_item_id[i]),
									old_quantity + Double.parseDouble(quantity[i]));
						}
					}
					session.setAttribute("res", "Successfully updated");
					response.sendRedirect("FleetOutgoingList.jsp");
				}else {
					session.setAttribute("res", "Updation failed");
					response.sendRedirect("FleetOutgoingList.jsp");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
