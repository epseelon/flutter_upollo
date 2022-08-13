import 'device_info.dart';
import 'enums/challenge_type.dart';
import 'enums/event_type.dart';
import 'enums/outcome.dart';
import 'flag.dart';
import 'geo_info.dart';
import 'user_info.dart';

class AnalysisResponse {
  /// Recommended action based on the Userwatch analysis.
  final Outcome action;

  /// All flags the Userwatch analysis identified.
  /// Note any flags with an ignoredUntil value after the present should
  /// generally be treated as if they were not present. Those ignored flags are
  /// already excluded from factoring into the action Outcome above.
  final List<Flag> flags;

  /// True if Userwatch detects a VPN is being used.
  /// Deprecated: This is available as in flags as type usingVpn
  @Deprecated('This is available as in flags as type usingVpn')
  final bool usingVpn;

  /// True if Userwatch detects TOR is being used.
  /// Deprecated: This is available in flags as type usingTor
  @Deprecated('This is available in flags as type usingTor')
  final bool usingTor;

  /// Information Userwatch discerned about the user.
  final UserInfo userInfo;

  /// Information Userwatch discerned about the device.
  final DeviceInfo deviceInfo;

  /// Geographic information discerned by Userwatch.
  final GeoInfo geoInfo;

  final List<ChallengeType> supportedChallenges;

  /// Unique identifier of the request which resulted in this analysis.
  final String requestId;

  /// Event type which resulted in this analysis being done.
  final EventType eventType;

  //reserved "trustScore", "history";

  AnalysisResponse({
    required this.action,
    required this.flags,
    required this.usingVpn,
    required this.usingTor,
    required this.userInfo,
    required this.deviceInfo,
    required this.geoInfo,
    required this.supportedChallenges,
    required this.requestId,
    required this.eventType,
  });

  static AnalysisResponse? fromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    return AnalysisResponse(
      action: Outcome.values[json['action'] as int],
      flags: (json['flags'] as List<dynamic>)
          .map((flag) => Flag.fromJson(flag)!)
          .toList(),
      usingVpn: json['usingVpn'] as bool,
      usingTor: json['usingTor'] as bool,
      userInfo: UserInfo.fromJson(json['userInfo'])!,
      deviceInfo: DeviceInfo.fromJson(json['deviceInfo'])!,
      geoInfo: GeoInfo.fromJson(json['geoInfo'])!,
      supportedChallenges: (json['supportedChallenges'] as List<dynamic>)
          .map((challenge) => ChallengeType.values[challenge as int])
          .toList(),
      requestId: json['requestId'],
      eventType: EventType.values[json['eventType'] as int],
    );
  }

  @override
  String toString() {
    return 'AnalysisResponse{action: $action, flags: $flags, usingVpn: $usingVpn, usingTor: $usingTor, userInfo: $userInfo, deviceInfo: $deviceInfo, geoInfo: $geoInfo, supportedChallenges: $supportedChallenges, requestId: $requestId, eventType: $eventType}';
  }
}
