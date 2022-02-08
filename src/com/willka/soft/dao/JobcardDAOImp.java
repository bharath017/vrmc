package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.willka.soft.bean.JobCardBean;
import com.willka.soft.dao.JobCardDAO;
import com.willka.soft.util.DBUtil;

public class JobcardDAOImp implements JobCardDAO{
	
	//all database variable here
		private Connection con=null;
		private PreparedStatement ps=null;
		private ResultSet rs=null;
		
		//write all query here
		private static final String INSERT_JOB_CARD="insert into job_card(vehicle_details,reg_no,kilo_meters,hours,driver_name,arrival_time,jobstarted_time,jobcompleted_time,attended_by,frontengine,hydraulic,backengine,drumgearbox,frontgear,coollent,clutchoil,steering,housing,breakoil) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		private static final String UPDATE_JOB_CARD="update job_card set vehicle_details=?,reg_no=?,kilo_meters=?,hours=?,driver_name=?,arrival_time=?,jobstarted_time=?,jobcompleted_time=?,attended_by=?,frontengine=?,backengine=?,drumgearbox=?,frontgear=?,hydraulic=?,coollent=?,clutchoil=?,steering=?,housing=?,breakoil=? where id=?";
		
		private static final String CANCEL_JOB_CARD="update job_card set job_card_status='cancelled' where id=?";

		public JobcardDAOImp() {
			con=DBUtil.getConnection();
		}
	@Override
	public int insertJobCard(JobCardBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_JOB_CARD);
		ps.setString(1, bean.getVehicle_details());
		ps.setString(2, bean.getReg_no());
		ps.setInt(3, bean.getKilo_meters());
		ps.setString(4, bean.getHours());
		ps.setString(5, bean.getDriver_name());
		ps.setString(6, bean.getArrival_time());
		ps.setString(7, bean.getJobstarted_time());
		ps.setString(8, bean.getJobcompleted_time());
		ps.setString(9, bean.getAttended_by());
		ps.setString(10, bean.getFrontengine());
		ps.setString(11, bean.getHydraulic());
		ps.setString(12, bean.getBackengine());
		ps.setString(13, bean.getDrumgearbox());
		ps.setString(14, bean.getFrontgear());
		ps.setString(15, bean.getCoollent());
		ps.setString(16, bean.getClutchoil());
		ps.setString(17, bean.getSteering());
		ps.setString(18, bean.getHousing());
		ps.setString(19, bean.getBreakoil());	
		
		int count=ps.executeUpdate();
		
		return count;
		
	}

	@Override
	public int updateJobCard(JobCardBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_JOB_CARD);
		ps.setString(1, bean.getVehicle_details());
		ps.setString(2, bean.getReg_no());
		ps.setInt(3, bean.getKilo_meters());
		ps.setString(4, bean.getHours());
		ps.setString(5, bean.getDriver_name());
		ps.setString(6, bean.getArrival_time());
		ps.setString(7, bean.getJobstarted_time());
		ps.setString(8, bean.getJobcompleted_time());
		ps.setString(9, bean.getAttended_by());
		ps.setString(10, bean.getFrontengine());
		ps.setString(11, bean.getHydraulic());
		ps.setString(12, bean.getBackengine());
		ps.setString(13, bean.getDrumgearbox());
		ps.setString(14, bean.getFrontgear());
		ps.setString(15, bean.getCoollent());
		ps.setString(16, bean.getClutchoil());
		ps.setString(17, bean.getSteering());
		ps.setString(18, bean.getHousing());
		ps.setString(19, bean.getBreakoil());
		ps.setInt(20, bean.getId());	
		
		int count=ps.executeUpdate();
		
		return count;
	}

	@Override
	public int deletJobCard(int id) throws Exception {
		ps=con.prepareStatement(CANCEL_JOB_CARD);
		ps.setInt(1, id);
		
		int count=ps.executeUpdate();
		return count;
	}
	

}
