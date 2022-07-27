import 'dart:convert';

class NotSaleInfoModel {
  int codReason;
  int codCli;
  DateTime dateNotSale;
  String obs;
  double lat;
  double long;
  String gpsEnd;
  String desc;
  String fantasyName;
  String socialReason;
  NotSaleInfoModel({
    required this.codReason,
    required this.codCli,
    required this.dateNotSale,
    required this.obs,
    required this.lat,
    required this.long,
    required this.gpsEnd,
    required this.desc,
    required this.fantasyName,
    required this.socialReason,
  });

  NotSaleInfoModel copyWith({
    int? codReason,
    int? codCli,
    DateTime? dateNotSale,
    String? obs,
    double? lat,
    double? long,
    String? gpsEnd,
    String? desc,
    String? fantasyName,
    String? socialReason,
  }) {
    return NotSaleInfoModel(
      codReason: codReason ?? this.codReason,
      codCli: codCli ?? this.codCli,
      dateNotSale: dateNotSale ?? this.dateNotSale,
      obs: obs ?? this.obs,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      gpsEnd: gpsEnd ?? this.gpsEnd,
      desc: desc ?? this.desc,
      fantasyName: fantasyName ?? this.fantasyName,
      socialReason: socialReason ?? this.socialReason,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'codReason': codReason,
      'codCli': codCli,
      'dateNotSale': dateNotSale.millisecondsSinceEpoch,
      'obs': obs,
      'lat': lat,
      'long': long,
      'gpsEnd': gpsEnd,
      'desc': desc,
      'fantasyName': fantasyName,
      'socialReason': socialReason,
    };
  }

  factory NotSaleInfoModel.fromMap(Map<String, dynamic> map) {
    return NotSaleInfoModel(
      codReason: map['codReason']?.toInt() ?? 0,
      codCli: map['codCli']?.toInt() ?? 0,
      dateNotSale: DateTime.fromMillisecondsSinceEpoch(map['dateNotSale']),
      obs: map['obs'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      long: map['long']?.toDouble() ?? 0.0,
      gpsEnd: map['gpsEnd'] ?? '',
      desc: map['desc'] ?? '',
      fantasyName: map['fantasyName'] ?? '',
      socialReason: map['socialReason'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotSaleInfoModel.fromJson(String source) => NotSaleInfoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotSaleInfoModel(codReason: $codReason, codCli: $codCli, dateNotSale: $dateNotSale, obs: $obs, lat: $lat, long: $long, gpsEnd: $gpsEnd, desc: $desc, fantasyName: $fantasyName, socialReason: $socialReason)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is NotSaleInfoModel &&
      other.codReason == codReason &&
      other.codCli == codCli &&
      other.dateNotSale == dateNotSale &&
      other.obs == obs &&
      other.lat == lat &&
      other.long == long &&
      other.gpsEnd == gpsEnd &&
      other.desc == desc &&
      other.fantasyName == fantasyName &&
      other.socialReason == socialReason;
  }

  @override
  int get hashCode {
    return codReason.hashCode ^
      codCli.hashCode ^
      dateNotSale.hashCode ^
      obs.hashCode ^
      lat.hashCode ^
      long.hashCode ^
      gpsEnd.hashCode ^
      desc.hashCode ^
      fantasyName.hashCode ^
      socialReason.hashCode;
  }
}
