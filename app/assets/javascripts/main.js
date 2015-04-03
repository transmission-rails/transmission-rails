(function () {
  'use strict';

  angular.module('Transmission', ['ngRoute', 'ngAnimate', 'Transmission.MainController', 'Transmission.HomeController'])
    .config(['$routeProvider', '$httpProvider', function ($routeProvider, $httpProvider) {
      $routeProvider
        .when('/', {templateUrl: 'partials/pages/home'})
        .otherwise('/');

      $httpProvider.defaults.headers.common['X-CSRF-Token'] = window.CSRF_TOKEN;
    }]);

}());

