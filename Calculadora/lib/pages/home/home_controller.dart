// import 'package:top_snackbar_flutter/custom_snack_bar.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';
// import 'package:upgrader/upgrader.dart';

// import 'package:flutter/material.dart';

// class HomeController {
//   final BuildContext context;

//   HomeController(this.context);

//   Future<void> checkForUpdates() async {
//     final upgrader = Upgrader();
//     upgrader.initialize();

//     bool updateAvailable = await upgrader.isUpdateAvailable();

//     if (updateAvailable) {
//       _showSnackBar("Nova versão disponível! Atualize o app.", Colors.blue);
//     } else {
//       _showSnackBar("Nenhuma nova versão disponível.", Colors.green);
//     }
//   }

//   void _showSnackBar(String message, Color color) {
//     final overlay = Overlay.of(context);
//     showTopSnackBar(
//       overlay,
//       CustomSnackBar.info(
//         message: message,
//         backgroundColor: color,
//       ),
//     );
//   }
// }
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:upgrader/upgrader.dart';

import 'package:flutter/material.dart';

class HomeController {
  final BuildContext context;

  HomeController(this.context);

  Future<void> checkForUpdates() async {
    final upgrader = Upgrader();
    upgrader.initialize();

    bool updateAvailable = await upgrader.isUpdateAvailable();

    if (updateAvailable) {
      _showSnackBar("Nova versão disponível! Atualize o app.", Colors.blue);
    } else {
      _showSnackBarSuccess("Nenhuma nova versão disponível.", Colors.green);
    }
  }

  void _showSnackBar(String message, Color color) {
    final overlay = Overlay.of(context);
    showTopSnackBar(
      overlay!,
      CustomSnackBar.info(
        message: message,
        backgroundColor: color,
      ),
    );
  }

  void _showSnackBarSuccess(String message, Color color) {
    final overlay = Overlay.of(context);
    showTopSnackBar(
      overlay!,
      CustomSnackBar.success(
        message: message,
        backgroundColor: color,
      ),
    );
  }

  double evaluateExpression(String expression) {
    try {
      // Remove espaços e substitui operadores inválidos
      final sanitizedExpression = _sanitizeExpression(expression);
      // Avalia a expressão
      return _evaluateMathExpression(sanitizedExpression);
    } catch (e) {
      return double.nan; // Retorna NaN em caso de erro
    }
  }

  String _sanitizeExpression(String expression) {
    // Remove espaços
    return expression.replaceAll(' ', '');
  }

  double _evaluateMathExpression(String expression) {
    // Função para avaliar expressões matemáticas básicas
    final expressionWithOperators =
        expression.replaceAll('×', '*').replaceAll('÷', '/');
    try {
      final result = double.parse(expressionWithOperators);
      return result;
    } catch (e) {
      // Avaliar expressões matemáticas com operadores
      try {
        // Calcula o resultado das operações matemáticas
        final result = _calculateResult(expressionWithOperators);
        return result;
      } catch (e) {
        return double.nan; // Retorna NaN em caso de erro
      }
    }
  }

  double _calculateResult(String expression) {
    // Implementa avaliação simples de expressões matemáticas
    // Suporta +, -, *, /
    final sanitizedExpression =
        expression.replaceAll('×', '*').replaceAll('÷', '/');
    final result = _evaluateBasicExpression(sanitizedExpression);
    return result;
  }

  double _evaluateBasicExpression(String expression) {
    final operators = ['+', '-', '*', '/'];
    double result = 0.0;
    int operatorIndex = -1;

    // Encontra o operador principal e divide a expressão
    for (String operator in operators) {
      operatorIndex = expression.indexOf(operator);
      if (operatorIndex != -1) {
        break;
      }
    }

    if (operatorIndex == -1) {
      // Se não há operadores, a expressão é um número
      result = double.parse(expression);
    } else {
      // Divide a expressão em operandos
      final leftOperand = expression.substring(0, operatorIndex);
      final rightOperand = expression.substring(operatorIndex + 1);
      final operator = expression[operatorIndex];

      final leftResult = _evaluateBasicExpression(leftOperand);
      final rightResult = _evaluateBasicExpression(rightOperand);

      switch (operator) {
        case '+':
          result = leftResult + rightResult;
          break;
        case '-':
          result = leftResult - rightResult;
          break;
        case '*':
          result = leftResult * rightResult;
          break;
        case '/':
          result = leftResult / rightResult;
          break;
      }
    }

    return result;
  }
}
