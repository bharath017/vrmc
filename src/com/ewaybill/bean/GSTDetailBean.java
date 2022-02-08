package com.ewaybill.bean;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class GSTDetailBean {
	private String client_id;
	private String client_secret;
	private String from_gstin;
	private String email_id;
	private String ip;
	private String username;
	private String password;
	
	public String getClient_id() {
		return client_id;
	}
	public void setClient_id(String client_id) {
		this.client_id = client_id;
	}
	public String getClient_secret() {
		return client_secret;
	}
	public void setClient_secret(String client_secret) {
		this.client_secret = client_secret;
	}
	public String getFrom_gstin() {
		return from_gstin;
	}
	public void setFrom_gstin(String from_gstin) {
		this.from_gstin = from_gstin;
	}
	public String getEmail_id() {
		return email_id;
	}
	public void setEmail_id(String email_id) {
		this.email_id = email_id;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	public GSTDetailBean() throws IOException {
		ClassLoader loader = Thread.currentThread()
								   .getContextClassLoader();
		InputStream stream = loader.getResourceAsStream("com/ewaybill/utility/utility.properties");
		Properties prop = new Properties();
		prop.load(stream);
		this.client_id = prop.getProperty("client_id_gst");
		this.client_secret = prop.getProperty("client_secret_gst");
		this.from_gstin = prop.getProperty("from_gstin_gst");
		this.email_id = prop.getProperty("email_id_gst");
		this.ip  = prop.getProperty("ip_gst");
		this.username  = prop.getProperty("username_gst");
		this.password = prop.getProperty("password_gst");
	}
	
}
