import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    this.id,
    required this.name,
    required this.identification,
    required this.email,
    required this.password,
  });

  int? id;
  final String name;
  final String identification;
  final String email;
  final String password;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
