import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_upollo_platform_interface.dart';

/// An implementation of [FlutterUpolloPlatform] that uses method channels.
class MethodChannelFlutterUpollo extends FlutterUpolloPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_upollo');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
