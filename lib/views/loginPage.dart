import 'package:flutter/material.dart';

import '../database/database.dart';
import '../models/user_model.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {

  final _formkey =  GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _databaseHelper = DatabaseHelper();

  late bool _isHidden = true;

  void passwordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final List<UserModel?> users = await _databaseHelper.getUsers();
    final user = users.firstWhere(
      (user) => user?.email == email && user?.password == password,
      orElse: () => null,
    );

    if (user != null) {
      // Se o usuário existe, redirecione para a tela de contatos
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/home');
    } else {
      // Caso contrário, exiba uma mensagem de erro
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro'),
          content: const Text('Credenciais inválidas.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Instituto_Federal_do_Piau%C3%AD_-_Marca_Vertical_2015.svg/800px-Instituto_Federal_do_Piau%C3%AD_-_Marca_Vertical_2015.svg.png',
                  height: 200,
                ),

                const SizedBox(height: 100,),
        
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                    hintText: 'nome@email.com',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.mail),
                  ),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Por favor, digite seu e-mail';
                    }else if(
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_emailController.text)
                    ){
                      return 'Por favor, digite um e-mail válido';
                    }
                    return null;
                  },
                ),
        
                const SizedBox(height: 20,),

                TextFormField(
                  obscureText: _isHidden,
                  decoration: InputDecoration(
                    label: const Text('Senha'),
                    hintText: 'Digite sua senha',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.key),
                    suffix: InkWell(
                      onTap: passwordView,
                      child: Icon(
                        _isHidden 
                        ? Icons.visibility 
                        : Icons.visibility_off,
                      ),
                    ),
                  ),
                  controller: _passwordController,
                  validator: (senha) {
                    if (senha == null || senha.isEmpty) {
                      return 'Por favor, digite sua senha';
                    } else if(senha.length < 6){
                      return 'Por favor, digite uma senha com no mínimo 6 dígitos';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20,),

                SizedBox(
                  height: 50,

                  child: ElevatedButton(
                    onPressed: (){
                      if (_formkey.currentState!.validate()) {
                        logar();
                        _login();
                      }
                    }, 
                    child: const Text(
                      'Entrar', 
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )
                  )
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: (){ Navigator.pushNamed(context, '/singup');},
                  child: Text('Criar novo usuário'),
                ),

                
              ],
            ),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){ Navigator.pushNamed(context, '/home');},
        tooltip: 'Home',
        child: const Icon(Icons.home),
      ),
    );
  }

  logar() async {
    print('Logado!');
  }

}
