(function (angular) {
  'use strict';

  angular
      .module('application.common')
      .constant('APP_CONSTANTS', {
        APP_NAME: 'Transmission Rails',
        APP_VERSION: 'v0.0.1'
      })
      .constant('API_CONSTANTS', {
        SESSION_BASE: '/session',
        ME_BASE: '/api/v1/me'
      })

}(window.angular));
