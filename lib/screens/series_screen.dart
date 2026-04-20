import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ztv/network/api_catholic.dart';

class SeriesScreen extends StatefulWidget{
  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen>{

  ApiCatholic? apiCatholic;

//esto no se si esta bien 
  @override
  void initState() {
    super.initState();
    apiCatholic = ApiCatholic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Series')),
      body: FutureBuilder(
        future: apiCatholic!.getAllCategories(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Container();
          }else{
            if(snapshot.hasError){
              return Center(child: Text('Error al cargar las series'));
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }
        }
      ),
    );
  }
}