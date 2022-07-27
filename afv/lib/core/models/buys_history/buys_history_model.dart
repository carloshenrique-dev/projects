import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'buys_history_items_model.dart';

class BuysHistoryModel {
  final String title;
  final List<BuysHistoryItemsModel> items;
  BuysHistoryModel({
    required this.title,
    required this.items,
  });

  BuysHistoryModel copyWith({
    String? title,
    List<BuysHistoryItemsModel>? items,
  }) {
    return BuysHistoryModel(
      title: title ?? this.title,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory BuysHistoryModel.fromMap(Map<String, dynamic> map) {
    return BuysHistoryModel(
      title: map['title'] ?? '',
      items: List<BuysHistoryItemsModel>.from(
          map['items']?.map((x) => BuysHistoryItemsModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory BuysHistoryModel.fromJson(String source) =>
      BuysHistoryModel.fromMap(json.decode(source));

  @override
  String toString() => 'BuysHistoryModel(title: $title, items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BuysHistoryModel &&
        other.title == title &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode => title.hashCode ^ items.hashCode;
}
