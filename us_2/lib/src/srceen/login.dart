import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:us_2/src/srceen/home.dart';
import 'package:us_2/src/srceen/image.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
void loginToast() {
  Fluttertoast.showToast(msg: '로그인 성공',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.indigoAccent[100],
      fontSize: 20.0,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT
  );
}

void signinToast() {
  Fluttertoast.showToast(msg: '회원가입 성공',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.indigoAccent[100],
      fontSize: 20.0,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT
  );
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        centerTitle:true,title: Text('Ground Us',
          style: TextStyle(fontSize: 40, color: Colors.black87)),),
      body: Column(
        children: [
      Expanded(
      child: Padding(
      padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
      child: FittedBox(
        fit: BoxFit.contain,
        child: CircleAvatar(
          backgroundImage: AssetImage("assets/earth_1.gif",
          ),
        ),
      ),
    ),
    ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                labelText: "Email",
              ),
               onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.vpn_key),
                labelText: "Password",
              ),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:[
            RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text('Signin',
                 style: TextStyle(fontSize: 20, color: Colors.white)),
              onPressed: (){
                  auth.signInWithEmailAndPassword(email: _email, password: _password).then((_){
                    loginToast();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ExampleApp())
                    );

                  });

            }),
            RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text('Signup',style: TextStyle(fontSize: 20, color: Colors.white)),
              onPressed: (){
                auth.createUserWithEmailAndPassword(email: _email, password: _password).then((_){
                  signinToast();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ExampleApp()));
                }
                );

              },
            )
          ])
        ],),
    );
  }
}