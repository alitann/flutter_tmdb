class ApplicationException implements Exception {
  final String? _message;
  final String? _prefix;

  ApplicationException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends ApplicationException {
  FetchDataException([message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends ApplicationException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends ApplicationException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends ApplicationException {
  InvalidInputException([message]) : super(message, "Invalid Input: ");
}
