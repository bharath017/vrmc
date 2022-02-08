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



 
<sql:query var="mix" dataSource="jdbc/rmc">
	select distinct NO_OF_CYCLES_VAL0,DATE_FORMAT(date(timestamp),'%d/%m/%Y') as real_date,TRUCK_DETAIL_VAL0,POURING_DET_VAL0,MIX_DESIGN_VAL0,RECIPE_NO_VAL0,round(BATCH_SIZE_VAL0,2) as batch_size,CUST_DETAIL_VAL0,TOTAL_M3_VAL0 from ved_log  where NO_OF_CYCLES_22_VAL0=? limit 1
	<sql:param value="${param.id}"/>
</sql:query>
  <c:forEach var="mix" items="${mix.rows}">
  		<c:set value="${mix}" var="rec"/>
  </c:forEach>
  <sql:query var="time" dataSource="jdbc/rmc">
  	select  time(min(timestamp)) as min_time,time(max(timestamp)) as max_time from  ved_log where NO_OF_CYCLES_22_VAL0=?
  	<sql:param value="${param.id}"/>
  </sql:query>
  <c:forEach var="time" items="${time.rows}">
  		<c:set value="${time}" var="tm"/>
  </c:forEach>
  
  
  <sql:query var="rcp" dataSource="jdbc/rmc">
  		select * from ved_log where NO_OF_CYCLES_22_VAL0=? limit 1
  		<sql:param value="${param.id}"/>
  </sql:query>
  <c:forEach items="${rcp.rows}" var="rcp">
  		<c:set value="${rcp}" var="mx"/>
  </c:forEach>
  
  
   <sql:query var="gen" dataSource="jdbc/rmc">
 		select  distinct * from ved_log where NO_OF_CYCLES_22_VAL0=?
 	<sql:param value="${param.id}"/>
 </sql:query>
 <DIV  style="z-index:25; position:absolute; left:4PX; top:8PX; width:708PX; height:15PX; " class="adornment10"  ALIGN="CENTER">
<table width="703PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor11"  ALIGN="CENTER">SAI SURYA CONCRETE</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:0PX; top:30PX; width:712PX; height:15PX; " class="adornment10"  ALIGN="CENTER">
<table width="707PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor12"  ALIGN="CENTER">Sy. No. :10/1 & 11/1, Thirumenahalli, Yelahanka, Bangalore-560064</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:0PX; top:48PX; width:712PX; height:16PX; " class="adornment10"  ALIGN="CENTER">
<table width="707PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="CENTER"><span class="fontColor12">TECHNICAL BATCH DATA REPORT</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:16PX; top:227PX; width:40PX; height:15PX; " class="adornment10" >
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor14">SL NO</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:80PX; top:227PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">12MM</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:120PX; top:227PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14"> M,SA</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:160PX; top:227PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14"> M,SA</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:200PX; top:227PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14"> 20MM </span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:240PX; top:227PX; width:48PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">CEM1</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:280PX; top:227PX; width:59PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="54PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">CEM2</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:464PX; top:227PX; width:56PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="51PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">ADMIX</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:544PX; top:227PX; width:48PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">TOTAL</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:632PX; top:227PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">CUM3</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:144PX; top:91PX; width:64PX; height:16PX; " class="adornment10" >
<table width="59PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" >${rec.NO_OF_CYCLES_VAL0}</td></tr></table>
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
<table width="155PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" >${rec.POURING_DET_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:288PX; top:91PX; width:64PX; height:15PX; " class="adornment10" >
<table width="59PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor16">Vehicle </span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:384PX; top:91PX; width:88PX; height:15PX; " class="adornment10" >
<table width="83PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor17" >${rec.TRUCK_DETAIL_VAL0}</td></tr></table>
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
<table width="155PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" >${rec.MIX_DESIGN_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:408PX; top:227PX; width:56PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="51PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">WATER</span></td></tr></table>
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
<table width="59PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" >${rec.TOTAL_M3_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:352PX; top:227PX; width:48PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor14">CEM3</span></td></tr></table>
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
	${tm.min_time}
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
<table width="187PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" >${rec.CUST_DETAIL_VAL0}</td></tr></table>
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
<table width="57PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" ><fmt:formatNumber value="${rec.batch_size}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:617PX; top:195PX; width:62PX; height:16PX; " class="adornment10" >
<table width="57PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" ><fmt:formatNumber value="${rec.batch_size}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:8PX; top:251PX; width:72PX; height:15PX; " class="adornment10" >
<table width="67PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor14">DESI//M3</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:79PX; top:251PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${mx.AGG1_RCP_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:120PX; top:251PX; width:32PX; height:16PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${mx.AGG2_RCP_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:160PX; top:251PX; width:32PX; height:16PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${mx.AGG3_RCP_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:208PX; top:251PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${mx.AGG4_RCP_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:248PX; top:251PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${mx.CEM1_RCP_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:304PX; top:251PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${mx.CEM2_RCP_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:360PX; top:251PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${mx.CEM3_RCP_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:414PX; top:251PX; width:34PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="29PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT"><fmt:formatNumber value="${mx.WAT_RCP_VAL0}" minFractionDigits="1" maxFractionDigits="2"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:464PX; top:251PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT"><fmt:formatNumber value="${mx.ADD_RCP_VAL0}" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:536PX; top:251PX; width:58PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT"><fmt:formatNumber minFractionDigits="2" value="${mx.ADD_RCP_VAL0+mx.AGG1_RCP_VAL0+mx.AGG2_RCP_VAL0+mx.AGG3_RCP_VAL0+mx.AGG4_RCP_VAL0+mx.CEM1_RCP_VAL0+mx.CEM2_RCP_VAL0+mx.CEM3_RCP_VAL0+mx.WAT_RCP_VAL0}" maxFractionDigits="2" groupingUsed="false"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:8PX; top:275PX; width:56PX; height:15PX; " class="adornment10" >
<table width="51PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph"><span class="fontColor14">L VALUE</span></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:79PX; top:275PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${mx.CALC_SETVALUES_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:120PX; top:275PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${mx.CALC_SETVALUES1_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:160PX; top:275PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${mx.CALC_SETVALUES2_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:208PX; top:275PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${mx.CALC_SETVALUES3_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:256PX; top:275PX; width:32PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${mx.CEME_SET_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:304PX; top:275PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${mx.CEME1_SET_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:360PX; top:275PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${mx.CEME2_SET_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:414PX; top:275PX; width:34PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="29PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${mx.WATER_SET_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:464PX; top:275PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT"><fmt:formatNumber value="${mx.ADD_SET_VAL0}" maxFractionDigits="2"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:536PX; top:275PX; width:58PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="53PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT"><fmt:formatNumber value="${mx.CALC_SETVALUES_VAL0+mx.CALC_SETVALUES2_VAL0+mx.CALC_SETVALUES1_VAL0+mx.CALC_SETVALUES3_VAL0+mx.WATER_SET_VAL0+mx.CEME_SET_VAL0+mx.CEME1_SET_VAL0+mx.CEME2_SET_VAL0+mx.ADD_SET_VAL0}" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:628PX; top:275PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT"><fmt:formatNumber value="${rec.ADD_RCP_VAL0}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:628PX; top:251PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="paragraph" ALIGN="RIGHT"><span class="fontColor19">1.00</span></td></tr></table>
</DIV>



<c:set value="304" var="top1"/>
<!-- Start Line -->
<c:set value="0" var="count"/>
<c:forEach items="${gen.rows}" var="recc">
<c:set value="${count+1}" var="count"/>
<DIV  style="z-index:25; position:absolute; left:80PX; top:${top1}PX; width:27PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="22PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${recc.AGG1_VALUE_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:120PX; top:${top1}PX; width:27PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="22PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${recc.AGG2_VALUE_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:163PX; top:${top1}PX; width:27PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="22PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${recc.AGG3_VALUE_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:205PX; top:${top1}PX; width:27PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="22PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${recc.AGG4_VALUE_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:408PX; top:${top1}PX; width:40PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT"><fmt:formatNumber value="${recc.WTRWT_VAL0}" maxFractionDigits="0"/>.0</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:448PX; top:${top1}PX; width:56PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="51PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT"><fmt:formatNumber value="${recc.ADDWT_VAL0}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:16PX; top:${top1}PX; width:40PX; height:14PX; " class="adornment10" >
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110" >${count}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:544PX; top:${top1}PX; width:48PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT"><fmt:formatNumber value="${recc.AGG1_VALUE_VAL0+recc.AGG2_VALUE_VAL0+recc.AGG3_VALUE_VAL0+recc.AGG4_VALUE_VAL0+recc.WTRWT_VAL0+recc.CEMTWT_VAL0+recc.ADDWT_VAL0+recc.CEME1_SET_VAL0+recc.CEME2_SET_VAL0}" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:240PX; top:${top1}PX; width:48PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT"> ${recc.CEMTWT_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:296PX; top:${top1}PX; width:48PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${recc.CEMTWT1_VAL0}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:632PX; top:${top1}PX; width:40PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT"><fmt:formatNumber value="${rec.ADD_RCP_VAL0}" minFractionDigits="2" maxFractionDigits="2" groupingUsed="false"/></td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:352PX; top:${top1}PX; width:48PX; height:15PX; " class="adornment10"  ALIGN="RIGHT">
<table width="43PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${recc.CEMTWT2_VAL0}</td></tr></table>
</DIV>
<c:set value="${top1+28}" var="top1"/>
</c:forEach>

<!-- End Line -->



 <sql:query var="sum" dataSource="jdbc/rmc">
  		select  sum(AGG1_VALUE_VAL0) as s1,sum(AGG2_VALUE_VAL0)as s2,sum(AGG3_VALUE_VAL0) as s3,sum(AGG4_VALUE_VAL0) as s4,sum(CEME_SET_VAL0) as s5,sum(CEME1_SET_VAL0) as s6,sum(CEME2_SET_VAL0) as s7,sum(WTRWT_VAL0) as s8,round(sum(ADDWT_VAL0),2) as s9
  		from (select DISTINCT * from ved_log where   NO_OF_CYCLES_22_VAL0=?) as t ;
  		<sql:param value="${param.id}"/>
 </sql:query>
 
 <sql:query var="dsum" dataSource="jdbc/rmc">
  		select  CALC_SETVALUES_VAL0*TOTAL_M3_VAL0 as p1,CALC_SETVALUES1_VAL0 * TOTAL_M3_VAL0 as p2,
  		CALC_SETVALUES2_VAL0 * TOTAL_M3_VAL0 as p3,CALC_SETVALUES3_VAL0 * TOTAL_M3_VAL0 as p4,
  		CEME_SET_VAL0 * TOTAL_M3_VAL0 as p5,CEME1_SET_VAL0 * TOTAL_M3_VAL0 as p6,CEME2_SET_VAL0 * TOTAL_M3_VAL0 as p7,
  		WATER_SET_VAL0 * TOTAL_M3_VAL0 as p8,ADD_SET_VAL0 * TOTAL_M3_VAL0 as p9
  	    from ved_log where NO_OF_CYCLES_22_VAL0=? limit 1 ;
  		<sql:param value="${param.id}"/>
 </sql:query>
 
 <c:forEach items="${dsum.rows}" var="dsum">
 	<c:set value="${dsum}" var="psum"/>
 </c:forEach>


 <c:forEach items="${sum.rows}" var="sum">
 	<c:set value="${sum}" var="sumbatch"/>
 </c:forEach>
  
  
 <c:set value="${sumbatch.s1+sumbatch.s2+sumbatch.s3+sumbatch.s4+sumbatch.s5+sumbatch.s6+sumbatch.s7+sumbatch.s8+sumbatch.s9}"  var="total_s"/>
<DIV  style="z-index:25; position:absolute; left:75PX; top:${top1+28}PX; width:32PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${psum.p1}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:160PX; top:${top1+28}PX; width:30PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="25PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${psum.p3}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:200PX; top:${top1+28}PX; width:30PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="25PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${psum.p4}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:115PX; top:${top1+28}PX; width:32PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="27PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${psum.p2}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:240PX; top:${top1+28}PX; width:45PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="40PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${psum.p5}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:408PX; top:${top1+28}PX; width:40PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="35PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${psum.p8}</td></tr></table>
</DIV>

<DIV  style="z-index:25; position:absolute; left:456PX; top:${top1+28}PX; width:52PX; height:14PX; " class="adornment10"  ALIGN="RIGHT">
<table width="47PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT"><fmt:formatNumber value="${psum.p9}" maxFractionDigits="2" minFractionDigits="2"/></td></tr></table>
</DIV>
<c:set value="${psum.p1+psum.p2+psum.p3+psum.p4+psum.p5+psum.p6+psum.p7+psum.p8+psum.p9}"  var="mix_total"/>
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
<table width="40PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor110"  ALIGN="RIGHT">${psum.p6}</td></tr></table>
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
<table width="40PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor13"  ALIGN="RIGHT">${psum.p7}</td></tr></table>
</DIV>

<sql:query var="ress" dataSource="jdbc/rmc">
	select truncate(((${sumbatch.s1}-${psum.p1})/${sumbatch.s1})*100,2) as m1,truncate(((${sumbatch.s2}-${psum.p2})/${sumbatch.s2})*100,2) as m2,truncate(((${sumbatch.s3}-${psum.p3})/${sumbatch.s3})*100,2) as m3,
	truncate(((${sumbatch.s4}-${psum.p4})/${sumbatch.s4})*100,2) as m4,truncate(((${sumbatch.s5}-${psum.p5})/${sumbatch.s5})*100,2) as m5,truncate(((${sumbatch.s6}-${psum.p6})/${sumbatch.s6})*100,2) as m6,
	truncate(((${sumbatch.s7}-${psum.p7})/${sumbatch.s7})*100,2) as m7,truncate(((${sumbatch.s8}-${psum.p8})/${sumbatch.s8})*100,2) as m8,truncate(((${sumbatch.s9}-${psum.p9})/${sumbatch.s9})*100,2) as m9;
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
<table width="74PX" border=0 cellpadding="0" cellspacing="0"><tr><td NOWRAP class="fontColor15" >${tm.max_time}</td></tr></table>
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
</BODY>
</HTML>
 