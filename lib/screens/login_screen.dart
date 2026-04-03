import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ztv/firebase/email_auth.dart';

//google singin 
//context es la ventana con la que se esta interactuando
//firestore es para aplicaciones sencillas
//realtime database se usa para aplicaciones mas robustas (redes sociales , etc)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isLoading=false;
  final conEmail = TextEditingController();
  final conPass = TextEditingController();
  final EmailAuth emailAuth = EmailAuth();
  
  @override
  Widget build(BuildContext context) {

    final txtUser = TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder()
      ),
    );
    final txtPwd = TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder()
      ),
    );
    final btnLogin = Positioned(
      bottom: 10,
      child: InkWell(
        onTap: (){
          isLoading=!isLoading;
          setState(() {});
          //Future.delayed(Duration(milliseconds: 4000)).then((value) {Navigator.pushNamed(context, "/dash");},);
          emailAuth.login(conEmail.text, conPass.text).then((value){
            if(value){
              Navigator.pushNamed(context, '/dash');
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text ('Error: Usuario o contraseña incorrectos'),
               backgroundColor: Colors.red,
               ) 
              );
            }
          });
          setState(() {
            isLoading=true;
          });
        },
        child: Lottie.asset('assets/DollarCoinsChest.json', height: 200)
      )
    );

    final loading= isLoading?
     Positioned(
      top: 50,
      child: Image.asset('assets/loading.gif', height: 300)
      ) : Container();
      
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/fly.jpg')
          )
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Positioned(
              top: 200,
              child: SizedBox(
                width: 300,
                child: Text("Soy un monumento a todos sus pecados", 
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, 
                                  fontFamily: 'halo',
                                  color: Colors.white),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              child: Container(
                height: 240,
                width: 400,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 201, 19, 186).withOpacity(.8),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    txtUser,
                    //Divider(),
                    SizedBox(height: 10,),
                    txtPwd,
                    
                  ],
                ),
              )
            ),
            btnLogin,
            loading
          ],
        ),
      ),
    );
  }
}