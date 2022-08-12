
import 'flutter_upollo_platform_interface.dart';

class FlutterUpollo {
  Future<String?> getPlatformVersion() {
    return FlutterUpolloPlatform.instance.getPlatformVersion();
  }
}
