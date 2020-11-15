class OrderCallbackFailed implements Exception {
  String cause;
  int errorCode;
  String responseBody;
  OrderCallbackFailed(this.cause, this.errorCode, this.responseBody);
}
