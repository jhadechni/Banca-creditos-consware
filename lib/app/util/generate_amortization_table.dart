import 'dart:math';

import 'package:prueba_tecnica_consware/app/util/currency_formatter.dart';

List<List<String>> generateAmortizationTable({
  required double loanAmount,
  required double annualInterestRate,
  required int loanTermInMonths,
}) {
  List<List<String>> amortizationTable = [];

  double monthlyInterestRate = annualInterestRate / 12 / 100;
  double monthlyPayment = (loanAmount * monthlyInterestRate) /
      (1 - pow(1 + monthlyInterestRate, -loanTermInMonths));

  double remainingBalance = loanAmount;

  for (int i = 1; i <= loanTermInMonths; i++) {
    double interestPayment = remainingBalance * monthlyInterestRate;
    double principalPayment = monthlyPayment - interestPayment;

    remainingBalance -= principalPayment;

    amortizationTable.add([
      i.toString(), // B. Número de la cuota
      Formatter.formatNumberCOP(monthlyPayment.toStringAsFixed(2)), // C. Cuota
      Formatter.formatNumberCOP(
          interestPayment.toStringAsFixed(2)), // D. Interés
      '+${Formatter.formatNumberCOP(principalPayment.toStringAsFixed(2))}', // E. Abono a capital
      Formatter.formatNumberCOP(
          remainingBalance.toStringAsFixed(2)), // F. Saldo del periodo
    ]);
  }

  return amortizationTable;
}
