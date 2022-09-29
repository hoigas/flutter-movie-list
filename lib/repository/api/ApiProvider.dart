import 'package:http/http.dart' as http;

class ApiProvider {
  final _host = 'api.themoviedb.org';
  final _apiVersion = 3;
  final _apiKey = '3df8f8a5929d4068223d35671dff9b97';
  final _language = 'ko-KR';

  Future<String> get({required String path, Map<String, String>? parameters}) async {
    parameters?['language'] = _language;
    parameters?['api_key'] = _apiKey;

    var uri = Uri.https(_host, '/$_apiVersion/$path', parameters);
    var response = await http.get(uri);

    return response.body;
  }
}
