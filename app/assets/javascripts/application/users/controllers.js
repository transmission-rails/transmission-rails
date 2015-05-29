(function (angular) {
  'use strict';

  angular
      .module('application.users')
      .controller('UsersLoginCtrl', UsersLoginCtrl)
      .controller('UsersRegistrationCtrl', UsersRegistrationCtrl);

  /* @ngInject */
  function UsersLoginCtrl($scope, $location, $auth) {
    $scope.user = {};

    $scope.login = function () {
      $auth.submitLogin($scope.user)
          .then(function(success) {
            $location.path('/');
          })
          .catch(function(error) {
            $.growl.error({title: 'Login Failed!', message: 'Username or password incorrect'});
          });
    };
  }

  /* @ngInject */
  function UsersRegistrationCtrl($scope, $location, $auth) {
    $scope.user = {};
    $scope.failure = false;

    $scope.register = function () {
      $auth.submitRegistration($scope.user)
          .then(function (success) {
            $location.path('/users/login');
          })
          .catch(function (error) {
            $.growl.error({title: 'Registration failed!', message: 'please fill in the appropriate fields below'});
          });
    };
  }

}(window.angular));
