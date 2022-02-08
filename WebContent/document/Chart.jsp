<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<h1>Test Chart</h1>
<div class="col-xs-2 mt-4 mb-4" style="width: 50% ; height: 50%;">
<canvas id="myChart"></canvas>

</div>

<div>
<table id="table1" class="table-border">
<tr>
	<th class="text-center">Item Name</th>
	<th class="text-center">Quantity</th>
	</tr>

</table>
</div>
</body>

  <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script>
var ctx = document.getElementById('myChart').getContext('2d');
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'bar',

    // The data for our dataset
    data: {
        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
        datasets: [{
            label: 'My First dataset',
            backgroundColor: 'rgb(255, 99, 132)',
            borderColor: 'rgb(255, 99, 132)',
            data: [0, 10, -5, 2, 20, 30, 45]
        }]
    },

    // Configuration options go here
    options: {}
});</script>



		<script type="text/javascript">
			$(document).ready(function(){
				console.log("here");
					$.ajax({
						type:'POST',
						url:'InventoryController?action=getStockDetails',
						headers:{
							Accept:"application/json;charset=utf-8",
							"Content-Type":"application/json;charset=utf-8"
						},
						success:function(result){
							$.each(res, function(index, value) {
							$('#table1').append('<tr> '+
							'<td class="text-center" style="width: 25%;">'+
							' ${res.product_Name} '+
						'	</td>'+
						'	<td class="text-center" style="width: 25%;">'+
						'		${res.quantity}'+
						'	</td>'+
						'	</tr>');
			        		
						});
						}
					});
			});
		</script>

</html>