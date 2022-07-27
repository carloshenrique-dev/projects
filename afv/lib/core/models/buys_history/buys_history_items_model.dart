import 'dart:convert';

class BuysHistoryItemsModel {
  final String? itemTitle;
  final String? itemValue;
  BuysHistoryItemsModel({
    this.itemTitle,
    this.itemValue,
  });

  BuysHistoryItemsModel copyWith({
    String? itemTitle,
    String? itemValue,
  }) {
    return BuysHistoryItemsModel(
      itemTitle: itemTitle ?? this.itemTitle,
      itemValue: itemValue ?? this.itemValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemTitle': itemTitle,
      'itemValue': itemValue,
    };
  }

  factory BuysHistoryItemsModel.fromMap(Map<String, dynamic> map) {
    return BuysHistoryItemsModel(
      itemTitle: map['itemTitle'],
      itemValue: map['itemValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BuysHistoryItemsModel.fromJson(String source) =>
      BuysHistoryItemsModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'BuysHistoryItemsModel(itemTitle: $itemTitle, itemValue: $itemValue)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BuysHistoryItemsModel &&
        other.itemTitle == itemTitle &&
        other.itemValue == itemValue;
  }

  @override
  int get hashCode => itemTitle.hashCode ^ itemValue.hashCode;
}
