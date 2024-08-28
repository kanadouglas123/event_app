import 'dart:convert';
import 'package:event_app/Auth/login.dart';
import 'package:event_app/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUpState();
}

class _SignUpState extends State<SignUP> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();


  final formKey=GlobalKey<FormState>();
  bool isVisible=true;
  bool isSigningUp=false;

  @override
  void initState() {
    _confirmController;
    _emailController;
    _passwordController;
    _nameController;
     
    super.initState();
  }

  @override
  void dispose() {
     _confirmController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    
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
              height: 140,
              width: 400,
              child:  SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Center(
                    child: Image.asset(
                      height: 60,
                      "assets/Elogo.png"),
                  ),
                   const Padding(
                     padding:  EdgeInsets.only(left: 13),
                     child: Text("Sign Up", textAlign: TextAlign.left,style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                   ),
                    const Padding(
                       padding:  EdgeInsets.only(left: 13),
                       child: Text("Please sign up to continue", textAlign: TextAlign.left,style: TextStyle(color: Colors.white38,fontSize: 18),),
                     )
                  //  ,  const ListTile(
                  //   leading: Icon(Icons.location_on,color: Colors.white,),
                  //   title: Text("Kampala",style: TextStyle(color: Colors.white),),
                  //  ),
                  //   const ListTile(
                  //   leading: Icon(Icons.phone,color: Colors.white,),
                  //   title: Text("+256780477356",style: TextStyle(color: Colors.white),),
                  //  )
                    ],
                    
                ),
              ),
            ),
            const SizedBox(height: 20,),
         Container(
          color: Colors.white,
           child: Padding(
              padding:const  EdgeInsets.only(left: 15,right: 15),
              child:   Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                    ///Name
                       const Text("Name",textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),),
                    Material(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: Colors.white70,
                    
                      elevation: 40,
                      shadowColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextFormField(
                            validator: (value) {
                            if(value!.isEmpty){
                              return "enter your name";
                            }else{
                              return null;
                            }
                          },
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                                style: const TextStyle(color: Colors.black,fontSize: 20),
                          keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person,color: Colors.black54,),
                          border: InputBorder.none,hintText: "Enter your name",hintStyle: TextStyle(color: Colors.black54)),
                                       ),
                      )), const SizedBox(height: 22,),
                      //Email
                       const Text("Email",textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),),
                      Material(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: Colors.white70,
                    
                      elevation: 40,
                      shadowColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextFormField(
                            validator: (value) {
                            if(value!.isEmpty&&_emailController.text!=13){
                              return "enter your email";
                            }else if (value.length <= 13) {
                             return "Enter a valid email please";
                                  } 
                            else{
                              return null;
                            }
                          },
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                                style: const TextStyle(color: Colors.black,fontSize: 20),
                          keyboardType: TextInputType.emailAddress,
                          
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email,color: Colors.black54,),
                          border: InputBorder.none,hintText: "Enter your email address",hintStyle: TextStyle(color: Colors.black54)),
                                       ),
                      )),const SizedBox(height: 22,), 
                     
                      //password
                        const Text("Password",textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),),
                       Material(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: Colors.white70,
                    
                      elevation: 40,
                      shadowColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextFormField(
                            validator: (value) {
                            if(value!.isEmpty){
                              return "enter your password";
                            }else if (value.length <= 4) {
                            return "password should be greater than four";
                             }else{
                              return null;
                            }
                          },
                          
                          controller: _passwordController,
                          textInputAction: TextInputAction.next,
                                style: const TextStyle(color: Colors.black,fontSize: 20),
                          keyboardType: TextInputType.number,
                          obscureText: isVisible,
                          
                        decoration:  InputDecoration(
                          prefixIcon: const Icon(Icons.lock,color: Colors.black54,),
                                suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              isVisible=!isVisible;
                            });
                          }, icon: isVisible? const Icon(Icons.visibility_off,color: Colors.black54,): const Icon(Icons.visibility,color: Colors.black54,)),

                          border: InputBorder.none,hintText: "Enter your new password",hintStyle: const TextStyle(color: Colors.black54)),
                                       ),
                      )),const SizedBox(height: 22,),
                      //confirm password
                        const Text("Confirm password",textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),),
                      Material(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: Colors.white70,
                    
                      elevation: 40,
                      shadowColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: TextFormField(
                          validator: (value) {
                            if(value!.isEmpty){
                              return "confirm your password";
                            }else{
                              return null;
                            }
                          },
                          controller: _confirmController,
                          textInputAction: TextInputAction.next,
                                style: const TextStyle(color: Colors.black,fontSize: 20),
                           keyboardType: TextInputType.number,
                          obscureText: isVisible,
                        decoration: InputDecoration(
                                suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              isVisible=!isVisible;
                            });
                          }, icon: isVisible? const Icon(Icons.visibility_off,color: Colors.black54,): const Icon(Icons.visibility,color: Colors.black54,)),
                          prefixIcon: const Icon(Icons.lock,color: Colors.black54,),
                          border: InputBorder.none,hintText: "Enter your confirm password",hintStyle: const TextStyle(color: Colors.black54)),
                                       ),
                      )),const SizedBox(height: 20,),
                     
                      ///Login Button
                      Center(
                        child: GestureDetector(
                          onTap: (){
                            if(formKey.currentState!.validate()){ 
                            if(_confirmController.text!=_passwordController.text){
                              Fluttertoast.showToast(msg: "passwords don't match").then((value) => setState(() {
                                _passwordController.clear();
                                _confirmController.clear();
                                
                              }));
                            }else{
                               validiteEmail(); } 
                               setState(() {
                                 isSigningUp=!isSigningUp;
                               });
                               }
                          },
                          child:isSigningUp?  Center(child: CircularProgressIndicator(
                            color: Colors.red[900],),):const Card(
                            color: Colors.red,
                           child:  Padding(
                             padding: EdgeInsets.only(left: 65,right: 65,top: 8,bottom: 8),
                             child: Text("SIGN UP",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                           ),),
                        ),
                      ), Center(child: TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login(),));
                      },child:const Text("Already have account? Login", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18))))
                      , const SizedBox(height: 85,),
                     const Center(child: Text("@2024 Event.All Right Reserved",style: TextStyle(color: Colors.black54)))
                      ,const SizedBox(height: 30,)
                     
                   ],
                 ),
              ),
            ),
         )
          ],
        )),
      ),
    );
  }
  ////checking existance of email
  void validiteEmail() async{
    String verify=_emailController.text.trim();
    try{
       var resValidateEmail = await http.post(Uri.parse( API.validateEmail),
    body: {
      "email":verify
      } );
    if(resValidateEmail.statusCode==200){
      var resbody=jsonDecode(resValidateEmail.body);
      if(resbody['emailFound']==true){
        Fluttertoast.showToast(
          backgroundColor: Colors.red[900],
          msg: "email already in use");
        setState(() {
           _confirmController.clear();
          _emailController.clear();
          _passwordController.clear();
          _nameController.clear();    
          
        });
      }else{
        registerAndSaveData();
      }  
    }else{
    }
    }catch(e){
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
   

  }
  
  void registerAndSaveData() async{

        String username=_nameController.text.trim();
        String email=_emailController.text.trim();
        String password=_passwordController.text.trim(); 
        try{
            var resSignup= await http.post(Uri.parse(API.hostConnectUserSign),
             body: {
              'email':email,
              'password':password,
              'username':username
             }
     );
     if(resSignup.statusCode==200){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                backgroundColor: Colors.white,
              content:const Text("Account created Successful",style: TextStyle(fontSize: 20,color: Colors.black),),
              actions: <Widget>[
                 Center(
                   child: InkWell(
                      onTap: (){
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Login()) );
                                   },
                                   child:const Card(
                                    elevation: 3,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(right: 30,left: 30,bottom: 4,top: 4),
                      child: Text("Login",style: TextStyle(fontSize: 20, color: Colors.black),),
                    ) )),
                 ),
              ],
            );
          },
        );
        setState(() {
          _confirmController.clear();
          _emailController.clear();
          _passwordController.clear();
          _nameController.clear();        });
      }else{
        Fluttertoast.showToast(
          backgroundColor: Colors.red[900],
          msg: "failed to register user");
      }
     
}catch(e){
    print(e.toString());
    Fluttertoast.showToast(msg: e.toString());

        }

   
     

  }
}