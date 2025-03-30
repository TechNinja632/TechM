import 'dart:convert';
import 'package:http/http.dart' as http;

class StockService {
  final String apiKey = 'U1GS8NF3AQ51MIC0';

  Future<Map<String, dynamic>> fetchStockData(String symbol) async {
    final url =
        'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load stock data');
    }
  }
}
