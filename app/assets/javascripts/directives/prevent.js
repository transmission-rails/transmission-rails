(function () {
  'use strict';

  angular.module('Transmission.Directives.Prevent', [])
    .directive('prevent', function () {
      return {
        restrict: 'A',
        link: function (scope, element, attrs) {
          element.on('click', function (e) {
            e && e.preventDefault();
          });
        }
      };
    });

}());