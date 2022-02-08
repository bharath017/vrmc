package com.willka.soft.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Properties;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.ss.usermodel.ClientAnchor;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Drawing;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Picture;
import org.apache.poi.ss.usermodel.PrintOrientation;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.util.IOUtils;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFPrintSetup;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.willka.soft.bean.MoistureCorrectionBean;
import com.willka.soft.dao.SettingDAOImpl;

public class FletcherBatchSheet {

	public void generateBatchSheet(int id) throws IOException, SQLException,Exception {
		// TODO Auto-generated method stub

		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		CallableStatement cs=null;
		PreparedStatement starttimeps=null;
		ResultSet starttimers=null;
		PreparedStatement bps=null;
		ResultSet brs=null;
		
		
		
		//Call For Generating Batching Sheet
				con=DBUtil.getConnection();
				try {
					cs=con.prepareCall("call batchsheetsave(?,?)");
					cs.registerOutParameter(2, Types.VARCHAR);
					cs.setInt(1, id);
					cs.execute();
				}catch(Exception e) {
					
				}
		XSSFWorkbook batch_sheet=new XSSFWorkbook();
		XSSFSheet spreadsheet=batch_sheet.createSheet("Batch Slip");
		
		starttimeps=con.prepareStatement("select addtime(subtime(min(target_time),max(target_time)),min(target_time)) as start_time" + 
			"	    from (select * from batchingsheet where id=? limit 2) as t");
			starttimeps.setInt(1, id);
			starttimers=starttimeps.executeQuery();
			
			con=DBUtil.getConnection();
			ps=con.prepareStatement("select p.*,REPLACE(format(p.aggregate1_value*p.p_quantity,0),',','') as p1,REPLACE(format(p.aggregate1_value*p.p_quantity,0),',','') as p1," + 
					" 	REPLACE(format(p.aggregate1_value*p.p_quantity,0),',','') as p1,REPLACE(format(p.aggregate2_value*p.p_quantity,0),',','') as p2," + 
					" 	REPLACE(format(p.aggregate3_value*p.p_quantity,0),',','') as p3,REPLACE(format(p.aggregate4_value*p.p_quantity,0),',','') as p4," + 
					" 	REPLACE(format(p.aggregate5_value*p.p_quantity,0),',','') as p5,REPLACE(format(p.aggregate6_value*p.p_quantity,0),',','') as p6," + 
					" 	REPLACE(format(p.aggregate7_value*p.p_quantity,0),',','') as p7,REPLACE(format(p.aggregate8_value*p.p_quantity,0),',','') as p8," + 
					" 	REPLACE(format(p.aggregate9_value*p.p_quantity,2),',','') as p9,REPLACE(format(p.aggregate10_value*p.p_quantity,1),',','') as p10," + 
					" 	REPLACE(format(p.aggregate11_value*p.p_quantity,0),',','') as p11 from (select t.*,format((t.aggregate1_value*p),0) as g1,format((t.aggregate2_value*p),0) as g2,format((t.aggregate3_value*p),0) as g3,format((t.aggregate4_value*p),0) as g4," + 
					" 	format((t.aggregate5_value*p),0) as g5,format((t.aggregate6_value*p),0) as g6,format((t.aggregate7_value*p),0) as g7,format((t.aggregate8_value*p),0) as g8," + 
					" 	format((t.aggregate9_value*p),2) as g9,format((t.aggregate10_value*p),1) as g10,format((t.aggregate11_value*p),0) as g11	" + 
					" 	from  ( select i.id,i.invoice_id,i.site_id as siteid,i.poi_id as po_id,i.vehicle_no,i.driver_name,i.pump,m.*,c.customer_phone,a.site_address as site_address,a.site_name, format((select sum(quantity) from invoice ii " + 
					"	where ii.customer_id=i.customer_id and ii.invoice_date=i.invoice_date and ii.invoice_id <=i.invoice_id),1) as cum_quantity," + 
					"	truncate(i.quantity/ceil(i.quantity),2) as batch_size,p.product_name,g.quantity,pl.plant_name,(i.quantity/ceil(i.quantity)) as p," + 
					"	DATE_FORMAT(i.invoice_date, '%d/%m/%Y') as real_date,(select count(*) from batchingsheet where id=i.id) as cycle,c.customer_name,i.quantity as p_quantity,i.invoice_time as end_time,i.docket_no," + 
					"	CAST(truncate(m.aggregate9_value,2) AS CHAR) as agm,format(ceil(i.quantity),0) as quant,ceil(i.quantity) as qua" + 
					"	from invoice i LEFT JOIN (receipe m,site_detail  a,customer c,purchase_order_item g,product p,plant pl,purchase_order po)" + 
					"	ON i.customer_id=c.customer_id" + 
					"	and i.poi_id=g.poi_id" + 
					"	and g.order_id=po.order_id" + 
					"	and po.site_id=m.site_id" + 
					"	and g.product_id=m.product_id" + 
					"	and g.product_id=p.product_id" + 
					"	and i.plant_id=pl.plant_id" + 
					"	and i.site_id=a.site_id" + 
					"	where i.id=?) as t) as p");
					ps.setInt(1, id);
					rs=ps.executeQuery();
					bps=con.prepareStatement("select sum(aggr1) as s1,sum(aggr2)as s2,sum(aggr3) as s3,sum(aggr4) as s4,sum(aggr5) as s5,sum(aggr6) as s6,sum(aggr7) as s7,sum(aggr8) as s8,format(sum(aggr9),2) as s9,\r\n" + 
							"  		sum(aggr10) as s10,sum(aggr11) as s11 from batchingsheet where id=?");
					bps.setInt(1, id);
					brs=bps.executeQuery();
					
					if(rs.next()){
						if(brs.next()) {
		
		XSSFRow row=spreadsheet.createRow(0);
		
//			Properties prop=new Properties();
//			ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
//			InputStream input = classLoader.getResourceAsStream("com/willka/soft/util/Util.properties");
//			prop.load(input);
//			File ff=new File(prop.getProperty("path")+"/stetter.png");
			
		//Excel column Width	
			spreadsheet.setColumnWidth(0, 2130);			// 7.57
			spreadsheet.setColumnWidth(1, 1530);			// 5.29 
			spreadsheet.setColumnWidth(2, 1200);			// 4.00	
			spreadsheet.setColumnWidth(3, 2550);			//9.29	
			spreadsheet.setColumnWidth(4, 650);				// 1.86
			spreadsheet.setColumnWidth(5, 700);				// 2.00
			spreadsheet.setColumnWidth(6, 2900);			// 10.57
			spreadsheet.setColumnWidth(7, 600);				//  1.57
			spreadsheet.setColumnWidth(8, 1360);			// 4.57
			spreadsheet.setColumnWidth(9, 2350);			// 8.43
			spreadsheet.setColumnWidth(10, 1200);			// 4.00
			spreadsheet.setColumnWidth(11, 2350);			// 8.43
			spreadsheet.setColumnWidth(12, 1250);			// 4.14
			spreadsheet.setColumnWidth(13, 2550);			// 9.29
			spreadsheet.setColumnWidth(14, 1980);			// 7.00

			
			spreadsheet.addMergedRegion(new CellRangeAddress(0,0,3,14));
			spreadsheet.addMergedRegion(new CellRangeAddress(1,1,0,2));
			spreadsheet.addMergedRegion(new CellRangeAddress(1,1,3,5));
			spreadsheet.addMergedRegion(new CellRangeAddress(1,1,6,8));
			
			spreadsheet.addMergedRegion(new CellRangeAddress(2,2,0,2));
			spreadsheet.addMergedRegion(new CellRangeAddress(2,2,3,5));
			spreadsheet.addMergedRegion(new CellRangeAddress(2,2,6,13));
			
			spreadsheet.addMergedRegion(new CellRangeAddress(3,3,0,2));
			spreadsheet.addMergedRegion(new CellRangeAddress(3,3,6,13));
			
			
			spreadsheet.addMergedRegion(new CellRangeAddress(5,5,0,1));
			
			
			spreadsheet.addMergedRegion(new CellRangeAddress(6,6,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(6,6,2,3));
			spreadsheet.addMergedRegion(new CellRangeAddress(6,6,6,7));
			spreadsheet.addMergedRegion(new CellRangeAddress(6,6,8,9));
			spreadsheet.addMergedRegion(new CellRangeAddress(6,6,11,12));
			
			spreadsheet.addMergedRegion(new CellRangeAddress(7,7,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(7,7,2,3));
			spreadsheet.addMergedRegion(new CellRangeAddress(7,7,6,7));
			spreadsheet.addMergedRegion(new CellRangeAddress(7,7,8,9));
			spreadsheet.addMergedRegion(new CellRangeAddress(7,7,11,12));
			
			spreadsheet.addMergedRegion(new CellRangeAddress(8,8,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(8,8,2,3));
			spreadsheet.addMergedRegion(new CellRangeAddress(8,8,6,7));
			spreadsheet.addMergedRegion(new CellRangeAddress(8,8,8,9));
			spreadsheet.addMergedRegion(new CellRangeAddress(8,8,11,12));
			
			spreadsheet.addMergedRegion(new CellRangeAddress(9,9,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(9,9,2,3));
			spreadsheet.addMergedRegion(new CellRangeAddress(9,9,6,7));
			spreadsheet.addMergedRegion(new CellRangeAddress(9,9,8,9));
			spreadsheet.addMergedRegion(new CellRangeAddress(9,9,11,12));
			
			spreadsheet.addMergedRegion(new CellRangeAddress(10,10,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(10,10,2,3));
			spreadsheet.addMergedRegion(new CellRangeAddress(10,10,6,7));
			spreadsheet.addMergedRegion(new CellRangeAddress(10,10,8,9));
			spreadsheet.addMergedRegion(new CellRangeAddress(10,10,11,12));
			
			spreadsheet.addMergedRegion(new CellRangeAddress(11,11,6,7));
			spreadsheet.addMergedRegion(new CellRangeAddress(11,11,8,9));
			spreadsheet.addMergedRegion(new CellRangeAddress(11,11,11,12));
			
			spreadsheet.addMergedRegion(new CellRangeAddress(12,12,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(12,12,2,3));
			
			spreadsheet.addMergedRegion(new CellRangeAddress(13,13,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(13,13,2,3));
			
			spreadsheet.addMergedRegion(new CellRangeAddress(16,16,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(17,17,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(18,18,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(19,19,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(20,20,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(21,21,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(22,22,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(23,23,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(24,24,0,1));
			
			spreadsheet.addMergedRegion(new CellRangeAddress(25,25,0,1));
			
			spreadsheet.addMergedRegion(new CellRangeAddress(27,27,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(27,27,3,5));
			spreadsheet.addMergedRegion(new CellRangeAddress(27,27,12,13));
			
			spreadsheet.addMergedRegion(new CellRangeAddress(28,28,0,1));
			spreadsheet.addMergedRegion(new CellRangeAddress(28,28,3,5));
			spreadsheet.addMergedRegion(new CellRangeAddress(28,28,12,13));
			
			spreadsheet.addMergedRegion(new CellRangeAddress(30,30,0,13));
			
			//schwing setter name
		XSSFCell cell=(XSSFCell)row.createCell(3);
//			cell.setCellValue("Report gen Date/Time  "+rs.getString("real_date")+ " "+rs.getString("end_time"));
			cell.setCellValue("Technical Batch Data Report");
			XSSFCellStyle style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			XSSFFont defaultFont= batch_sheet.createFont();
			defaultFont=batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)14);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)450);
			
			row=spreadsheet.createRow(1);

			cell=(XSSFCell)row.createCell(0);
			Properties prop=new Properties();
			ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
			InputStream input = classLoader.getResourceAsStream("com/willka/soft/util/Util.properties");
			prop.load(input);
			File ff=new File(prop.getProperty("path")+"/ids.png");
			
			//set image
			// read the image to the stream
			final FileInputStream stream = new FileInputStream(ff);
			final CreationHelper helper = batch_sheet.getCreationHelper();
			final Drawing drawing = spreadsheet.createDrawingPatriarch();
			
			final ClientAnchor anchor = helper.createClientAnchor();
			anchor.setAnchorType( ClientAnchor.MOVE_AND_RESIZE );
			
			final int pictureIndex = batch_sheet.addPicture(IOUtils.toByteArray(stream), Workbook.PICTURE_TYPE_PNG);
			anchor.setCol1( 0 );
			anchor.setRow1(1); // same row is okay
			anchor.setRow2(3);
			anchor.setCol2(1);
			final Picture pict = drawing.createPicture( anchor, pictureIndex );
			pict.resize();

			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue("Plant Id");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)12);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
//			row.setHeight((short)600);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue("1");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)12);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
//			row.setHeight((short)600);
			
			cell=(XSSFCell)row.createCell(14);
//			Properties prop1=new Properties();
			ClassLoader classLoader1 = Thread.currentThread().getContextClassLoader();
			InputStream input1 = classLoader1.getResourceAsStream("com/willka/soft/util/Util.properties");
			prop.load(input1);
			File fff=new File(prop.getProperty("path")+"/iec.png");
			//set image
			// read the image to the stream
			final FileInputStream stream1 = new FileInputStream(fff);
			final CreationHelper helper1 = batch_sheet.getCreationHelper();
			final Drawing drawing1 = spreadsheet.createDrawingPatriarch();
			
			final ClientAnchor anchor1 = helper1.createClientAnchor();
			anchor1.setAnchorType( ClientAnchor.MOVE_AND_RESIZE );
			
			final int pictureIndex1 = batch_sheet.addPicture(IOUtils.toByteArray(stream1), Workbook.PICTURE_TYPE_PNG);
			anchor1.setCol1(13);
			anchor1.setRow1(1); // same row is okay
			anchor1.setRow2(3);
			anchor1.setCol2(11);
			final Picture pict1 = drawing1.createPicture( anchor1, pictureIndex1 );
			pict1.resize();

			row=spreadsheet.createRow(2);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue("Plant Address");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);	
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue("FLETCHER CONCRETES");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)12);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			row=spreadsheet.createRow(3);		

			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue("Sy. No. 28, Behind Vibgyor Schook, katamnallur Gate");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
			defaultFont.setFontName("Calibri");
			defaultFont.setColor(IndexedColors.BLACK.getIndex());
			defaultFont.setBold(false);
			defaultFont.setItalic(false);
			style.setFont(defaultFont);
			cell.setCellStyle(style);

			row=spreadsheet.createRow(5);		

			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Plant Details");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
			defaultFont.setFontName("Calibri");
			defaultFont.setColor(IndexedColors.BLACK.getIndex());
			defaultFont.setBold(false);
			defaultFont.setItalic(false);
			style.setFont(defaultFont);
			cell.setCellStyle(style);			

row=spreadsheet.createRow(6);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Docket NO");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(2);
			cell.setCellValue(":1");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);	
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue("Mix Description");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(8);
			cell.setCellValue(": "+rs.getString("product_name"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue("Ordered Qty");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(" : "+rs.getDouble("quantity"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(14);
			cell.setCellValue("M3");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
		
			
row=spreadsheet.createRow(7);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Docket Date");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(2);
			cell.setCellValue(": "+rs.getString("real_date"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue("Mix code");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(8);
			cell.setCellValue(": "+rs.getString("product_name"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue("Produced Qty");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(": "+rs.getDouble("p_quantity"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
			cell=(XSSFCell)row.createCell(14);
			cell.setCellValue("M3");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
	
			
row=spreadsheet.createRow(8);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Batch Start Time");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(2);
			if(starttimers.next()){
				cell.setCellValue(": "+starttimers.getString(1));
			}
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue("Strength");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);	
			
			cell=(XSSFCell)row.createCell(11);
//			cell.setCellValue("Produced Qty");
			cell.setCellValue("Returned Qty");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(13);
//			cell.setCellValue(": "+rs.getDouble("p_quantity"));
			cell.setCellValue(":0");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
		
			cell=(XSSFCell)row.createCell(14);
			cell.setCellValue("M3");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)600);
			

			
row=spreadsheet.createRow(9);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Customer");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(2);
			cell.setCellValue(": "+rs.getString("customer_name"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue("Slump");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue("Set This Load");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(": "+rs.getDouble("cum_quantity"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
		
			cell=(XSSFCell)row.createCell(14);
			cell.setCellValue("M3");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
row=spreadsheet.createRow(10);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Site ");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(2);
			cell.setCellValue(": "+rs.getString("site_name"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue("User ");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(8);
			cell.setCellValue("OEM ");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue("First Batch Size");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(": 1.00");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(14);
			cell.setCellValue("M3");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
row=spreadsheet.createRow(11);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue("Ticket No");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(8);
//			cell.setCellValue(": "+rs.getString("vehicle_no"));
//			cell.setCellValue(": "+rs.getInt(id));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue("Other Batch Size ");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue("1.00");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(14);
			cell.setCellValue("M3");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
			
			
row=spreadsheet.createRow(12);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Truck No");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(2);
//			cell.setCellValue(": "+rs.getInt(id));
			cell.setCellValue(": "+rs.getString("vehicle_no"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
row=spreadsheet.createRow(13);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Driver Name");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
//			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_TOP);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short) 500);
			
			cell=(XSSFCell)row.createCell(2);
//			cell.setCellValue(": "+rs.getInt(id));
			cell.setCellValue(": "+rs.getString("driver_name"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
//			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_TOP);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short) 1000);
			
			
			
			
			
row=spreadsheet.createRow(14);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Product");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue("Design");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue("Required");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue("Batched");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue("Moisture");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue("Error");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
row=spreadsheet.createRow(15);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Code");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue("Qty/M3");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue("Quantity");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue("Quantity");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue("%");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue("%");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
row=spreadsheet.createRow(16);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(rs.getString("aggregate1_name"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getDouble("aggregate1_value"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			MoistureCorrectionBean bean=new SettingDAOImpl().getMoistureDetails();
			double p1=rs.getDouble("p1")-(bean.getAggr1_abs()-bean.getAggr1_moi())*rs.getDouble("aggregate1_value")/100*rs.getDouble("p_quantity");
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue(p1);
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setDataFormat(batch_sheet.createDataFormat().getFormat("0"));
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue(brs.getDouble("s1"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
			
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue(bean.getAggr1_moi());
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(0);
			cell.setCellFormula("ROUND(IF(J17=0,0,(J17-G17)/J17*100),2)");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
row=spreadsheet.createRow(17);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(rs.getString("aggregate2_name"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getDouble("aggregate2_value"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			double p2=rs.getDouble("p2")-(bean.getAggr2_abs()-bean.getAggr2_moi())*rs.getDouble("aggregate2_value")/100*rs.getDouble("p_quantity");
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue(p2);
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setDataFormat(batch_sheet.createDataFormat().getFormat("0"));
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue(brs.getDouble("s2"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue(bean.getAggr2_moi());
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(0);
			cell.setCellFormula("ROUND(IF(J18=0,0,(J18-G18)/J18*100),2)");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
row=spreadsheet.createRow(18);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(rs.getString("aggregate3_name"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getDouble("aggregate3_value"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
			double p3=rs.getDouble("p3")-(bean.getAggr3_abs()-bean.getAggr3_moi())*rs.getDouble("aggregate3_value")/100*rs.getDouble("p_quantity");
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue(p3);
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setDataFormat(batch_sheet.createDataFormat().getFormat("0"));
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue(brs.getDouble("s3"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue(bean.getAggr3_moi());
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(0);
			cell.setCellFormula("ROUND(IF(J19=0,0,(J19-G19)/J19*100),2)");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
row=spreadsheet.createRow(19);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(rs.getString("aggregate4_name"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getDouble("aggregate4_value"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			double p4=rs.getDouble("p4")-(bean.getAggr4_abs()-bean.getAggr4_moi())*rs.getDouble("aggregate4_value")/100*rs.getDouble("p_quantity");
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue(p4);
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setDataFormat(batch_sheet.createDataFormat().getFormat("0"));
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue(brs.getDouble("s4"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue(bean.getAggr4_moi());
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(0);
			cell.setCellFormula("ROUND(IF(J20=0,0,(J20-G20)/J20*100),2)");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
row=spreadsheet.createRow(20);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(rs.getString("aggregate5_name"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getDouble("aggregate5_value"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue(rs.getDouble("p5"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue(brs.getDouble("s5"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(0);
			cell.setCellFormula("ROUND(IF(J21=0,0,(J21-G21)/J21*100),2)");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
row=spreadsheet.createRow(21);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(rs.getString("aggregate6_name"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getDouble("aggregate6_value"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue(rs.getDouble("p6"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue(brs.getDouble("s6"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(0);
			cell.setCellFormula("ROUND(IF(J22=0,0,(J22-G22)/J22*100),2)");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
row=spreadsheet.createRow(22);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(rs.getString("aggregate8_name"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getDouble("aggregate8_value"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
			double p8=rs.getDouble("p8")+(rs.getDouble("p1")-p1)+(rs.getDouble("p2")-p2)+(rs.getDouble("p3")-p3)+(rs.getDouble("p4")-p4);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue(p8);
			
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setDataFormat(batch_sheet.createDataFormat().getFormat("0"));
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue(brs.getDouble("s8"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(0);
			cell.setCellFormula("ROUND(IF(J23=0,0,(J23-G23)/J23*100),2)");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
row=spreadsheet.createRow(23);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(rs.getString("aggregate9_name"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getDouble("aggregate9_value"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue(rs.getDouble("p9"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue(brs.getDouble("s9"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(0);
			cell.setCellFormula("ROUND(IF(J24=0,0,(J24-G24)/J24*100),2)");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
row=spreadsheet.createRow(25);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Total");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(0);
			cell.setCellFormula("D17+D18+D19+D20+D21+D22+D23+D24");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue(0);
			cell.setCellFormula("G17+G18+G19+G20+G21+G22+G23+G24");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue(0);
			cell.setCellFormula("J17+J18+J19+J20+J21+J22+J23+J24");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)11);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
row=spreadsheet.createRow(27);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Num Batches");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue("with this load");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue("This Load");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue("Batch End Time");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
row=spreadsheet.createRow(28);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(rs.getInt("cycle"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getDouble("cum_quantity"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue(rs.getDouble("p_quantity"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue(rs.getString("end_time"));
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			
			
row=spreadsheet.createRow(30);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Note : All Materials are in KGs");
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)14);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)450);
			
			//this is print area of this page
			spreadsheet.getPrintSetup().setPaperSize(XSSFPrintSetup.A4_PAPERSIZE);
			spreadsheet.getPrintSetup().setOrientation(PrintOrientation.LANDSCAPE);
			spreadsheet.setMargin(Sheet.LeftMargin, 0.2);
			spreadsheet.setMargin(Sheet.BottomMargin, 0.3);
			spreadsheet.setMargin(Sheet.TopMargin, 0.3);
			spreadsheet.setMargin(Sheet.RightMargin, 0.2);
			spreadsheet.setMargin(Sheet.HeaderMargin, 0.3);
			spreadsheet.setMargin(Sheet.FooterMargin, 0.3);
			spreadsheet.setFitToPage(true);	
			
			}
			
				}
			Properties prop=new Properties();
			ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
			InputStream input = classLoader.getResourceAsStream("com/willka/soft/util/Util.properties");
			prop.load(input);
			File f=new File(prop.getProperty("path")+"/batch_sheet.xlsx");
			if(f.exists()) {
			boolean fr=f.delete();
			}
			FileOutputStream out=new FileOutputStream(prop.getProperty("path")+"/batch_sheet.xlsx");
			batch_sheet.write(out);
			
			out.close();
	}

}
