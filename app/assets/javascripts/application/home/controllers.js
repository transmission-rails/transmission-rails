(function (angular) {
  'use strict';

  angular
      .module('application.home')
      .controller('HomeCtrl', HomeCtrl);

  /* @ngInject */
  function HomeCtrl($scope, Me) {
    Me.index()
        .then(function (success) {
          $scope.me = success.data;
        });
  }

}(window.angular));
