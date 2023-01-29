import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'config.g.dart';

@HiveType(typeId: 1)
class Config extends Equatable {
  @HiveField(0)
  final bool? dynamicColor;
  @HiveField(1)
  final bool? highRefreshRate;
  @HiveField(2)
  final bool? autoSign;
  @HiveField(3)
  final bool? traditionalChinese;

  const Config({
    this.dynamicColor,
    this.highRefreshRate,
    this.autoSign,
    this.traditionalChinese,
  });

  factory Config.fromMap(Map<String, dynamic> data) => Config(
        dynamicColor: data['dynamic_color'] as bool?,
        highRefreshRate: data['high_refresh_rate'] as bool?,
        autoSign: data['auto_sign'] as bool?,
        traditionalChinese: data['traditional_chinese'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'dynamic_color': dynamicColor,
        'high_refresh_rate': highRefreshRate,
        'auto_sign': autoSign,
        'traditional_chinese': traditionalChinese,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Config].
  factory Config.fromJson(String data) {
    return Config.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Config] to a JSON string.
  String toJson() => json.encode(toMap());

  Config copyWith({
    bool? dynamicColor,
    bool? highRefreshRate,
    bool? autoSign,
    bool? traditionalChinese,
  }) {
    return Config(
      dynamicColor: dynamicColor ?? this.dynamicColor,
      highRefreshRate: highRefreshRate ?? this.highRefreshRate,
      autoSign: autoSign ?? this.autoSign,
      traditionalChinese: traditionalChinese ?? this.traditionalChinese,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      dynamicColor,
      highRefreshRate,
      autoSign,
      traditionalChinese,
    ];
  }
}
