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

import 'physical_address.dart';

class UserInfo {
  /// The user's unique identifier.
  final String? userId;

  /// The user's email address.
  final String? userEmail;

  /// The user's phone number.
  final String? userPhone;

  /// The user's name.
  final String? userName;

  /// The URL of the user's profile picture.
  final String? userImage;

  /// Some custom values about the user.
  final dynamic customerSuppliedValues;

  /// Address information, this would typically be shipping or home address
  List<PhysicalAddress> addresses;

  UserInfo({
    this.userId,
    this.userEmail,
    this.userPhone,
    this.userName,
    this.userImage,
    this.customerSuppliedValues,
    this.addresses = const [],
  });

  static UserInfo? fromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    return UserInfo(
      userId: json['userId'] as String?,
      userEmail: json['userEmail'] as String?,
      userPhone: json['userPhone'] as String?,
      userName: json['userName'] as String?,
      userImage: json['userImage'] as String?,
      customerSuppliedValues: json['customerSuppliedValues'],
      addresses: json['addresses'] == null
          ? []
          : (json['addresses'] as List<dynamic>)
              .map((address) => PhysicalAddress.fromJson(address)!)
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'userName': userName,
      'userImage': userImage,
      'customerSuppliedValues': customerSuppliedValues,
      'addresses': addresses.map((address) => address.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'UserInfo{userId: $userId, userEmail: $userEmail, userPhone: $userPhone, userName: $userName, userImage: $userImage, customerSuppliedValues: $customerSuppliedValues, addresses: $addresses}';
  }
}
