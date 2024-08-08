import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WebSocketChannel channel = IOWebSocketChannel.connect(
      'ws:https://echo.websocket.org/'); // webSocket Url
  late StreamSubscription subscription;
  String price = 'Loading...';

  @override
  void initState() {
    super.initState();
    subscription = channel.stream.listen((message) {
      final data = jsonDecode(message);
      setState(() {
        price = data['Price'].toString();
      });
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text(price),
        ),
      ),
    );
  }
}
