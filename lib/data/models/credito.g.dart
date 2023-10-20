// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credito.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Credito _$CreditoFromJson(Map<String, dynamic> json) => Credito(
      id: json['id'] as int?,
      tipoCredito: json['tipoCredito'] as String,
      salarioBase: json['salarioBase'] as String,
      maximoPrestamo: json['maximoPrestamo'] as String,
      cuotaCredito: json['cuotaCredito'] as String,
      anualInterest: (json['anualInterest'] as num).toDouble(),
      term: json['term'] as int,
      idUsuario: json['idUsuario'] as String,
    );

Map<String, dynamic> _$CreditoToJson(Credito instance) => <String, dynamic>{
      'id': instance.id,
      'tipoCredito': instance.tipoCredito,
      'salarioBase': instance.salarioBase,
      'maximoPrestamo': instance.maximoPrestamo,
      'cuotaCredito': instance.cuotaCredito,
      'anualInterest': instance.anualInterest,
      'term': instance.term,
      'idUsuario': instance.idUsuario,
    };
