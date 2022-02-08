
angular.module("myApp",[])
	   .controller("myController",function($scope,$http,$log,$filter){
		   $(document).ready(function(){
			   var emp_id=$('#employee_id').val();
			    $http({
			   		method:'POST',
			   		url:"EmployeeController?action=GetEmployees&employee_id="+emp_id
			   	}).then(function(response){
			   		$scope.employees=response.data;
			   	},function(response){
			   		console.log("somethisng went wrong");
			   	});
			   	
			    
			    $scope.date=new Date();
			    $scope.date =   $filter('date')($scope.date, 'yyyy-MM-dd');
			    
			    var getDetails=function(){
			    	var e_id=($('#e_id').val()==null || $('#e_id').val()=='')?0:$('#e_id').val();
			    	//alert(e_id);
			    	$http({
			    		method:'post',
			    		url:'AttendanceController?action=GetAttendanceDetails&e_id='+e_id
			    	}).then(function(response){
			    		$scope.attendance=response.data;
			    	});
			    }
			    
			    getDetails();
			    $('#e_id').on('change',function(){
			    	getDetails();
			    }); 

			    
			    
			    $scope.e_id;
			    $scope.counter=0;
			    console.log($scope.e_id);
			    
			    $scope.$watch('e_id',function(){
			    	//alert("hello world");
			    	$scope.counter=$scope.counter+1;
			    	console.log($scope.counter);
			    });
			    
			    
			    
			    
			    
		   });
});