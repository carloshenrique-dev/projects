import 'dart:convert';

class FinancialPositionsItemsModel {
  final int? customerCode;
  final int? subsidiaryCode;
  final int? titleCode;
  final int? installment;
  final String? type;
  final String? issueDate;
  final String? originalIssueDate;
  final String? dueDate;
  final double? amountInstallment;
  final int? ticketNumber;
  final String? paymentDate;
  final double? amountInterest;
  final double? discount;
  final double? amountPaid;
  final String? series;
  final int? installmentsQty;
  FinancialPositionsItemsModel({
    this.customerCode,
    this.subsidiaryCode,
    this.titleCode,
    this.installment,
    this.type,
    this.issueDate,
    this.originalIssueDate,
    this.dueDate,
    this.amountInstallment,
    this.ticketNumber,
    this.paymentDate,
    this.amountInterest,
    this.discount,
    this.amountPaid,
    this.series,
    this.installmentsQty,
  });

  FinancialPositionsItemsModel copyWith({
    int? customerCode,
    int? subsidiaryCode,
    int? titleCode,
    int? installment,
    String? type,
    String? issueDate,
    String? originalIssueDate,
    String? dueDate,
    double? amountInstallment,
    int? ticketNumber,
    String? paymentDate,
    double? amountInterest,
    double? discount,
    double? amountPaid,
    String? series,
    int? installmentsQty,
  }) {
    return FinancialPositionsItemsModel(
      customerCode: customerCode ?? this.customerCode,
      subsidiaryCode: subsidiaryCode ?? this.subsidiaryCode,
      titleCode: titleCode ?? this.titleCode,
      installment: installment ?? this.installment,
      type: type ?? this.type,
      issueDate: issueDate ?? this.issueDate,
      originalIssueDate: originalIssueDate ?? this.originalIssueDate,
      dueDate: dueDate ?? this.dueDate,
      amountInstallment: amountInstallment ?? this.amountInstallment,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      paymentDate: paymentDate ?? this.paymentDate,
      amountInterest: amountInterest ?? this.amountInterest,
      discount: discount ?? this.discount,
      amountPaid: amountPaid ?? this.amountPaid,
      series: series ?? this.series,
      installmentsQty: installmentsQty ?? this.installmentsQty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerCode': customerCode,
      'subsidiaryCode': subsidiaryCode,
      'titleCode': titleCode,
      'installment': installment,
      'type': type,
      'issueDate': issueDate,
      'originalIssueDate': originalIssueDate,
      'dueDate': dueDate,
      'amountInstallment': amountInstallment,
      'ticketNumber': ticketNumber,
      'paymentDate': paymentDate,
      'amountInterest': amountInterest,
      'discount': discount,
      'amountPaid': amountPaid,
      'series': series,
      'installmentsQty': installmentsQty,
    };
  }

  factory FinancialPositionsItemsModel.fromMap(Map<String, dynamic> map) {
    return FinancialPositionsItemsModel(
      customerCode: map['CustomerCode']?.toInt(),
      subsidiaryCode: map['SubsidiaryCode']?.toInt(),
      titleCode: map['TitleCode']?.toInt(),
      installment: map['Installment']?.toInt(),
      type: map['Type'],
      issueDate: map['IssueDate'],
      originalIssueDate: map['OriginalIssueDate'],
      dueDate: map['DueDate'],
      amountInstallment: map['AmountInstallment']?.toDouble(),
      ticketNumber: map['TicketNumber']?.toInt(),
      paymentDate: map['PaymentDate'],
      amountInterest: map['AmountInterest']?.toDouble(),
      discount: map['Discount']?.toDouble(),
      amountPaid: map['AmountPaid']?.toDouble(),
      series: map['Series'],
      installmentsQty: map['InstallmentsQty']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory FinancialPositionsItemsModel.fromJson(Map<String, dynamic> json) {
    return FinancialPositionsItemsModel(
      customerCode: json['CustomerCode']?.toInt(),
      subsidiaryCode: json['SubsidiaryCode']?.toInt(),
      titleCode: json['TitleCode']?.toInt(),
      installment: json['Installment']?.toInt(),
      type: json['Type'],
      issueDate: json['IssueDate'],
      originalIssueDate: json['OriginalIssueDate'],
      dueDate: json['DueDate'],
      amountInstallment: json['AmountInstallment']?.toDouble(),
      ticketNumber: json['TicketNumber']?.toInt(),
      paymentDate: json['PaymentDate'],
      amountInterest: json['AmountInterest']?.toDouble(),
      discount: json['Discount']?.toDouble(),
      amountPaid: json['AmountPaid']?.toDouble(),
      series: json['Series'],
      installmentsQty: json['InstallmentsQty']?.toInt(),
    );
  }

  @override
  String toString() {
    return 'FinancialPositionsItemsModel(customerCode: $customerCode, subsidiaryCode: $subsidiaryCode, titleCode: $titleCode, installment: $installment, type: $type, issueDate: $issueDate, originalIssueDate: $originalIssueDate, dueDate: $dueDate, amountInstallment: $amountInstallment, ticketNumber: $ticketNumber, paymentDate: $paymentDate, amountInterest: $amountInterest, discount: $discount, amountPaid: $amountPaid, series: $series, installmentsQty: $installmentsQty)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FinancialPositionsItemsModel &&
        other.customerCode == customerCode &&
        other.subsidiaryCode == subsidiaryCode &&
        other.titleCode == titleCode &&
        other.installment == installment &&
        other.type == type &&
        other.issueDate == issueDate &&
        other.originalIssueDate == originalIssueDate &&
        other.dueDate == dueDate &&
        other.amountInstallment == amountInstallment &&
        other.ticketNumber == ticketNumber &&
        other.paymentDate == paymentDate &&
        other.amountInterest == amountInterest &&
        other.discount == discount &&
        other.amountPaid == amountPaid &&
        other.series == series &&
        other.installmentsQty == installmentsQty;
  }

  @override
  int get hashCode {
    return customerCode.hashCode ^
        subsidiaryCode.hashCode ^
        titleCode.hashCode ^
        installment.hashCode ^
        type.hashCode ^
        issueDate.hashCode ^
        originalIssueDate.hashCode ^
        dueDate.hashCode ^
        amountInstallment.hashCode ^
        ticketNumber.hashCode ^
        paymentDate.hashCode ^
        amountInterest.hashCode ^
        discount.hashCode ^
        amountPaid.hashCode ^
        series.hashCode ^
        installmentsQty.hashCode;
  }
}
