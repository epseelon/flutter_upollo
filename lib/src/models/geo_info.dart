/*
 * MIT License
 *
 * Copyright (c) 2022 Epseelon OÜ
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

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
