import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:midterm_android/BasketFood.dart';
import 'package:midterm_android/DetailsPage.dart';

void main() {
  _MyHomePageState m = _MyHomePageState();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _a = 0;
  double cost = 0;
  Map<String, String> products = {};
  Map<String, String> defaultFood = {
    ' mì': 'assets/banhmi.png,15000₫',
    'Phở': 'assets/pho.png,30000₫',
    'Cơm tấm': 'assets/comtam.png,30000₫',
    'Bún bò': 'assets/bunbo.png,35000₫',
    'Bún riêu': 'assets/bunrieu.png,30000₫',
    'Bún chả': 'assets/buncha.png,200₫'
  };

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: const Color(0xFF21BFBD),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 40.0, top: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Shopping Foods',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              BasketFood(products: products, cost: cost)));
                    },
                    icon: const Icon(Icons.shopping_basket))
              ],
            ),
          ),
          //product
          const SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 100.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: const EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 45.0),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height - 200.0,
                        child: ListView.builder(
                          itemCount: defaultFood.length,
                          itemBuilder: (BuildContext context, int index) {
                            String key = defaultFood.keys.elementAt(index);
                            return Row(
                              children: <Widget>[
                                Flexible(
                                    child: Card(
                                  child: _buildFoodItem(
                                      defaultFood[key]!.split(',')[0],
                                      key,
                                      defaultFood[key]!.split(',')[1]),
                                ))
                              ],
                            );
                          },
                        ))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFoodItem(String imgPath, String foodName, String price) {
    return Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () async {
              Map<String, String> results = await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return DetailsPage(
                    products: products,
                    heroTag: imgPath,
                    foodName: foodName,
                    foodPrice: price);
              }));
              if (results != null) {
                cost = 0;
                setState(() {
                  products.forEach((key, value) {cost+=double.parse(value.split(',')[1].replaceAll('₫', ''))*int.parse(value.split(',')[2]);});
                  products = results;
                  products.removeWhere((k, v) => v.split(',')[2] == '0');
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(children: [
                  Hero(
                      tag: imgPath,
                      child: Image(
                          image: AssetImage(imgPath),
                          fit: BoxFit.cover,
                          height: 75.0,
                          width: 75.0)),
                  SizedBox(width: 10.0),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(foodName,
                            style: const TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.bold)),
                        Text(price,
                            style: const TextStyle(
                                fontSize: 15.0, color: Colors.grey))
                      ])
                ])),
                IconButton(
                    icon: const Icon(Icons.add),
                    color:(kIsWeb) ? Colors.red:Colors.black,
                     // Colors.red,
                    onPressed: () async {
                      Map<String, String> results = await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (BuildContext context) {
                        return DetailsPage(
                            products: products,
                            heroTag: imgPath,
                            foodName: foodName,
                            foodPrice: price);
                      }));
                      if (results != null) {
                        cost = 0;
                        setState(() {
                          products.forEach((key, value) {cost+=double.parse(value.split(',')[1].replaceAll('₫', ''))*int.parse(value.split(',')[2]);});
                          products = results;
                          products.removeWhere((k, v) => v.split(',')[2] == '0');
                        });
                      }
                    })
              ],
            )));
  }
}
