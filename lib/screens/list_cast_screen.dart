import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:ztv/database/cast_db.dart';
import 'package:ztv/listeners/value_listener.dart';

class ListCastScreen extends StatefulWidget {
  const ListCastScreen({super.key});

  @override
  State<ListCastScreen> createState() => _ListCastScreenState();
}

class _ListCastScreenState extends State<ListCastScreen> {

  CastDb? castDb;

  final space=SizedBox(height: 5,);
  final conName = TextEditingController();
  final conBirth = TextEditingController();
  final conGender = TextEditingController();

  @override
  void initState() {
    super.initState();
    castDb = CastDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de actores'),
      actions: [
        IconButton(onPressed: ShowAlert, 
        icon: Icon(Icons.add))
      ],
      ),
      body: ValueListenableBuilder(
        valueListenable: ValueListener.refreshList,
        builder: (context, value, child) {
          return FutureBuilder(future: castDb!.SELECT(),
           builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                  return Container(
                    margin: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * .1,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text(snapshot.data![index].nameCast!)),
                        InkWell(
                          onTap: (){
                            conName.text = snapshot.data![index].nameCast!;
                            conBirth.text = snapshot.data![index].birthCast!;
                            conGender.text=snapshot.data![index].gender!;
                            ShowAlert(snapshot.data![index].idCast!);
                            },
                          child: Image.asset("assets/edit.png",height: 30,)),

                        GestureDetector(
                          onTap: (){
                            var alert = AlertDialog(
                              title: Text('Validar accion'),
                              content: Text('Deseas elimianr el registro?'),
                              actions: [
                                TextButton(onPressed: (){
                                  castDb!.DELETE(snapshot.data![index].idCast!).then((value){
                                    if(value>0){
                                      Navigator.pop(context);
                                      ValueListener.refreshList.value=!ValueListener.refreshList.value;
                                    }
                                  });
                                  ValueListener.refreshList.value=!ValueListener.refreshList.value;
                                }, child: Text('Si')),
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text('No'))
                              ],
                            );
                            showDialog(context: context, builder: (context)=>alert,);
                          },
                          child : Image.asset("assets/delete.png",height: 30,)
                        ),
                      ],
                    ),
                  );
                }
              );
            }else{
              if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }else{
                return Center(child: CircularProgressIndicator());
              }
            }
           },);
        }
      ),
    );
  }

  void ShowAlert([int? idCast]){
    var alertDialog=AlertDialog(
      title: Text('Agregar actor'),
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
                controller: conBirth,
                decoration: const InputDecoration(
                  border: OutlineInputBorder()
                ),
                onTap: () async{
                  DateTime? birthDate = await showDatePicker(context: 
                  context,initialDate: DateTime.now()
                   , firstDate: DateTime(2000), lastDate: DateTime(2100));
                if(birthDate !=null){
                  String formattedDate=DateFormat('yyyy-MM-dd').format(birthDate);
                  setState(() {
                    conBirth.text = formattedDate;
                  });
                }
                },
              ),
              space,
              TextFormField(
                controller: conGender,
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
              space,
              ElevatedButton(onPressed: (){
                var data={
                  "nameCast": conName.text,
                  "birthCast": conBirth.text,
                  "gender": conGender.text
                };
                if(idCast == null){
                  castDb!.INSERT(data).then(
                    (value){
                    if(value > 0){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Refistro guardado')));
                      ValueListener.refreshList.value= !ValueListener.refreshList.value;
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ocurrio un error')));
                    }
                    Navigator.pop(context);
                  }
                );
                }else{
                  data["idCast"]=idCast.toString();
                  castDb!.UPDATE(data).then((value){
                    if(value > 0){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Refistro actualizado')));
                      ValueListener.refreshList.value= !ValueListener.refreshList.value;
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