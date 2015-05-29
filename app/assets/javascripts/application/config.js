(function (angular) {
  'use strict';

  angular
      .module('application')
      .config(applicationConfig)
      .config(configureAuth);

  /* @ngInject */
  function applicationConfig($httpProvider, $routeProvider) {
    $httpProvider.interceptors.push('AuthInterceptor');

    $routeProvider.otherwise({redirectTo: '/'});
  }

  /* @ngInject */
  function configureAuth($authProvider) {
    $authProvider.configure({
      apiUrl: window.location.protocol + '//' + window.location.host
    });
  }

}(window.angular));
