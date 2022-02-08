<?xml version="1.0" encoding="utf-8"?>
<%@ page contentType ="text/xml"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



     <jsp:useBean id="now" class="java.util.Date" />
 	 <fmt:formatDate var="month" pattern="MM" value="${now}" />
 	 <fmt:formatDate var="year" pattern="yy" value="${now}" />
 	 <c:set var="start_year">
 	 	<c:choose>
 	 		<c:when test="${month>=4}">
 	 			${year}
 	 		</c:when>
 	 		<c:otherwise>
 	 			${year-1}
 	 		</c:otherwise>
 	 	</c:choose>
 	 </c:set>
 	 <c:set var="end_year">
 	 	<c:choose>
 	 		<c:when test="${month>=4}">
 	 			${year+1}
 	 		</c:when>
 	 		<c:otherwise>
 	 			${year}
 	 		</c:otherwise>
 	 	</c:choose>
 	 </c:set>
 	 
 	<c:set value="${(empty param.plant_id || param.plant_id=='null')?'':param.plant_id}" var="plant_id"/>
	<c:set value="${(empty param.product_id || param.product_id=='null')?'':param.product_id}" var="product_id"/>
	<c:choose>
	<c:when test="${param.report_type=='date'}">
		<sql:query var="inv" dataSource="jdbc/rmc">
			select i.*,c.customer_name,DATE_FORMAT(i.invoice_date,'%Y%m%d') as fake_date,DATE_FORMAT(i.invoice_date,'%d-%b-%Y') as realdate,
			c.customer_address,s.site_name,s.site_address,s.tally_ladger,pr.product_name,pr.product_id,p.plant_name,m.mp_name,
			truncate((i.rate/(100+po.gst_percent))*100,2) as price,po.gst_percent,round(i.tax_amount/2,2) as tx,round(i.net_amount-(i.gross_amount+round(i.tax_amount/2,2)+round(i.tax_amount/2,2)),2) as round
		    from test_invoice i LEFT JOIN (test_customer c,test_site_detail s,test_purchase_order_item poi,product pr,plant p,test_purchase_order po,marketing_person m)
			ON i.customer_id=c.customer_id
			and i.site_id=s.site_id
			and i.poi_id=poi.poi_id
			and poi.order_id=poi.order_id
			and poi.product_id=pr.product_id
			and i.plant_id=p.plant_id
			and poi.order_id=po.order_id
			and po.marketing_person_id=m.mp_id
			where i.invoice_date between ? and ?
			and pr.product_id like if(''=?,'%%',?)
			and i.plant_id like if(''=?,'%%',?)
			and i.invoice_status='active'
			order by id asc
			<sql:param value="${param.from_date}"/>
			<sql:param value="${param.to_date}"/>
			<sql:param value="${product_id}"/>
			<sql:param value="${product_id}"/>
			<sql:param value="${plant_id}"/>
			<sql:param value="${plant_id}"/>
		</sql:query>
	</c:when>
	<c:when test="${param.report_type=='customer'}">
		<sql:query var="inv" dataSource="jdbc/rmc">
			select i.*,c.customer_name,DATE_FORMAT(i.invoice_date,'%Y%m%d') as fake_date,DATE_FORMAT(i.invoice_date,'%d-%b-%Y') as realdate,
			c.customer_address,s.site_name,s.site_address,s.tally_ladger,pr.product_name,pr.product_id,p.plant_name,m.mp_name,
			truncate((i.rate/(100+po.gst_percent))*100,2) as price,po.gst_percent,round(i.tax_amount/2,2) as tx,round(i.net_amount-(i.gross_amount+round(i.tax_amount/2,2)+round(i.tax_amount/2,2)),2) as round
		    from test_invoice i LEFT JOIN (test_customer c,test_site_detail s,test_purchase_order_item poi,product pr,plant p,test_purchase_order po,marketing_person m)
			ON i.customer_id=c.customer_id
			and i.site_id=s.site_id
			and i.poi_id=poi.poi_id
			and poi.order_id=poi.order_id
			and poi.product_id=pr.product_id
			and i.plant_id=p.plant_id
			and poi.order_id=po.order_id
			and po.marketing_person_id=m.mp_id
			where i.customer_id like if(''=?,'%%',?)
			and i.site_id like if(''=?,'%%',?)
			and pr.product_id like if(''=?,'%%',?)
			and i.plant_id like if(''=?,'%%',?)
			and i.invoice_status='active'
			order by id asc
			<sql:param value="${param.customer_id}"/>
			<sql:param value="${param.customer_id}"/>
			<sql:param value="${param.site_id}"/>
			<sql:param value="${param.site_id}"/>
			<sql:param value="${product_id}"/>
			<sql:param value="${product_id}"/>
			<sql:param value="${plant_id}"/>
			<sql:param value="${plant_id}"/>
		</sql:query>
	</c:when>
	
	<c:when test="${param.report_type=='vehicle'}">
		<sql:query var="inv" dataSource="jdbc/rmc">
			select i.*,c.customer_name,DATE_FORMAT(i.invoice_date,'%Y%m%d') as fake_date,DATE_FORMAT(i.invoice_date,'%d-%b-%Y') as realdate,
			c.customer_address,s.site_name,s.site_address,s.tally_ladger,pr.product_name,pr.product_id,p.plant_name,m.mp_name,
			truncate((i.rate/(100+po.gst_percent))*100,2) as price,po.gst_percent,round(i.tax_amount/2,2) as tx,round(i.net_amount-(i.gross_amount+round(i.tax_amount/2,2)+round(i.tax_amount/2,2)),2) as round
		    from test_invoice i LEFT JOIN (test_customer c,test_site_detail s,test_purchase_order_item poi,product pr,plant p,test_purchase_order po,marketing_person m)
			ON i.customer_id=c.customer_id
			and i.site_id=s.site_id
			and i.poi_id=poi.poi_id
			and poi.order_id=poi.order_id
			and poi.product_id=pr.product_id
			and i.plant_id=p.plant_id
			and poi.order_id=po.order_id
			and po.marketing_person_id=m.mp_id
			where i.vehicle_no like if(''=?,'%%',?)
			and pr.product_id like if(''=?,'%%',?)
			and i.plant_id like if(''=?,'%%',?)
			and i.invoice_status='active'
			order by id asc
			<sql:param value="${param.vehicle_no}"/>
			<sql:param value="${param.vehicle_no}"/>
			<sql:param value="${product_id}"/>
			<sql:param value="${product_id}"/>
			<sql:param value="${plant_id}"/>
			<sql:param value="${plant_id}"/>
		</sql:query>
	</c:when>
	
	<c:when test="${param.report_type=='customerdate'}">
		<sql:query var="inv" dataSource="jdbc/rmc">
			select i.*,c.customer_name,DATE_FORMAT(i.invoice_date,'%Y%m%d') as fake_date,DATE_FORMAT(i.invoice_date,'%d-%b-%Y') as realdate,
			c.customer_address,s.site_name,s.site_address,s.tally_ladger,pr.product_name,pr.product_id,p.plant_name,m.mp_name,
			truncate((i.rate/(100+po.gst_percent))*100,2) as price,po.gst_percent,round(i.tax_amount/2,2) as tx,round(i.net_amount-(i.gross_amount+round(i.tax_amount/2,2)+round(i.tax_amount/2,2)),2) as round
		    from test_invoice i LEFT JOIN (test_customer c,test_site_detail s,test_purchase_order_item poi,product pr,plant p,test_purchase_order po,marketing_person m)
			ON i.customer_id=c.customer_id
			and i.site_id=s.site_id
			and i.poi_id=poi.poi_id
			and poi.order_id=poi.order_id
			and poi.product_id=pr.product_id
			and i.plant_id=p.plant_id
			and poi.order_id=po.order_id
			and po.marketing_person_id=m.mp_id
			where i.customer_id like if(''=?,'%%',?)
			and i.site_id like if(''=?,'%%',?)
			and pr.product_id like if(''=?,'%%',?)
			and i.plant_id like if(''=?,'%%',?)
			and i.invoice_date between ? and ?
			and i.invoice_status='active'
			order by id asc
			<sql:param value="${param.customer_id}"/>
			<sql:param value="${param.customer_id}"/>
			<sql:param value="${param.site_id}"/>
			<sql:param value="${param.site_id}"/>
			<sql:param value="${product_id}"/>
			<sql:param value="${product_id}"/>
			<sql:param value="${plant_id}"/>
			<sql:param value="${plant_id}"/>
			<sql:param value="${param.from_date}"/>
			<sql:param value="${param.to_date}"/>
		</sql:query>
	</c:when>
	<c:when test="${report_type=='vehicle_date'}">
		<sql:query var="inv" dataSource="jdbc/rmc">
			select i.*,c.customer_name,DATE_FORMAT(i.invoice_date,'%Y%m%d') as fake_date,DATE_FORMAT(i.invoice_date,'%d-%b-%Y') as realdate,
			s.site_name,s.site_address,s.tally_ladger,pr.product_name,pr.product_id,p.plant_name,m.mp_name,
			truncate((i.rate/(100+po.gst_percent))*100,2) as price,po.gst_percent,round(i.tax_amount/2,2) as tx,round(i.net_amount-(i.gross_amount+round(i.tax_amount/2,2)+round(i.tax_amount/2,2)),2) as round
		    from test_invoice i LEFT JOIN (test_customer c,test_site_detail s,test_purchase_order_item poi,product pr,plant p,test_purchase_order po,marketing_person m)
			ON i.customer_id=c.customer_id
			and i.site_id=s.site_id
			and i.poi_id=poi.poi_id
			and poi.order_id=poi.order_id
			and poi.product_id=pr.product_id
			and i.plant_id=p.plant_id
			and poi.order_id=po.order_id
			and po.marketing_person_id=m.mp_id
			where i.customer_id like if(''=?,'%%',?)
			and i.site_id like if(''=?,'%%',?)
			and pr.product_id like if(''=?,'%%',?)
			and i.plant_id like if(''=?,'%%',?)
			and i.invoice_date between ? and ?
			and i.invoice_status='active'
			order by id asc
		</sql:query>
	</c:when>
</c:choose>
<ENVELOPE>
 <HEADER>
  <TALLYREQUEST>Import Data</TALLYREQUEST>
 </HEADER>
 <BODY>
  <IMPORTDATA>
   <REQUESTDESC>
    <REPORTNAME>Vouchers</REPORTNAME>
    <STATICVARIABLES>
     <SVCURRENTCOMPANY>SAI SURYA CONCRETE -Audit ${start_year}-${end_year}</SVCURRENTCOMPANY>
    </STATICVARIABLES>
   </REQUESTDESC>
   <REQUESTDATA>
   
   <c:forEach items="${inv.rows}" var="result">
    <TALLYMESSAGE xmlns:UDF="TallyUDF">
     <VOUCHER REMOTEID="" VCHKEY="" VCHTYPE="GST SALES" ACTION="Create" OBJVIEW="Invoice Voucher View">
      <ADDRESS.LIST TYPE="String">
      	<c:forTokens items="${result.customer_address}" delims="," var="cusadd">
		   <ADDRESS><![CDATA[${cusadd}]]></ADDRESS>
		</c:forTokens>
      </ADDRESS.LIST>
      <BASICBUYERADDRESS.LIST TYPE="String">
        <c:forTokens items="${result.site_address}" delims="," var="siteadd">
			<BASICBUYERADDRESS><![CDATA[${siteadd}]]></BASICBUYERADDRESS>
		</c:forTokens>
      </BASICBUYERADDRESS.LIST>
      <OLDAUDITENTRYIDS.LIST TYPE="Number">
       <OLDAUDITENTRYIDS>-1</OLDAUDITENTRYIDS>
      </OLDAUDITENTRYIDS.LIST>
      <DATE>${result.fake_date}</DATE>
      <GUID></GUID>
      <STATENAME>Karnataka</STATENAME>
      <PARTYNAME>${result.customer_name}</PARTYNAME>
      <VOUCHERTYPENAME>GST SALES</VOUCHERTYPENAME>
      <REFERENCE>GST/<fmt:formatNumber value="${result.invoice_id}" minIntegerDigits="5" groupingUsed="false"/></REFERENCE>
      <VOUCHERNUMBER>GST/<fmt:formatNumber value="${result.invoice_id}" minIntegerDigits="5" groupingUsed="false"/></VOUCHERNUMBER>
      <PARTYLEDGERNAME>${result.tally_ladger}</PARTYLEDGERNAME>
      <BASICBASEPARTYNAME>${result.customer_name}</BASICBASEPARTYNAME>
      <CSTFORMISSUETYPE/>
      <CSTFORMRECVTYPE/>
      <FBTPAYMENTTYPE>Default</FBTPAYMENTTYPE>
      <PERSISTEDVIEW>Invoice Voucher View</PERSISTEDVIEW>
      <BASICBUYERNAME>${result.customer_name}</BASICBUYERNAME>
      <BASICBUYERSSALESTAXNO>29810761356</BASICBUYERSSALESTAXNO>
      <BASICDATETIMEOFINVOICE>${result.realdate} at ${result.invoice_time}</BASICDATETIMEOFINVOICE>
      <BASICDATETIMEOFREMOVAL>${result.realdate} at ${result.invoice_time}</BASICDATETIMEOFREMOVAL>
      <VCHGSTCLASS/>
      <ENTEREDBY>surya</ENTEREDBY>
      <VOUCHERTYPEORIGNAME>GST SALES</VOUCHERTYPEORIGNAME>
      <DIFFACTUALQTY>No</DIFFACTUALQTY>
      <ISMSTFROMSYNC>No</ISMSTFROMSYNC>
      <ASORIGINAL>No</ASORIGINAL>
      <AUDITED>No</AUDITED>
      <FORJOBCOSTING>No</FORJOBCOSTING>
      <ISOPTIONAL>No</ISOPTIONAL>
      <EFFECTIVEDATE>${result.fake_date}</EFFECTIVEDATE>
      <USEFOREXCISE>No</USEFOREXCISE>
      <ISFORJOBWORKIN>No</ISFORJOBWORKIN>
      <ALLOWCONSUMPTION>No</ALLOWCONSUMPTION>
      <USEFORINTEREST>No</USEFORINTEREST>
      <USEFORGAINLOSS>No</USEFORGAINLOSS>
      <USEFORGODOWNTRANSFER>No</USEFORGODOWNTRANSFER>
      <USEFORCOMPOUND>No</USEFORCOMPOUND>
      <USEFORSERVICETAX>No</USEFORSERVICETAX>
      <ISEXCISEVOUCHER>No</ISEXCISEVOUCHER>
      <EXCISETAXOVERRIDE>No</EXCISETAXOVERRIDE>
      <USEFORTAXUNITTRANSFER>No</USEFORTAXUNITTRANSFER>
      <EXCISEOPENING>No</EXCISEOPENING>
      <USEFORFINALPRODUCTION>No</USEFORFINALPRODUCTION>
      <ISTDSOVERRIDDEN>No</ISTDSOVERRIDDEN>
      <ISTCSOVERRIDDEN>No</ISTCSOVERRIDDEN>
      <ISTDSTCSCASHVCH>No</ISTDSTCSCASHVCH>
      <INCLUDEADVPYMTVCH>No</INCLUDEADVPYMTVCH>
      <ISSUBWORKSCONTRACT>No</ISSUBWORKSCONTRACT>
      <ISVATOVERRIDDEN>No</ISVATOVERRIDDEN>
      <IGNOREORIGVCHDATE>No</IGNOREORIGVCHDATE>
      <ISVATPAIDATCUSTOMS>No</ISVATPAIDATCUSTOMS>
      <ISDECLAREDTOCUSTOMS>No</ISDECLAREDTOCUSTOMS>
      <ISSERVICETAXOVERRIDDEN>No</ISSERVICETAXOVERRIDDEN>
      <ISISDVOUCHER>No</ISISDVOUCHER>
      <ISEXCISEOVERRIDDEN>No</ISEXCISEOVERRIDDEN>
      <ISEXCISESUPPLYVCH>No</ISEXCISESUPPLYVCH>
      <ISGSTOVERRIDDEN>No</ISGSTOVERRIDDEN>
      <GSTNOTEXPORTED>No</GSTNOTEXPORTED>
      <ISVATPRINCIPALACCOUNT>No</ISVATPRINCIPALACCOUNT>
      <ISBOENOTAPPLICABLE>No</ISBOENOTAPPLICABLE>
      <ISSHIPPINGWITHINSTATE>No</ISSHIPPINGWITHINSTATE>
      <ISOVERSEASTOURISTTRANS>No</ISOVERSEASTOURISTTRANS>
      <ISCANCELLED>No</ISCANCELLED>
      <HASCASHFLOW>No</HASCASHFLOW>
      <ISPOSTDATED>No</ISPOSTDATED>
      <USETRACKINGNUMBER>No</USETRACKINGNUMBER>
      <ISINVOICE>Yes</ISINVOICE>
      <MFGJOURNAL>No</MFGJOURNAL>
      <HASDISCOUNTS>No</HASDISCOUNTS>
      <ASPAYSLIP>No</ASPAYSLIP>
      <ISCOSTCENTRE>No</ISCOSTCENTRE>
      <ISSTXNONREALIZEDVCH>No</ISSTXNONREALIZEDVCH>
      <ISEXCISEMANUFACTURERON>No</ISEXCISEMANUFACTURERON>
      <ISBLANKCHEQUE>No</ISBLANKCHEQUE>
      <ISVOID>No</ISVOID>
      <ISONHOLD>No</ISONHOLD>
      <ORDERLINESTATUS>No</ORDERLINESTATUS>
      <VATISAGNSTCANCSALES>No</VATISAGNSTCANCSALES>
      <VATISPURCEXEMPTED>No</VATISPURCEXEMPTED>
      <ISVATRESTAXINVOICE>No</ISVATRESTAXINVOICE>
      <VATISASSESABLECALCVCH>No</VATISASSESABLECALCVCH>
      <ISVATDUTYPAID>Yes</ISVATDUTYPAID>
      <ISDELIVERYSAMEASCONSIGNEE>No</ISDELIVERYSAMEASCONSIGNEE>
      <ISDISPATCHSAMEASCONSIGNOR>No</ISDISPATCHSAMEASCONSIGNOR>
      <ISDELETED>No</ISDELETED>
      <CHANGEVCHMODE>No</CHANGEVCHMODE>
      <EXCLUDEDTAXATIONS.LIST>      </EXCLUDEDTAXATIONS.LIST>
      <OLDAUDITENTRIES.LIST>      </OLDAUDITENTRIES.LIST>
      <ACCOUNTAUDITENTRIES.LIST>      </ACCOUNTAUDITENTRIES.LIST>
      <AUDITENTRIES.LIST>      </AUDITENTRIES.LIST>
      <DUTYHEADDETAILS.LIST>      </DUTYHEADDETAILS.LIST>
      <SUPPLEMENTARYDUTYHEADDETAILS.LIST>      </SUPPLEMENTARYDUTYHEADDETAILS.LIST>
      <EWAYBILLDETAILS.LIST>      </EWAYBILLDETAILS.LIST>
      <INVOICEDELNOTES.LIST>      </INVOICEDELNOTES.LIST>
      <INVOICEORDERLIST.LIST>      </INVOICEORDERLIST.LIST>
      <INVOICEINDENTLIST.LIST>      </INVOICEINDENTLIST.LIST>
      <ATTENDANCEENTRIES.LIST>      </ATTENDANCEENTRIES.LIST>
      <ORIGINVOICEDETAILS.LIST>      </ORIGINVOICEDETAILS.LIST>
      <INVOICEEXPORTLIST.LIST>      </INVOICEEXPORTLIST.LIST>
      <LEDGERENTRIES.LIST>
       <OLDAUDITENTRYIDS.LIST TYPE="Number">
        <OLDAUDITENTRYIDS>-1</OLDAUDITENTRYIDS>
       </OLDAUDITENTRYIDS.LIST>
       <LEDGERNAME>${result.tally_ladger}</LEDGERNAME>
       <GSTCLASS/>
       <ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>
       <LEDGERFROMITEM>No</LEDGERFROMITEM>
       <REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>
       <ISPARTYLEDGER>Yes</ISPARTYLEDGER>
       <ISLASTDEEMEDPOSITIVE>Yes</ISLASTDEEMEDPOSITIVE>
       <ISCAPVATTAXALTERED>No</ISCAPVATTAXALTERED>
       <AMOUNT>-${result.net_amount}</AMOUNT>
       <SERVICETAXDETAILS.LIST>       </SERVICETAXDETAILS.LIST>
       <BANKALLOCATIONS.LIST>       </BANKALLOCATIONS.LIST>
       <BILLALLOCATIONS.LIST>
        <NAME>GST/<fmt:formatNumber value="${result.invoice_id}" minIntegerDigits="5" groupingUsed="false"/></NAME>
        <BILLTYPE>New Ref</BILLTYPE>
        <TDSDEDUCTEEISSPECIALRATE>No</TDSDEDUCTEEISSPECIALRATE>
        <AMOUNT>-${result.net_amount}</AMOUNT>
        <INTERESTCOLLECTION.LIST>        </INTERESTCOLLECTION.LIST>
        <STBILLCATEGORIES.LIST>        </STBILLCATEGORIES.LIST>
       </BILLALLOCATIONS.LIST>
       <INTERESTCOLLECTION.LIST>       </INTERESTCOLLECTION.LIST>
       <OLDAUDITENTRIES.LIST>       </OLDAUDITENTRIES.LIST>
       <ACCOUNTAUDITENTRIES.LIST>       </ACCOUNTAUDITENTRIES.LIST>
       <AUDITENTRIES.LIST>       </AUDITENTRIES.LIST>
       <INPUTCRALLOCS.LIST>       </INPUTCRALLOCS.LIST>
       <DUTYHEADDETAILS.LIST>       </DUTYHEADDETAILS.LIST>
       <EXCISEDUTYHEADDETAILS.LIST>       </EXCISEDUTYHEADDETAILS.LIST>
       <RATEDETAILS.LIST>       </RATEDETAILS.LIST>
       <SUMMARYALLOCS.LIST>       </SUMMARYALLOCS.LIST>
       <STPYMTDETAILS.LIST>       </STPYMTDETAILS.LIST>
       <EXCISEPAYMENTALLOCATIONS.LIST>       </EXCISEPAYMENTALLOCATIONS.LIST>
       <TAXBILLALLOCATIONS.LIST>       </TAXBILLALLOCATIONS.LIST>
       <TAXOBJECTALLOCATIONS.LIST>       </TAXOBJECTALLOCATIONS.LIST>
       <TDSEXPENSEALLOCATIONS.LIST>       </TDSEXPENSEALLOCATIONS.LIST>
       <VATSTATUTORYDETAILS.LIST>       </VATSTATUTORYDETAILS.LIST>
       <COSTTRACKALLOCATIONS.LIST>       </COSTTRACKALLOCATIONS.LIST>
       <REFVOUCHERDETAILS.LIST>       </REFVOUCHERDETAILS.LIST>
       <INVOICEWISEDETAILS.LIST>       </INVOICEWISEDETAILS.LIST>
       <VATITCDETAILS.LIST>       </VATITCDETAILS.LIST>
       <ADVANCETAXDETAILS.LIST>       </ADVANCETAXDETAILS.LIST>
      </LEDGERENTRIES.LIST>
      <LEDGERENTRIES.LIST>
       <OLDAUDITENTRYIDS.LIST TYPE="Number">
        <OLDAUDITENTRYIDS>-1</OLDAUDITENTRYIDS>
       </OLDAUDITENTRYIDS.LIST>
       <LEDGERNAME>SGST TAX</LEDGERNAME>
       <GSTCLASS/>
       <ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>
       <LEDGERFROMITEM>No</LEDGERFROMITEM>
       <REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>
       <ISPARTYLEDGER>No</ISPARTYLEDGER>
       <ISLASTDEEMEDPOSITIVE>No</ISLASTDEEMEDPOSITIVE>
       <ISCAPVATTAXALTERED>No</ISCAPVATTAXALTERED>
       <AMOUNT>${result.tx}</AMOUNT>
       <VATEXPAMOUNT>${result.tx}</VATEXPAMOUNT>
       <SERVICETAXDETAILS.LIST>       </SERVICETAXDETAILS.LIST>
       <BANKALLOCATIONS.LIST>       </BANKALLOCATIONS.LIST>
       <BILLALLOCATIONS.LIST>       </BILLALLOCATIONS.LIST>
       <INTERESTCOLLECTION.LIST>       </INTERESTCOLLECTION.LIST>
       <OLDAUDITENTRIES.LIST>       </OLDAUDITENTRIES.LIST>
       <ACCOUNTAUDITENTRIES.LIST>       </ACCOUNTAUDITENTRIES.LIST>
       <AUDITENTRIES.LIST>       </AUDITENTRIES.LIST>
       <INPUTCRALLOCS.LIST>       </INPUTCRALLOCS.LIST>
       <DUTYHEADDETAILS.LIST>       </DUTYHEADDETAILS.LIST>
       <EXCISEDUTYHEADDETAILS.LIST>       </EXCISEDUTYHEADDETAILS.LIST>
       <RATEDETAILS.LIST>       </RATEDETAILS.LIST>
       <SUMMARYALLOCS.LIST>       </SUMMARYALLOCS.LIST>
       <STPYMTDETAILS.LIST>       </STPYMTDETAILS.LIST>
       <EXCISEPAYMENTALLOCATIONS.LIST>       </EXCISEPAYMENTALLOCATIONS.LIST>
       <TAXBILLALLOCATIONS.LIST>       </TAXBILLALLOCATIONS.LIST>
       <TAXOBJECTALLOCATIONS.LIST>       </TAXOBJECTALLOCATIONS.LIST>
       <TDSEXPENSEALLOCATIONS.LIST>       </TDSEXPENSEALLOCATIONS.LIST>
       <VATSTATUTORYDETAILS.LIST>       </VATSTATUTORYDETAILS.LIST>
       <COSTTRACKALLOCATIONS.LIST>       </COSTTRACKALLOCATIONS.LIST>
       <REFVOUCHERDETAILS.LIST>       </REFVOUCHERDETAILS.LIST>
       <INVOICEWISEDETAILS.LIST>       </INVOICEWISEDETAILS.LIST>
       <VATITCDETAILS.LIST>       </VATITCDETAILS.LIST>
       <ADVANCETAXDETAILS.LIST>       </ADVANCETAXDETAILS.LIST>
      </LEDGERENTRIES.LIST>
      <LEDGERENTRIES.LIST>
       <OLDAUDITENTRYIDS.LIST TYPE="Number">
        <OLDAUDITENTRYIDS>-1</OLDAUDITENTRYIDS>
       </OLDAUDITENTRYIDS.LIST>
       <LEDGERNAME>CGST TAX</LEDGERNAME>
       <GSTCLASS/>
       <ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>
       <LEDGERFROMITEM>No</LEDGERFROMITEM>
       <REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>
       <ISPARTYLEDGER>No</ISPARTYLEDGER>
       <ISLASTDEEMEDPOSITIVE>No</ISLASTDEEMEDPOSITIVE>
       <ISCAPVATTAXALTERED>No</ISCAPVATTAXALTERED>
       <AMOUNT>${result.tx}</AMOUNT>
       <VATEXPAMOUNT>${result.tx}</VATEXPAMOUNT>
       <SERVICETAXDETAILS.LIST>       </SERVICETAXDETAILS.LIST>
       <BANKALLOCATIONS.LIST>       </BANKALLOCATIONS.LIST>
       <BILLALLOCATIONS.LIST>       </BILLALLOCATIONS.LIST>
       <INTERESTCOLLECTION.LIST>       </INTERESTCOLLECTION.LIST>
       <OLDAUDITENTRIES.LIST>       </OLDAUDITENTRIES.LIST>
       <ACCOUNTAUDITENTRIES.LIST>       </ACCOUNTAUDITENTRIES.LIST>
       <AUDITENTRIES.LIST>       </AUDITENTRIES.LIST>
       <INPUTCRALLOCS.LIST>       </INPUTCRALLOCS.LIST>
       <DUTYHEADDETAILS.LIST>       </DUTYHEADDETAILS.LIST>
       <EXCISEDUTYHEADDETAILS.LIST>       </EXCISEDUTYHEADDETAILS.LIST>
       <RATEDETAILS.LIST>       </RATEDETAILS.LIST>
       <SUMMARYALLOCS.LIST>       </SUMMARYALLOCS.LIST>
       <STPYMTDETAILS.LIST>       </STPYMTDETAILS.LIST>
       <EXCISEPAYMENTALLOCATIONS.LIST>       </EXCISEPAYMENTALLOCATIONS.LIST>
       <TAXBILLALLOCATIONS.LIST>       </TAXBILLALLOCATIONS.LIST>
       <TAXOBJECTALLOCATIONS.LIST>       </TAXOBJECTALLOCATIONS.LIST>
       <TDSEXPENSEALLOCATIONS.LIST>       </TDSEXPENSEALLOCATIONS.LIST>
       <VATSTATUTORYDETAILS.LIST>       </VATSTATUTORYDETAILS.LIST>
       <COSTTRACKALLOCATIONS.LIST>       </COSTTRACKALLOCATIONS.LIST>
       <REFVOUCHERDETAILS.LIST>       </REFVOUCHERDETAILS.LIST>
       <INVOICEWISEDETAILS.LIST>       </INVOICEWISEDETAILS.LIST>
       <VATITCDETAILS.LIST>       </VATITCDETAILS.LIST>
       <ADVANCETAXDETAILS.LIST>       </ADVANCETAXDETAILS.LIST>
      </LEDGERENTRIES.LIST>
      <LEDGERENTRIES.LIST>
       <OLDAUDITENTRYIDS.LIST TYPE="Number">
        <OLDAUDITENTRYIDS>-1</OLDAUDITENTRYIDS>
       </OLDAUDITENTRYIDS.LIST>
       <LEDGERNAME>Round Off</LEDGERNAME>
       <GSTCLASS/>
       <ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>
       <LEDGERFROMITEM>No</LEDGERFROMITEM>
       <REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>
       <ISPARTYLEDGER>No</ISPARTYLEDGER>
       <ISLASTDEEMEDPOSITIVE>No</ISLASTDEEMEDPOSITIVE>
       <ISCAPVATTAXALTERED>No</ISCAPVATTAXALTERED>
       <AMOUNT>${result.round}</AMOUNT>
       <VATEXPAMOUNT>${result.round}</VATEXPAMOUNT>
       <SERVICETAXDETAILS.LIST>       </SERVICETAXDETAILS.LIST>
       <BANKALLOCATIONS.LIST>       </BANKALLOCATIONS.LIST>
       <BILLALLOCATIONS.LIST>       </BILLALLOCATIONS.LIST>
       <INTERESTCOLLECTION.LIST>       </INTERESTCOLLECTION.LIST>
       <OLDAUDITENTRIES.LIST>       </OLDAUDITENTRIES.LIST>
       <ACCOUNTAUDITENTRIES.LIST>       </ACCOUNTAUDITENTRIES.LIST>
       <AUDITENTRIES.LIST>       </AUDITENTRIES.LIST>
       <INPUTCRALLOCS.LIST>       </INPUTCRALLOCS.LIST>
       <DUTYHEADDETAILS.LIST>       </DUTYHEADDETAILS.LIST>
       <EXCISEDUTYHEADDETAILS.LIST>       </EXCISEDUTYHEADDETAILS.LIST>
       <RATEDETAILS.LIST>       </RATEDETAILS.LIST>
       <SUMMARYALLOCS.LIST>       </SUMMARYALLOCS.LIST>
       <STPYMTDETAILS.LIST>       </STPYMTDETAILS.LIST>
       <EXCISEPAYMENTALLOCATIONS.LIST>       </EXCISEPAYMENTALLOCATIONS.LIST>
       <TAXBILLALLOCATIONS.LIST>       </TAXBILLALLOCATIONS.LIST>
       <TAXOBJECTALLOCATIONS.LIST>       </TAXOBJECTALLOCATIONS.LIST>
       <TDSEXPENSEALLOCATIONS.LIST>       </TDSEXPENSEALLOCATIONS.LIST>
       <VATSTATUTORYDETAILS.LIST>       </VATSTATUTORYDETAILS.LIST>
       <COSTTRACKALLOCATIONS.LIST>       </COSTTRACKALLOCATIONS.LIST>
       <REFVOUCHERDETAILS.LIST>       </REFVOUCHERDETAILS.LIST>
       <INVOICEWISEDETAILS.LIST>       </INVOICEWISEDETAILS.LIST>
       <VATITCDETAILS.LIST>       </VATITCDETAILS.LIST>
       <ADVANCETAXDETAILS.LIST>       </ADVANCETAXDETAILS.LIST>
      </LEDGERENTRIES.LIST>
      <ALLINVENTORYENTRIES.LIST>
       <STOCKITEMNAME>${result.product_name}</STOCKITEMNAME>
       <ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>
       <ISLASTDEEMEDPOSITIVE>No</ISLASTDEEMEDPOSITIVE>
       <ISAUTONEGATE>No</ISAUTONEGATE>
       <ISCUSTOMSCLEARANCE>No</ISCUSTOMSCLEARANCE>
       <ISTRACKCOMPONENT>No</ISTRACKCOMPONENT>
       <ISTRACKPRODUCTION>No</ISTRACKPRODUCTION>
       <ISPRIMARYITEM>No</ISPRIMARYITEM>
       <ISSCRAP>No</ISSCRAP>
       <RATE>${result.price}/Cum&apos;s</RATE>
       <AMOUNT><fmt:formatNumber value="${result.gross_amount}" maxFractionDigits="2" groupingUsed="false"/></AMOUNT>
       <ACTUALQTY> ${result.quantity} Cum&apos;s</ACTUALQTY>
       <BILLEDQTY> ${result.quantity} Cum&apos;s</BILLEDQTY>
       <BATCHALLOCATIONS.LIST>
        <GODOWNNAME>Main Location</GODOWNNAME>
        <BATCHNAME>Primary Batch</BATCHNAME>
        <DESTINATIONGODOWNNAME>Main Location</DESTINATIONGODOWNNAME>
        <INDENTNO/>
        <ORDERNO/>
        <TRACKINGNUMBER/>
        <DYNAMICCSTISCLEARED>No</DYNAMICCSTISCLEARED>
        <AMOUNT><fmt:formatNumber value="${result.gross_amount}" maxFractionDigits="2" groupingUsed="false"/></AMOUNT>
        <ACTUALQTY> ${result.quantity} Cum&apos;s</ACTUALQTY>
        <BILLEDQTY> ${result.quantity} Cum&apos;s</BILLEDQTY>
        <ADDITIONALDETAILS.LIST>        </ADDITIONALDETAILS.LIST>
        <VOUCHERCOMPONENTLIST.LIST>        </VOUCHERCOMPONENTLIST.LIST>
       </BATCHALLOCATIONS.LIST>
       <ACCOUNTINGALLOCATIONS.LIST>
        <OLDAUDITENTRYIDS.LIST TYPE="Number">
         <OLDAUDITENTRYIDS>-1</OLDAUDITENTRYIDS>
        </OLDAUDITENTRYIDS.LIST>
        <LEDGERNAME>GST SALES @18%</LEDGERNAME>
        <GSTCLASS/>
        <ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>
        <LEDGERFROMITEM>No</LEDGERFROMITEM>
        <REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>
        <ISPARTYLEDGER>No</ISPARTYLEDGER>
        <ISLASTDEEMEDPOSITIVE>No</ISLASTDEEMEDPOSITIVE>
        <ISCAPVATTAXALTERED>No</ISCAPVATTAXALTERED>
        <AMOUNT><fmt:formatNumber value="${result.gross_amount}" maxFractionDigits="2" groupingUsed="false"/></AMOUNT>
        <SERVICETAXDETAILS.LIST>        </SERVICETAXDETAILS.LIST>
        <BANKALLOCATIONS.LIST>        </BANKALLOCATIONS.LIST>
        <BILLALLOCATIONS.LIST>        </BILLALLOCATIONS.LIST>
        <INTERESTCOLLECTION.LIST>        </INTERESTCOLLECTION.LIST>
        <OLDAUDITENTRIES.LIST>        </OLDAUDITENTRIES.LIST>
        <ACCOUNTAUDITENTRIES.LIST>        </ACCOUNTAUDITENTRIES.LIST>
        <AUDITENTRIES.LIST>        </AUDITENTRIES.LIST>
        <INPUTCRALLOCS.LIST>        </INPUTCRALLOCS.LIST>
        <DUTYHEADDETAILS.LIST>        </DUTYHEADDETAILS.LIST>
        <EXCISEDUTYHEADDETAILS.LIST>        </EXCISEDUTYHEADDETAILS.LIST>
        <RATEDETAILS.LIST>        </RATEDETAILS.LIST>
        <SUMMARYALLOCS.LIST>        </SUMMARYALLOCS.LIST>
        <STPYMTDETAILS.LIST>        </STPYMTDETAILS.LIST>
        <EXCISEPAYMENTALLOCATIONS.LIST>        </EXCISEPAYMENTALLOCATIONS.LIST>
        <TAXBILLALLOCATIONS.LIST>        </TAXBILLALLOCATIONS.LIST>
        <TAXOBJECTALLOCATIONS.LIST>        </TAXOBJECTALLOCATIONS.LIST>
        <TDSEXPENSEALLOCATIONS.LIST>        </TDSEXPENSEALLOCATIONS.LIST>
        <VATSTATUTORYDETAILS.LIST>        </VATSTATUTORYDETAILS.LIST>
        <COSTTRACKALLOCATIONS.LIST>        </COSTTRACKALLOCATIONS.LIST>
        <REFVOUCHERDETAILS.LIST>        </REFVOUCHERDETAILS.LIST>
        <INVOICEWISEDETAILS.LIST>        </INVOICEWISEDETAILS.LIST>
        <VATITCDETAILS.LIST>        </VATITCDETAILS.LIST>
        <ADVANCETAXDETAILS.LIST>        </ADVANCETAXDETAILS.LIST>
       </ACCOUNTINGALLOCATIONS.LIST>
       <DUTYHEADDETAILS.LIST>       </DUTYHEADDETAILS.LIST>
       <SUPPLEMENTARYDUTYHEADDETAILS.LIST>       </SUPPLEMENTARYDUTYHEADDETAILS.LIST>
       <TAXOBJECTALLOCATIONS.LIST>       </TAXOBJECTALLOCATIONS.LIST>
       <REFVOUCHERDETAILS.LIST>       </REFVOUCHERDETAILS.LIST>
       <EXCISEALLOCATIONS.LIST>       </EXCISEALLOCATIONS.LIST>
       <EXPENSEALLOCATIONS.LIST>       </EXPENSEALLOCATIONS.LIST>
      </ALLINVENTORYENTRIES.LIST>
      <PAYROLLMODEOFPAYMENT.LIST>      </PAYROLLMODEOFPAYMENT.LIST>
      <ATTDRECORDS.LIST>      </ATTDRECORDS.LIST>
      <GSTEWAYCONSIGNORADDRESS.LIST>      </GSTEWAYCONSIGNORADDRESS.LIST>
      <GSTEWAYCONSIGNEEADDRESS.LIST>      </GSTEWAYCONSIGNEEADDRESS.LIST>
      <TEMPGSTRATEDETAILS.LIST>      </TEMPGSTRATEDETAILS.LIST>
      <UDF:TRADERCONSVATTINNO.LIST DESC="`TraderConsVATTINNo`" ISLIST="YES" TYPE="String" INDEX="10015">
       <UDF:TRADERCONSVATTINNO DESC="`TraderConsVATTINNo`">29810761356</UDF:TRADERCONSVATTINNO>
      </UDF:TRADERCONSVATTINNO.LIST>
      <UDF:VATDEALERNATURE.LIST DESC="`VATDealerNature`" ISLIST="YES" TYPE="String" INDEX="10031">
       <UDF:VATDEALERNATURE DESC="`VATDealerNature`">Registered Dealer</UDF:VATDEALERNATURE>
      </UDF:VATDEALERNATURE.LIST>
     </VOUCHER>
    </TALLYMESSAGE>
    </c:forEach>
    <TALLYMESSAGE xmlns:UDF="TallyUDF">
     <COMPANY>
      <REMOTECMPINFO.LIST MERGE="Yes">
       <NAME></NAME>
       <REMOTECMPNAME>SAI SURYA CONCRETE -Audit ${start_year}-${end_year}</REMOTECMPNAME>
       <REMOTECMPSTATE>Karnataka</REMOTECMPSTATE>
      </REMOTECMPINFO.LIST>
     </COMPANY>
    </TALLYMESSAGE>
    <TALLYMESSAGE xmlns:UDF="TallyUDF">
     <COMPANY>
      <REMOTECMPINFO.LIST MERGE="Yes">
       <NAME></NAME>
       <REMOTECMPNAME>SAI SURYA CONCRETE -Audit ${start_year}-${end_year}</REMOTECMPNAME>
       <REMOTECMPSTATE>Karnataka</REMOTECMPSTATE>
      </REMOTECMPINFO.LIST>
     </COMPANY>
    </TALLYMESSAGE>
   </REQUESTDATA>
  </IMPORTDATA>
 </BODY>
</ENVELOPE>
