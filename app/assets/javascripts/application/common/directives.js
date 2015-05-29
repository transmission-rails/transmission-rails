(function (angular, $) {
  'use strict';

  angular
      .module('application.common')
      .directive('navbar', navbar)
      .directive('subNavbar', subNavbar)
      .directive('imageFallback', imageFallback)
      .directive('footer', footer);

  /* @ngInject */
  function navbar(APP_CONSTANTS, Me, $auth) {
    return {
      restrict: 'E',
      templateUrl: '/templates/common/partials/navbar.directive.html',
      link: function (scope, elem, attrs) {
        scope.app_name = APP_CONSTANTS.APP_NAME;
        Me.index().then(function (success) {
          scope.me = success.data;
        });

        scope.logout = function () {
          $auth.signOut()
              .then(function(resp) {
                // handle success response
              })
        };
      }
    }
  }

  /* @ngInject */
  function subNavbar($route) {
    return {
      restrict: 'E',
      templateUrl: '/templates/common/partials/profile-navbar.directive.html',
      link: function (scope, elem, attrs) {
        scope.route = $route.current.$$route.name;
      }
    };
  }

  /* @ngInject */
  function imageFallback() {
    return {
      restrict: 'A',
      link: function (scope, elem, attrs) {
        elem.bind('error', function () {
          elem.attr('src', attrs['imageFallback']);
        });

        scope.$watch(function () {
          return attrs['ngSrc'];
        }, function (value) {
          if (!value) elem.attr('src', attrs['imageFallback']);
        });
      }
    }
  }

  /* @ngInject */
  function footer($timeout, APP_CONSTANTS) {
    return {
      restrict: 'E',
      templateUrl: '/templates/common/partials/footer.directive.html',
      link: function (scope, elem, attrs) {
        scope.app_version = APP_CONSTANTS.APP_VERSION;
        scope.app_name = APP_CONSTANTS.APP_NAME;
        scope.today = moment();

        var footerWrapper = $('.wrapper');

        // Quite often you will occur a few wrapping `<div>`s in the
        // top level of your DOM, so we need to set the height
        // to be 100% on each of those. This will also set it on
        // the `<html>` and `<body>`.
        footerWrapper.parents().css('height', '100%');
        footerWrapper.css({
          'min-height': '100%',
          'height': 'auto'
        });

        // Append a pushing div to the stickyFooterWrapper.
        var footerPush = $('<div class="push"></div>');
        footerWrapper.append(footerPush);

        var setHeights = function () {
          var height = elem.outerHeight();
          footerPush.height(height);
          footerWrapper.css('margin-bottom', -(height));
        };

        $timeout(setHeights, 0);
        $(window).on('resize', setHeights);
      }
    }
  }

}(window.angular, window.jQuery));