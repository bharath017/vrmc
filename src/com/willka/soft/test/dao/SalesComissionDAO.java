package com.willka.soft.test.dao;

import com.willka.soft.test.bean.CustomerPaymentBean;
import com.willka.soft.test.bean.SalesComissionBean;

public interface SalesComissionDAO {

	public int insertPayment(SalesComissionBean bean) throws Exception;

	public double getCreditAmmount(int customer_id) throws Exception;

	public SalesComissionBean getSinglePaymentDetails(int payment_id) throws Exception;

	public int updatePayment(SalesComissionBean updatebean) throws Exception;

	public int insertModificationDetails(SalesComissionBean bean) throws Exception;

	public int deletePaymentDetails(int payment_id) throws Exception;

}
