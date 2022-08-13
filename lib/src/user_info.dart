import 'physical_address.dart';

class UserInfo {
  final String? userId;
  final String? userEmail;
  final String? userPhone;
  final String? userName;
  final String? userImage;
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
