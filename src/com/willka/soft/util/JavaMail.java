package com.willka.soft.util;

import java.util.List;

import javax.mail.MessagingException;

import com.willka.soft.bean.CustomerQuotationBean;
import com.willka.soft.bean.MailSettingBean;

public class JavaMail {

	public static boolean sendEmail(CustomerQuotationBean bean,List<String> email,MailSettingBean been) {
		try {
			JavaMailUtil.sendMail(bean,email,been);
			return true;
		} catch (MessagingException e) {
			e.printStackTrace();
			return false;
		}
		
	}
}
