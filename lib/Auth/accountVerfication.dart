import 'package:event_app/screens/ButtomNavBar.dart';
import 'package:flutter/material.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _SignUpState();
}

class _SignUpState extends State<Verify> {
   final _oneController=TextEditingController();
    final _twoController=TextEditingController();
     final _threeController=TextEditingController();
      final _fourController=TextEditingController();

      @override
  void initState() {
    _oneController;
    _threeController;
    _twoController;
    _fourController;
   
    super.initState();
  }
  @override
  void dispose() {
    _oneController.dispose();
    _threeController.dispose();
    _twoController.dispose();
    _fourController.dispose();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Center(
                    child: Image.asset(
                      height: 60,
                      "assets/Elogo.png"),
                  ),
                  const SizedBox(height: 20,),
                   const Padding(
                     padding:  EdgeInsets.only(left: 13),
                     child: Text("SignUp", textAlign: TextAlign.left,style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                   ),
                    const Padding(
                       padding:  EdgeInsets.only(left: 13),
                       child: Text("Verfication", textAlign: TextAlign.left,style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                     ),
                     const SizedBox(height: 20,)
                   ,  
                 const  Padding(
                    padding:  EdgeInsets.only(left:13 ),
                    child: Text("We have send OTP to this number",style: TextStyle(color: Colors.white),),
                  ),
                   
                    
                const  Padding(
                    padding:  EdgeInsets.only(left: 13),
                    child:  Text("+256780477356",style: TextStyle(color: Colors.white),),
                  ),
                  
                    ],
                    
                ),
              ),
            ),
            const SizedBox(height: 20,),
         Container(
          color: Colors.white,
           child: Padding(
              padding:const  EdgeInsets.only(left: 15,right: 15),
              child:   Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                  const SizedBox(height: 100,),

                 const  Text("Enter the 4 digit OTP number", style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                 const SizedBox(height: 20,),

               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Material(
                    
                    borderRadius:const BorderRadius.all(Radius.circular(20)),
                    elevation: 30,
                    shadowColor: Colors.white,
                    color: Colors.white70,
                     child: Container(
                      decoration:const  BoxDecoration(color: Colors.white,),
                      width: 50,
                      child: Center(child:  Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextField(
                          controller: _oneController,
                           maxLength: 1,
                          textInputAction: TextInputAction.next,
                               style: const TextStyle(color: Colors.black,fontSize: 20),
                            //maxLength: 1,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(border: InputBorder.none),
                        ),
                      )),
                     ),
                   ),const SizedBox(width: 10,),
                      Material(
                  borderRadius:const BorderRadius.all(Radius.circular(20)),
                  elevation: 30,
                  shadowColor: Colors.white,
                  color: Colors.white70,
                   child: Container(
                    decoration:const  BoxDecoration(color: Colors.white,),
                    width: 50,
                    child:  Center(child:  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: _twoController,
                        maxLength: 1,
                        textInputAction: TextInputAction.next,
                              style: const TextStyle(color: Colors.black,fontSize: 20),
                          //maxLength: 1,
                         keyboardType: TextInputType.number,
                        decoration: const InputDecoration(border: InputBorder.none),
                      ),
                    )),
                   ),
                 ),const SizedBox(width: 10,),
                    Material(
                  borderRadius:const BorderRadius.all(Radius.circular(20)),
                  elevation: 30,
                  shadowColor: Colors.white,
                  color: Colors.white70,
                   child: Container(
                    decoration:const  BoxDecoration(color: Colors.white,),
                    width: 50,
                    child:  Center(child:  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: _threeController,
                         maxLength: 1,
                        textInputAction: TextInputAction.next,
                              style:const  TextStyle(color: Colors.black,fontSize: 20),
                        //maxLength: 1,
                         keyboardType: TextInputType.number,
                        decoration: const InputDecoration(border: InputBorder.none,hintText: null),
                      ),
                    )),
                   ),
                 ),const SizedBox(width: 10,),
                    Material(
                  borderRadius:const BorderRadius.all(Radius.circular(20)),
                  elevation: 30,
                  shadowColor: Colors.white,
                  color: Colors.white70,
                   child: Container(
                    decoration:const  BoxDecoration(color: Colors.white,),
                    width: 50,
                    child: Center(child:  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: _fourController,
                         maxLength: 1,
                        textInputAction: TextInputAction.next,
                        
                              style: const TextStyle(color: Colors.black,fontSize: 20),
                          //maxLength: 1,
                         keyboardType: TextInputType.number,
                        decoration: const InputDecoration(border: InputBorder.none),
                      ),
                    )),
                   ),
                 ),
                 ],
               ),
               
                   const SizedBox(height: 22,),
                   
                    ///Submit  Button
                    Center(
                      child: GestureDetector(
                        onTap: (){
                           _oneController.clear();
                           _twoController.clear();
                           _threeController.clear();
                           _fourController.clear();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const NaviBar()));},
                        child: const Card(
                          color: Colors.red,
                         child:  Padding(
                           padding: EdgeInsets.only(left: 65,right: 65,top: 8,bottom: 8),
                           child: Text("SUBMIT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                         ),),
                      ),
                    ), Center(child: TextButton(onPressed: (){
                    
                    },child:const Text("Resend OTP", style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 18))))
                    , const SizedBox(height: 100,),
                   const Center(child: Text("@2024 Event.All Right Reserved"))
                    ,const SizedBox(height: 50,)
                   
                 ],
               ),
            ),
         )
          ],
        )),
      ),
    );
  }
}