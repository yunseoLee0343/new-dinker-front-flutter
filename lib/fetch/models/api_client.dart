import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;

  ApiClient(this.baseUrl);

  Future<List<String>> fetchBrands() async {
    final response = await http.get(Uri.parse('$baseUrl/hot'));
    //final response = await http.get(Uri.parse('$baseUrl/brands'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => item['title'] as String).toList();
    } else {
      throw Exception('Failed to fetch brands');
    }
  }
}
