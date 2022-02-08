package com.willka.soft.util;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Date;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class SmsTaskScheduler {

	public static void executeTask() {
		ScheduledExecutorService exeService=Executors.newScheduledThreadPool(1);
		exeService.scheduleAtFixedRate(()->{
			try {
				/*URL myURL = new URL("http://alerts.variforrm.in/api?method=sms.normal&api_key=d856d249220d507900e2624037115599&to=9513333144&sender=WISOFT&message=Hello%20boss%20Arun%20Here");
				URLConnection myURLConnection = myURL.openConnection();
				
				int i=myURLConnection.getContentLength();*/
				System.out.println("Hello world");
			}  catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}, 0, 10L, TimeUnit.SECONDS);
	}
}
