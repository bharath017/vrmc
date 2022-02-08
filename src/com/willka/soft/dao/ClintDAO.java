package com.willka.soft.dao;

import com.willka.soft.bean.ClintBean;

public interface ClintDAO {
	
	public int insertClint(ClintBean bean) throws Exception;
	
	public int updateClint(ClintBean bean) throws Exception;
	
	public int deleteClint(int clint_id) throws Exception;
}
