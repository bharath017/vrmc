package com.willka.soft.bean;

import java.io.Serializable;

public class MailSettingBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	private String smtp_host;
	private String smtp_user;
	private String smtp_password;
	private String smtp_port;
	private String smtp_security;
	private String smtp_authontication_domain;
	
	
	public String getSmtp_host() {
		return smtp_host;
	}
	public void setSmtp_host(String smtp_host) {
		this.smtp_host = smtp_host;
	}
	public String getSmtp_user() {
		return smtp_user;
	}
	public void setSmtp_user(String smtp_user) {
		this.smtp_user = smtp_user;
	}
	public String getSmtp_password() {
		return smtp_password;
	}
	public void setSmtp_password(String smtp_password) {
		this.smtp_password = smtp_password;
	}
	public String getSmtp_port() {
		return smtp_port;
	}
	public void setSmtp_port(String smtp_port) {
		this.smtp_port = smtp_port;
	}
	public String getSmtp_security() {
		return smtp_security;
	}
	public void setSmtp_security(String smtp_security) {
		this.smtp_security = smtp_security;
	}
	public String getSmtp_authontication_domain() {
		return smtp_authontication_domain;
	}
	public void setSmtp_authontication_domain(String smtp_authontication_domain) {
		this.smtp_authontication_domain = smtp_authontication_domain;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
	@Override
	public String toString() {
		return "MailSettingBean [smtp_host=" + smtp_host + ", smtp_user=" + smtp_user + ", smtp_password="
				+ smtp_password + ", smtp_port=" + smtp_port + ", smtp_security=" + smtp_security
				+ ", smtp_authontication_domain=" + smtp_authontication_domain + "]";
	}
	
	
	
}
