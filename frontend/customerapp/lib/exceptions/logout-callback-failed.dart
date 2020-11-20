class LogoutCallbackFailed implements Exception {
  String cause;
  int errorCode;
  String responseBody;
  LogoutCallbackFailed(this.cause, this.errorCode, this.responseBody);
}
