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

import 'flutter_upollo_platform_interface.dart';

export 'src/enums/address_type.dart';
export 'src/enums/challenge_type.dart';
export 'src/enums/device_class.dart';
export 'src/enums/event_type.dart';
export 'src/enums/flag_type.dart';
export 'src/enums/outcome.dart';
export 'src/models/analysis_response.dart';
export 'src/models/device_info.dart';
export 'src/models/event_response.dart';
export 'src/models/flag.dart';
export 'src/models/geo_info.dart';
export 'src/models/lat_lng.dart';
export 'src/models/physical_address.dart';
export 'src/models/postal_address.dart';
export 'src/models/user_info.dart';

class FlutterUpollo {
  static FlutterUpolloPlatform get instance => FlutterUpolloPlatform.instance;

  /// Shortcut for instance.init().
  /// [publicApiKey] is the public API key for your Upollo account.
  static Future<void> init({required String publicApiKey}) {
    return instance.init(publicApiKey: publicApiKey);
  }
}
