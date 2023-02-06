import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key?key}):super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String stringResponse='';
Map mapResponse={};
Map dataResponse={};
List listResponse=[];

class _MyHomePageState extends State<MyHomePage> {
Future apicall() async{
  http.Response response;
  response=await http.get(Uri.parse("https://reqres.in/api/users"));
  if(response.statusCode==200){
    setState(() {
      mapResponse=json.decode(response.body);
      listResponse=mapResponse['data'];
    });
  }
}

@override
void initState(){
  apicall();
  super.initState();
}
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rest API"),   
      ),
  body: ListView.builder(itemBuilder: (context, index) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(listResponse[index]['avatar']),
          ),
          Text(listResponse[index]['id'].toString()),
          Text(listResponse[index]['email'].toString()),
          Text(listResponse[index]['first_name'].toString()),
          Text(listResponse[index]['last_name'].toString()),
        ],
      ),
    );
  },
  itemCount: listResponse==null?0:listResponse.length,
  ),   
    );
  }
}