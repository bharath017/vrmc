package com.willka.soft.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.willka.soft.bean.GradeComposition;
import com.willka.soft.bean.ProductBean;

public interface ProductDAO {
	
	public ArrayList<String> getAllProductNamesForSuggestion()throws Exception;
	
	public ArrayList<HashMap<String, Object>> getAllProductList(String search,int business_id,int start,int length)throws Exception;
	
	public int countAllProductList(String search,int business_id)throws Exception;
	
	public int insertProduct(ProductBean bean)throws Exception;
	
	public int updateProduct(ProductBean bean)throws Exception;
	
	public int changeProductStatus(int product_id,String status)throws Exception;
	
	public HashMap<String, Object> getSingleProductDetails(int product_id)throws Exception;
	
	public ArrayList<HashMap<String, Object>> getSingleGradecompositionDetails(int product_id)throws Exception;
	
	public int addComposition(GradeComposition bean)throws Exception;
	
	public int removeComposition(int comp_id)throws Exception;
	
	public int updateOtherDetails(ProductBean bean)throws Exception;
	
	
	
}
