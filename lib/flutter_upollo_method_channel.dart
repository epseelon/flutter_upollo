import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_upollo_platform_interface.dart';
import 'src/analysis_response.dart';
import 'src/enums/event_type.dart';
import 'src/event_response.dart';
import 'src/user_info.dart';

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
