import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future<dynamic> getCurrencyData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String currencyData = response.body;
      print(currencyData);

      return jsonDecode(currencyData);
    } else {
      print('Error : ${response.statusCode}');
    }
  }
}
