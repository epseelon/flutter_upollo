import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_upollo_method_channel.dart';
import 'src/analysis_response.dart';
import 'src/enums/event_type.dart';
import 'src/event_response.dart';
import 'src/user_info.dart';

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
