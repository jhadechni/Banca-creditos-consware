import 'package:json_annotation/json_annotation.dart';
part 'credito.g.dart';

@JsonSerializable()
class Credito {
  Credito({
    this.id,
    required this.tipoCredito,
    required this.salarioBase,
    required this.maximoPrestamo,
    required this.cuotaCredito,
    required this.anualInterest,
    required this.term,
    required this.idUsuario,
  });

  int? id;
  final String tipoCredito;
  final String salarioBase;
  final String maximoPrestamo;
  final String cuotaCredito;
  final double anualInterest;
  final int term;
  final String idUsuario;

  factory Credito.fromJson(Map<String, dynamic> json) =>
      _$CreditoFromJson(json);

  Map<String, dynamic> toJson() => _$CreditoToJson(this);
}
