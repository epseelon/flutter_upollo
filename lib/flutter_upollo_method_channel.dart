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

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_upollo_platform_interface.dart';
import 'src/enums/event_type.dart';
import 'src/models/analysis_response.dart';
import 'src/models/event_response.dart';
import 'src/models/user_info.dart';

/// An implementation of [FlutterUpolloPlatform] that uses method channels.
class MethodChannelFlutterUpollo extends FlutterUpolloPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_upollo');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> init({
    required String publicApiKey,
    Map<String, String>? options,
  }) async {
    await methodChannel.invokeMethod<Function>('init', {
      'publicApiKey': publicApiKey,
      'options': options,
    });
  }

  @override
  Future<EventResponse?> track({
    required UserInfo userInfo,
    required EventType eventType,
  }) async {
    final eventResponse = await methodChannel.invokeMapMethod<String, dynamic>(
      'track',
      {
        'userInfo': userInfo.toJson(),
        'eventType': eventType.index,
      },
    );
    return EventResponse.fromJson(eventResponse);
  }

  @override
  Future<AnalysisResponse?> assess({
    required UserInfo userInfo,
    required EventType eventType,
  }) async {
    final analysisResponse =
        await methodChannel.invokeMapMethod<String, dynamic>(
      'assess',
      {
        'userInfo': userInfo.toJson(),
        'eventType': eventType.index,
      },
    );

    return AnalysisResponse.fromJson(analysisResponse);
  }
}
