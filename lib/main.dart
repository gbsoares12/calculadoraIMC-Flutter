import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double _weight = double.parse(weightController.text);
      double _height = double.parse(heightController.text) / 100;
      double _imc = 0.0;
      _imc = _weight / (_height * _height);
      if (_imc < 18.6) {
        _infoText = "Abaixo do Peso (${_imc.toStringAsPrecision(4)})";
      } else if (_imc >= 18.6 && _imc < 24.9) {
        _infoText = "Peso Ideal (${_imc.toStringAsPrecision(4)})";
      } else if (_imc >= 24.9 && _imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${_imc.toStringAsPrecision(4)})";
      } else if (_imc >= 29.9 && _imc < 34.9) {
        _infoText = "Obesidade Grau I (${_imc.toStringAsPrecision(4)})";
      } else if (_imc >= 34.9 && _imc < 39.9) {
        _infoText = "Obesidade Grau II (${_imc.toStringAsPrecision(4)})";
      } else if (_imc >= 40) {
        _infoText = "Obesidade Grau III (${_imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.black45,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white70,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline, size: 120.0, color: Colors.white),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.white)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 23.0),
                    controller: weightController,
                    validator: (value) {
                      double e = double.tryParse(value);
                      if (value.isEmpty) {
                        return "Insira seu Peso!";
                      } else if (e == null) {
                        return 'Insira somente numeros!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.white)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 23.0),
                    controller: heightController,
                    validator: (value) {
                      double e = double.tryParse(value);
                      if (value.isEmpty) {
                        return "Insira sua Altura!";
                      } else if (e == null) {
                        return 'Insira somente numeros!';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _calculate();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 25.0),
                          ),
                          color: Colors.white),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  )
                ],
              ),
            )));
  }
}
