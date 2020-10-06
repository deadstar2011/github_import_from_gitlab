import 'dart:convert';
import 'package:http/http.dart' as http;

List<String> getQuery(params, {acc = ''}) {
  if (null == params) {
    return [];
  }
  if (params is Map) {
    var result = <String>[];
    params.keys.toList().forEach((key) {
      final newAcc = '' == acc ? key : '$acc[$key]';
      result.addAll(getQuery(params[key], acc: newAcc));
    });
    return result;
  }
  if (params is List) {
    var result = <String>[];
    params.toList().forEach((item) {
      result.addAll(getQuery(item, acc: '$acc[]'));
    });
    return result;
  }
  return ['$acc=$params'];
}

class HttpService {
  Future<Map<String, dynamic>> get(String path,
      {String scheme, String host, params, Map<String, String> headers}) {
    return http
        .get(getUri(scheme, host, path, params: params), headers: headers)
        .then(_getResponse)
        .catchError(_handleErrors);
  }

  Future<Map<String, dynamic>> put(String path,
      {String scheme, String host, params, body, Map<String, String> headers}) {
    return http
        .put(getUri(scheme, host, path, params: params),
            body: body, headers: headers)
        .then(_getResponse)
        .catchError(_handleErrors);
  }

  Future<Map<String, dynamic>> post(String path,
      {String scheme, String host, params, body, Map<String, String> headers}) {
    return http
        .post(getUri(scheme, host, path, params: params),
            body: body, headers: headers)
        .then(_getResponse)
        .catchError(_handleErrors);
  }

  Future<Map<String, dynamic>> delete(String path,
      {String scheme, String host, params, Map<String, String> headers}) {
    return http
        .delete(getUri(scheme, host, path, params: params), headers: headers)
        .then(_getResponse)
        .catchError(_handleErrors);
  }

  Uri getUri(String scheme, String host, String path, {params}) {
    var query = getQuery(params);
    return Uri(scheme: scheme, host: host, path: path, query: query.join('&'));
  }

  Map<String, dynamic> _getResponse(http.Response response) {
    final answerBody = jsonDecode(response.body) as Map<String, dynamic>;
    answerBody['statusCode'] = response.statusCode;

    return answerBody;
  }

  Map<String, dynamic> _handleErrors(e) {
    return {
      'message': [
        {
          'type': 'error',
          'code': 503,
          'title': 'No connection',
        }
      ],
      'statusCode': 503,
    };
  }
}

HttpService httpService = HttpService();
