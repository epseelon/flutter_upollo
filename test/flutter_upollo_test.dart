import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_upollo/flutter_upollo.dart';
import 'package:flutter_upollo/flutter_upollo_platform_interface.dart';
import 'package:flutter_upollo/flutter_upollo_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterUpolloPlatform 
    with MockPlatformInterfaceMixin
    implements FlutterUpolloPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
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
