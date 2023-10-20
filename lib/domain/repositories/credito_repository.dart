import 'package:prueba_tecnica_consware/data/models/credito.dart';

abstract class CreditoRepository {
  Future<bool> guardarCotizacion(Credito credito);
  Future<List<Map<String, dynamic>>> getAllCotizaciones(String email);
  Future<Credito> getCotizacion(int id);
}
