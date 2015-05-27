(function (angular) {
  'use strict';

  angular
      .module('application', [
        'ngRoute',
        'ngAnimate',
        'ng-token-auth',
        'ui.bootstrap',
        'angularMoment',
        'application.common',
        'application.me',
        'application.users',
        'application.home'
      ]);

}(window.angular));
