import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_mqtt/blocs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider.value(value: mqttBloc(topic: 'aritra'), child: Home(),)
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<mqttBloc>(
          builder: (context, value, child) => Container(
            child: Text(value.message.toString()),
          ),
        ),
      ),
    );
  }
}


