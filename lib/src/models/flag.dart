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

import '../enums/flag_type.dart';

class Flag {
  final FlagType type;
  final DateTime firstFlagged;
  final DateTime mostRecentlyFlagged;

  /// A null ignoredUntil value, or a non-null value before the present, means
  /// this flag is set and should be treated accordingly.
  /// A non-null ignoredUntil value which is after the present indicates this
  /// flag is set, but should be ignored — i.e. treated as if not flagged.
  /// The max time further indicates that the flag should be ignored forever.
  final DateTime? ignoredUntil;

  Flag({
    required this.type,
    required this.firstFlagged,
    required this.mostRecentlyFlagged,
    this.ignoredUntil,
  });

  static Flag? fromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    return Flag(
      type: FlagType.values[json['type'] as int],
      firstFlagged:
          DateTime.fromMillisecondsSinceEpoch(json['firstFlagged'] as int),
      mostRecentlyFlagged: DateTime.fromMillisecondsSinceEpoch(
          json['mostRecentlyFlagged'] as int),
      ignoredUntil: json['ignoredUntil'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              1000 * json['ignoredUntil'] as int,
            ),
    );
  }

  @override
  String toString() {
    return 'Flag{type: $type, firstFlagged: $firstFlagged, mostRecentlyFlagged: $mostRecentlyFlagged, ignoredUntil: $ignoredUntil}';
  }
}
