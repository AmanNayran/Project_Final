import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Project Final'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(50),
          child: SingleChildScrollView(
            child: Column(
              
              children: [
        
                Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Instituto_Federal_do_Piau%C3%AD_-_Marca_Vertical_2015.svg/800px-Instituto_Federal_do_Piau%C3%AD_-_Marca_Vertical_2015.svg.png',
                  height: 200,
                ),
        
                const SizedBox(height: 100,),
        
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 200,
        
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/contact');
                          }, 
                          child: const Text(
                            'Contatos', 
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          )
                        ),
                      ) 
                    ),
        
                    const SizedBox(width: 20,),
        
                    Expanded(
                      child: SizedBox(
                        height: 200,
        
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/');
                          }, 
                          child: const Text(
                            'Mapa', 
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          )
                        ),
                      ) 
                    ),
                  ],
                ),
        
                const SizedBox(height: 20,),
        
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 200,
        
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/');
                          }, 
                          child: const Text(
                            'Extra', 
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          )
                        ),
                      ) 
                    ),
        
                    const SizedBox(width: 20,),
        
                    Expanded(
                      child: SizedBox(
                        height: 200,
        
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/');
                          }, 
                          child: const Text(
                            'Extra', 
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          )
                        ),
                      ) 
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
