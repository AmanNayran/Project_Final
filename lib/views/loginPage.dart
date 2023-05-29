import 'package:flutter/material.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {

  final _formkey =  GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late bool _isHidden = true;

  void passwordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
        
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                    hintText: 'nome@email.com'
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
        
                TextFormField(
                  obscureText: _isHidden,
                  decoration: InputDecoration(
                    label: Text('Senha'),
                    hintText: 'Digite sua senha',
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

                SizedBox(height: 20,),
        
                ElevatedButton(
                  onPressed: (){
                    if (_formkey.currentState!.validate()) {
                      logar();
                    }
                  }, 
                  child: Text('Entrar',)
                )
              ],
            ),
          ),
        )
      )
    );
  }

  logar() async {
    print('Logado!');
  }

}
