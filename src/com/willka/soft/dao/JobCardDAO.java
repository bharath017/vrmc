package com.willka.soft.dao;


import com.willka.soft.bean.JobCardBean;

public interface JobCardDAO {
	
public int insertJobCard(JobCardBean bean)throws Exception;
	
	public int updateJobCard(JobCardBean bean)throws Exception;
	
	public int deletJobCard(int id)throws Exception;
	

}
