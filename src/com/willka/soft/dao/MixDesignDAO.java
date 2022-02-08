package com.willka.soft.dao;

import com.willka.soft.bean.MixDesignBean;

public interface MixDesignDAO  {

	public int insertMixDesign(MixDesignBean bean)throws Exception;
	
	public int insertReceipe(MixDesignBean bean)throws Exception;
	
	public int updateMixDesign(MixDesignBean bean)throws Exception;
	
	public int updateReceipe(MixDesignBean bean)throws Exception;
	
	public int deleteReceipe(int receipe_id)throws Exception;
	
	public MixDesignBean getSingleMixDesignDetails(String receipe_code)throws Exception;
	
	public int deleteMixDesign(int design_id)throws Exception;
	
	public MixDesignBean getSingleReceipeDetails(int receipe_id)throws Exception;
	
	public boolean generateBatchSheet(int id)throws Exception;
	
	
}
