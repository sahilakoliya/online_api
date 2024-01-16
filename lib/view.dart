import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:online_api/myclass.dart';
import 'package:http/http.dart' as http;

class view extends StatefulWidget {
  const view({super.key});

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {

  // final List<String> imageList = [
  //
  // ];




  @override
  Widget build(BuildContext context) {
    product p = ModalRoute.of(context)!.settings.arguments as product;
    Future getHttp() async {
      var url = Uri.https('dummyjson.com', 'products/${p.id}');
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      Map m = jsonDecode(response.body);
      List l = m['id'];
      return m;
    }
    return Scaffold(
      appBar: AppBar(title: Text(""),),
      body: FutureBuilder(future: getHttp(), builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done)
          {
            List l = p.images!;
             // Map m = snapshot.dat
              return Column(
                children: [
                  GFCarousel(
                    items: l.map(
                          (url) {
                        return Container(
                          margin: EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            child: Image.network(
                                url,
                                fit: BoxFit.cover,
                                width: 1000.0
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    onPageChanged: (index) {
                        index;
                    },
                  ),

                  Text("${p.id}"),
                  Text("${p.title}"),
                  Text("${p.price}")
                ],
              );
          }
        else
          {
            return Center(child: CircularProgressIndicator(),);
          }
      },),
    );
  }
}
