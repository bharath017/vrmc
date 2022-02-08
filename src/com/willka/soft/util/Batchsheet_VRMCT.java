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

import net.sf.jasperreports.engine.export.oasis.CellStyle;



public class Batchsheet_VRMCT {
	/**
	 * @param args
	 * @throws IOException
	 */
	
	public  void generateBatchSheet(int id) throws IOException, SQLException {
		
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		CallableStatement cs=null;
		PreparedStatement starttimeps=null;
		ResultSet starttimers=null;
		PreparedStatement bps=null;
		ResultSet brs=null;
		XSSFFont defaultFont=null;
		
		//Call For Generating Batching Sheet
		con=DBUtil.getConnection();
		try {
			cs=con.prepareCall("call testdcbatchsheetsave(?,?)");
			cs.registerOutParameter(2, Types.VARCHAR);
			cs.setInt(1, id);
			cs.execute();
		}catch(Exception e) {
			
		}
		
		
		// TODO Auto-generated method stub

		XSSFWorkbook batch_sheet=new XSSFWorkbook();
		XSSFSheet spreadsheet=batch_sheet.createSheet("Batch Slip");
		
		//Set Column Width	
		spreadsheet.setColumnWidth(0, 1725);		//a		6
		spreadsheet.setColumnWidth(1, 1400);		//g		4.71
		spreadsheet.setColumnWidth(2, 1450);			//c		1
		spreadsheet.setColumnWidth(3, 1425);		//l		4.86
		spreadsheet.setColumnWidth(4, 1670);		//p		5.86
		spreadsheet.setColumnWidth(5, 1400);		//g		4.71
		spreadsheet.setColumnWidth(6, 1360);		//F		4.57
		spreadsheet.setColumnWidth(7, 1160);		//i		3.86
		spreadsheet.setColumnWidth(8, 1425);		//l		4.86
		spreadsheet.setColumnWidth(9, 1250);		//l		4.14 
		spreadsheet.setColumnWidth(10, 1325);		//		4.43
		spreadsheet.setColumnWidth(11, 1270);		//k		4.29
		spreadsheet.setColumnWidth(12, 1360);
		spreadsheet.setColumnWidth(13, 1670);		//		5.86
		spreadsheet.setColumnWidth(14, 1325);		//		4.43
		spreadsheet.setColumnWidth(15, 1150);		//		3.71 
		spreadsheet.setColumnWidth(16, 1360);		//F		4.57
		spreadsheet.setColumnWidth(17, 1480);		//b		5
		spreadsheet.setColumnWidth(18, 2075);		//s		7.43
		spreadsheet.setColumnWidth(19, 1750);		//q		6.14
		spreadsheet.setColumnWidth(20, 1520);		//q		5.29
		
		// Merge Cell Data	
spreadsheet.addMergedRegion(new CellRangeAddress(0,0,2,20));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(1,1,0,20));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(2,2,0,20));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(4,4,0,2));
		spreadsheet.addMergedRegion(new CellRangeAddress(4,4,3,8));
		spreadsheet.addMergedRegion(new CellRangeAddress(4,4,12,15));
		spreadsheet.addMergedRegion(new CellRangeAddress(4,4,16,20));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(5,5,0,2));
		spreadsheet.addMergedRegion(new CellRangeAddress(5,5,3,8));
		spreadsheet.addMergedRegion(new CellRangeAddress(5,5,12,15));
		spreadsheet.addMergedRegion(new CellRangeAddress(5,5,16,20));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(6,6,0,2));
		spreadsheet.addMergedRegion(new CellRangeAddress(6,6,3,8));
		spreadsheet.addMergedRegion(new CellRangeAddress(6,6,12,15));
		spreadsheet.addMergedRegion(new CellRangeAddress(6,6,16,20));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(8,8,0,2));
		spreadsheet.addMergedRegion(new CellRangeAddress(8,8,3,8));
		spreadsheet.addMergedRegion(new CellRangeAddress(8,8,12,15));
		spreadsheet.addMergedRegion(new CellRangeAddress(8,8,16,20));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(10,10,0,2));
		spreadsheet.addMergedRegion(new CellRangeAddress(10,10,3,8));
		spreadsheet.addMergedRegion(new CellRangeAddress(10,10,12,15));
		spreadsheet.addMergedRegion(new CellRangeAddress(10,10,16,20));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(12,12,0,2));
		spreadsheet.addMergedRegion(new CellRangeAddress(12,12,3,8));
		spreadsheet.addMergedRegion(new CellRangeAddress(12,12,12,15));
		spreadsheet.addMergedRegion(new CellRangeAddress(12,12,16,20));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(14,14,0,2));
		spreadsheet.addMergedRegion(new CellRangeAddress(14,14,3,8));
		spreadsheet.addMergedRegion(new CellRangeAddress(14,14,12,15));
		spreadsheet.addMergedRegion(new CellRangeAddress(14,14,16,20));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(16,16,0,2));
		spreadsheet.addMergedRegion(new CellRangeAddress(16,16,3,8));
		spreadsheet.addMergedRegion(new CellRangeAddress(16,16,12,15));
		spreadsheet.addMergedRegion(new CellRangeAddress(16,16,16,20));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(18,18,0,2));
		spreadsheet.addMergedRegion(new CellRangeAddress(18,18,3,8));
		spreadsheet.addMergedRegion(new CellRangeAddress(18,18,12,15));
		spreadsheet.addMergedRegion(new CellRangeAddress(18,18,16,20));
		
		
		
	XSSFRow row=spreadsheet.createRow(0);		
		row.setHeight((short) 630);
			Properties prop=new Properties();
			ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
			InputStream input = classLoader.getResourceAsStream("com/willka/soft/util/Util.properties");
			prop.load(input);
			File ff=new File(prop.getProperty("path")+"/stetter9.png");
			
			//set image
			// read the image to the stream
			final FileInputStream stream =
			        new FileInputStream(ff);
			final CreationHelper helper = batch_sheet.getCreationHelper();
			final Drawing drawing = spreadsheet.createDrawingPatriarch();

			final ClientAnchor anchor = helper.createClientAnchor();
			anchor.setAnchorType( ClientAnchor.MOVE_AND_RESIZE );
			

			final int pictureIndex =
					batch_sheet.addPicture(IOUtils.toByteArray(stream), Workbook.PICTURE_TYPE_PNG);
			anchor.setCol1(1);
			anchor.setRow1(0); // same row is okay
			anchor.setRow2(0);
			anchor.setCol2(1);
			final Picture pict = drawing.createPicture( anchor, pictureIndex );
			pict.resize();
			
			XSSFCell cell=(XSSFCell)row.createCell(2);
			cell.setCellValue("SCHWING stetter \nMCI 360 Contro System");
			XSSFCellStyle style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
		    defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)14);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)750);
		
			row=spreadsheet.createRow(1);
			
			 cell=(XSSFCell)row.createCell(0);
			 
				cell.setCellValue("Stetter"); 
			 
			 
			
			 style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			
			 defaultFont= batch_sheet.createFont();
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)20);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)650);	
			
			row=spreadsheet.createRow(2);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Autographic / Batch Report / Delivery Note");
			
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			
			defaultFont= batch_sheet.createFont();
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)14);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)520);	
			
	row=spreadsheet.createRow(3);
			
			cell=(XSSFCell)row.createCell(0);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(1);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(2);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(3);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(4);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(5);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(6);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(7);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(8);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(9);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(10);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(11);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(12);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(13);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(14);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(15);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(16);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(17);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(18);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(20);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);
			
			cell=(XSSFCell)row.createCell(19);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);	
			
			
			
			
			starttimeps=con.prepareStatement("select addtime(subtime(min(target_time),max(target_time)),min(target_time)) as start_time" + 
		"	    from (select * from test_dcbatchingsheet where id=? limit 2) as t");
		starttimeps.setInt(1, id);
		starttimers=starttimeps.executeQuery();
		
		
		con=DBUtil.getConnection();
		ps=con.prepareStatement("select p.*,REPLACE(format(p.aggregate1_value*p.p_quantity,0),',','') as p1,REPLACE(format(p.aggregate1_value*p.p_quantity,0),',','') as p1," + 
				" 	REPLACE(format(p.aggregate1_value*p.p_quantity,0),',','') as p1,REPLACE(format(p.aggregate2_value*p.p_quantity,0),',','') as p2," + 
				" 	REPLACE(format(p.aggregate3_value*p.p_quantity,0),',','') as p3,REPLACE(format(p.aggregate4_value*p.p_quantity,0),',','') as p4," + 
				" 	REPLACE(format(p.aggregate5_value*p.p_quantity,0),',','') as p5,REPLACE(format(p.aggregate6_value*p.p_quantity,0),',','') as p6," + 
				" 	REPLACE(format(p.aggregate7_value*p.p_quantity,0),',','') as p7,REPLACE(format(p.aggregate8_value*p.p_quantity,0),',','') as p8," + 
				" 	REPLACE(format(p.aggregate9_value*p.p_quantity,2),',','') as p9,REPLACE(format(p.aggregate10_value*p.p_quantity,1),',','') as p10," + 
				" 	REPLACE(format(p.aggregate11_value*p.p_quantity,0),',','') as p11,REPLACE(format(p.aggregate12_value*p.p_quantity,0),',','') as p12 from (select t.*,CAST(format((t.aggregate1_value*p),0) AS UNSIGNED) as g1,CAST(format((t.aggregate2_value*p),0) AS UNSIGNED) as g2,CAST(format((t.aggregate3_value*p),0) AS UNSIGNED) as g3,CAST(format((t.aggregate4_value*p),0) AS UNSIGNED) as g4," + 
				" 	format((t.aggregate5_value*p),0) as g5,format((t.aggregate6_value*p),0) as g6,format((t.aggregate7_value*p),0) as g7,format((t.aggregate8_value*p),0) as g8," + 
				" 	format((t.aggregate9_value*p),2) as g9,format((t.aggregate10_value*p),1) as g10,format((t.aggregate11_value*p),0) as g11,format((t.aggregate12_value*p),0) as g12	" + 
				" 	from  ( select i.id,i.invoice_id,i.site_id as siteid,i.poi_id as po_id,i.vehicle_no,i.driver_name,i.pump,m.*,c.customer_phone,a.site_address as site_address,a.site_name, format((select sum(quantity) from test_dc ii " + 
				"	where ii.customer_id=i.customer_id and ii.invoice_date=i.invoice_date and ii.invoice_id <=i.invoice_id),1) as cum_quantity," + 
				"	truncate(i.quantity/ceil(i.quantity),2) as batch_size,p.product_name,g.quantity,pl.plant_name,(i.quantity/ceil(i.quantity)) as p," + 
				"	DATE_FORMAT(i.invoice_date, '%d/%m/%Y') as real_date,(select count(*) from test_dcbatchingsheet where id=i.id) as cycle,c.customer_name,i.quantity as p_quantity,i.invoice_time as end_time,i.docket_no," + 
				"	CAST(truncate(m.aggregate9_value,2) AS CHAR) as agm,format(ceil(i.quantity),0) as quant,ceil(i.quantity) as qua" + 
				"	from test_dc i LEFT JOIN (test_receipe m,test_site_detail  a,test_customer c,test_purchase_order_item g,product p,plant pl,test_purchase_order po)" + 
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
					"  		sum(aggr10) as s10,sum(aggr11) as s11,sum(aggr12) as s12 from test_dcbatchingsheet where id=?");
			bps.setInt(1, id);
			brs=bps.executeQuery();
			
			
			
			
			if(rs.next()){
			row=spreadsheet.createRow(4);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Batch Date");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)350);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getString("real_date"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)350);
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue("Plant Serial No");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)350);
			
			cell=(XSSFCell)row.createCell(16);
			cell.setCellValue("M1");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)350);	
			
row=spreadsheet.createRow(5);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Batch Start Time");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)350);
			
			cell=(XSSFCell)row.createCell(3);
			if(starttimers.next()){
				cell.setCellValue(starttimers.getString(1));
			}
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)350);
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue("Batch End Time");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)350);
			
			cell=(XSSFCell)row.createCell(16);
			cell.setCellValue(rs.getString("end_time"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)350);
			
			
	row=spreadsheet.createRow(6);
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue("Batcher Name");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)350);
			
			cell=(XSSFCell)row.createCell(16);
			cell.setCellValue("Stetter");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)350);
			
			
row=spreadsheet.createRow(7);
			
			cell=(XSSFCell)row.createCell(0);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(1);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(2);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(3);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(4);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(5);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(6);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(7);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(8);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(9);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(10);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(11);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(12);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(13);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(14);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(15);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(16);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(17);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(18);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);				

			cell=(XSSFCell)row.createCell(19);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);	
			
			cell=(XSSFCell)row.createCell(20);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)200);	
			
row=spreadsheet.createRow(8);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Batch No");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getInt("invoice_id"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue("Truck Driver");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(16);
			cell.setCellValue(rs.getString("driver_name"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
	row=spreadsheet.createRow(9);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(" ");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)200);
			
	row=spreadsheet.createRow(10);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Customer");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getString("customer_name"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue("Production Qty");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(16);
			cell.setCellValue(rs.getDouble("p_quantity"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
row=spreadsheet.createRow(11);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(" ");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)200);
			
row=spreadsheet.createRow(12);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Site Address");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getString("site_address"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue("Returned Qty");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(16);
			cell.setCellValue("0.00");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			
			
			
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
row=spreadsheet.createRow(13);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(" ");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)200);
			
row=spreadsheet.createRow(14);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Recipe Code");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getString("recipe_code"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue("Total Ordered Qty");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(16);
			cell.setCellValue(rs.getDouble("quantity"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);

row=spreadsheet.createRow(15);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(" ");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)200);			
			
row=spreadsheet.createRow(16);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Recipe Name");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getString("product_name"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue("with This Load");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(16);
			cell.setCellValue(rs.getDouble("cum_quantity"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
row=spreadsheet.createRow(17);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(" ");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)200);			
			
row=spreadsheet.createRow(18);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Truck No");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getString("vehicle_no"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue("Batch Size");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(16);
			cell.setCellValue(rs.getDouble("batch_size"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			
row=spreadsheet.createRow(19);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(" ");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)10);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)150);
			
row=spreadsheet.createRow(20);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(" ");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			int i=1;
			
			cell=(XSSFCell)row.createCell(1);
			cell.setCellValue(rs.getString("aggregate1_name"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
						
			cell=(XSSFCell)row.createCell(2);
			cell.setCellValue(rs.getString("aggregate2_name"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getString("aggregate3_name"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(4);
			cell.setCellValue(rs.getString("aggregate4_name"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(5);
			cell.setCellValue("Agg5");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue("Agg6");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(7);
			cell.setCellValue(rs.getString("aggregate5_name"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(8);
			cell.setCellValue(rs.getString("aggregate6_name"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue(rs.getString("aggregate7_name"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(10);
			cell.setCellValue(rs.getString("aggregate11_name"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue(rs.getString("aggregate12_name"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue(rs.getString("aggregate8_name"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue("Ice");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(14);
			cell.setCellValue("Slum");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(15);
			cell.setCellValue("Silica");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(16);
			cell.setCellValue(rs.getString("aggregate9_name"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(17);
			cell.setCellValue(rs.getString("aggregate10_name"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(18);
			cell.setCellValue("Admix2");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			cell=(XSSFCell)row.createCell(19);
			cell.setCellValue("Admix2.2");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)500);
			
			
	row=spreadsheet.createRow(21);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Recipe");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(1);
			cell.setCellValue(rs.getInt("aggregate1_value"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(2);
			cell.setCellValue(rs.getInt("aggregate2_value"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getInt("aggregate3_value"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(4);
			cell.setCellValue(rs.getInt("aggregate4_value"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(5);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(7);
			cell.setCellValue(rs.getInt("aggregate5_value"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(8);
			cell.setCellValue(rs.getInt("aggregate6_value"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue(rs.getInt("aggregate7_value"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(10);
			cell.setCellValue(rs.getInt("aggregate11_value"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue(rs.getInt("aggregate12_value"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue(rs.getInt("aggregate8_value"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(14);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(15);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(16);
			cell.setCellValue(rs.getInt("aggregate9_value"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(17);
			cell.setCellValue(rs.getInt("aggregate10_value"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
		    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(18);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
		    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
			cell.setCellStyle(style);
			row.setHeight((short)10);
			
			cell=(XSSFCell)row.createCell(19);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
		    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
			cell.setCellStyle(style);
			row.setHeight((short)10);
			

row=spreadsheet.createRow(22);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Target");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(1);
			cell.setCellValue(rs.getInt("g1"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(2);
			cell.setCellValue(rs.getInt("g2"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getInt("g3"));
			System.out.println(rs.getInt("g3"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(4);
			cell.setCellValue(rs.getInt("g4"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(5);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(7);
			cell.setCellValue(rs.getInt("g5"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(8);
			cell.setCellValue(rs.getInt("g6"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue(rs.getInt("g7"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(10);
			cell.setCellValue(rs.getInt("g11"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue(rs.getInt("g12"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue(rs.getInt("g8"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(14);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(15);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);

			cell=(XSSFCell)row.createCell(16);
			cell.setCellValue(rs.getInt("g9"));
			style=batch_sheet.createCellStyle();
			style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(17);
			cell.setCellValue(rs.getInt("g10"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
		    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(18);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
		    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(19);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
		    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
			cell.setCellStyle(style);
			row.setHeight((short)300);		
			
			
			i=23;
			
			PreparedStatement ps2=con.prepareStatement("select t.*,CAST(ag9 AS CHAR) as ee from  (select b.*,truncate(b.aggr9,2) ag9 from test_dcbatchingsheet b where id=?) as t");
			ps2.setInt(1, id);
			ResultSet rs2=ps2.executeQuery();
			
			while(rs2.next()){
			
			row=spreadsheet.createRow(i);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue(rs2.getString("target_time"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(1);
			cell.setCellValue(rs2.getInt("aggr1"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(2);
			cell.setCellValue(rs2.getInt("aggr2"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs2.getInt("aggr3"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(4);
			cell.setCellValue(rs2.getInt("aggr4"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(5);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(7);
			cell.setCellValue(rs2.getInt("aggr5"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(8);
			cell.setCellValue(rs2.getInt("aggr6"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue(rs2.getInt("aggr7"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(10);
			cell.setCellValue(rs2.getInt("aggr11"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue(rs2.getInt("aggr12"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue(rs2.getInt("aggr8"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(14);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(15);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(16);
			cell.setCellValue(rs2.getDouble("aggr9"));
			style=batch_sheet.createCellStyle();
			style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(17);
			cell.setCellValue(rs2.getDouble("aggr10"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
		    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(18);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
		    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(19);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
		    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
			cell.setCellStyle(style);
			row.setHeight((short)300);
			i++;
			}	
			
			int p=0;
			p=i;
			
			
			row=spreadsheet.createRow(p+1);
			
			cell=(XSSFCell)row.createCell(0);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(1);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(2);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(3);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(4);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(5);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(6);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(7);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(8);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(9);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(10);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(11);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(12);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(13);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(14);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(15);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(16);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(17);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(18);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);				

			cell=(XSSFCell)row.createCell(19);
			style=batch_sheet.createCellStyle();
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			
row=spreadsheet.createRow(p+2);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Total");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)13);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(true);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			
			
			PreparedStatement ps3=con.prepareStatement("select sum(aggr1) as s1,sum(aggr2)as s2,sum(aggr3) as s3,sum(aggr4) as s4,sum(aggr5) as s5,sum(aggr6) as s6,sum(aggr7) as s7,sum(aggr8) as s8,format(sum(aggr9),2) as s9,\r\n" + 
					"				  		sum(aggr10) as s10,sum(aggr11) as s11,sum(aggr12) as s12 from test_dcbatchingsheet where id=?");
			ps3.setInt(1, id);
			ResultSet rs3=ps3.executeQuery();
			if(rs3.next()) {
			row=spreadsheet.createRow(p+3);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Act");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
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
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(1);
			cell.setCellValue(rs3.getInt("s1"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(2);
			cell.setCellValue(rs3.getInt("s2"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs3.getInt("s3"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(4);
			cell.setCellValue(rs3.getInt("s4"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(5);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(7);
			cell.setCellValue(rs3.getInt("s5"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(8);
			cell.setCellValue(rs3.getInt("s6"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue(rs3.getInt("s7"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(10);
			cell.setCellValue(rs3.getInt("s11"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue(rs3.getInt("s12"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue(rs3.getInt("s8"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(14);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(15);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(16);
			cell.setCellValue(rs3.getDouble("s9"));
			style=batch_sheet.createCellStyle();
			style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(17);
			cell.setCellValue(rs3.getDouble("s10"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
		    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(18);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
		    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(19);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
		    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			
			
row=spreadsheet.createRow(p+4);
			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("Tar");
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
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
			row.setHeight((short)300);	
			
			cell=(XSSFCell)row.createCell(1);
			cell.setCellValue(rs.getInt("p1"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(2);
			cell.setCellValue(rs.getInt("p2"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(3);
			cell.setCellValue(rs.getInt("p3"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(4);
			cell.setCellValue(rs.getInt("p4"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(5);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(6);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(7);
			cell.setCellValue(rs.getInt("p5"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(8);
			cell.setCellValue(rs.getInt("p6"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(9);
			cell.setCellValue(rs.getInt("p7"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(10);
			cell.setCellValue(rs.getInt("p11"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(11);
			cell.setCellValue(rs.getInt("p12"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(12);
			cell.setCellValue(rs.getInt("p8"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(13);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(14);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(15);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(16);
			cell.setCellValue(rs.getInt("p9"));
			style=batch_sheet.createCellStyle();
			style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(17);
			cell.setCellValue(rs.getInt("p10"));
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
		    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(18);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
		    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
			cell.setCellStyle(style);
			row.setHeight((short)300);
			
			cell=(XSSFCell)row.createCell(19);
			cell.setCellValue(0);
			style=batch_sheet.createCellStyle();
			style=batch_sheet.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setWrapText(true);
			defaultFont= batch_sheet.createFont();
			defaultFont.setFontHeightInPoints((short)8);
		    defaultFont.setFontName("Calibri");
		    defaultFont.setColor(IndexedColors.BLACK.getIndex());
		    defaultFont.setBold(false);
		    defaultFont.setItalic(false);
		    style.setFont(defaultFont);
		    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
			cell.setCellStyle(style);
			row.setHeight((short)300);	
			
			
row=spreadsheet.createRow(p+5);
			
			cell=(XSSFCell)row.createCell(0);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(1);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(2);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(3);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(4);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)400);				

			cell=(XSSFCell)row.createCell(5);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(6);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(7);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(8);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(9);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(10);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(11);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(12);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(13);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)400);				

			cell=(XSSFCell)row.createCell(14);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(15);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(16);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(17);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(18);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);				

			cell=(XSSFCell)row.createCell(19);
			style=batch_sheet.createCellStyle();
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cell.setCellStyle(style);
			row.setHeight((short)250);
			
			
	row=spreadsheet.createRow(p+6);
			spreadsheet.addMergedRegion(new CellRangeAddress(p+6,p+6,0,10));			
			cell=(XSSFCell)row.createCell(0);
			cell.setCellValue("        Moisture Correction & Other Component Correction");
			style=batch_sheet.createCellStyle();
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
			row.setHeight((short)300);	
			
			
			
row=spreadsheet.createRow(p+7);

			spreadsheet.addMergedRegion(new CellRangeAddress(p+7,p+7,13,14));
			
						cell=(XSSFCell)row.createCell(0);
						cell.setCellValue(" ");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						
						cell=(XSSFCell)row.createCell(1);
						cell.setCellValue("G1Moi");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(2);
						cell.setCellValue("G2Moi");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(3);
						cell.setCellValue("G3Moi");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(4);
						cell.setCellValue("G4Moi");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(5);
						cell.setCellValue("G5Moi");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(6);
						cell.setCellValue("G6Moi");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(7);
						cell.setCellValue("C1.cor");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(8);
						cell.setCellValue("C2.Cor");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(9);
						cell.setCellValue("C3.Cor");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(10);
						cell.setCellValue("C4.Cor");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(11);
						cell.setCellValue("C5.Cor");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(12);
						cell.setCellValue("W1.Cor");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(13);
						cell.setCellValue("W2.Cor");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(15);
						cell.setCellValue("Si.Cor");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(16);
						cell.setCellValue("Adm11.C");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(17);
						cell.setCellValue("Adm12.C");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(18);
						cell.setCellValue("Adm21.C");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(19);
						cell.setCellValue("Adm22.C");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(true);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						p=p+8;
						
						
for(i=p;i<p+rs.getInt("quant");i++){
	
row=spreadsheet.createRow(i);
			
			spreadsheet.addMergedRegion(new CellRangeAddress(i,i,13,14));

						cell=(XSSFCell)row.createCell(0);
						cell.setCellValue(" ");
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(1);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(2);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(3);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(4);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(5);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(6);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(7);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(8);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(9);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(10);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(11);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(12);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(13);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(15);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(16);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);
						
						cell=(XSSFCell)row.createCell(17);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(18);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
						
						cell=(XSSFCell)row.createCell(19);
						cell.setCellValue(0.0);
						style=batch_sheet.createCellStyle();
						style=batch_sheet.createCellStyle();
						style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
						style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
						style.setWrapText(true);
						defaultFont= batch_sheet.createFont();
						defaultFont.setFontHeightInPoints((short)8);
					    defaultFont.setFontName("Calibri");
					    defaultFont.setColor(IndexedColors.BLACK.getIndex());
					    defaultFont.setBold(false);
					    defaultFont.setItalic(false);
					    style.setFont(defaultFont);
					    style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
						cell.setCellStyle(style);
						row.setHeight((short)300);	
			}
		}		
		
						
		}			
						
						
			
		//this is print area of this page
		spreadsheet.getPrintSetup().setPaperSize(XSSFPrintSetup.A4_PAPERSIZE);
		spreadsheet.setMargin(Sheet.LeftMargin, 0);
		spreadsheet.setMargin(Sheet.BottomMargin, 0.3);
		spreadsheet.setMargin(Sheet.TopMargin, 0.3);
		spreadsheet.setMargin(Sheet.RightMargin, 0.2);
		spreadsheet.setMargin(Sheet.HeaderMargin, 0.3);
		spreadsheet.setMargin(Sheet.FooterMargin, 0.3);
		spreadsheet.setFitToPage(true);	
		
		
		/* DOWNLOAD THIS FILE IN REPORT FOLDER	*/
		File f=new File(prop.getProperty("path")+"/batch_sheet.xlsx");
		if(f.exists()) {
		boolean fr=f.delete();
		}
		FileOutputStream out=new FileOutputStream(prop.getProperty("path")+"/batch_sheet.xlsx");
		batch_sheet.write(out);
		
		out.close();
		
		
	}



}
