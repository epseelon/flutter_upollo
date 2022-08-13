import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_upollo/flutter_upollo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _doingSomething = false;
  bool _upolloInitialized = false;

  EventType _eventType = EventType.login;
  String _userId = "123";
  String _userEmail = "john@epseelon.com";
  String _result = "";

  @override
  void initState() {
    super.initState();
    initUpollo();
  }

  Future<void> initUpollo() async {
    await FlutterUpollo.init(
      publicApiKey: const String.fromEnvironment('UPOLLO_KEY'),
    );

    setState(() {
      _upolloInitialized = true;
    });
  }

  Future<void> _assess() async {
    setState(() {
      _result = "";
      _doingSomething = true;
    });
    final result = await FlutterUpollo.instance.assess(
      eventType: _eventType,
      userInfo: UserInfo(userId: _userId, userEmail: _userEmail),
    );
    setState(() {
      _doingSomething = false;
      _result = result.toString();
    });
  }

  Future<void> _track() async {
    setState(() {
      _result = "";
      _doingSomething = true;
    });
    final result = await FlutterUpollo.instance.track(
      eventType: _eventType,
      userInfo: UserInfo(userId: _userId, userEmail: _userEmail),
    );
    setState(() {
      _doingSomething = false;
      _result = result.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Upollo Example'),
        ),
        body: Center(
          child: _upolloInitialized && !_doingSomething
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        initialValue: _userId,
                        decoration: const InputDecoration(
                          labelText: 'User ID',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _userId = value;
                          });
                        },
                      ),
                      TextFormField(
                        initialValue: _userEmail,
                        decoration: const InputDecoration(
                          labelText: 'User email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            _userEmail = value;
                          });
                        },
                      ),
                      DropdownButtonFormField<EventType>(
                          value: _eventType,
                          items: EventType.values
                              .map(
                                (e) => DropdownMenuItem<EventType>(
                                  value: e,
                                  child: Text(e.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _eventType = value!;
                            });
                          }),
                      ElevatedButton(
                        onPressed: _track,
                        child: const Text('Track'),
                      ),
                      ElevatedButton(
                        onPressed: _assess,
                        child: const Text('Assess'),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_result),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
