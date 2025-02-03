import 'package:calculadora/ui/app_bar_geral.dart';

import 'package:calculadora/ui/text_style.dart';
import 'package:flutter/material.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayValue = '';
  String history = '';
  String result = '';
  bool shouldClear = false;

  late HomeController _homeController;

  @override
  void initState() {
    super.initState();
    _homeController = HomeController(context);
    _homeController.checkForUpdates(); // Verifica atualizações ao iniciar
  }

  void _input(String value) {
    setState(() {
      if (shouldClear) {
        displayValue = '';
        shouldClear = false;
      }
      displayValue += value;
    });
  }

  void _calculate() {
    final result = _homeController.evaluateExpression(displayValue);
    setState(() {
      if (result.isNaN) {
        this.result = 'Erro';
      } else {
        this.result = result.toString();
      }
      history += '$displayValue = $result\n';
      shouldClear = true;
    });
  }

  void _clear() {
    setState(() {
      displayValue = '';
      result = '';
      history = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBarGeral(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: context.textStyles.textMedium.copyWith(fontSize: 20),
              decoration: const InputDecoration(fillColor: Colors.grey),
              enabled: false,
              // readOnly: true,
              maxLines: 3,
              controller: TextEditingController(text: history),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: context.textStyles.textExtraBold.copyWith(fontSize: 30),
              decoration: InputDecoration(fillColor: Colors.blue[50]),
              enabled: false,
              // readOnly: true,
              controller: TextEditingController(text: displayValue),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 50,
                          margin: const EdgeInsets.only(left: 40),
                          child: _buildButtonRow(
                            ['7'],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: _buildButtonRow(
                            ['8'],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: _buildButtonRow(
                            ['9'],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: _buildButtonRow(
                            ['/'],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 50,
                          margin: const EdgeInsets.only(left: 40),
                          child: _buildButtonRow(
                            ['4'],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: _buildButtonRow(
                            ['5'],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: _buildButtonRow(
                            ['6'],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: _buildButtonRow(
                            ['*'],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          height: 50,
                          margin: const EdgeInsets.only(left: 40),
                          child: _buildButtonRow(
                            ['1'],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: _buildButtonRow(
                            ['2'],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: _buildButtonRow(
                            ['3'],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: _buildButtonRow(
                            ['-'],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 50,
                          margin: const EdgeInsets.only(left: 40),
                          child: _buildButtonRow(
                            ['0'],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: _buildButtonRow(
                            ['.'],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: _buildButtonRow(
                            ['+'],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: _buildButtonRow(
                            ['='],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(child: _buildButtonRow(['C'], true)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons, [bool isClearButton = false]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((String buttonLabel) {
        return SizedBox(
          width: 80,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: isClearButton ? Colors.red : Colors.blue[200],
                foregroundColor: Colors.black),
            onPressed: () {
              if (buttonLabel == '=') {
                _calculate();
              } else if (buttonLabel == 'C') {
                _clear();
              } else {
                _input(buttonLabel);
              }
            },
            child: Text(buttonLabel),
          ),
        );
      }).toList(),
    );
  }
}
