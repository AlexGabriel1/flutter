import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: 'imc', home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String info = 'Informe seus dados';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void ResetFields() {
    pesoController.text = " ";
    alturaController.text = " ";
    setState(() {
      info = 'Informe seus dados';
    });
  }

  void calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      print(imc);
      if (imc < 18.6) {
        info = 'Abaixo do peso ideal   IMC :${imc.toStringAsPrecision(4)}';
      } else if (imc > 18.6 && imc < 25) {
        info = 'Peso normal   IMC : ${imc.toStringAsPrecision(4)}';
      } else if (imc > 25 && imc < 30) {
        info = 'Sobrepeso   IMC : ${imc.toStringAsPrecision(4)}';
      } else if (imc > 30 && imc < 35) {
        info = 'Obesidade Grau I   IMC : ${imc.toStringAsPrecision(4)}';
      } else if (imc > 35 && imc < 40) {
        info = 'Obesidade Grau II   IMC : ${imc.toStringAsPrecision(4)}';
      } else if (imc > 40) {
        info = 'Obesidade Grau III   IMC : ${imc.toStringAsPrecision(4)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora IMC'),
          centerTitle: true,
          backgroundColor: Colors.lightGreenAccent,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: ResetFields),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(Icons.person_outline,
                        size: 120, color: Colors.redAccent),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Digite seu peso (kg)',
                          labelStyle: TextStyle(color: Colors.green),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green, fontSize: 25),
                        controller: pesoController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Insira seu peso';
                          }
                        }),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Digite sua altura (cm)',
                        labelStyle: TextStyle(color: Colors.green),
                      ),
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Colors.green, fontSize: 25),
                      controller: alturaController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Insira sua altura';
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Container(
                          height: 60.0,
                          child: RaisedButton(
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                calcular();
                              }
                            },
                            child: Text(
                              'Calcular',
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.green,
                          )),
                    ),
                    Text(
                      info,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 25),
                    )
                  ],
                ))));
  }
}
