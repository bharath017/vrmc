package com.willka.soft.controller;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.willka.soft.dao.SmsSenderDAO;
import com.willka.soft.dao.SmsSenderDAOImpl;

import groovyjarjarasm.asm.tree.IntInsnNode;


@WebListener
public class SmsSenderListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		this.getExecutorService().shutdown();
	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		SmsSenderDAO dao=new SmsSenderDAOImpl();
		LocalDateTime localNow = LocalDateTime.now();
        ZoneId currentZone = ZoneId.of("Asia/Kolkata");
        ZonedDateTime zonedNow = ZonedDateTime.of(localNow, currentZone);
        ZonedDateTime zonedNext5 ;
        zonedNext5 = zonedNow.withHour(12).withMinute(30).withSecond(0);
        if(zonedNow.compareTo(zonedNext5) > 0)
            zonedNext5 = zonedNext5.plusDays(1);

        Duration duration = Duration.between(zonedNow, zonedNext5);
        long initalDelay = duration.getSeconds();
        
        System.out.println(initalDelay);
		
		this.getExecutorService().scheduleAtFixedRate(()->{
			try {
				StringBuffer buffer=new StringBuffer();
				final Calendar cal = Calendar.getInstance();
			    cal.add(Calendar.DATE, -1);
			    Date date=cal.getTime();
			    DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		        String yesterday= dateFormat.format(date);
		        System.out.println(yesterday);
				buffer.append("Date : "+yesterday+"%0D").append(dao.getWithBillDetails()).append(dao.getWithoutBillDetails()).append("buildrmc.in");
				URL myURL = new URL("http://alerts.variforrm.in/api?method=sms.normal&api_key=d856d249220d507900e2624037115599&to=9902461188&sender=WISOFT&message="+buffer.toString());
				URLConnection myURLConnection = myURL.openConnection();
				buffer=null;
				System.out.println(myURLConnection.getContentLength());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}, initalDelay, 24*60*60,TimeUnit.SECONDS);
		// TODO Auto-generated method stub
	}
	
	
	public ScheduledExecutorService getExecutorService() {
		return Executors.newScheduledThreadPool(1);
	}
	
	

	
}
