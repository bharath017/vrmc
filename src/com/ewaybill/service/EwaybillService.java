package com.ewaybill.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import com.ewaybill.bean.GSTDetailBean;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


public class EwaybillService {
	GSTDetailBean gbean = null;
	
	public EwaybillService() throws IOException {
		 gbean = new GSTDetailBean();
		 
	}

	
	
	
	public Map<String,Object> authenticateForGstDetails() throws Exception {
		URL url = new URL("https://api.mastergst.com/ewaybillapi/v1.03/authenticate?email=nandeeeesh%40gmail.com"
				+ "&username=SREE_RENUK_API_WST&password=Willkasoft%40143N");
		HttpURLConnection con = 
				(HttpURLConnection)url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("ip_address", gbean.getIp());
		con.setRequestProperty("client_id", gbean.getClient_id());
		con.setRequestProperty("client_secret", gbean.getClient_secret());
		con.setRequestProperty("gstin", gbean.getFrom_gstin());
		int responseCode = con.getResponseCode();
		if (responseCode == HttpURLConnection.HTTP_OK) { // success
			BufferedReader in = new BufferedReader(new InputStreamReader(
					con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			String responseData = response.toString();
			JsonParser jsonParser = new JsonParser();
			JsonObject jsonReqObject = (JsonObject) jsonParser.parse(responseData);
			System.out.println(jsonReqObject);
			Map<String,Object> data = new HashMap<String, Object>();
			data.put("status_cd", jsonReqObject.get("status_cd"));
			data.put("status_desc", jsonReqObject.get("status_desc"));
			return data;
		} else {
			System.out.println("GET request not worked");
			return null;
		}
	}
	
	
	
	public Map<String,Object> getGSTINDetails(String GSTIN)throws Exception{
		URL url = new URL("https://api.mastergst.com/ewaybillapi/v1.03/ewayapi/getgstindetails?email=nandeeeesh%40gmail.com&GSTIN="+GSTIN);
		HttpURLConnection con = 
				(HttpURLConnection)url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("ip_address", gbean.getIp());
		con.setRequestProperty("client_id", gbean.getClient_id());
		con.setRequestProperty("client_secret", gbean.getClient_secret());
		con.setRequestProperty("gstin", gbean.getFrom_gstin());
		int responseCode = con.getResponseCode();
		if (responseCode == HttpURLConnection.HTTP_OK) { // success
			BufferedReader in = new BufferedReader(new InputStreamReader(
					con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			String responseData = response.toString();
			JsonParser jsonParser = new JsonParser();
			JsonObject jsonReqObject = (JsonObject) jsonParser.parse(responseData);
			Map<String,Object> data = new HashMap<String, Object>();
			if(jsonReqObject.get("error")!=null) {
				data = this.processError(jsonReqObject.get("error").toString());
			}else {
				data = this.processGSTINDetails(jsonReqObject.toString());
				data.put("errorCode", 0);
			}
			return data;
		} else {
			System.out.println("GET request not worked");
			return null;
		}
		
	}
	
	
	public Map<String,Object> processError(String error) {
		JsonParser jsonParser = new JsonParser();
		JsonObject jsonReqObject = (JsonObject) jsonParser.parse(error);
		JsonObject messageData = (JsonObject) jsonParser.parse(jsonReqObject.toString());
		String errorCodes = messageData.get("message").toString().replace("\"", "").replace("\\", "").replace(",", "");
		JsonObject errorCode = (JsonObject) jsonParser.parse(errorCodes);
		Map<String,Object> data = new HashMap<String, Object>();
		data.put("errorCode",  errorCode.get("errorCodes").getAsInt());
		return data;
	}
	
	public Map<String,Object> processGSTINDetails(String data){
		JsonParser jsonParser = new JsonParser();
		JsonObject jsonReqObject = (JsonObject) jsonParser.parse(data);
		JsonObject realData = (JsonObject) jsonReqObject.get("data");
		String gstin = realData.get("gstin").getAsString();
		String address1 = realData.get("address1").getAsString();
		String address2 = realData.get("address2").getAsString();
		String pincode = realData.get("pinCode").getAsString();
		String tradeName = realData.get("tradeName").getAsString();
		String panNo = gstin.substring(2,12);
		
		//now store dta
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("gstin", gstin);
		map.put("legalName", "");
		map.put("tradeName", tradeName);
		map.put("address1", address1);
		map.put("address2", address2);
		map.put("pincode", pincode);
		map.put("panNo", panNo);
		return map;
	}
	
	
	public Map<String,Object> getDistanceBetweenTwoZipCode(String key,String Zipcode1, String Zipcode2)throws Exception{
		URL url  = new URL("https://www.zipcodeapi.com/rest/"+key+"/distance.json/" + Zipcode1 + "/" + Zipcode2 + "/mile");
		HttpURLConnection con = 
				(HttpURLConnection)url.openConnection();
		int responseCode = con.getResponseCode();
		if (responseCode == HttpURLConnection.HTTP_OK) { // success
			BufferedReader in = new BufferedReader(new InputStreamReader(
					con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			String responseData = response.toString();
			JsonParser jsonParser = new JsonParser();
			JsonObject jsonReqObject = (JsonObject) jsonParser.parse(responseData);
			System.out.println(jsonReqObject);
		} else {
			System.out.println("GET request not worked");
		}
		return null;
	}
	
}


//https://api.mastergst.com/ewaybillapi/v1.03/authenticate?email=nandeeeesh%40gmail.com&username=05AAACH6188F1ZM&password=abc123%40%40

//var url = "https://www.zipcodeapi.com/rest/"+clientKey+"/distance.json/" + zipcode1 + "/" + zipcode2 + "/mile";