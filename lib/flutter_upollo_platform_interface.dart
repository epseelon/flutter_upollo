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

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_upollo_method_channel.dart';
import 'src/enums/event_type.dart';
import 'src/models/analysis_response.dart';
import 'src/models/event_response.dart';
import 'src/models/user_info.dart';

abstract class FlutterUpolloPlatform extends PlatformInterface {
  /// Constructs a FlutterUpolloPlatform.
  FlutterUpolloPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterUpolloPlatform _instance = MethodChannelFlutterUpollo();

  /// The default instance of [FlutterUpolloPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterUpollo].
  static FlutterUpolloPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterUpolloPlatform] when
  /// they register themselves.
  static set instance(FlutterUpolloPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> init(
      {required String publicApiKey, Map<String, String>? options}) {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<AnalysisResponse?> assess(
      {required UserInfo userInfo, required EventType eventType}) {
    throw UnimplementedError('trackLogin() has not been implemented.');
  }

  Future<EventResponse?> track(
      {required UserInfo userInfo, required EventType eventType}) {
    throw UnimplementedError('trackLogin() has not been implemented.');
  }
}
