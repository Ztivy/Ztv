
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ztv/firebase/email_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
    final conEmail = TextEditingController();
    final conPass = TextEditingController();
    
    @override
    Widget build(BuildContext context) {
      final EmailAuth emailAuth = EmailAuth();
      final txtEmail = TextFormField(
        controller: conEmail,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        )
      );
      final txtPass = TextFormField(
        obscureText: true,
        controller: conPass,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        )
      );
      final btnRegister = SizedBox(
        width: double.infinity,
        child: InkWell(
          onTap: () async {
            try {
              await emailAuth.createUser(conEmail.text, conPass.text).then((value) {
                Future.delayed(Duration(milliseconds: 2000)).then((value) => Navigator.pushNamed(context, '/dash'));
              });
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${e.toString()}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            child: Text('Registrar', style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
      );

      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [const Positioned
              (
                top: 200,
                child: SizedBox(
                  width: 300,
                ),
              ),
              Positioned(
                child: Container(
                  height: 400,
                  width: 400,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 70, 70, 70).withOpacity(0.5)
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [ 
                      txtEmail,
                      txtPass,
                      btnRegister
                    ],
                  ),
                )
              ),        
            ]
          )
        ),
      );
    }
}