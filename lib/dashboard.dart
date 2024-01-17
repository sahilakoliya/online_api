import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:online_api/myclass.dart';
import 'package:http/http.dart' as http;
class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  final dio = Dio();
  // var url = Uri.https('example.com', 'whatsit/create');
  // var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
  Future getHttp() async {
    final url = await Uri.parse('https://dummyjson.com/products/124');
    var response = await http.get(url);
    Map m = jsonDecode(response.body);
    return m;

    // print(response);
  }
  @override
  Widget build(BuildContext context) {
    // product p = ModalRoute.of(context)!.settings.arguments as product;
    return Scaffold(
      appBar: AppBar(title: Text("List of Products"),),
      body: FutureBuilder(future: getHttp(),builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done)
          {
            if(snapshot.hasData)
              {
                Map m = snapshot.data;
                List l = m['products'];
                return ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
                  product a = product.fromJson(l[index]);
                  return Card(
                    child: ListTile(onTap: () {
                     Navigator.pushNamed(context, "view",arguments: a);
                    },
                      leading: Image.network("${a.thumbnail}",width: 75,height: 75),
                      title: Text("${a.title}"),
                      trailing: Text("${a.price}"),
                    ),
                  );
                },
                );
              }
            else
              {
                return Center(child: CircularProgressIndicator(),);
              }
          }

          else
          {
            return Center(child: CircularProgressIndicator(),);
          }
      },),
    );
  }
}
