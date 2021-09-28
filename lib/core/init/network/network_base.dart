import 'dart:convert';

import '../exception/application_exception.dart';
import 'package:http/http.dart' as http;

class NetworkBase {
  Future<dynamic> get(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url));
      responseJson = _returnResponse(response);
    } catch (exception) {
      throw exception.toString();
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
