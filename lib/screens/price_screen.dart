import 'package:flutter/material.dart';
import '../services/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/services/currency.dart';
import 'package:bitcoin_ticker/services/networking.dart';
import 'package:bitcoin_ticker/utilities/mywidgets.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCryto = cryptoList[0];
  String cur2 = 'USD';
  Currency currency = Currency();

  String selectedValue = 'USD';
  double convertedValue = 0;
  double convertedValue2 = 0;
  double convertedValue3 = 0;

  @override
  void initState() {
    super.initState();
    print('initializing state lol.');
    updateUI();
    updateUI2();
    updateUI3();
  }

  updateUI3() async {
    dynamic currencyData3 = await currency.getCurrency('LTC', selectedValue);
    print(currencyData3);
    setState(() {
      if (currencyData3 == null) {
        convertedValue3 = 0;
        return;
      }
      convertedValue3 = currencyData3['rate'];
    });
  }

  updateUI2() async {
    dynamic currencyData2 = await currency.getCurrency('ETH', selectedValue);
    print(currencyData2);
    setState(() {
      if (currencyData2 == null) {
        convertedValue2 = 0;
        return;
      }
      convertedValue2 = currencyData2['rate'];
    });
  }

  updateUI() async {
    dynamic currencyData =
        await currency.getCurrency(selectedCryto, selectedValue);
    print(convertedValue.toStringAsFixed(1));
    setState(() {
      if (currencyData == null) {
        convertedValue = 0;
        return;
      }
      convertedValue = currencyData['rate'];
    });
    // }
  }

  DropdownButton<String> androidPicker() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    //for(String currency in currenciesList) *second method for doing the same shii
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropDownItems.add(newItem);
    }

    return DropdownButton<String>(
        value: selectedValue,
        items: dropDownItems,
        onChanged: (value) {
          print(value);
          setState(() {
            selectedValue = value;
            updateUI();
            updateUI2();
            updateUI3();
          });
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  // Widget getPicker() {
  //   if (Platform.isIOS) {
  //     return iOSPicker();
  //   } else if (Platform.isAndroid) {
  //     return androidPicker();
  //   }else{
  //     return
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          MyCard('BTC', '${convertedValue.toStringAsFixed(2)} $selectedValue'),
          MyCard('ETH', '${convertedValue2.toStringAsFixed(2)} $selectedValue'),
          MyCard('LTC', '${convertedValue3.toStringAsFixed(2)} $selectedValue'),
          Container(
            height: 64.0,
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
