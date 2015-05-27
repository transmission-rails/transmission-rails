(function (angular) {
  'use strict';

  angular
      .module('application.users')
      .factory('User', User);

  /* @ngInject */
  function User($resource) {
    return $resource('/api/v1/users/:id', {id: '@id'},
        {
          'create': {method: 'POST'},
          'index': {method: 'GET', isArray: true},
          'show': {method: 'GET', isArray: false},
          'update': {method: 'PUT'},
          'destroy': {method: 'DELETE'}
        }
    );
  }

}(window.angular));
