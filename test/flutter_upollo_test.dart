import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_upollo/flutter_upollo.dart';
import 'package:flutter_upollo/flutter_upollo_method_channel.dart';
import 'package:flutter_upollo/flutter_upollo_platform_interface.dart';
import 'package:flutter_upollo/src/analysis_response.dart';
import 'package:flutter_upollo/src/event_response.dart';
import 'package:flutter_upollo/src/user_info.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterUpolloPlatform
    with MockPlatformInterfaceMixin
    implements FlutterUpolloPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

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

  test('getPlatformVersion', () async {
    FlutterUpollo flutterUpolloPlugin = FlutterUpollo();
    MockFlutterUpolloPlatform fakePlatform = MockFlutterUpolloPlatform();
    FlutterUpolloPlatform.instance = fakePlatform;

    expect(await flutterUpolloPlugin.getPlatformVersion(), '42');
  });
}
