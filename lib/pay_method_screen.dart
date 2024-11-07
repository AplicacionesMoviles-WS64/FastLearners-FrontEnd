import 'package:fastlearners_frontend_flutter/home_screen.dart';
import 'package:fastlearners_frontend_flutter/login_screen.dart';
import 'package:flutter/material.dart';
import '../database/db.dart';
import 'modelo/creditCard.dart';
class PayMethodScreen extends StatefulWidget {
  final String email;

  PayMethodScreen({required this.email});

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
  bool _isLoading = false;
  late Future<List<CreditCard>> _creditCardsFuture;
  final DB _db = DB();

  @override
  void initState() {
    super.initState();
    _loadCreditCards();
  }

  void _loadCreditCards() {
    setState(() {
      _creditCardsFuture = _db.getAllCreditCards();
    });
  }

  String? _validateNameTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }
    return null;
  }

  String? _validateNumberCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'El número de tarjeta es requerido';
    }
    if (value.length != 16) {
      return 'Debe contener 16 dígitos';
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
    if (value == null || value.isEmpty) {
      return 'La fecha de expiración es requerida';
    }
    return null;
  }

  String? _validateSecurityNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'El código de seguridad es requerido';
    }
    if (value.length != 3) {
      return 'Debe contener 3 dígitos';
    }
    return null;
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final newCard = CreditCard(
        cardNumber: _numberCardController.text,
        cardHolderName: _titleNameController.text,
        expirationDate: _dateExpireController.text,
        cvv: _securityNumberController.text,
        nickname: _cardNicknameController.text.isNotEmpty ? _cardNicknameController.text : null,
      );

      await _db.insertCreditCard(newCard);

      setState(() {
        _isLoading = false;
        _loadCreditCards();
      });

      _formKey.currentState!.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tarjeta registrada exitosamente')),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));

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
          child: Column(
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
                          labelText: 'Nombre del titular',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: _validateNameTitle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: TextFormField(
                        controller: _numberCardController,
                        decoration: InputDecoration(
                          labelText: 'Número de la tarjeta',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: _validateNumberCard,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: TextFormField(
                              controller: _dateExpireController,
                              decoration: InputDecoration(
                                labelText: 'Fecha de expiración',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              keyboardType: TextInputType.datetime,
                              validator: _validateDateExpire,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: TextFormField(
                              controller: _securityNumberController,
                              decoration: InputDecoration(
                                labelText: 'Código de seguridad',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: _validateSecurityNumber,
                            ),
                          ),
                        ),
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
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _register,
                      child: _isLoading
                          ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                          : Text('Registrarse', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(254, 95, 85, 1),
                        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}