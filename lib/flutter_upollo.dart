import 'flutter_upollo_platform_interface.dart';

export 'src/analysis_response.dart';
export 'src/device_info.dart';
export 'src/enums/address_type.dart';
export 'src/enums/challenge_type.dart';
export 'src/enums/device_class.dart';
export 'src/enums/event_type.dart';
export 'src/enums/flag_type.dart';
export 'src/enums/outcome.dart';
export 'src/event_response.dart';
export 'src/flag.dart';
export 'src/geo_info.dart';
export 'src/lat_lng.dart';
export 'src/physical_address.dart';
export 'src/postal_address.dart';
export 'src/user_info.dart';

class FlutterUpollo {
  static FlutterUpolloPlatform get instance => FlutterUpolloPlatform.instance;

  Future<String?> getPlatformVersion() {
    return instance.getPlatformVersion();
  }

  static Future<void> init({required String publicApiKey}) {
    return instance.init(publicApiKey: publicApiKey);
  }
}
