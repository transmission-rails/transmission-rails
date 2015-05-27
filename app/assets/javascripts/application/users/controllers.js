(function (angular) {
  'use strict';

  angular
      .module('application.users')
      .controller('UsersShowCtrl', UsersShowCtrl)
      .controller('UsersLoginCtrl', UsersLoginCtrl)
      .controller('UsersRegistrationCtrl', UsersRegistrationCtrl);

  /* @ngInject */
  function UsersShowCtrl($scope, $routeParams, User) {
    User.show({id: $routeParams.id}, function (response) {
      $scope.user = response;
    });
  }

  /* @ngInject */
  function UsersLoginCtrl($scope, $location, Session) {
    $scope.login = function () {
      Session.login($scope.user.username, $scope.user.password).then(function (response) {
        $location.path('/');
      }, function () {
        $.growl.error({title: 'Login Failed!', message: 'Username or password incorrect'});
      });
    };
  }

  /* @ngInject */
  function UsersRegistrationCtrl($scope, $location, Store, User) {
    if (Store.has('oauth')) {
      $location.path('/');
    }

    $scope.user = {};
    $scope.failure = false;

    $scope.register = function () {
      User.create({user: $scope.user}, function () {
        $location.path('/users/login');
      }, function () {
        $.growl.error({title: 'Registration failed!', message: 'please fill in the appropriate fields below'});
      });
    };
  }

}(window.angular));
