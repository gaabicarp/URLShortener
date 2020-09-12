var app = angular.module("MyApp", []);
app.controller("FirstController", function($scope, $http){
    $scope.links = []
    $scope.url = '';

    $http.get('http://localhost:3000/links/')
        .then(function(data){
            console.log(data)
            $scope.links = data.data;
        },function(err){
            console.log(err)
        })

    $scope.postUrl = function(){
        $http.post('http://localhost:3000/links/',{original_url: $scope.url}).then(res=>{
            res.data.error === 1 ? alert('No se pudo generar el link correctamente, asegurese que tenga el formato http://www.url.com/') : $scope.links.push(res.data)
        })
    }

    $scope.deleteUrl = function(id){
        console.log(id)
        $http.delete('http://localhost:3000/links', id).then(res=>{
            console.log(res);
        })
    }
});

//

//ng-click="postUrl"

//ng-model="url"

//ng-controller="FirstController"