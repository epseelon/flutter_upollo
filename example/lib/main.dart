/*
 * MIT License
 *
 * Copyright (c) 2022 Epseelon OÜ
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_upollo/flutter_upollo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterUpollo.init(
    publicApiKey: const String.fromEnvironment('UPOLLO_KEY'),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _doingSomething = false;

  EventType _eventType = EventType.login;
  String _userId = "123";
  String _userEmail = "john@epseelon.com";
  String _result = "";

  @override
  void initState() {
    super.initState();
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
          child: !_doingSomething
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
