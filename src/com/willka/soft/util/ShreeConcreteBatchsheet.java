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
import java.text.DecimalFormat;
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
import org.jfree.ui.Align;

public class ShreeConcreteBatchsheet {
	 
	public  void generateBatchSheet(int id) throws IOException, SQLException {
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
		
		Properties prop=new Properties();
		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		InputStream input = classLoader.getResourceAsStream("com/willka/soft/util/Util.properties");
		prop.load(input);
		File ff=new File(prop.getProperty("path")+"/stetter3.png");

		//set image
				// read the image to the stream
				final FileInputStream stream = new FileInputStream(ff);
				final CreationHelper helper = batch_sheet.getCreationHelper();
				final Drawing drawing = spreadsheet.createDrawingPatriarch();

				final ClientAnchor anchor = helper.createClientAnchor();
				anchor.setAnchorType( ClientAnchor.MOVE_AND_RESIZE );
				
				
				final int pictureIndex = batch_sheet.addPicture(IOUtils.toByteArray(stream), Workbook.PICTURE_TYPE_PNG);
				anchor.setCol1(1);
				anchor.setRow1(1); // same row is okay
				anchor.setRow2(2);
				anchor.setCol2(1);
				final Picture pict = drawing.createPicture( anchor, pictureIndex );
				pict.resize();
				
				//inserting image finished here
		
		
//Set Column Width	
		spreadsheet.setColumnWidth(0, 1825);		//a		6
		spreadsheet.setColumnWidth(1, 1880);		//b		5
		spreadsheet.setColumnWidth(2, 1725);		//c		4.86
		spreadsheet.setColumnWidth(3, 2105);		//d		4.43
		spreadsheet.setColumnWidth(4, 1700);		//e		4.71
		spreadsheet.setColumnWidth(5, 300);		//F		4
		spreadsheet.setColumnWidth(6, 1525);		//F		4
		spreadsheet.setColumnWidth(7, 1500);		//g		4.71
		spreadsheet.setColumnWidth(8, 1460);		//h		3.86
		spreadsheet.setColumnWidth(9, 1160);		//i		3.86
		spreadsheet.setColumnWidth(10, 100);		//j		4
		spreadsheet.setColumnWidth(11, 2570);		//k		4.29
		spreadsheet.setColumnWidth(12, 1625);		//l		4.86	
		spreadsheet.setColumnWidth(13, 100);		//m		2.43
		spreadsheet.setColumnWidth(14, 4020);		//n		3.29
		spreadsheet.setColumnWidth(15, 200);		//o		3.43
		spreadsheet.setColumnWidth(16, 170);		//p		5.86
		spreadsheet.setColumnWidth(17, 2550);		//q		6.14
		spreadsheet.setColumnWidth(18, 1160);		//r		6

		
// Merge Cell Data	
		spreadsheet.addMergedRegion(new CellRangeAddress(0,0,0,18));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(1,1,2,10));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(4,4,1,10));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(3,3,1,10));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(5,5,0,18));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(7,7,0,2));
		spreadsheet.addMergedRegion(new CellRangeAddress(7,7,3,5));
		spreadsheet.addMergedRegion(new CellRangeAddress(7,7,13,16));
//		spreadsheet.addMergedRegion(new CellRangeAddress(7,7,17,18));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(8,8,0,2));
		spreadsheet.addMergedRegion(new CellRangeAddress(8,8,3,5));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(9,9,0,2));
		spreadsheet.addMergedRegion(new CellRangeAddress(9,9,3,5));
		spreadsheet.addMergedRegion(new CellRangeAddress(9,9,13,16));
//		spreadsheet.addMergedRegion(new CellRangeAddress(9,9,17,18));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(10,10,0,4));
		spreadsheet.addMergedRegion(new CellRangeAddress(10,10,6,10));
		spreadsheet.addMergedRegion(new CellRangeAddress(10,10,13,16));
//		spreadsheet.addMergedRegion(new CellRangeAddress(10,10,17,18));
		
		
		spreadsheet.addMergedRegion(new CellRangeAddress(11,11,0,4));
		spreadsheet.addMergedRegion(new CellRangeAddress(11,11,6,10));
		spreadsheet.addMergedRegion(new CellRangeAddress(11,11,13,16));
//		spreadsheet.addMergedRegion(new CellRangeAddress(10,10,17,18));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(12,12,0,4));
		spreadsheet.addMergedRegion(new CellRangeAddress(12,12,6,10));
		spreadsheet.addMergedRegion(new CellRangeAddress(12,12,13,16));
//		spreadsheet.addMergedRegion(new CellRangeAddress(10,10,17,18));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(13,13,0,4));
		spreadsheet.addMergedRegion(new CellRangeAddress(13,13,6,10));
		spreadsheet.addMergedRegion(new CellRangeAddress(13,13,13,16));
//		spreadsheet.addMergedRegion(new CellRangeAddress(10,10,17,18));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(14,14,0,4));
		spreadsheet.addMergedRegion(new CellRangeAddress(14,14,6,10));
		spreadsheet.addMergedRegion(new CellRangeAddress(14,14,13,16));
//		spreadsheet.addMergedRegion(new CellRangeAddress(10,10,17,18));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(15,15,0,4));
		spreadsheet.addMergedRegion(new CellRangeAddress(15,15,6,10));
		spreadsheet.addMergedRegion(new CellRangeAddress(15,15,13,16));
//		spreadsheet.addMergedRegion(new CellRangeAddress(10,10,17,18));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(16,16,0,4));
		spreadsheet.addMergedRegion(new CellRangeAddress(16,16,6,10));
		spreadsheet.addMergedRegion(new CellRangeAddress(16,16,13,16));
//		spreadsheet.addMergedRegion(new CellRangeAddress(10,10,17,18));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(17,17,0,4));
		spreadsheet.addMergedRegion(new CellRangeAddress(17,17,6,10));
		spreadsheet.addMergedRegion(new CellRangeAddress(17,17,13,16));
//		spreadsheet.addMergedRegion(new CellRangeAddress(10,10,17,18));
		
		spreadsheet.addMergedRegion(new CellRangeAddress(18,18,0,4));
		spreadsheet.addMergedRegion(new CellRangeAddress(18,18,6,10));
		spreadsheet.addMergedRegion(new CellRangeAddress(18,18,13,16));
//		spreadsheet.addMergedRegion(new CellRangeAddress(10,10,17,18));
		
		
//		spreadsheet.addMergedRegion(new CellRangeAddress(15,15,0,2));
//		spreadsheet.addMergedRegion(new CellRangeAddress(15,15,3,5));
//		
		spreadsheet.addMergedRegion(new CellRangeAddress(20,20,0,5));
		spreadsheet.addMergedRegion(new CellRangeAddress(20,20,6,9));
		spreadsheet.addMergedRegion(new CellRangeAddress(20,20,11,13));
		spreadsheet.addMergedRegion(new CellRangeAddress(20,20,14,16));
		spreadsheet.addMergedRegion(new CellRangeAddress(20,20,17,18));
//		
		spreadsheet.addMergedRegion(new CellRangeAddress(25,25,0,18));
//		
//		spreadsheet.addMergedRegion(new CellRangeAddress(22,22,11,16));
//		spreadsheet.addMergedRegion(new CellRangeAddress(22,22,17,18));
//		
//		spreadsheet.addMergedRegion(new CellRangeAddress(23,23,0,18));
		
		

		

	// Create Rows 
		
XSSFRow row=spreadsheet.createRow(0);

		XSSFCell cell=(XSSFCell)row.createCell(0);
		cell.setCellValue("SHREE CONCRETE");
		
		XSSFCellStyle style=batch_sheet.createCellStyle();
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		
		XSSFFont defaultFont= batch_sheet.createFont();
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)14);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(true);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		row.setHeight((short)450);
		
		
row=spreadsheet.createRow(1);

		cell=(XSSFCell)row.createCell(2);
		cell.setCellValue("MCI 370 Control System Ver 3.1");
		
		style=batch_sheet.createCellStyle();
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT );
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_BOTTOM);
		style.setWrapText(true);
		
		defaultFont= batch_sheet.createFont();
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)13.5);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(true);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		row.setHeight((short)450);

		
row=spreadsheet.createRow(3);
		cell=(XSSFCell)row.createCell(1);
		cell.setCellValue("SCHWING");
		
		style=batch_sheet.createCellStyle();
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT );
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_BOTTOM);
		style.setWrapText(true);
		
		defaultFont= batch_sheet.createFont();
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		row.setHeight((short)450);
		
		
row=spreadsheet.createRow(4);
		cell=(XSSFCell)row.createCell(1);
		cell.setCellValue("Stetter");
		
		style=batch_sheet.createCellStyle();
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT );
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		
		defaultFont= batch_sheet.createFont();
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)12);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		//row.setHeight((short)450);

row=spreadsheet.createRow(5);
		row.setHeight((short)550);
		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue("Docket / Batch Report / Autographic Record");
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)13.5);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(true);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
//row=spreadsheet.createRow(6);
//		row.setHeight((short)50);
row=spreadsheet.createRow(6);
		row.setHeight((short)100);
		
//row=spreadsheet.createRow(7);
		cell.setCellStyle(style);

		/*
		 * 
		 * 
		//create database variable and connect it and generate batch slip
		 * 
		 * 
		 * 
		 */	
		
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
		
		//now get batch start and end time
		/*
		 * 
		 * Batch Slip creation and declaration end's here
		 * 
		 * 
		 * 
		*/		
		
		
		
if(rs.next()){
		
row=spreadsheet.createRow(7);
		
		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue("Batch Date");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(true);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(3);
		cell.setCellValue(rs.getString("real_date"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(13);
		cell.setCellValue("Plant Serial No");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(true);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(17);
		cell.setCellValue("383");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
	    defaultFont.setFontName("Times New Roman");
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
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(true);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(3);
//		cell.setCellValue("start_time");
		if(starttimers.next()){
			cell.setCellValue(starttimers.getString("start_time"));
			}
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
row=spreadsheet.createRow(9);

		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue("Batch End Time");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(3);
		cell.setCellValue(rs.getString("end_time"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);		
		
		
		
		
row=spreadsheet.createRow(10);

		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue("Batch Number / Docket Number");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(5);
		cell.setCellValue(":");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);	
		
		cell=(XSSFCell)row.createCell(6);
		cell.setCellValue(rs.getInt("invoice_id"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);	


		cell=(XSSFCell)row.createCell(13);
		cell.setCellValue("Ordered Quantity");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(17);
		cell.setCellValue(": "+rs.getDouble("quantity"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(18);
		cell.setCellValue("M\u00B3");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);


		
		
row=spreadsheet.createRow(11);

		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue("Customer:");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(5);
		cell.setCellValue(":");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(6);
//		cell.setCellValue(rs.getInt("invoice_id"));
		cell.setCellValue(rs.getString("customer_name"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		cell=(XSSFCell)row.createCell(13);
		cell.setCellValue("Production Quantity");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)10);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(17);
		cell.setCellValue(": "+rs.getDouble("p_quantity"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);	
		
		cell=(XSSFCell)row.createCell(18);
		cell.setCellValue("M\u00B3");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);	
		
		

row=spreadsheet.createRow(12);
		
		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue("Site ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(5);
		cell.setCellValue(":");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(6);
		cell.setCellValue(rs.getString("site_address"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		
		cell=(XSSFCell)row.createCell(13);
		cell.setCellValue("Adj/Manual Quantity");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)10);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(true);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		cell=(XSSFCell)row.createCell(17);
		cell.setCellValue(": "+"0.00");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(18);
		cell.setCellValue("M\u00B3");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		
		
row=spreadsheet.createRow(13);
		
		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue("Recipe Code ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(5);
		cell.setCellValue(":");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(6);
		cell.setCellValue(rs.getString("recipe_code"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		
		cell=(XSSFCell)row.createCell(13);
		cell.setCellValue("With This Load");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)10);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(true);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		cell=(XSSFCell)row.createCell(17);
		cell.setCellValue(": "+rs.getDouble("cum_quantity"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(18);
		cell.setCellValue("M\u00B3");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		
		
row=spreadsheet.createRow(14);
		
		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue("Recipe Name ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(5);
		cell.setCellValue(":");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(6);
		cell.setCellValue(rs.getString("product_name"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		
		cell=(XSSFCell)row.createCell(13);
		cell.setCellValue("Mixer Capacity");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)10);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(true);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		cell=(XSSFCell)row.createCell(17);
		cell.setCellValue(": "+"1.00");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(18);
		cell.setCellValue("M\u00B3");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
row=spreadsheet.createRow(15);


		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue("Truck Number");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(5);
		cell.setCellValue(":");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(6);
		cell.setCellValue(rs.getString("vehicle_no"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		cell=(XSSFCell)row.createCell(13);
		cell.setCellValue("Batch Size");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)10);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		cell=(XSSFCell)row.createCell(17);
		cell.setCellValue(": "+rs.getDouble("batch_size"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(18);
		cell.setCellValue("M\u00B3");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);

		
		
row=spreadsheet.createRow(16);


		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue("Truck Driver");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(5);
		cell.setCellValue(":");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(6);
		cell.setCellValue(rs.getString("driver_name"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		
		cell=(XSSFCell)row.createCell(13);
		cell.setCellValue("Net Wt from W.Bridge");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)10);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		cell=(XSSFCell)row.createCell(17);
//		cell.setCellValue(rs.getDouble("batch_size"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(18);
		cell.setCellValue("0Kg");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);



row=spreadsheet.createRow(17);


		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue("Order Number");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(5);
		cell.setCellValue(":");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(6);
		cell.setCellValue(rs.getString("plant_name"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
row=spreadsheet.createRow(18);


		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue("Batcher Name");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(5);
		cell.setCellValue(":");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(6);
		cell.setCellValue("Stetter");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)11);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		
		/*
		 * 
		 * 
		 * HERE INVOICE DETAIL'S GETTING END'S HERE	
		 * 
		 * 
		 * 	*/

row=spreadsheet.createRow(19);		
row=spreadsheet.createRow(20);

		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue("Aggregate");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)12);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(1);
		cell.setCellValue(" ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
		defaultFont.setFontName("Calibri");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(2);
		cell.setCellValue("");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
		defaultFont.setFontName("Calibri");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(3);
		cell.setCellValue(" ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
		defaultFont.setFontName("Calibri");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(4);
		cell.setCellValue(" ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
		defaultFont.setFontName("Calibri");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(5);
		cell.setCellValue(" ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
		defaultFont.setFontName("Calibri");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(6);
		cell.setCellValue("Cement");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)12);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(7);
		cell.setCellValue("");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)12);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		cell=(XSSFCell)row.createCell(8);
		cell.setCellValue(" ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
		defaultFont.setFontName("Calibri");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(9);
		cell.setCellValue(" ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
		defaultFont.setFontName("Calibri");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(10);
		cell.setCellValue(" ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
		defaultFont.setFontName("Calibri");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(11);
		cell.setCellValue("Water");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)12);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(12);
		cell.setCellValue(" ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
		defaultFont.setFontName("Calibri");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(13);
		cell.setCellValue(" ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
		defaultFont.setFontName("Calibri");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(14);
		cell.setCellValue("MS/ICE");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)12);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(15);
		cell.setCellValue("");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)12);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(16);
		cell.setCellValue(" ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
		defaultFont.setFontName("Calibri");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(17);
		cell.setCellValue("Admiture");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)12);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(18);
		cell.setCellValue(" ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)12);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
	
row=spreadsheet.createRow(21);
		row.setHeight((short)25);
		
row=spreadsheet.createRow(22);

		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue(rs.getString("aggregate1_name"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(1);
		cell.setCellValue(rs.getString("aggregate2_name"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(2);
		cell.setCellValue(rs.getString("aggregate3_name"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(3);
		cell.setCellValue(rs.getString("aggregate4_name"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(4);
		cell.setCellValue("0");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(5);
//		cell.setCellValue("NA");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(6);
		cell.setCellValue(rs.getString("aggregate5_name"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(7);
		cell.setCellValue(rs.getString("aggregate6_name"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(8);
		cell.setCellValue(rs.getString("aggregate7_name"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(9);
		cell.setCellValue("NA");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(10);
//		cell.setCellValue("NA");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(11);
		cell.setCellValue(rs.getString("aggregate8_name"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(12);
		cell.setCellValue("NA");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(13);
//		cell.setCellValue("NA");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(14);
		cell.setCellValue(rs.getString("aggregate9_name"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(15);
//		cell.setCellValue(" ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Times New Roman");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);;
		
		cell=(XSSFCell)row.createCell(16);
//		cell.setCellValue(" ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(17);
		cell.setCellValue("NA");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(18);
		cell.setCellValue(" ");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setBorderTop(HSSF1CellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
row=spreadsheet.createRow(23);
		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue("Recipe targets");
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
//		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)12);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(true);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);


//RECEIPE VALUE		
row=spreadsheet.createRow(24);

		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue(rs.getInt("g1"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(1);
		cell.setCellValue(rs.getInt("g2"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(2);
		cell.setCellValue(rs.getInt("g3"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(3);
		cell.setCellValue(rs.getInt("g4"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(4);
		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(5);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(6);
		cell.setCellValue(rs.getInt("g5"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(7);
		cell.setCellValue(rs.getInt("g6"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(8);
		cell.setCellValue(rs.getInt("g7"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(9);
		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(10);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(11);
		cell.setCellValue(rs.getInt("g8"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(12);
		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(13);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(14);
		cell.setCellValue(rs.getFloat("g9"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(15);
//		cell.setCellValue(0.00);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);;
		
		cell=(XSSFCell)row.createCell(16);
//		cell.setCellValue(0.00);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(17);
		cell.setCellValue(0.00);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(18);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
row=spreadsheet.createRow(25);
		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue("Water Abs(%) / Moisture (%) with water correction / Corr. Target in Kgs/ Actual in Kgs.");
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)13.5);
		defaultFont.setFontName("Times New Roman");
		defaultFont.setColor(IndexedColors.BLACK.getIndex());
		defaultFont.setBold(false);
		defaultFont.setItalic(false);
		style.setFont(defaultFont);
		cell.setCellStyle(style);
		row.setHeight((short)400);
		
		cell=(XSSFCell)row.createCell(1);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(2);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(3);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(4);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		cell=(XSSFCell)row.createCell(5);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(6);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		cell=(XSSFCell)row.createCell(7);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(8);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		cell=(XSSFCell)row.createCell(9);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(10);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		cell=(XSSFCell)row.createCell(11);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(12);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		cell=(XSSFCell)row.createCell(13);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(14);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		cell=(XSSFCell)row.createCell(15);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(16);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		cell=(XSSFCell)row.createCell(17);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(18);
		style=batch_sheet.createCellStyle();
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cell.setCellStyle(style);

		int i=25;
		PreparedStatement ps2=con.prepareStatement("select t.*,CAST(ag9 AS CHAR) as ee from  (select b.*,truncate(b.aggr9,2) ag9 from batchingsheet b where id=?) as t");
		ps2.setInt(1, id);
		ResultSet rs2=ps2.executeQuery();
		
		while(rs2.next()){
		i++;
		
		row=spreadsheet.createRow(i);					// 1
		
		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue(0.0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(1);
		cell.setCellValue(0.0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(2);
		cell.setCellValue(0.0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(3);
		cell.setCellValue(0.0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(4);
		cell.setCellValue(0.0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(5);
//		cell.setCellValue(0.0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(6);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(7);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(8);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(9);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(10);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(11);
		cell.setCellValue(15);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(12);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(13);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(14);
//		cell.setCellValue(0.00);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(15);
//		cell.setCellValue(0.00);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(16);
//		cell.setCellValue(0.00);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);;
		
		cell=(XSSFCell)row.createCell(17);
//		cell.setCellValue(0.00);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(18);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		
		
		/* NOW GET ALL BATCHING DETAIL'S HERE	*/
		//now get total batch sheet generated in 
		
		i++;
		
		row=spreadsheet.createRow(i);					// 2
		
		
		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue(0.0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(1);
		cell.setCellValue(0.0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(2);
		cell.setCellValue(0.0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(3);
		cell.setCellValue(0.0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(4);
		cell.setCellValue(0.0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(5);
//		cell.setCellValue(0.0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		cell=(XSSFCell)row.createCell(9);
		cell.setCellValue("Bal. Wtr");
		spreadsheet.addMergedRegion(new CellRangeAddress(i,i,9,11));
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.0"));
		style.setWrapText(false);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		
		i++;
		row=spreadsheet.createRow(i);			// 3


		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue(rs.getInt("g1"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(1);
		cell.setCellValue(rs.getInt("g2"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(2);
		cell.setCellValue(rs.getInt("g3"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(3);
		cell.setCellValue(rs.getInt("g4"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(4);
		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(5);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(6);
		cell.setCellValue(rs.getInt("g5"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(7);
		cell.setCellValue(rs.getInt("g6"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(8);
		cell.setCellValue(rs.getInt("g7"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(9);
		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(10);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(11);
		cell.setCellValue(rs.getInt("g8"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(12);
		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(13);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(14);
		cell.setCellValue(rs.getFloat("g9"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(15);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(16);
//		cell.setCellValue(0.00);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);;
		
		cell=(XSSFCell)row.createCell(17);
		cell.setCellValue(0.00);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(18);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		
		i++;
		
		
		
		
		row=spreadsheet.createRow(i);		//4
		
		
		cell=(XSSFCell)row.createCell(0);
		cell.setCellValue(rs2.getInt("aggr1"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(1);
		cell.setCellValue(rs2.getInt("aggr2"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(2);
		cell.setCellValue(rs2.getInt("aggr3"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(3);
		cell.setCellValue(rs2.getInt("aggr4"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(4);
		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(5);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(6);
		cell.setCellValue(rs2.getInt("aggr5"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(7);
		cell.setCellValue(rs2.getInt("aggr6"));
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(8);
		cell.setCellValue(rs2.getInt("aggr7"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(9);
		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(10);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(11);
		cell.setCellValue(rs2.getInt("aggr8"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(12);
		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(13);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(14);
		cell.setCellValue(rs2.getFloat("aggr9"));
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(15);
//		cell.setCellValue(0.00);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(16);
//		cell.setCellValue(0.00);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);;
		
		cell=(XSSFCell)row.createCell(17);
		cell.setCellValue(0.00);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		cell=(XSSFCell)row.createCell(18);
//		cell.setCellValue(0);
		
		style=batch_sheet.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setWrapText(true);
		defaultFont= batch_sheet.createFont();
		defaultFont.setFontHeightInPoints((short)8);
	    defaultFont.setFontName("Arial");
	    defaultFont.setColor(IndexedColors.BLACK.getIndex());
	    defaultFont.setBold(false);
	    defaultFont.setItalic(false);
	    style.setFont(defaultFont);
		cell.setCellStyle(style);
		
		
		}
				
   
   row=spreadsheet.createRow(i+1);
   row.setHeight((short)100);

	cell=(XSSFCell)row.createCell(0);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
	defaultFont.setFontName("Arial");
	defaultFont.setColor(IndexedColors.BLACK.getIndex());
	defaultFont.setBold(false);
	defaultFont.setItalic(false);
	style.setFont(defaultFont);
	cell.setCellStyle(style);

	cell=(XSSFCell)row.createCell(1);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);

	cell=(XSSFCell)row.createCell(2);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);

	cell=(XSSFCell)row.createCell(3);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);

	cell=(XSSFCell)row.createCell(4);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);

	cell=(XSSFCell)row.createCell(5);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(6);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	cell=(XSSFCell)row.createCell(7);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	cell=(XSSFCell)row.createCell(8);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	cell=(XSSFCell)row.createCell(9);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	cell=(XSSFCell)row.createCell(10);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	cell=(XSSFCell)row.createCell(11);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	cell=(XSSFCell)row.createCell(12);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	cell=(XSSFCell)row.createCell(13);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	cell=(XSSFCell)row.createCell(14);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	cell=(XSSFCell)row.createCell(15);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	cell=(XSSFCell)row.createCell(16);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	cell=(XSSFCell)row.createCell(17);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	cell=(XSSFCell)row.createCell(18);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);

row=spreadsheet.createRow(i+2);
spreadsheet.addMergedRegion(new CellRangeAddress(i+2,i+2,0,7));
spreadsheet.addMergedRegion(new CellRangeAddress(i+2,i+2,8,10));
	cell=(XSSFCell)row.createCell(0);
	cell.setCellValue("Total Set Weight in Kgs.");
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)13);
	defaultFont.setFontName("Times New Roman");
	defaultFont.setColor(IndexedColors.BLACK.getIndex());
	defaultFont.setBold(false);
	defaultFont.setItalic(false);
	style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(8);
	cell.setCellValue("Total Bal. Wtr");
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)12);
	defaultFont.setFontName("Times New Roman");
	defaultFont.setColor(IndexedColors.BLACK.getIndex());
	defaultFont.setBold(false);
	defaultFont.setItalic(false);
	style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(12);
	cell.setCellValue(0);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)12);
	defaultFont.setFontName("Times New Roman");
	defaultFont.setColor(IndexedColors.BLACK.getIndex());
	defaultFont.setBold(false);
	defaultFont.setItalic(false);
	style.setFont(defaultFont);
	cell.setCellStyle(style);
	
		
row=spreadsheet.createRow(i+3);

	cell=(XSSFCell)row.createCell(0);
	cell.setCellValue(rs.getInt("p1"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(1);
	cell.setCellValue(rs.getInt("p2"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(2);
	cell.setCellValue(rs.getInt("p3"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(3);
	cell.setCellValue(rs.getInt("p4"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(4);
	cell.setCellValue(0);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(5);
//	cell.setCellValue(0);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(6);
	cell.setCellValue(rs.getInt("p5"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(7);
	cell.setCellValue(rs.getInt("p6"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(8);
	cell.setCellValue(rs.getInt("p7"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(9);
	cell.setCellValue(0);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(10);
//	cell.setCellValue(0);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(11);
	cell.setCellValue(rs.getInt("p8"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(12);
	cell.setCellValue(0);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(13);
//	cell.setCellValue(0);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(14);
	cell.setCellValue(rs.getFloat("p9"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(15);
//	cell.setCellValue(0.00);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(16);
//	cell.setCellValue(0.00);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);;
	
	cell=(XSSFCell)row.createCell(17);
	cell.setCellValue(0.00);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setDataFormat(batch_sheet.createDataFormat().getFormat("0.00"));
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(18);
//	cell.setCellValue(0);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
row=spreadsheet.createRow(i+4);
	row.setHeight((short)25);
	
row=spreadsheet.createRow(i+5);
	spreadsheet.addMergedRegion(new CellRangeAddress(i+5,i+5,0,18));
	//spreadsheet.addMergedRegion(new CellRangeAddress(47,47,17,18));

	cell=(XSSFCell)row.createCell(0);
	cell.setCellValue("Total Actual in Kgs.");
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)13);
	defaultFont.setFontName("Times New Roman");
	defaultFont.setColor(IndexedColors.BLACK.getIndex());
	defaultFont.setBold(false);
	defaultFont.setItalic(false);
	style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	PreparedStatement ps3=con.prepareStatement("select sum(aggr1) as s1,sum(aggr2)as s2,sum(aggr3) as s3,sum(aggr4) as s4,sum(aggr5) as s5,sum(aggr6) as s6,sum(aggr7) as s7,sum(aggr8) as s8,format(sum(aggr9),2) as s9,\r\n" + 
			"				  		sum(aggr10) as s10,sum(aggr11) as s11 from batchingsheet where id=?");
	ps3.setInt(1, id);
	ResultSet rs3=ps3.executeQuery();
	
	if(rs3.next()) {
		
	row=spreadsheet.createRow(i+6);

	cell=(XSSFCell)row.createCell(0);
	cell.setCellValue(rs3.getInt("s1"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(1);
	cell.setCellValue(rs3.getInt("s2"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(2);
	cell.setCellValue(rs3.getInt("s3"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(3);
	cell.setCellValue(rs3.getInt("s4"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(4);
	cell.setCellValue(0);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(5);
//	cell.setCellValue(0);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(6);
	cell.setCellValue(rs3.getInt("s5"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(7);
	cell.setCellValue(rs3.getInt("s6"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(8);
	cell.setCellValue(rs3.getInt("s7"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(9);
	cell.setCellValue(0);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(10);
//	cell.setCellValue(0);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(11);
	cell.setCellValue(rs3.getInt("s8"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(12);
	cell.setCellValue(0);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(13);
//	cell.setCellValue(0);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(14);
	cell.setCellValue(rs3.getFloat("s9"));
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(15);
//	cell.setCellValue(0.00);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(16);
//	cell.setCellValue(0.00);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);;
	
	cell=(XSSFCell)row.createCell(17);
	cell.setCellValue(0.00);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(18);
//	cell.setCellValue(0);
	
	style=batch_sheet.createCellStyle();
	style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
	style.setWrapText(true);
	defaultFont= batch_sheet.createFont();
	defaultFont.setFontHeightInPoints((short)8);
    defaultFont.setFontName("Arial");
    defaultFont.setColor(IndexedColors.BLACK.getIndex());
    defaultFont.setBold(false);
    defaultFont.setItalic(false);
    style.setFont(defaultFont);
	cell.setCellStyle(style);
	
	}
row=spreadsheet.createRow(i+7);

	row.setHeight((short)25);
	cell=(XSSFCell)row.createCell(0);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(1);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(2);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(3);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(4);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(5);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(6);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(7);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(8);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(9);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(10);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(11);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(12);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(13);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(14);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(15);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(16);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(17);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	cell=(XSSFCell)row.createCell(18);
	style=batch_sheet.createCellStyle();
	style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	cell.setCellStyle(style);
	
	
	
		//this is print area of this page
		spreadsheet.getPrintSetup().setPaperSize(XSSFPrintSetup.A4_PAPERSIZE);
		spreadsheet.setMargin(Sheet.LeftMargin, 0.4);
		spreadsheet.setMargin(Sheet.BottomMargin, 0.3);
		spreadsheet.setMargin(Sheet.TopMargin, 0.3);
		spreadsheet.setMargin(Sheet.RightMargin, 0.1);
		spreadsheet.setMargin(Sheet.HeaderMargin, 0.3);
		spreadsheet.setMargin(Sheet.FooterMargin, 0.3);
		spreadsheet.setFitToPage(true);	
}	
		
		
	   /* DOWNLOAD THIS FILE IN REPORT FOLDER	*/
		File f=new File(prop.getProperty("path")+"/batch_sheet.xlsx");
		if(f.exists()) {
		boolean fr=f.delete();
		}
		FileOutputStream out=new FileOutputStream(prop.getProperty("path")+"/batch_sheet.xlsx");
		batch_sheet.write(out);
		
		//File f=new File("C:/Users/Arun Kumar Rout/Desktop/RMC AND PROJECTS/Panchami RMC/WebContent/invoice_report.xlsx");
		out.close();
		
	   /* DOWNLOAD FINISHED HERE*/
		
		
	}
}
