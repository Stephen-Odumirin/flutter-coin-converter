import 'package:bitcoin_ticker/services/currency.dart';
import 'package:bitcoin_ticker/services/networking.dart';
import 'package:flutter/cupertino.dart';

const BASE_URL = 'https://rest.coinapi.io/v1/exchangerate/';
//TODO('insert your api key here ... get it from coinapi.io')
const apikey = 'Your-Api-Key-Here';

class Currency {
  Future<dynamic> getCurrency(String cur1, String cur2) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://rest.coinapi.io/v1/exchangerate/$cur1/$cur2?apikey=$apikey');

    var currencyData = await networkHelper.getCurrencyData();

    return currencyData;
  }
}
