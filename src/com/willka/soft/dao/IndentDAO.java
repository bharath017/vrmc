package com.willka.soft.dao;

import java.util.ArrayList;

import com.willka.soft.bean.IndentBean;
import com.willka.soft.bean.IndentItemBean;



public interface IndentDAO {
	
	public int insertIndent(IndentBean bean)throws Exception;
	
	public int updateIndent(IndentBean bean)throws Exception;
	
	public int deleteIndent(int indent_id)throws Exception;
	
	public int insertIndentItem(IndentItemBean bean)throws Exception;
	
	public int updateIndentItem(IndentItemBean bean)throws Exception;
	
	public int deleteIndentItem(int indent_item_id)throws Exception;
	
	public IndentBean getSingleIndent(int indent_id)throws Exception;
	
	public IndentItemBean getSingleIndentItem(int indent_item_id)throws Exception;
	
	public int getMaxIndentId()throws Exception;
	
	public int getMaxOrderNo(int plant_id,int start_year,int end_year)throws Exception;
	
	public ArrayList<IndentItemBean> getAllIndentItem(int indent_id)throws Exception;

	public String getTheUserName(String user_login_id) throws Exception ;
	
	public int statusIndent(int indent_id) throws Exception ;
	public int approvedBy(String approved_by, int indent_id) throws Exception;
	
}
