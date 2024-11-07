import 'package:fastlearners_frontend_flutter/home_screen.dart';
import 'package:fastlearners_frontend_flutter/login_screen.dart';
import 'package:flutter/material.dart';

class PayMethodScreen extends StatefulWidget {
  @override
  _PayMethodScreenState createState() => _PayMethodScreenState();
}

class _PayMethodScreenState extends State<PayMethodScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleNameController = TextEditingController();
  final TextEditingController _numberCardController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateExpireController = TextEditingController();
  final TextEditingController _securityNumberController = TextEditingController();
  final TextEditingController _cardNicknameController = TextEditingController();
  bool _isCardNicknameVisible = false;
  bool _isLoading = false;

  String? _validateNameTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }
    return null;
  }

  String? _validateNumberCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'El numero de tarjeta es requerido';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo es requerido';
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Ingresa un correo válido';
    }
    return null;
  }
  String? _validateDateExpire(String? value) {
    return null;
  }
  String? _validateSecurityNumber(String? value) {
    return null;
  }


  String? _validateCardNickname(String? value) {
   return null;
  }
  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registro exitoso')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Methods"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child:  Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'Añadir pago por tarjeta',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextFormField(
                            controller: _titleNameController,
                            decoration: InputDecoration(
                              labelText: 'Numero del titular',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            autofocus: true,
                            validator: _validateNameTitle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextFormField(
                            controller: _numberCardController,
                            decoration: InputDecoration(
                              labelText: 'Numero de la tarjeta',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            validator: _validateNumberCard,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: SizedBox(
                                width: 300,
                                child: TextField(
                                  controller: _dateExpireController,
                                  decoration: InputDecoration(
                                    labelText: 'Fecha de expiración',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                ),
                                  keyboardType: TextInputType.datetime,
                              )
                            )
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                                child: SizedBox(
                                    width: 300,
                                    child: TextField(
                                      controller: _securityNumberController,
                                      decoration: InputDecoration(
                                        labelText: 'Codigo de seguridad',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                      ),
                                    )
                                )
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Correo electrónico',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: _validateEmail,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextFormField(
                            controller: _cardNicknameController,
                            decoration: InputDecoration(
                              labelText: 'Apodo de tarjeta (opcional)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            obscureText: !_isCardNicknameVisible,
                            validator: _validateCardNickname,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _register,
                          child: _isLoading
                              ? CircularProgressIndicator(
                            valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                              : const Text('Registrarse', style: TextStyle(color: Colors.black)),
                        )
                      ],
                    ),

                ),
                Container(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: const Text(
                              '¿Ya tienes una cuenta? Inicia sesión aquí',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                          ]
                    )
                )
              ]
          ),
        )
      )
    );
  }

}