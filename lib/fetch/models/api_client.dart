import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;

  ApiClient(this.baseUrl);

  Future<List<String>> fetch(String detailUrl) async {
    print('$baseUrl' + detailUrl + '/');
    final response = await http.get(Uri.parse('$baseUrl' + detailUrl + '/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => item['content'] as String).toList();
    } else {
      print(response);
      throw Exception('Failed to fetch brands');
    }
  }
}
