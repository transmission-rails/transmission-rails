(function (angular) {
  'use strict';

  angular
      .module('application')
      .config(applicationConfig);

  /* @ngInject */
  function applicationConfig($httpProvider, $routeProvider) {
    $httpProvider.interceptors.push('AuthInterceptor');
    $httpProvider.defaults.headers.common['Accept'] = 'application/json';
    $httpProvider.defaults.headers.common['Content-Type'] = 'application/json';
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = window['CSRF_TOKEN'];

    $routeProvider.otherwise({redirectTo: '/'});
  }

}(window.angular));
