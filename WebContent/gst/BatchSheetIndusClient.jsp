<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<HTML>

<STYLE>
 A {text-decoration:none}
 A IMG {border-style:none; border-width:0;} 
.fontColor10 {FONT-SIZE:11.9PT; ; FONT-FAMILY:Verdana; }
.fontColor11 {FONT-SIZE:11.9PT; ; FONT-FAMILY:Courier New; FONT-WEIGHT:BOLD; }
.fontColor12 {FONT-SIZE:9.9PT; ; FONT-FAMILY:Courier New; FONT-WEIGHT:BOLD; }
.fontColor13 {FONT-SIZE:9.9PT; ; FONT-FAMILY:Times New Roman; }
.fontColor14 {FONT-SIZE:7.9PT; ; FONT-FAMILY:Times New Roman; FONT-WEIGHT:BOLD; }
.fontColor15 {FONT-SIZE:9.9PT; ; FONT-FAMILY:Times New Roman; FONT-WEIGHT:BOLD; }
.fontColor16 {FONT-SIZE:8.9PT; ; FONT-FAMILY:Courier New; FONT-WEIGHT:BOLD; }
.fontColor17 {FONT-SIZE:8.9PT; ; FONT-FAMILY:Times New Roman; FONT-WEIGHT:BOLD; }
.fontColor18 {FONT-SIZE:6.9PT; ; FONT-FAMILY:Times New Roman; }
.fontColor19 {FONT-SIZE:9.9PT; ; FONT-FAMILY:Times New Roman; FONT-WEIGHT:BOLD; }
.fontColor110 {FONT-SIZE:8.9PT; ; FONT-FAMILY:Times New Roman; }
.fontColor111 {FONT-SIZE:11.9PT; ; FONT-FAMILY:Times New Roman; FONT-WEIGHT:BOLD; }
.adornment10 {border-color:000000; border-style:none; border-bottom-width:0PX; border-left-width:0PX; border-top-width:0PX; border-right-width:0PX; }
</STYLE>

<TITLE>Crystal Report Viewer</TITLE>
<BODY LEFTMARGIN="0" TOPMARGIN="0" BOTTOMMARGIN="0" RIGHTMARGIN="0">


<c:catch var="ctch">
 	 <sql:update dataSource="jdbc/rmc" var="ex">
 			call testbatchsheetsave(?,@a);
 			<sql:param value="${param.id}"/>
 	 </sql:update>
 </c:catch>


<sql:query var="available" dataSource="jdbc/rmc">
 	 select * from test_batchingsheet where id=?
 	 <sql:param value="${param.id}"/>
 </sql:query>
 
 <c:set value="false" var="availability"/>
 <c:forEach items="${available.rows}" var="available">
 	  <c:set value="true" var="availability"/>
 </c:forEach>
 
<c:choose>
	<c:when test="${availability==true}">
	<sql:query var="start_time" dataSource="jdbc/rmc">
	  	select addtime(subtime(min(target_time),max(target_time)),min(target_time)) as start_time
	    from (select * from test_batchingsheet where id=? limit 2) as t
	    <sql:param value="${param.id}"/>
	</sql:query>
	
	<sql:query var="mix" dataSource="jdbc/rmc">
 	select p.*,REPLACE(format(p.aggregate1_value*p.p_quantity,0),',','') as p1,REPLACE(format(p.aggregate1_value*p.p_quantity,0),',','') as p1,
 	REPLACE(format(p.aggregate1_value*p.p_quantity,0),',','') as p1,REPLACE(format(p.aggregate2_value*p.p_quantity,0),',','') as p2,
 	REPLACE(format(p.aggregate3_value*p.p_quantity,0),',','') as p3,REPLACE(format(p.aggregate4_value*p.p_quantity,0),',','') as p4,
 	REPLACE(format(p.aggregate5_value*p.p_quantity,0),',','') as p5,REPLACE(format(p.aggregate6_value*p.p_quantity,0),',','') as p6,
 	REPLACE(format(p.aggregate7_value*p.p_quantity,0),',','') as p7,REPLACE(format(p.aggregate8_value*p.p_quantity,0),',','') as p8,
 	REPLACE(format(p.aggregate9_value*p.p_quantity,2),',','') as p9,REPLACE(format(p.aggregate10_value*p.p_quantity,1),',','') as p10,
 	REPLACE(format(p.aggregate11_value*p.p_quantity,0),',','') as p11 from (select t.*,format((t.aggregate1_value*p),0) as g1,format((t.aggregate2_value*p),0) as g2,format((t.aggregate3_value*p),0) as g3,format((t.aggregate4_value*p),0) as g4,
 	format((t.aggregate5_value*p),0) as g5,format((t.aggregate6_value*p),0) as g6,format((t.aggregate7_value*p),0) as g7,format((t.aggregate8_value*p),0) as g8,
 	format((t.aggregate9_value*p),2) as g9,format((t.aggregate10_value*p),1) as g10,format((t.aggregate11_value*p),0) as g11	
 	from  ( select i.id,i.invoice_id,i.site_id as siteid,i.poi_id as po_id,i.vehicle_no,i.driver_name,i.pump,m.*,c.customer_phone,a.site_address as site_address,a.site_name, format((select sum(quantity) from test_invoice ii 
	where ii.customer_id=i.customer_id and ii.invoice_date=i.invoice_date and ii.invoice_id <=i.invoice_id),1) as cum_quantity,
	truncate(i.quantity/ceil(i.quantity),2) as batch_size,p.product_name,g.quantity,pl.plant_name,(i.quantity/ceil(i.quantity)) as p,
	DATE_FORMAT(i.invoice_date, '%d-%m-%Y') as real_date,c.customer_name,i.quantity as p_quantity,i.invoice_time as end_time,i.docket_no,
	CAST(truncate(m.aggregate9_value,2) AS CHAR) as agm,format(ceil(i.quantity),0) as quant,ceil(i.quantity) as qua
	from test_invoice i LEFT JOIN (test_receipe m,test_site_detail  a,test_customer c,test_purchase_order_item g,product p,plant pl,test_purchase_order po)
	ON i.customer_id=c.customer_id
	and i.poi_id=g.poi_id
	and g.order_id=po.order_id
	and po.site_id=m.site_id
	and g.product_id=m.product_id
	and g.product_id=p.product_id
	and i.plant_id=pl.plant_id
	and i.site_id=a.site_id
	where i.id=?) as t) as p
	<sql:param value="${param.id}"/>
  </sql:query>
  
  <c:forEach var="mix" items="${mix.rows}">
  		<c:set value="${mix}" var="rec"/>
  </c:forEach>
<DIV  style="z-index:25; position:absolute; left:4PX; top:8PX; width:708PX; height:15PX; " class="adornment10"  ALIGN="CENTER">
<table width="703PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor11"  ALIGN="CENTER">INDUS</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:0PX; top:30PX; width:712PX; height:15PX; " class="adornment10"  ALIGN="CENTER">
<table width="707PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor12"  ALIGN="CENTER">BGLR</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:0PX; top:48PX; width:712PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="707PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor12">TECHNICAL BATCH DATA REPORT</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:16PX; top:227PX; width:40PX; height:15PX; " class="adornment10" >
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor14">SL NO</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:80PX; top:227PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">${rec.aggregate1_name}</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:120PX; top:227PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">${rec.aggregate2_name}</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:160PX; top:227PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">${rec.aggregate3_name}</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:200PX; top:227PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">${rec.aggregate4_name}</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:240PX; top:227PX; width:48PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">${rec.aggregate5_name}</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:280PX; top:227PX; width:59PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="54PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">${rec.aggregate6_name}</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:464PX; top:227PX; width:56PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="51PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">${rec.aggregate9_name}</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:544PX; top:227PX; width:48PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">TOTAL</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:632PX; top:227PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">CUM3</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:144PX; top:91PX; width:64PX; height:16PX; " class="adornment10" >
<table width="59PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" >${rec.docket_no}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:24PX; top:107PX; width:72PX; height:15PX; " class="adornment10" >
<table width="67PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Date </span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:24PX; top:171PX; width:80PX; height:15PX; " class="adornment10" >
<table width="75PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Pouring </span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:144PX; top:107PX; width:79PX; height:16PX; " class="adornment10" >
<table width="74PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" >${rec.real_date}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:144PX; top:171PX; width:160PX; height:15PX; " class="adornment10" >
<table width="155PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" >${rec.site_name}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:288PX; top:91PX; width:64PX; height:15PX; " class="adornment10" >
<table width="59PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Vehicle </span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:384PX; top:91PX; width:88PX; height:15PX; " class="adornment10" >
<table width="83PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor17" >${rec.vehicle_no}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:288PX; top:107PX; width:64PX; height:15PX; " class="adornment10" >
<table width="59PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">T-Qty</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:288PX; top:123PX; width:120PX; height:14PX; " class="adornment10" >
<table width="115PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Cement Grade</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:392PX; top:123PX; width:56PX; height:15PX; " class="adornment10" >
<table width="51PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor17" >53</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:24PX; top:187PX; width:80PX; height:16PX; " class="adornment10" >
<table width="75PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Mix Design</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:144PX; top:187PX; width:160PX; height:15PX; " class="adornment10" >
<table width="155PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" >${rec.recipe_code}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:408PX; top:227PX; width:56PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="51PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">${rec.aggregate8_name}</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:120PX; top:91PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:120PX; top:107PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor18">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:360PX; top:123PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor18">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:368PX; top:107PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:368PX; top:91PX; width:12PX; height:112PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:392PX; top:107PX; width:64PX; height:16PX; " class="adornment10" >
<table width="59PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" >${rec.p_quantity}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:352PX; top:227PX; width:48PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">${rec.aggregate7_name}</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:120PX; top:187PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:120PX; top:171PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:24PX; top:123PX; width:96PX; height:15PX; " class="adornment10" >
<table width="91PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Batch Startin</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:24PX; top:147PX; width:72PX; height:15PX; " class="adornment10" >
<table width="67PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Customer</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:144PX; top:123PX; width:79PX; height:16PX; " class="adornment10" >
<table width="74PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" >
	<c:forEach items="${start_time.rows}" var="start_time">
	  		${start_time.start_time}
	 </c:forEach> 
</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:120PX; top:131PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:120PX; top:147PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:24PX; top:91PX; width:96PX; height:16PX; " class="adornment10" >
<table width="91PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Trip Slip No </span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:144PX; top:147PX; width:192PX; height:15PX; " class="adornment10" >
<table width="187PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" >${rec.customer_name}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:368PX; top:123PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:288PX; top:139PX; width:64PX; height:15PX; " class="adornment10" >
<table width="59PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Strength</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:288PX; top:155PX; width:64PX; height:15PX; " class="adornment10" >
<table width="59PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Slump</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:288PX; top:171PX; width:64PX; height:15PX; " class="adornment10" >
<table width="59PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">User</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:290PX; top:187PX; width:70PX; height:15PX; " class="adornment10" >
<table width="65PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Mixed Des</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:368PX; top:139PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:352PX; top:131PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:368PX; top:155PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:368PX; top:171PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:368PX; top:187PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:480PX; top:91PX; width:92PX; height:15PX; " class="adornment10" >
<table width="87PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Ordered Qty</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:480PX; top:115PX; width:104PX; height:15PX; " class="adornment10" >
<table width="99PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Produced Qty</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:480PX; top:131PX; width:112PX; height:15PX; " class="adornment10" >
<table width="107PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Returned Qty</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:480PX; top:155PX; width:104PX; height:15PX; " class="adornment10" >
<table width="99PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Set this Load</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:480PX; top:171PX; width:128PX; height:15PX; " class="adornment10" >
<table width="123PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">First Batch Size</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:480PX; top:195PX; width:120PX; height:15PX; " class="adornment10" >
<table width="115PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Other Batch Size</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:596PX; top:195PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:596PX; top:171PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:596PX; top:155PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:596PX; top:131PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:596PX; top:115PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:596PX; top:91PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:648PX; top:147PX; width:12PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="7PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor14">:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:617PX; top:171PX; width:62PX; height:16PX; " class="adornment10" >
<table width="57PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" ><fmt:formatNumber value="${(rec.batch_size==1.0)?rec.batch_size:rec.batch_size+0.01}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:617PX; top:195PX; width:62PX; height:16PX; " class="adornment10" >
<table width="57PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" ><fmt:formatNumber value="${(rec.batch_size==1.0)?rec.batch_size:rec.batch_size+0.01}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:8PX; top:251PX; width:72PX; height:15PX; " class="adornment10" >
<table width="67PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor14">DESI//M3</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:79PX; top:251PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.aggregate1_value}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:120PX; top:251PX; width:32PX; height:16PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.aggregate2_value}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:160PX; top:251PX; width:32PX; height:16PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.aggregate3_value}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:208PX; top:251PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.aggregate4_value}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:248PX; top:251PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.aggregate5_value}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:304PX; top:251PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.aggregate6_value}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:360PX; top:251PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.aggregate7_value}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:414PX; top:251PX; width:34PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="29PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.aggregate8_value}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:464PX; top:251PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.aggregate9_value}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:536PX; top:251PX; width:58PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT"><fmt:formatNumber value="${rec.aggregate1_value+rec.aggregate2_value+rec.aggregate3_value+rec.aggregate4_value+rec.aggregate5_value+rec.aggregate6_value+rec.aggregate7_value+rec.aggregate8_value+rec.aggregate9_value}" maxFractionDigits="2" groupingUsed="false"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:8PX; top:275PX; width:56PX; height:15PX; " class="adornment10" >
<table width="51PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor14">L VALUE</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:79PX; top:275PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.g1}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:120PX; top:275PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.g2}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:160PX; top:275PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.g3}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:208PX; top:275PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.g4}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:256PX; top:275PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.g5}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:304PX; top:275PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.g6}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:360PX; top:275PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.g7}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:414PX; top:275PX; width:34PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="29PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.g8}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:464PX; top:275PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.g9}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:536PX; top:275PX; width:58PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT"><fmt:formatNumber value="${rec.g1+rec.g2+rec.g3+rec.g4+rec.g5+rec.g6+rec.g7+rec.g8+rec.g9}" groupingUsed="false" maxFractionDigits="2"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:628PX; top:275PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT"><fmt:formatNumber value="${(rec.batch_size==1.0)?rec.batch_size:rec.batch_size+0.01}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:628PX; top:251PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor19">1.00</span></td></tr></table>
</DIV>

 <sql:query var="gen" dataSource="jdbc/rmc">
 	 select t.*,CAST(ag9 AS CHAR) as ee from  (select b.*,truncate(b.aggr9,2) ag9 from test_batchingsheet b where id=?) as t
 	<sql:param value="${param.id}"/>
 </sql:query>


<c:set value="304" var="top1"/>
<!-- Start Line -->
<c:set value="0" var="count"/>
<c:forEach items="${gen.rows}" var="recc">
<c:set value="${count+1}" var="count"/>
<DIV  style="z-index:25; position:absolute; left:80PX; top:${top1}PX; width:27PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="22PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${recc.aggr1}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:120PX; top:${top1}PX; width:27PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="22PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${recc.aggr2}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:163PX; top:${top1}PX; width:27PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="22PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${recc.aggr3}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:205PX; top:${top1}PX; width:27PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="22PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${recc.aggr4}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:408PX; top:${top1}PX; width:40PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${recc.aggr8}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:448PX; top:${top1}PX; width:56PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="51PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT"><fmt:formatNumber value="${recc.aggr9}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:16PX; top:${top1}PX; width:40PX; height:14PX; " class="adornment10" >
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110" >${count}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:544PX; top:${top1}PX; width:48PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT"><fmt:formatNumber value="${recc.aggr1+recc.aggr2+recc.aggr3+recc.aggr4+recc.aggr5+recc.aggr6+recc.aggr7+recc.aggr8+recc.aggr9}" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:240PX; top:${top1}PX; width:48PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT"> ${recc.aggr5}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:296PX; top:${top1}PX; width:48PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${recc.aggr6}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:632PX; top:${top1}PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT"><fmt:formatNumber value="${(rec.batch_size==1.0)?rec.batch_size:rec.batch_size+0.01}" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:352PX; top:${top1}PX; width:48PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${recc.aggr7}</td></tr></table>
</DIV>
<c:set value="${top1+28}" var="top1"/>
</c:forEach>

<!-- End Line -->


 <sql:query var="sum" dataSource="jdbc/rmc">
  		select sum(aggr1) as s1,sum(aggr2)as s2,sum(aggr3) as s3,sum(aggr4) as s4,sum(aggr5) as s5,sum(aggr6) as s6,sum(aggr7) as s7,sum(aggr8) as s8,format(sum(aggr9),2) as s9,
  		sum(aggr10) as s10,sum(aggr11) as s11 from test_batchingsheet where id=?;
  		<sql:param value="${param.id}"/>
 </sql:query>
 
 <c:forEach items="${sum.rows}" var="sum">
 	<c:set value="${sum}" var="sumbatch"/>
 </c:forEach>
 <c:set value="${sumbatch.s1+sumbatch.s2+sumbatch.s3+sumbatch.s4+sumbatch.s5+sumbatch.s6+sumbatch.s7+sumbatch.s8+sumbatch.s9}" var="total_s"/>
<DIV  style="z-index:25; position:absolute; left:75PX; top:${top1+28}PX; width:32PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${rec.p1}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:160PX; top:${top1+28}PX; width:30PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="25PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${rec.p3}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:200PX; top:${top1+28}PX; width:30PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="25PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${rec.p4}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:115PX; top:${top1+28}PX; width:32PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${rec.p2}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:240PX; top:${top1+28}PX; width:45PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="40PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${rec.p5}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:408PX; top:${top1+28}PX; width:40PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${rec.p8}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:456PX; top:${top1+28}PX; width:52PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="47PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${rec.p9}</td></tr></table>
</DIV>
<c:set value="${rec.p1+rec.p2+rec.p3+rec.p4+rec.p5+rec.p6+rec.p7+rec.p8+rec.p9}"  var="mix_total"/>
<DIV  style="z-index:25; position:absolute; left:544PX; top:${top1+28}PX; width:52PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="47PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT"><fmt:formatNumber value="${mix_total}" maxFractionDigits="2" groupingUsed="false" minFractionDigits="2"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:16PX; top:${top1+28}PX; width:56PX; height:15PX; " class="adornment10" >
<table width="51PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor14">Set Total:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:16PX; top:${top1+4}PX; width:40PX; height:15PX; " class="adornment10" >
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor14">Total:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:75PX; top:${top1+4}PX; width:32PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor17"  ALIGN="RIGHT">${sumbatch.s1}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:112PX; top:${top1+4}PX; width:34PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="29PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor17"  ALIGN="RIGHT">${sumbatch.s2}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:158PX; top:${top1+4}PX; width:32PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor17"  ALIGN="RIGHT">${sumbatch.s3}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:200PX; top:${top1+4}PX; width:32PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor17"  ALIGN="RIGHT">${sumbatch.s4}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:240PX; top:${top1+4}PX; width:48PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor17"  ALIGN="RIGHT">${sumbatch.s5}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:408PX; top:${top1+4}PX; width:40PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor17"  ALIGN="RIGHT">${sumbatch.s8}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:448PX; top:${top1+4}PX; width:56PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="51PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor17"  ALIGN="RIGHT">${sumbatch.s9}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:536PX; top:${top1+4}PX; width:56PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="51PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor17"  ALIGN="RIGHT">${total_s}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:296PX; top:${top1+28}PX; width:45PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="40PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${rec.p6}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:296PX; top:${top1+4}PX; width:48PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor17"  ALIGN="RIGHT">${sumbatch.s6}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:626PX; top:${top1+4}PX; width:44PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="39PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor17"  ALIGN="RIGHT">${rec.p_quantity}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:352PX; top:${top1+4}PX; width:48PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor17"  ALIGN="RIGHT">${sumbatch.s7}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:352PX; top:${top1+28}PX; width:45PX; height:16PX; " class="adornment10"  ALIGN="RIGHT">
<table width="40PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${rec.p7}</td></tr></table>
</DIV>

<sql:query var="ress" dataSource="jdbc/rmc">
	select truncate(((${sumbatch.s1}-${rec.p1})/${sumbatch.s1})*100,2) as m1,truncate(((${sumbatch.s2}-${rec.p2})/${sumbatch.s2})*100,2) as m2,truncate(((${sumbatch.s3}-${rec.p3})/${sumbatch.s3})*100,2) as m3,
	truncate(((${sumbatch.s4}-${rec.p4})/${sumbatch.s4})*100,2) as m4,truncate(((${sumbatch.s5}-${rec.p5})/${sumbatch.s5})*100,2) as m5,truncate(((${sumbatch.s6}-${rec.p6})/${sumbatch.s6})*100,2) as m6,
	truncate(((${sumbatch.s7}-${rec.p7})/${sumbatch.s7})*100,2) as m7,truncate(((${sumbatch.s8}-${rec.p8})/${sumbatch.s8})*100,2) as m8,truncate(((${sumbatch.s9}-${rec.p9})/${sumbatch.s9})*100,2) as m9;
</sql:query>

<c:forEach items="${ress.rows}" var="ress">
	<c:set value="${ress}" var="rs"/>
</c:forEach>
<DIV  style="z-index:25; position:absolute; left:56PX; top:${top1+52}PX; width:58PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${(empty rs.m1)?0.00:rs.m1}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:16PX; top:${top1+52}PX; width:49PX; height:15PX; " class="adornment10" >
<table width="44PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor14">Error  %:</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:16PX; top:${top1+76}PX; width:60PX; height:15PX; " class="adornment10" >
<table width="55PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor14">Moisture :</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:128PX; top:${top1+52}PX; width:58PX; height:15PX; " class="adornment10" >
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13" >${(empty rs.m2)?0.00:rs.m2}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:168PX; top:${top1+52}PX; width:58PX; height:15PX; " class="adornment10" >
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13" >${(empty rs.m3)?0.00:rs.m3}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:216PX; top:${top1+52}PX; width:58PX; height:15PX; " class="adornment10" >
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13" >${(empty rs.m4)?0.00:rs.m4}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:264PX; top:${top1+52}PX; width:58PX; height:15PX; " class="adornment10" >
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13" >${(empty rs.m5)?0.00:rs.m5}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:323PX; top:${top1+52}PX; width:58PX; height:15PX; " class="adornment10" >
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13" >${(empty rs.m6)?0.00:rs.m6}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:384PX; top:${top1+52}PX; width:58PX; height:15PX; " class="adornment10" >
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13" >${(empty rs.m7)?0.00:rs.m7}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:432PX; top:${top1+52}PX; width:58PX; height:15PX; " class="adornment10" >
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13" >${(empty rs.m8)?0.00:rs.m8}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:480PX; top:${top1+52}PX; width:58PX; height:15PX; " class="adornment10" >
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13" >${(empty rs.m9)?0.00:rs.m9}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:16PX; top:${top1+105}PX; width:104PX; height:38PX; " class="adornment10" >
<table width="99PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor111">No Of Batches </span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:136PX; top:${top1+107}PX; width:40PX; height:15PX; " class="adornment10" >
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" >${count}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:200PX; top:${top1+107}PX; width:136PX; height:19PX; " class="adornment10" >
<table width="131PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor111">Batch End Time :</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:360PX; top:${top1+107}PX; width:79PX; height:16PX; " class="adornment10" >
<table width="74PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" >${rec.end_time}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:80PX; top:${top1+76}PX; width:58PX; height:15PX; " class="adornment10" >
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13" >0.00</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:128PX; top:${top1+76}PX; width:58PX; height:15PX; " class="adornment10" >
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13" >0.00</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:168PX; top:${top1+76}PX; width:58PX; height:15PX; " class="adornment10" >
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13" >0.00</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:216PX; top:${top1+76}PX; width:58PX; height:15PX; " class="adornment10" >
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13" >0.00</td></tr></table>
</DIV>
<BR>
</c:when>
<c:otherwise>
	Please add mix design

</c:otherwise>
 </c:choose>
</BODY>
</HTML>
