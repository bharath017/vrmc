$('document').ready(function(){
	
	
	 $('.select2').css('width','100%').select2({allowClear:true})
		.on('change', function(){
		}); 
  
  
  $('.date-picker').datepicker({
			autoclose: true,
			todayHighlight: true,
			"orientation":"bottom left"
	 });
		
  
  $("#id-date-picker-1").datepicker();
		$('#id-date-picker-1').datepicker({
		        "autoclose": true,
		        "orientation":"bottom left"
	});
		
	/*TIME PICKER START'S HERE*/
	$('#timepicker1').timepicker({
		minuteStep: 1,
		showSeconds: true,
		showMeridian: false,
		disableFocus: true,
		icons: {
			up: 'fa fa-chevron-up',
			down: 'fa fa-chevron-down'
		}
	}).on('focus', function() {
		$('#timepicker1').timepicker('showWidget');
	}).next().on(ace.click_event, function(){
		$(this).prev().focus();
	});

	
	
	var a,b,c,d,e,f,g,h,i,j,k,l;
	
	
	$('#a').on('click keyup', function(){
		a=$('#a').val();
		b=parseInt(a)+1;
	$('#b').val(b);
	});
	$('#c').on('click keyup', function(){
		c=$('#c').val();
		d=parseInt(c)+1;
	$('#d').val(d);
	});
	$('#e').on('click keyup', function(){
		e=$('#e').val();
		f=parseInt(e)+1;
	$('#f').val(f);
	});
	$('#g').on('click keyup', function(){
		g=$('#g').val();
		h=parseInt(g)+1;
	$('#h').val(h);
	});
	$('#i').on('click keyup', function(){
		var i=$('#i').val();
		j=parseInt(i)+1;
	$('#j').val(j);
	});
	$('#k').on('click keyup', function(){
		k=$('#k').val();
		l=parseInt(k)+1;
	$('#l').val(l);
	});
	$('input').on('click keyup', function(){
		$('.hide').show();
		getCreditReport();
	});
	var list=[];
	var getCreditReport=function(){
		var x=1;
		$('input').each(function(){
			var x=$(this).attr('id');
			var y=$(this).val();
			list.push(y);
		})
		
	}
	$('#creditReportDate').on('click', function(){
		var a=$('#a').val();
		a=parseInt(a);
		var b=$('#b').val();
		b=parseInt(b);
		var c=$('#c').val();
		c=parseInt(c);
		var d=$('#d').val();
		d=parseInt(d);
		var e=$('#e').val();
		e=parseInt(e);
		var f=$('#f').val();
		f=parseInt(f);
		var g=$('#g').val();
		a=parseInt(a);
		var h=$('#h').val();
		h=parseInt(h);
		var j=$('#j').val();
		j=parseInt(j);
		var k=$('#k').val();
		k=parseInt(k);
		var l=$('#l').val();
		l=parseInt(l);
		var i=$('#i').val();
		i=parseInt(i);
		var date=$('#id-date-picker-2').val();
		var customer_id=$('#param_custo').val();
		console.log(customer_id);
		window.location="CreditReport.jsp?action=generateReport&report_type=cusgbmd&a="+a+"&b="+b+"&c="+c+"&d="+d+"&e="+e+"&f="+f+"&g="+g+"&h="+h+"&i="+i+"&j="+j+"&k="+k+"&l="+l+"&customer_id="+customer_id+"&date="+date;
	});
});