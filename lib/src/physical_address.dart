import 'enums/address_type.dart';
import 'postal_address.dart';

class PhysicalAddress {
  final AddressType type;
  final PostalAddress address;

  PhysicalAddress({
    required this.type,
    required this.address,
  });

  static PhysicalAddress? fromJson(dynamic json) {
    if (json == null) return null;
    return PhysicalAddress(
      type: AddressType.values[json['type'] as int],
      address: PostalAddress.fromJson(json['address'] as Map<String, dynamic>)!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.index,
      'address': address.toJson(),
    };
  }

  @override
  String toString() {
    return 'PhysicalAddress{type: $type, address: $address}';
  }
}
