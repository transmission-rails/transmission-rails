(function (angular) {
  'use strict';

  angular
      .module('application.users')
      .factory('User', User);

  /* @ngInject */
  function User($http) {
    return {
      create: function (user) {
        return $http({
          url: '/auth',
          method: 'POST',
          data: user
        })
      }
    }
  }

}(window.angular));
