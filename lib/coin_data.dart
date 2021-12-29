import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

const apiKey = 'CEB9CCD0-1F4F-4E4B-80F6-20CDB586CFB2';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String coin in cryptoList) {
      String requestURL = '$coinAPIURL/$coin/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(
        Uri.parse(requestURL),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var price = data['rate'];
        cryptoPrices[coin] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
      }
    }
    return cryptoPrices;
  }
}
