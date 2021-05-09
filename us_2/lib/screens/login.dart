
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:us_2/data/join_or_login.dart';
import 'package:us_2/helper/login_background.dart';

class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(
            size: size,
            painter: LoginBackground(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _logoImage,
              Stack(
                children: <Widget>[
                  _inputForm(size),
                  _authButton(size),
                ],
              ),
              Container(
                height: size.height * 0.1,
              ),
              Consumer<JoinOrLogin>(
                builder: (context,  joinOrLogin, child) =>
                    GestureDetector(
                        onTap: () {
                          joinOrLogin.toggle();
                        },
                        child: Text(joinOrLogin.isJoin?"Already Have an Account? Sign in":"Dont Have an Account? Create One",
                          style: TextStyle(color: joinOrLogin.isJoin?Colors.red:Colors.blue),)),
              ),

              Container(
                height: size.height * 0.05,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget get _logoImage =>
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
      );

  Widget _inputForm(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Padding(
          padding:
          const EdgeInsets.only(left: 12.0, right: 12, top: 12, bottom: 32),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    obscureText: true,
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle),
                      labelText: "Email",
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please input correct Email.";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      labelText: "Password",
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please input correct Password.";
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 8,
                  ),
                  Consumer<JoinOrLogin>(
                    builder:(context,value,child) =>Opacity(
                        opacity: value.isJoin?0:1,
                        child: Text("Forgot Password")),
                  ),
                ],
              )),
        ),
      ),
    );
  }
  void _register(BuildContext context) async {
    final UserCredential result=await FirebaseAuth.instance.createUserWithEmailAndPassword
      (email: _emailController.text, password: _passwordController.text);
    final User user=result.user;
    if(user==null){
      final snacBar=SnackBar(content: Text('Please try again later'),);
      Scaffold.of(context).showSnackBar(snacBar);
    }
  }

  void _login(BuildContext context) async {
    final UserCredential result=await FirebaseAuth.instance.signInWithEmailAndPassword
      (email: _emailController.text, password: _passwordController.text);
    final User user=result.user;
    if(user==null){
      final snacBar=SnackBar(content: Text('Please try again later'),);
      Scaffold.of(context).showSnackBar(snacBar);
    }
  }
  Widget _authButton(Size size) {
    return Positioned(
      left: size.width * 0.15,
      right: size.width * 0.15,
      bottom: 0,
      child: SizedBox(
        height: 50,
        child: Consumer<JoinOrLogin>(
          builder: (context, joinOrLogin,child)=>RaisedButton(
              child: Text(
                  joinOrLogin.isJoin?"Join":"Login",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              color: joinOrLogin.isJoin?Colors.red:Colors.blue,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  joinOrLogin.isJoin?_register(context):_login(context);
                }
              }),
        ),
      ),
    );
  }
}
