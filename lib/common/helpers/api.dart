import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:optima_delivery_mobile/common/helpers/HttpSerivce.dart';

class Api {
  final _storage = FlutterSecureStorage();
  String authCode;
  String host;
  String scheme;

  void setInitialBackUrl() async {
    final backUrlData = await getBackUrlData();
    if (backUrlData['host'] == null || backUrlData['scheme'] == null) {
      await setDefaultBackUrl();
    } else {
      host = backUrlData['host'] as String;
      scheme = backUrlData['scheme'] as String;
    }
  }

  void setInitialToken() async {
    authCode = await getToken();
  }

  void setDefaultBackUrl() async {
    final hostConfig = GlobalConfiguration().getString('host');
    final schemeConfig = GlobalConfiguration().getString('scheme');
    await setBackUrlData(hostConfig, schemeConfig);
  }

  void setBackUrlData(String newHost, String newScheme) async {
    host = newHost;
    scheme = newScheme;
    await _storage.write(key: 'host', value: newHost);
    await _storage.write(key: 'scheme', value: newScheme);
  }

  Future<Map> getBackUrlData() async {
    final host = await _storage.read(key: 'host');
    final scheme = await _storage.read(key: 'scheme');

    return {
      'host': host,
      'scheme': scheme,
    };
  }

  void setToken(String token) {
    _storage.write(key: 'token', value: token);
    authCode = token;
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
    authCode = null;
  }

  Future<String> getToken() async {
    return await _storage.read(key: 'token');
  }

  Future<Map<String, dynamic>> get(String path, {params}) {
    return http
        .get(getUri(path, params: params), headers: headers)
        .then(_getResponse)
        .catchError(_handleErrors);
  }

  Future<Map<String, dynamic>> put(String path, {params, body}) {
    return http
        .put(getUri(path, params: params), body: body, headers: headers)
        .then(_getResponse)
        .catchError(_handleErrors);
  }

  Future<Map<String, dynamic>> post(String path, {params, body}) {
    return http
        .post(getUri(path, params: params), body: body, headers: headers)
        .then(_getResponse)
        .catchError(_handleErrors);
  }

  Future<Map<String, dynamic>> delete(String path, {params}) {
    return http
        .delete(getUri(path, params: params), headers: headers)
        .then(_getResponse)
        .catchError(_handleErrors);
  }

  Uri getUri(String path, {params}) {
    var query = getQuery(params);
    return Uri(scheme: scheme, host: host, path: path, query: query.join('&'));
  }

  Future<Map<String, dynamic>> requestLocal(String url) async {
    return Future.delayed(
      Duration(seconds: 1),
      () => rootBundle.loadString(url).then((String str) {
        return json.decode(str) as Map<String, dynamic>;
      }),
    );
  }

  Map<String, String> get headers => {
        'X-Courier-Key': authCode,
      };

  Map<String, dynamic> _getResponse(http.Response response) {
    final answerBody = jsonDecode(response.body) as Map<String, dynamic>;
    answerBody['code'] = response.statusCode;

    return answerBody;
  }

  Map<String, dynamic> _handleErrors(e) {
    return {
      'message': [
        {
          'type': 'error',
          'code': 503,
          'title': 'No connection',
          'validator': null,
        }
      ],
      'code': 503,
    };
  }
}

Api api = Api();
