import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final List method =[
    PaymentWidget(Image: const Image(image: AssetImage('assets/mtn.png')), pressed: (){}),
    PaymentWidget(Image: const Image(image: AssetImage('assets/Visa.png')),  pressed: (){}),
    PaymentWidget(Image: const Image(image: AssetImage('assets/airtel.jpg')),  pressed: (){}),
    PaymentWidget(Image: const Image(image: AssetImage('assets/paypal.jpeg')),  pressed: (){})
    , PaymentWidget(Image: const Image(image: AssetImage('assets/flex.png')),  pressed: (){}),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text('Payment'),

      ),
      body:Center(
                child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
                itemCount: method.length,
                itemBuilder: (context,index){
                  return  method[index];
                }
                ),
              )
    );
  }
}


class PaymentWidget extends StatelessWidget {
  final Image;
  final VoidCallback pressed;

  const PaymentWidget({super.key, required this.Image,  required this.pressed});

  @override
  Widget build(BuildContext context) {
    return InkWell
    (
      onTap: pressed,
      child: SizedBox(
        
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Material(
            elevation: 40,
            shadowColor: Colors.white,

            color: Colors.white,
            child:  
               Image, ),
        ),
        
        ),
      )
    ;
  }
}