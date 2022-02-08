package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.willka.soft.bean.PipelineBean;
import com.willka.soft.util.DBUtil;

public class PipeLineDAOImpl implements PipeLineDAO{
	
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	

	private static final String INSERT_PIPELINR="insert into pipe_line (unit,bdm,customer_id,total_volume,period_month,vol_month,target_date,remark_as,status)values(?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_PIPELINR="update pipe_line set unit=?,bdm=?,customer_id=?,total_volume=?,period_month=?,vol_month=?,target_date=?,remark_as=?,status=? where pipe_id=?";
	public  PipeLineDAOImpl() {
	
		con=DBUtil.getConnection();
	}
	@Override
	public int insertPipeLine(PipelineBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_PIPELINR);
		ps.setString(1, bean.getUnit());
		ps.setString(2, bean.getBdm());
		ps.setString(3, bean.getCustomer_id());
		ps.setInt(4, bean.getTotal_volume());
		ps.setInt(5, bean.getPeriod_month());
		ps.setInt(6, bean.getVol_month());
		ps.setString(7, bean.getTarget_date());
		ps.setString(8, bean.getRemark_as());
		ps.setString(9, bean.getStatus());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updatePipeline(PipelineBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_PIPELINR);
		ps.setString(1, bean.getUnit());
		ps.setString(2, bean.getBdm());
		ps.setString(3, bean.getCustomer_id());
		ps.setInt(4, bean.getTotal_volume());
		ps.setInt(5, bean.getPeriod_month());
		ps.setInt(6, bean.getVol_month());
		ps.setString(7, bean.getTarget_date());
		ps.setString(8, bean.getRemark_as());
		ps.setString(9, bean.getStatus());
		ps.setInt(10, bean.getPipe_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deletePipeLIne(int pipe_id) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	

	

}
