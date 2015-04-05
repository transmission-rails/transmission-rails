(function () {
  'use strict';

  angular.module('Transmission.LoginController', ['partials/pages/login'])
    .controller('LoginController', ['$scope', '$http', '$location', function ($scope, $http, $location) {

      if ($scope.loggedIn) {
        $location.path('/').replace();
      }

      $scope.login = function () {
        var basicAuth = btoa($scope.username + ':' + $scope.password);
        $http.post('/login', {}, {headers: {'Authorization': 'Basic ' + basicAuth}})
          .success(function () {
            $scope.$parent.loggedIn = true;
            $location.path('/').replace();
          })
          .error(function () {
            $scope.error = true;
          });
      };

    }]);

}());