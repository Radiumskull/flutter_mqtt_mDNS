import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class mqttBloc extends ChangeNotifier{
  var _client;
  var _mqtt_message;
  final builder = MqttClientPayloadBuilder();

  final String topic;
  mqttBloc({this.topic}) {
    _client = MqttServerClient('bhawan.co.in', 'test_flutter_app');
    builder.addString('Hello from mqtt_client');
    connect();
  }
  String get message => _mqtt_message;
  void connect() async {
    await _client.connect().whenComplete(() => print("Connected"));
    _client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload);
    subscription();
  }

  void subscription(){
    _client.subscribe(topic, MqttQos.atMostOnce);
    _client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;
      final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
//      print(
//          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
//      print('');
    _mqtt_message = pt;
    notifyListeners();
    });
  }

  void disconnect() async {
    _client.disconnect();

  }
}