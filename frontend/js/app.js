var app = angular.module("MyApp", ["ngRoute"])

app.config(function($routeProvider){
    $routeProvider
        .when("/",{
            controller: "FirstController",
            templateUrl: "componentes/home.html"
        })
})

app.controller("FirstController", function($scope, $http){
    $scope.links = [];
    $scope.url = '';
    $scope.mensaje = '';

    $http.get('http://localhost:3000/links/')
        .then(res=>{
            console.log(res)
            $scope.links = res.data;
        },function(err){
            console.log(err)
        })

    $scope.postUrl = function(){
        $http.post('http://localhost:3000/links/',{original_url: $scope.url}).then(res=>{
            if(res.data.error === 1){
                $scope.showToast('No se pudo generar el link correctamente, asegurese que tenga el formato http://www.url.com/') 
            } else{
                $scope.showToast('Link generado') 
                $scope.links.push(res.data)
            }
        })
    }

    $scope.deleteUrl = function(id){
        console.log(id)
        $http.delete(`http://localhost:3000/links/${id}`).then(res=>{
            $scope.links = res.data
        })
        $scope.showToast('Link eliminado')
    }

    $scope.copyToClipboard = function(url){
        let link = `http://localhost:3000/links/${url}`

        var aux = document.createElement("input");
        document.body.appendChild(aux);
        aux.setAttribute("id", "aux_id");
        document.getElementById("aux_id").value=link;
        aux.select();
        document.execCommand("copy");
        document.body.removeChild(aux);

        $scope.showToast('Link copiado al clipboard')
    }

    $scope.showToast = function(mensaje){
        $scope.mensaje = mensaje
        var x = document.getElementById("snackbar");
        x.className = "show";
        setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
    }
});