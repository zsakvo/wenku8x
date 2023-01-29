import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 2)
class Account extends Equatable {
  @HiveField(0)
  final String? username;
  @HiveField(1)
  final String? password;

  const Account({this.username, this.password});

  factory Account.fromMap(Map<String, dynamic> data) => Account(
        username: data['username'] as String?,
        password: data['password'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'username': username,
        'password': password,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Account].
  factory Account.fromJson(String data) {
    return Account.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Account] to a JSON string.
  String toJson() => json.encode(toMap());

  Account copyWith({
    String? username,
    String? password,
  }) {
    return Account(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [username, password];
}
