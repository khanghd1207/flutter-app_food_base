import 'package:flutter/material.dart';

class BasketFood extends StatefulWidget {
  final products;
  final cost;

  const BasketFood({super.key, this.products, this.cost});

  @override
  _BasketFood createState() => _BasketFood();
}

class _BasketFood extends State<BasketFood> {
  late double sum = 0;
  late double cost = widget.products == null
      ? 0.0
      : double.parse(
      widget.products.forEach((k, v) => sum += double.parse(v.split(',')[2])));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7A9BEE),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text('Giỏ hàng',
            style: TextStyle(fontSize: 18.0, color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView(
          children: <Widget>[
      const SizedBox(height: 40.0),
      Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Row(
          children: const <Widget>[
            Text('Shopping Food',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0)),
          ],
        ),
      ),
      //product
      const SizedBox(height: 40.0),
      Container(
        height: MediaQuery
            .of(context)
            .size
            .height - 189.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
        ),
        child: ListView(
          primary: false,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height - 280.0,
                    child: ListView.builder(
                      itemCount: widget.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        String key = widget.products.keys.elementAt(index);
                        return Row(
                          children: <Widget>[
                            Flexible(
                                child: Card(
                                  child: _buildFoodItem(
                                      widget.products[key].split(',')[0],
                                      key,
                                      widget.products[key].split(',')[1],
                                      widget.products[key]
                                          .split(',')[2]
                                          .replaceAll('₫', '')),
                                )),

                          ],
                        );
                      },
                    ))),
            SizedBox(height: 15.0,),
            Center(child: Text(
              'Tổng: ${widget.cost}₫',
              style: const TextStyle(fontSize: 20.0, color: Colors.red),)),
          ],
        ),
      ),
      ],
    ),);
  }

  Widget _buildFoodItem(String imgPath, String foodName, String price,
      String count) {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 5.0, top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(children: [
              Hero(
                  tag: imgPath,
                  child: Image(
                      image: AssetImage(imgPath),
                      fit: BoxFit.cover,
                      height: 75.0,
                      width: 75.0)),
              const SizedBox(width: 10.0),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(foodName,
                    style: const TextStyle(
                        fontSize: 17.0, fontWeight: FontWeight.bold)),
                Text('Đơn giá: ${price}',
                    style: const TextStyle(fontSize: 15.0, color: Colors.grey)),
                Text('Số lượng: ${count}',
                    style: const TextStyle(fontSize: 15.0, color: Colors.grey)),
              ]),
              const SizedBox(width: 10.0),
              Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        "Thành tiền: ${double.parse(price.replaceAll("₫", "")) *
                            int.parse(count)}₫",
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.redAccent,
                        ))
                  ])
            ]),
          ],
        ));
  }
}
