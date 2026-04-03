import 'package:flutter/material.dart';
import 'package:ztv/firebase/proferores_firestore.dart';

class ProfesoresScreen extends StatefulWidget {
  ProferoresFirestore proferoresFirestore = ProferoresFirestore();
  @override
  State<ProfesoresScreen> createState() => _ProfesoresScreenState();
}

class _ProfesoresScreenState extends State<ProfesoresScreen> {
  final space=SizedBox(height: 5,);
  final conName = TextEditingController();
  final conEdad = TextEditingController();
  ProferoresFirestore proferoresFirestore = ProferoresFirestore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profesores'),
      ),
      body: StreamBuilder(stream: proferoresFirestore.getProfesores()
      , builder: (context,snapshot){
        if(snapshot.hasData){
          return GridView.builder(
          itemCount: snapshot.data!.docs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.8), 
          itemBuilder: (context, index) {
            return Container(
              color: Colors.purpleAccent[700],
              height: 250,
              width: 250,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(snapshot.data!.docs[index].get('foto')),
                  ),
                  ListTile(title: Text(snapshot.data!.docs[index].get('nombre')),
                  subtitle: Text(snapshot.data!.docs[index].get('edad').toString()),),
                  Row(children: [
                    IconButton(onPressed:() => ShowAlert(snapshot.data!.docs[index].id), icon: Icon(Icons.edit_attributes)),
                    IconButton(onPressed: (){
                      var alert = AlertDialog(
                              title: Text('Accion requerida'),
                              content: Text("¿Deseas elimianr al Profesor $snapshot.data!.docs[index].get(´nombre´) ?"),
                              actions: [
                                TextButton(onPressed: (){
                                  proferoresFirestore.deleteProfesor(snapshot.data!.docs[index].id).then((value){
                                    if(value){
                                      Navigator.pop(context); 
                                    }
                                  });
                                }, child: Text('Si')),
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text('No'))
                              ],
                            );
                            showDialog(context: context, builder: (context)=>alert,);
                    }, icon: Icon(Icons.delete_forever)),
                  ],)
                ],
              ),
              );
          },);
        }
        else{
          if(snapshot.hasError){
            return Text('Error:$snapshot.error');
          }
          else{
            return const CircularProgressIndicator();
          }
        }
      }) ,
    );
  }

  void ShowAlert([String? id]){
    var alertDialog=AlertDialog(
      title: Text('Agregar profesor'),
      content: Container(
        child: Container(
          width: 200,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                controller: conName,
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
              space,
              TextFormField(
                readOnly: true,
                controller: conEdad,
                decoration: const InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
              space,
              ElevatedButton(onPressed: (){
                var data={
                  "nombre": conName.text,
                  "edad": conEdad.text,
                  "foto": ''
                };
                if(id == null){
                  proferoresFirestore.insertProfesor(data).then(
                    (value){
                    if(value){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Refistro guardado')));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ocurrio un error')));
                    }
                    Navigator.pop(context);
                  }
                );
                }else{
                  data['id']=id.toString();
                  proferoresFirestore.updateProfesor(id.toString(),data).then((value){
                    if(value){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Refistro actualizado')));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ocurrio un error')));
                    }
                  });
                }
              }, 
              child: Text('Guardar') 
              )
            ],
          ),
        ),
      ),
    );

    showDialog(context: context,
     builder: (context) => alertDialog);
  }
}