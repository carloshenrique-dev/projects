import 'dart:convert';

class CustomersAddressModel {
  final String? address;
  final String? numberAddress;
  final String? neighborhood;
  final String? city;
  final String? complement;
  final String? postalCode;
  final String? state;
  final String? type;
  final int? addressCode;
  final int? customerCode;
  CustomersAddressModel({
    this.address,
    this.numberAddress,
    this.neighborhood,
    this.city,
    this.complement,
    this.postalCode,
    this.state,
    this.type,
    this.addressCode,
    this.customerCode,
  });

  CustomersAddressModel copyWith({
    String? address,
    String? numberAddress,
    String? neighborhood,
    String? city,
    String? complement,
    String? postalCode,
    String? state,
    String? type,
    int? addressCode,
    int? customerCode,
  }) {
    return CustomersAddressModel(
      address: address ?? this.address,
      numberAddress: numberAddress ?? this.numberAddress,
      neighborhood: neighborhood ?? this.neighborhood,
      city: city ?? this.city,
      complement: complement ?? this.complement,
      postalCode: postalCode ?? this.postalCode,
      state: state ?? this.state,
      type: type ?? this.type,
      addressCode: addressCode ?? this.addressCode,
      customerCode: customerCode ?? this.customerCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'numberAddress': numberAddress,
      'neighborhood': neighborhood,
      'city': city,
      'complement': complement,
      'postalCode': postalCode,
      'state': state,
      'type': type,
      'addressCode': addressCode,
      'customerCode': customerCode,
    };
  }

  factory CustomersAddressModel.fromMap(Map<String, dynamic> map) {
    return CustomersAddressModel(
      address: map['address'],
      numberAddress: map['numberAddress'],
      neighborhood: map['neighborhood'],
      city: map['city'],
      complement: map['complement'],
      postalCode: map['postalCode'],
      state: map['state'],
      type: map['type'],
      addressCode: map['addressCode']?.toInt(),
      customerCode: map['customerCode']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomersAddressModel.fromJson(Map<String, dynamic> json) {
    return CustomersAddressModel(
      address: json['Address'],
      numberAddress: json['NumberAdress'],
      neighborhood: json['Neighborhood'],
      city: json['City'],
      complement: json['Complement'],
      postalCode: json['PostalCode'],
      state: json['State'],
      type: json['Type'],
      addressCode: json['AddressCode']?.toInt(),
      customerCode: json['customerCode']?.toInt(),
    );
  }

  @override
  String toString() {
    return 'CustomersAddressModel(address: $address, numberAddress: $numberAddress, neighborhood: $neighborhood, city: $city, complement: $complement, postalCode: $postalCode, state: $state, type: $type, addressCode: $addressCode, customerCode: $customerCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomersAddressModel &&
        other.address == address &&
        other.numberAddress == numberAddress &&
        other.neighborhood == neighborhood &&
        other.city == city &&
        other.complement == complement &&
        other.postalCode == postalCode &&
        other.state == state &&
        other.type == type &&
        other.addressCode == addressCode &&
        other.customerCode == customerCode;
  }

  @override
  int get hashCode {
    return address.hashCode ^
        numberAddress.hashCode ^
        neighborhood.hashCode ^
        city.hashCode ^
        complement.hashCode ^
        postalCode.hashCode ^
        state.hashCode ^
        type.hashCode ^
        addressCode.hashCode ^
        customerCode.hashCode;
  }
}
