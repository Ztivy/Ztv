import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ProferoresFirestore {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference? profesoresCollection;

  ProferoresFirestore(){
    profesoresCollection = _firestore.collection('profesores');
  }

  Future <bool> insertProfesor(Map<String,dynamic> data) async{
    try{
    profesoresCollection!.doc().set(data);
    return true;
    }catch(e){return false;}
  }
  Future<bool> updateProfesor(String id,Map<String,dynamic> data)async{
    try{
    profesoresCollection!.doc(id).update(data);
    return true;
    }catch(e){return false;}
  }
  Future<bool> deleteProfesor(String id) async{
    try{
    profesoresCollection!.doc(id).delete();
    return true;
    }catch(e){return false;}
  }
  Stream<QuerySnapshot> getProfesores(){
    return profesoresCollection!.snapshots();
  }
}