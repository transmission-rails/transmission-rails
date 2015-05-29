(function (angular) {
  'use strict';

  angular
      .module('application.common')
      .factory('AuthInterceptor', AuthInterceptor)
      .factory('Store', Store);

  /* @ngInject */
  function AuthInterceptor($injector) {
    return {
      request: function (config) {
        if (config.url.indexOf('/api/v1') > -1) {
          $injector.invoke(['$auth', function ($auth) {
            config.headers = $auth.retrieveData('auth_headers') || {};

            config.headers['Accept'] = 'application/json';
            config.headers['Content-Type'] = 'application/json';
            config.headers['X-CSRF-Token'] = window['CSRF_TOKEN'];
          }]);
        }

        return config;
      }
    };
  }

  /* @ngInject */
  function Store() {
    return {
      get: function (name) {
        return JSON.parse(atob(localStorage[name]));
      },

      set: function (name, value) {
        if (value) {
          localStorage[name] = btoa(JSON.stringify(value));
        }
      },

      has: function (name) {
        return !!localStorage[name];
      },

      empty: function (name) {
        delete localStorage[name];
      }
    };
  }

}(window.angular));
