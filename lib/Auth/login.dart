import 'dart:convert';

import 'package:event_app/Auth/signup.dart';
import 'package:event_app/Model/userModel.dart';
import 'package:event_app/Userprefs/User_prefes.dart';
import 'package:event_app/constants/api_constants.dart';
import 'package:event_app/screens/ButtomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();


  bool isVisible=true;
   bool isLogging=false;

  final formKey =GlobalKey<FormState>();

  @override
  void initState() {
    _emailController;
    _passwordController;
    super.initState();
  }

  @override
  void dispose() {
   _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: SafeArea(
        child: SingleChildScrollView(child: Column(
          children: [
          
            ///first Container
            Container(
              color: Colors.red[900],
              height: 200,
              width: 400,
              child:  SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Center(
                    child: Image.asset(
                      height: 100,
                      "assets/Elogo.png"),
                  ),const SizedBox(height: 20,),
                   const Padding(
                     padding:  EdgeInsets.all(8.0),
                     child: Text("Login", textAlign: TextAlign.left,style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                   ),
                    const Padding(
                       padding:  EdgeInsets.only(left: 8),
                       child: Text("Please signin to continue", textAlign: TextAlign.left,style: TextStyle(color: Colors.white38,fontSize: 18),),
                     )
                    ],
                    
                ),
              ),
            ),
            const SizedBox(height: 20,),
         Container(
           height: 450,
           width: 500,
           color: Colors.white,
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Form(
              key: formKey,
               child: SingleChildScrollView(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     ///country part
                        const Text("Email",textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),),
                     Material(
                       borderRadius: const BorderRadius.all(Radius.circular(12)),
                       color: Colors.white70,
                     
                       elevation: 40,
                       shadowColor: Colors.white,
                       child: Padding(
                         padding:const  EdgeInsets.only(left: 8),
                         child:TextFormField(
                          validator: (value) {
                            if(value!.isEmpty){
                              return "please enter your email";
                            }else{
                              return null;
                            }
                          },
                          controller: _emailController,
                          
                          textInputAction: TextInputAction.next,
                           style: const TextStyle(color: Colors.black,fontSize: 20),
                         decoration: const InputDecoration(
                          
                          prefixIcon: Icon(Icons.email,color: Colors.black54,),
                          border: InputBorder.none,hintText: "Enter your email",hintStyle: TextStyle(color: Colors.black54
                        
                         )),
                                        ),
                       )), const SizedBox(height: 22,),
                       //password
                        const Text("password",textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),),
                       Material(
                       borderRadius: const BorderRadius.all(Radius.circular(12)),
                       color: Colors.white70,
                     
                       elevation: 40,
                       shadowColor: Colors.white,
                       child: Padding(
                         padding: const EdgeInsets.only(left: 8),
                         child:TextFormField(
                           validator: (value) {
                            if(value!.isEmpty){
                              return "please enter your password";
                            }else{
                              return null;
                            }
                          },
                          obscureText: isVisible,
                          controller: _passwordController,
                          textInputAction: TextInputAction.next,
                           keyboardType: TextInputType.number,
                                 style: const TextStyle(color: Colors.black,fontSize: 20),
                         decoration:  InputDecoration(
                          prefixIcon: const Icon(Icons.lock,color: Colors.black54,),
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              isVisible=!isVisible;
                            });
                          }, icon: isVisible? const Icon(Icons.visibility_off,color: Colors.black54,): const Icon(Icons.visibility,color: Colors.black54,)),
                          border: InputBorder.none,
                          hintText: "Enter your password" ,hintStyle: const TextStyle(color: Colors.black54)),
                                        ),
                       )), const SizedBox(height: 22,),
                         
                       ///Login Button
                       Center(
                         child: GestureDetector(
                          onTap: () { 
                          
                            if(formKey.currentState!.validate()){
                              setState(() {
                                isLogging=!isLogging;
                              });
                             
                           loginUser();
                            }      
                            },
                           child: isLogging?  Center(child: CircularProgressIndicator(color: Colors.red[900],),):const Card(  
                             color: Colors.red,
                            child:  Padding(
                              padding: EdgeInsets.only(left: 65,right: 65,top: 8,bottom: 8),
                              child:  Text("LOGIN",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)
                            ),),
                         ),
                 
                         ///Don't have account page
                       ), Center(child: TextButton(onPressed: (){
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUP(),));
                       },child:const Text("Don't have account? Register", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18))))
                       , const SizedBox(height: 50,),
                      const Center(child: Text("@2024 Event.All Right Reserved",style: TextStyle(color: Colors.black87)))
                       ,const SizedBox(height: 30,)
                         
                    ],
                  ),
               ),
             ),
           ),
         )
          ],
        )),
      ),
    );
  }
  
  void loginUser() async {
  String email = _emailController.text.trim();
  String password = _passwordController.text.trim();

  try {
    var resSignIn = await http.post(
      Uri.parse(API.loginUser),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (resSignIn.statusCode == 200) {
      var resSignInBody = jsonDecode(resSignIn.body);

      if (resSignInBody['emailFound'] == true) {
        final userData = User.fromJson(resSignInBody['userData']);
        await RememberUser.saveUser(userData);   
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                backgroundColor: Colors.white,
              content:const Text("Login Successful",style: TextStyle(fontSize: 20,color: Colors.black),),
              actions: [
                 Center(
                   child: InkWell(
                                   onTap: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const NaviBar()),
                      );
                                   },
                                   child:const Card(
                                    elevation: 3,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(right: 30,left: 30,bottom: 4,top: 4),
                      child: Text("ok",style: TextStyle(fontSize: 20, color: Colors.black),),
                    ) )),
                 ),
              ],
            );
          },
        );
      } else {
        Fluttertoast.showToast(
          fontSize: 16,
          backgroundColor: Colors.red[900],
          msg: "Invalid user");
      }
    } else {
      Fluttertoast.showToast(msg: "Error: ${resSignIn.statusCode}");
    }
  } catch (e) {
    print(e.toString());
    Fluttertoast.showToast(msg: e.toString());
  }
}
}

