package com.willka.soft.util;

import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.willka.soft.bean.CompanyDetailsBean;
import com.willka.soft.bean.CustomerQuotationBean;
import com.willka.soft.bean.MailSettingBean;

public class JavaMailUtil {

	public static void sendMail(CustomerQuotationBean bean,List<String> email_list,MailSettingBean been) throws MessagingException {
		Properties properties=new Properties();
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", been.getSmtp_host());
		properties.put("mail.smtp.port", been.getSmtp_port());
		
		String myAccountEmail=been.getSmtp_user();
		String password=been.getSmtp_password();
		
		Session session=Session.getInstance(properties,new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(myAccountEmail, password);
			}
		});
		
		
		Message message=prepareMessage(session,myAccountEmail,bean,email_list);
		Transport.send(message);
	}
	
	private static Message prepareMessage(Session session,String myAccountEmail,CustomerQuotationBean bean,List<String> emails) {
		try {
			
			//compose mail here
			
			StringBuffer buffer=new StringBuffer();
			buffer.append("Dear Sir / Madam ,");
			buffer.append("<br><br><br>");
			buffer.append("We are offering our lowest cost price for the supply of Ready Mix <br>" + 
					"Concrete.<br><br><br>");
			buffer.append("We hope our rates are competitive and reasonable and we expect your <br>" + 
					"earliest response. Please kindly find the attached our quote about our <br>" + 
					"RMC Product.<br><br>");
			buffer.append("<h1 style='green';><a href='"+bean.getHost()+bean.getQuotation_id()+"' style='green';>Download your quotation here</a></h1>");
			buffer.append("Thanking you once again and looking forward to the pleasure of receiving <br><br><br>" + 
					"your valued order and long term business relationship with you.<br>");
			buffer.append("We are awaiting your valuable reply.<br><br><br>");
			buffer.append("Altima Conmix India Pvt Ltd<br>" + 
					"S.Vasanth kumar<br>" + 
					"70229 20666");
			
			Message message=new MimeMessage(session);
			message.setFrom(new InternetAddress(myAccountEmail));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(bean.getCustomer_email()));
			message.setSubject("Quotation for Concrete");
			message.setContent(buffer.toString(),"text/html");
			return message;
			 
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
}
