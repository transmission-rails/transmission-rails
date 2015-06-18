(function (angular) {
  'use strict';

  angular
      .module('application.me')
      .factory('Me', Me);

  /* @ngInject */
  function Me($http, API_CONSTANTS) {
    return {
      index: function () {
        return $http({
          method: 'GET',
          url: API_CONSTANTS.ME_BASE
        });
      },

      update: function (data) {
        return $http({
          method: 'PUT',
          url: API_CONSTANTS.ME_BASE,
          data: data
        });
      },

      password: function (data) {
        return $http({
          method: 'PUT',
          url: API_CONSTANTS.ME_BASE + '/password',
          data: data
        });
      }
    }
  }

}(window.angular));

