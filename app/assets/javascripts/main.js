(function () {
  'use strict';

  angular.module('Transmission', [
    'ngRoute',
    'ngAnimate',
    'Transmission.Controllers',
    'Transmission.Directives'
  ])
    .config(['$routeProvider', '$httpProvider', function ($routeProvider, $httpProvider) {
      $routeProvider
        .when('/', {templateUrl: 'partials/pages/home', controller: 'HomeController'})
        .when('/login', {templateUrl: 'partials/pages/login', controller: 'LoginController'})
        .otherwise('/');

      $httpProvider.defaults.headers.common['X-CSRF-Token'] = window.CSRF_TOKEN;
    }]);

}());

