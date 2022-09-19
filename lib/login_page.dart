

import 'package:flutter/material.dart';

import 'login_provider.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String username = '';
  String password = '';

  void setPassword(text){
    password = text;
  }
  void setUsername(text){
    username = text;
  }

  handleAuthentication() async {
    bool authenticated = await LoginProvider.performLogin(username, password);
    if (!mounted) return;
    if (!authenticated){
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
        content: Text("Credenciais inválidas!"),
        behavior: SnackBarBehavior.floating,
      ));
    }else{
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
          content: Text("Login realizado com sucesso!"),
          behavior: SnackBarBehavior.floating
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DefaultTextInput(label: 'Usuário', onTextChange: setUsername),
              const SizedBox(height: 10),
              DefaultTextInput(label: 'Senha', onTextChange: setPassword, isPassword: true),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: handleAuthentication,
                child: const Text('Entrar'),
              ),
            ],
          ),
        )
    );
  }
}

class DefaultTextInput extends StatelessWidget {
  const DefaultTextInput({Key? key, required this.label,
    required this.onTextChange, this.isPassword = false}) : super(key: key);

  final String label;
  final Function(String) onTextChange;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textDirection: TextDirection.ltr,
      obscureText: isPassword,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: (text){
        onTextChange(text);
      },
    );
  }
}