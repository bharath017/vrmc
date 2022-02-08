package com.willka.soft.dao;


import com.willka.soft.bean.PipelineBean;

public interface PipeLineDAO {
	
    public int insertPipeLine(PipelineBean bean) throws Exception;
	
	public int updatePipeline(PipelineBean bean) throws Exception;
	
	public int deletePipeLIne(int pipe_id) throws Exception;

}
