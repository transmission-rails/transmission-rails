(function () {
  'use strict';

  angular.module('Transmission.HomeController', ['partials/pages/home'])
    .controller('HomeController', ['$scope', '$location', function ($scope, $location) {

      if (!$scope.loggedIn) {
        $location.path('/login').replace();
      }

    }]);

}());