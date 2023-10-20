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
      anualInterest: (double.parse(json['anualInterest']) as num).toDouble(),
      term: json['term'] as String,
      email: json['email'] as String,
      fecha: json['fecha'] as String,
    );

Map<String, dynamic> _$CreditoToJson(Credito instance) => <String, dynamic>{
      'id': instance.id,
      'tipoCredito': instance.tipoCredito,
      'salarioBase': instance.salarioBase,
      'maximoPrestamo': instance.maximoPrestamo,
      'cuotaCredito': instance.cuotaCredito,
      'anualInterest': instance.anualInterest,
      'term': instance.term,
      'email': instance.email,
      'fecha': instance.fecha,
    };
