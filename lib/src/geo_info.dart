import 'lat_lng.dart';

class GeoInfo {
  final LatLng? geoIpLatLng;
  final String geoIpCity;
  final String geoIpSubregion;
  final String geoIpRegion;
  final DateTime? lastHere;

  GeoInfo({
    required this.geoIpLatLng,
    required this.geoIpCity,
    required this.geoIpSubregion,
    required this.geoIpRegion,
    required this.lastHere,
  });

  static GeoInfo? fromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    return GeoInfo(
      geoIpLatLng: json['geoIpLatLng'] == null
          ? null
          : LatLng.fromJson(json['geoIpLatLng']),
      geoIpCity: json['geoIpCity'] as String,
      geoIpSubregion: json['geoIpSubregion'] as String,
      geoIpRegion: json['geoIpRegion'] as String,
      lastHere: json['lastHere'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['lastHere'] as int),
    );
  }

  @override
  String toString() {
    return 'GeoInfo{geoIpLatLng: $geoIpLatLng, geoIpCity: $geoIpCity, geoIpSubregion: $geoIpSubregion, geoIpRegion: $geoIpRegion, lastHere: $lastHere}';
  }
}
