(function () {
  'use strict';

  angular.module('Transmission.Directives.ShowTrigger', [])
    .directive('showTrigger', function () {
      return {
        restrict: 'A',
        link: function (scope, element, attrs) {
          var timeout = attrs.timeout || 200;

          setTimeout(function () {
            element.addClass('show');
          }, timeout);
        }
      };
    });

}());