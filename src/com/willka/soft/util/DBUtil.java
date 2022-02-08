package com.willka.soft.util;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBUtil {

	private static Connection con=null;
	static{
		try {
			InitialContext initialContext=new InitialContext();
			Context context=(Context)initialContext.lookup("java:comp/env");
			DataSource ds=(DataSource)context.lookup("jdbc/rmc");
			con=ds.getConnection();
		} catch (NamingException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static Connection getConnection(){
		return con;
	}
}
