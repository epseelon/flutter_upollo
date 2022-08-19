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

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_upollo/flutter_upollo.dart';
import 'package:flutter_upollo/flutter_upollo_method_channel.dart';
import 'package:flutter_upollo/flutter_upollo_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterUpolloPlatform
    with MockPlatformInterfaceMixin
    implements FlutterUpolloPlatform {
  /*@override
  Future<String?> getPlatformVersion() => Future.value('42');*/

  @override
  Future<void> init(
      {required String publicApiKey, Map<String, String>? options}) {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<AnalysisResponse> assess(
      {required UserInfo userInfo, required EventType eventType}) {
    // TODO: implement assess
    throw UnimplementedError();
  }

  @override
  Future<EventResponse> track(
      {required UserInfo userInfo, required EventType eventType}) {
    // TODO: implement track
    throw UnimplementedError();
  }
}

void main() {
  final FlutterUpolloPlatform initialPlatform = FlutterUpolloPlatform.instance;

  test('$MethodChannelFlutterUpollo is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterUpollo>());
  });

  /*test('getPlatformVersion', () async {
    FlutterUpollo flutterUpolloPlugin = FlutterUpollo();
    MockFlutterUpolloPlatform fakePlatform = MockFlutterUpolloPlatform();
    FlutterUpolloPlatform.instance = fakePlatform;

    expect(await flutterUpolloPlugin.getPlatformVersion(), '42');
  });*/
}
