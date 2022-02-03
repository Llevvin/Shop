import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListShop extends StatefulWidget {
  const ListShop({Key? key}) : super(key: key);

  @override
  _ListShopState createState() => _ListShopState();
}

class _ListShopState extends State<ListShop> {
  var _result = [];
  void getData() async {
    Uri url = Uri.parse('https://fakestoreapi.com/products/');
    http.Response response = await http.get(url);
    final jsonData = json.decode(response.body) as List;

    setState(() {
      _result = jsonData;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Material(
      child: Scaffold(
        body: ListView.builder(
            itemCount: _result.length,
            itemBuilder: (context, i) {
              final post = _result[i];
              return Container(
                  child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'From',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('﹩${post["price"]}'),
                              const FloatingActionButton(
                                backgroundColor: Colors.black,
                                onPressed: null,
                                child: Icon(Icons.add_shopping_cart_outlined),
                              )
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                          ),
                          Image.network(
                            post["image"],
                            width: MediaQuery.of(context).size.width * 0.45,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.45,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: TextButton(
                              style: const ButtonStyle(
                                  alignment: Alignment.centerLeft),
                              onPressed: () {},
                              child: Text('${post["category"]}')),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.40,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 30,
                          height: 40,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.black),
                          child: Text(
                            '${post['rating']["rate"]}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              '${post['rating']["count"]}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          decoration: const BoxDecoration(
                              color: Colors.black26,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Text(
                          '${post["title"]}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                        child: Text(
                          '${post["description"]}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black12, width: 2)))),
                    )
                  ],
                ),
              ));
            }),
      ),
    );
  }
}
