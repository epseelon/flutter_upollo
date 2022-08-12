import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_upollo_method_channel.dart';

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
}
