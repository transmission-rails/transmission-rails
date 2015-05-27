(function (angular) {
  'use strict';

  angular
      .module('application.common')
      .factory('AuthInterceptor', AuthInterceptor)
      .factory('Session', Session)
      .factory('Store', Store);

  /* @ngInject */
  function AuthInterceptor($q, $location) {
    return {
      responseError: function (response) {
        $location.path('/users/login');
        return $q.reject(response);
      }
    };
  }

  /* @ngInject */
  function Session($http, $location, API_CONSTANTS) {
    return {
      login: function (username, password) {
        return $http({
          method: 'POST',
          url: API_CONSTANTS.SESSION_BASE + '/login',
          data: {
            username: username,
            password: password
          }
        })
      },

      logout: function () {
        $http({
          method: 'GET',
          url: API_CONSTANTS.SESSION_BASE + '/logout'
        }).then(function () {
          $location.path('/users/login');
        });
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
