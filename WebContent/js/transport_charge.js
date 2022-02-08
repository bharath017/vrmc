$(document).ready(function(){
	
	
  		$('input[name="start_time"],[name="end_time"]').on('change keyup blur',function(){
  			//console.log("hello world");
  			var start_time=$('input[name="start_time"]').val();
  			var end_time=$('input[name="end_time"]').val();
  			var start_date=new Date(start_time);
  			var end_date=new Date(end_time);
  			$('#start_time_view').text(start_date.toLocaleString());
  			$('#end_time_view').text(end_date.toLocaleString());
  			
  			var timeDiff = Math.abs(start_date.getTime() - end_date.getTime());
  			var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24)); 
  			console.log(diffDays);
  			$('#total_time_view').text(diffDays);
  		});
  		
  		
 });