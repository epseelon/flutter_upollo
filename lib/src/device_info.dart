import 'enums/device_class.dart';

class DeviceInfo {
  final String deviceId;
  final String os;
  final DeviceClass deviceClass;
  final String deviceName;
  final String userAgent;
  final String browser;
  final DateTime? lastUsed;
  final bool blockedGlobally;

  /// Will always be false if request is unrelated to a single user
  final bool blockedForThisUser;

  DeviceInfo({
    required this.deviceId,
    required this.os,
    required this.deviceClass,
    required this.deviceName,
    required this.userAgent,
    required this.browser,
    required this.lastUsed,
    required this.blockedGlobally,
    required this.blockedForThisUser,
  });

  static DeviceInfo? fromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    return DeviceInfo(
      deviceId: json['deviceId'] as String,
      os: json['os'] as String,
      deviceClass: DeviceClass.values[json['deviceClass'] as int],
      deviceName: json['deviceName'] as String,
      userAgent: json['userAgent'] as String,
      browser: json['browser'] as String,
      lastUsed: json['lastUsed'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['lastUsed'] as int),
      blockedGlobally: json['blockedGlobally'] as bool,
      blockedForThisUser: json['blockedForThisUser'] as bool,
    );
  }

  @override
  String toString() {
    return 'DeviceInfo{deviceId: $deviceId, os: $os, deviceClass: $deviceClass, deviceName: $deviceName, userAgent: $userAgent, browser: $browser, lastUsed: $lastUsed, blockedGlobally: $blockedGlobally, blockedForThisUser: $blockedForThisUser}';
  }
}
