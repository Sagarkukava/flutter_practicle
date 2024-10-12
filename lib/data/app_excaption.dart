
class AppExcaption implements Exception{

  final _message ;
  final _prefix ;
  AppExcaption([this._message,this._prefix]);

  String toString(){
    return '$_message$_prefix';
  }
}

class FetchdataException extends AppExcaption{

  FetchdataException([String? message]) : super(message, " Error During Communication");
}

class BadRequesExcepation extends AppExcaption{

  BadRequesExcepation([String? message]) : super(message, " Invalid Request");
}

class UnauthorisedException extends AppExcaption{

  UnauthorisedException([String? message]) : super(message, " Unauthorised Request");
}

class InvalidinputExcepation extends AppExcaption{

  InvalidinputExcepation([String? message]) : super(message, " Invalid Input");
}