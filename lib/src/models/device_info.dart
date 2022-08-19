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

import '../enums/device_class.dart';

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
