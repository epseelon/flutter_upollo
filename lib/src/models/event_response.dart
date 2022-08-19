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

class EventResponse {
  /// A token which can be sent to your own server so it can dig into the
  /// assessment of a user following events being reported for tracking by
  /// your client application.
  final String eventToken;

  //reserved "validation_signature";

  EventResponse({
    required this.eventToken,
  });

  static EventResponse? fromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    return EventResponse(
      eventToken: json['eventToken'],
    );
  }

  @override
  String toString() {
    return 'EventResponse{eventToken: $eventToken}';
  }
}
