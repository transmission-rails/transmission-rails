(function (angular) {
  'use strict';

  angular
      .module('application')
      .config(applicationConfig)
      .config(configureAuth);

  /* @ngInject */
  function applicationConfig($httpProvider, $routeProvider) {
    $httpProvider.interceptors.push('AuthInterceptor');

    $routeProvider.otherwise({redirectTo: '/'});
  }

  /* @ngInject */
  function configureAuth($authProvider) {
    $authProvider.configure({
      apiUrl: window.location.protocol + '//' + window.location.host,
      tokenValidationPath: '/auth/validate_token',
      signOutUrl: '/auth/sign_out',
      emailRegistrationPath: '/auth',
      accountUpdatePath: '/auth',
      accountDeletePath: '/auth',
      confirmationSuccessUrl: window.location.href,
      passwordResetPath: '/auth/password',
      passwordUpdatePath: '/auth/password',
      passwordResetSuccessUrl: window.location.href,
      emailSignInPath: '/auth/sign_in',
      storage: 'localStorage',
      proxyIf: function () {
        return false;
      },
      proxyUrl: '/proxy',
      authProviderPaths: {
        github: '/auth/github',
        facebook: '/auth/facebook',
        google: '/auth/google'
      },
      tokenFormat: {
        "access-token": "{{ token }}",
        "token-type": "Bearer",
        "client": "{{ clientId }}",
        "expiry": "{{ expiry }}",
        "uid": "{{ uid }}"
      },
      parseExpiry: function (headers) {
        // convert from UTC ruby (seconds) to UTC js (milliseconds)
        return (parseInt(headers['expiry']) * 1000) || null;
      },
      handleLoginResponse: function (response) {
        return response.data;
      },
      handleAccountResponse: function (response) {
        return response.data;
      },
      handleTokenValidationResponse: function (response) {
        return response.data;
      }
    });
  }

}(window.angular));
