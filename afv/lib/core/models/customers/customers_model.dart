import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:up_afv/core/models/customers/customers_address_model.dart';

class CustomersModel {
  final int? customerCode;
  final String? corporateName;
  final String? commercialName;
  final String? cnpjCpf;
  final String? ieRg;
  final String? phones;
  final String? contact;
  final String? activityArea;
  final String? sellerName;
  final String? paymentCondition;
  final String? attendance;
  final String? sectorCode;
  final int? sequency;
  final double? creditLimValue;
  final String? creditLimDate;
  final int? qtyOpenBond;
  final int? maxAmountExpiredBond;
  final String? active;
  final String? priceList;
  final int? paymentConditionCode;
  final String? mail;
  final String? eppMe;
  final int? activityAreaCode;
  final int? itineraryCode;
  final List<CustomersAddressModel>? customersAddressModel;
  CustomersModel({
    this.customerCode,
    this.corporateName,
    this.commercialName,
    this.cnpjCpf,
    this.ieRg,
    this.phones,
    this.contact,
    this.activityArea,
    this.sellerName,
    this.paymentCondition,
    this.attendance,
    this.sectorCode,
    this.sequency,
    this.creditLimValue,
    this.creditLimDate,
    this.qtyOpenBond,
    this.maxAmountExpiredBond,
    this.active,
    this.priceList,
    this.paymentConditionCode,
    this.mail,
    this.eppMe,
    this.activityAreaCode,
    this.itineraryCode,
    this.customersAddressModel,
  });

  CustomersModel copyWith({
    int? customerCode,
    String? corporateName,
    String? commercialName,
    String? cnpjCpf,
    String? ieRg,
    String? phones,
    String? contact,
    String? activityArea,
    String? sellerName,
    String? paymentCondition,
    String? attendance,
    String? sectorCode,
    int? sequency,
    double? creditLimValue,
    String? creditLimDate,
    int? qtyOpenBond,
    int? maxAmountExpiredBond,
    String? active,
    String? priceList,
    int? paymentConditionCode,
    String? mail,
    String? eppMe,
    int? activityAreaCode,
    int? itineraryCode,
    List<CustomersAddressModel>? customersAddressModel,
  }) {
    return CustomersModel(
      customerCode: customerCode ?? this.customerCode,
      corporateName: corporateName ?? this.corporateName,
      commercialName: commercialName ?? this.commercialName,
      cnpjCpf: cnpjCpf ?? this.cnpjCpf,
      ieRg: ieRg ?? this.ieRg,
      phones: phones ?? this.phones,
      contact: contact ?? this.contact,
      activityArea: activityArea ?? this.activityArea,
      sellerName: sellerName ?? this.sellerName,
      paymentCondition: paymentCondition ?? this.paymentCondition,
      attendance: attendance ?? this.attendance,
      sectorCode: sectorCode ?? this.sectorCode,
      sequency: sequency ?? this.sequency,
      creditLimValue: creditLimValue ?? this.creditLimValue,
      creditLimDate: creditLimDate ?? this.creditLimDate,
      qtyOpenBond: qtyOpenBond ?? this.qtyOpenBond,
      maxAmountExpiredBond: maxAmountExpiredBond ?? this.maxAmountExpiredBond,
      active: active ?? this.active,
      priceList: priceList ?? this.priceList,
      paymentConditionCode: paymentConditionCode ?? this.paymentConditionCode,
      mail: mail ?? this.mail,
      eppMe: eppMe ?? this.eppMe,
      activityAreaCode: activityAreaCode ?? this.activityAreaCode,
      itineraryCode: itineraryCode ?? this.itineraryCode,
      customersAddressModel:
          customersAddressModel ?? this.customersAddressModel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerCode': customerCode,
      'corporateName': corporateName,
      'commercialName': commercialName,
      'cnpjCpf': cnpjCpf,
      'ieRg': ieRg,
      'phones': phones,
      'contact': contact,
      'activityArea': activityArea,
      'sellerName': sellerName,
      'paymentCondition': paymentCondition,
      'attendance': attendance,
      'sectorCode': sectorCode,
      'sequency': sequency,
      'creditLimValue': creditLimValue,
      'creditLimDate': creditLimDate,
      'qtyOpenBond': qtyOpenBond,
      'maxAmountExpiredBond': maxAmountExpiredBond,
      'active': active,
      'priceList': priceList,
      'paymentConditionCode': paymentConditionCode,
      'mail': mail,
      'eppMe': eppMe,
      'activityAreaCode': activityAreaCode,
      'itineraryCode': itineraryCode,
      'customersAddressModel':
          customersAddressModel?.map((x) => x.toMap()).toList(),
    };
  }

  factory CustomersModel.fromMap(Map<String, dynamic> map) {
    return CustomersModel(
      customerCode: map['CustomerCode']?.toInt(),
      corporateName: map['CorporateName'] ?? 'S/ razão social cadastrada',
      commercialName: map['CommercialName'] ?? 'S/ nome fantasia cadastrado',
      cnpjCpf: map['CnpjCpf'] ?? 'Sem CPF/CNJ cadastrado',
      ieRg: map['IeRg'] ?? 'S/ Inscição estadual cadastrada',
      phones: map['Phones'] ?? 'S/ telefone cadastrado',
      contact: map['Contact'] ?? 'S/ contato cadastrado',
      activityArea: map['ActivityArea'] ?? 'S/ atividade cadastrada',
      sellerName: map['SellerName'] ?? 'S/ nome do vendedor cadastrado',
      paymentCondition:
          map['PaymentCondition'] ?? 'S/ condição de pagamento cadastrada',
      attendance: map['Attendance'] ?? 'S/ informação',
      sectorCode: map['SectorCode'] ?? 'S/ código de setor cadastrado',
      sequency: map['Sequency']?.toInt(),
      creditLimValue: map['CreditLimValue']?.toDouble(),
      creditLimDate: map['CreditLimDate'] ?? '',
      qtyOpenBond: map['QtyOpenBond']?.toInt(),
      maxAmountExpiredBond: map['MaxAmountExpiredBond']?.toInt(),
      active: map['Active'] ?? 'S/ atividade cadastrada',
      priceList: map['PriceList'] ?? 'S/ lista de preço cadastrada',
      paymentConditionCode: map['PaymentConditionCode']?.toInt(),
      mail: map['Mail'] ?? 'S/ e-mail cadastrado',
      eppMe: map['eppMe'],
      activityAreaCode: map['activityAreaCode']?.toInt(),
      itineraryCode: map['itineraryCode']?.toInt(),
      customersAddressModel: map['customersAddressModel'] != null
          ? List<CustomersAddressModel>.from(map['customersAddressModel']
              ?.map((x) => CustomersAddressModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomersModel.fromJson(Map<String, dynamic> json) {
    return CustomersModel(
      customerCode: json['CustomerCode']?.toInt(),
      corporateName: json['CorporateName'] ?? 'S/ razão social cadastrada',
      commercialName: json['CommercialName'] ?? 'S/ nome fantasia cadastrado',
      cnpjCpf: json['CnpjCpf'] ?? 'Sem CPF/CNJ cadastrado',
      ieRg: json['IeRg'] ?? 'S/ Inscição estadual cadastrada',
      phones: json['Phones'] ?? 'S/ telefone cadastrado',
      contact: json['Contact'] ?? 'S/ contato cadastrado',
      activityArea: json['ActivityArea'] ?? 'S/ atividade cadastrada',
      sellerName: json['SellerName'] ?? 'S/ nome do vendedor cadastrado',
      paymentCondition:
          json['PaymentCondition'] ?? 'S/ condição de pagamento cadastrada',
      attendance: json['Attendance'] ?? 'S/ informação',
      sectorCode: json['SectorCode'] ?? 'S/ código de setor cadastrado',
      sequency: json['Sequency']?.toInt(),
      creditLimValue: json['CreditLimValue']?.toDouble(),
      creditLimDate: json['CreditLimDate'] ?? '',
      qtyOpenBond: json['QtyOpenBond']?.toInt(),
      maxAmountExpiredBond: json['MaxAmountExpiredBond']?.toInt(),
      active: json['Active'] ?? 'S/ atividade cadastrada',
      priceList: json['PriceList'] ?? 'S/ lista de preço cadastrada',
      paymentConditionCode: json['PaymentConditionCode']?.toInt(),
      mail: json['Mail'] ?? 'S/ e-mail cadastrado',
      eppMe: json['EppMe'] ?? '',
      activityAreaCode: json['ActivityAreaCode']?.toInt(),
      itineraryCode: json['ItineraryCode']?.toInt(),
      customersAddressModel: List<CustomersAddressModel>.from(
          json['custumerAddresses']
              ?.map((x) => CustomersAddressModel.fromJson(x))),
    );
  }

  @override
  String toString() {
    return 'CustomersModel(customerCode: $customerCode, corporateName: $corporateName, commercialName: $commercialName, cnpjCpf: $cnpjCpf, ieRg: $ieRg, phones: $phones, contact: $contact, activityArea: $activityArea, sellerName: $sellerName, paymentCondition: $paymentCondition, attendance: $attendance, sectorCode: $sectorCode, sequency: $sequency, creditLimValue: $creditLimValue, creditLimDate: $creditLimDate, qtyOpenBond: $qtyOpenBond, maxAmountExpiredBond: $maxAmountExpiredBond, active: $active, priceList: $priceList, paymentConditionCode: $paymentConditionCode, mail: $mail, eppMe: $eppMe, activityAreaCode: $activityAreaCode, itineraryCode: $itineraryCode, customersAddressModel: $customersAddressModel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomersModel &&
        other.customerCode == customerCode &&
        other.corporateName == corporateName &&
        other.commercialName == commercialName &&
        other.cnpjCpf == cnpjCpf &&
        other.ieRg == ieRg &&
        other.phones == phones &&
        other.contact == contact &&
        other.activityArea == activityArea &&
        other.sellerName == sellerName &&
        other.paymentCondition == paymentCondition &&
        other.attendance == attendance &&
        other.sectorCode == sectorCode &&
        other.sequency == sequency &&
        other.creditLimValue == creditLimValue &&
        other.creditLimDate == creditLimDate &&
        other.qtyOpenBond == qtyOpenBond &&
        other.maxAmountExpiredBond == maxAmountExpiredBond &&
        other.active == active &&
        other.priceList == priceList &&
        other.paymentConditionCode == paymentConditionCode &&
        other.mail == mail &&
        other.eppMe == eppMe &&
        other.activityAreaCode == activityAreaCode &&
        other.itineraryCode == itineraryCode &&
        listEquals(other.customersAddressModel, customersAddressModel);
  }

  @override
  int get hashCode {
    return customerCode.hashCode ^
        corporateName.hashCode ^
        commercialName.hashCode ^
        cnpjCpf.hashCode ^
        ieRg.hashCode ^
        phones.hashCode ^
        contact.hashCode ^
        activityArea.hashCode ^
        sellerName.hashCode ^
        paymentCondition.hashCode ^
        attendance.hashCode ^
        sectorCode.hashCode ^
        sequency.hashCode ^
        creditLimValue.hashCode ^
        creditLimDate.hashCode ^
        qtyOpenBond.hashCode ^
        maxAmountExpiredBond.hashCode ^
        active.hashCode ^
        priceList.hashCode ^
        paymentConditionCode.hashCode ^
        mail.hashCode ^
        eppMe.hashCode ^
        activityAreaCode.hashCode ^
        itineraryCode.hashCode ^
        customersAddressModel.hashCode;
  }
}
