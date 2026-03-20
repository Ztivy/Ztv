import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  createUser(String email, String password) async{
    try{
      final credentials = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      credentials.user?.sendEmailVerification();
    }catch(e){print(e);}
  }

  login(String email, String password) async{
    try{
      final credentials = await _auth.signInWithEmailAndPassword(email: email, password: password);

      //?? operador de coalescemcia nula
      if(credentials.user?.emailVerified??false){
        print("Acceso permitido");
      }
      else{
        print("Por favor, verifica tu correo electronico antes de iniciar sesion");
      }
    }catch(e){print(e);}
  }
}