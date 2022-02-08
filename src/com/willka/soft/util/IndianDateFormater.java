package com.willka.soft.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

public class IndianDateFormater {

	public static String converToIndianFormat(String date) {
		try {
			DateFormat originalFormat=new SimpleDateFormat("dd/mm/yyyy",Locale.ENGLISH);
			DateFormat targetFormat=new SimpleDateFormat("yyyy-mm-dd");
			Date dt=originalFormat.parse(date);
			String formatDate=targetFormat.format(dt);
			return formatDate;
		} catch (ParseException e) {
			return null;
		}
	}
	
	
	public static final Map<String,Integer> getFinancialYearByDate(String date) throws ParseException {
		Map<String,Integer> data=new HashMap<String, Integer>();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");  
		Date parse = sdf.parse(date);  
		Calendar c = Calendar.getInstance();  
		c.setTime(parse); 
		int month=c.get(Calendar.MONTH);
		int start_year=(month>=3)?c.get(Calendar.YEAR):c.get(Calendar.YEAR)-1;
		int end_year=(month>=3)?c.get(Calendar.YEAR)+1:c.get(Calendar.YEAR);
		data.put("start_year", start_year);
		data.put("end_year", end_year);
		return data;
	}
	
	public static final Map<String,Integer> getFinancialYearByMysqlDate(String date) throws ParseException {
		Map<String,Integer> data=new HashMap<String, Integer>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
		Date parse = sdf.parse(date);  
		Calendar c = Calendar.getInstance();  
		c.setTime(parse); 
		int month=c.get(Calendar.MONTH);
		int start_year=(month>=3)?c.get(Calendar.YEAR):c.get(Calendar.YEAR)-1;
		int end_year=(month>=3)?c.get(Calendar.YEAR)+1:c.get(Calendar.YEAR);
		data.put("start_year", start_year);
		data.put("end_year", end_year);
		return data;
	}
	public static String converToIndianFormatOther(String date) {
		try {
			DateFormat originalFormat=new SimpleDateFormat("yyyy-mm-dd",Locale.ENGLISH);
			DateFormat targetFormat=new SimpleDateFormat("dd/mm/yyyy");
			Date dt=originalFormat.parse(date);
			String formatDate=targetFormat.format(dt);
			return formatDate;
		} catch (ParseException e) {
			return null;
		}
	}
}
