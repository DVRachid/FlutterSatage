import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formkey = GlobalKey<FormState>();
  final emailController=TextEditingController();
  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }
  @override

  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: const Text("Reset Password"),
    ),
    body: Padding(
      padding:const EdgeInsets.all(16),
      child: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Receive an email to reset your password ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller:emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: "Email"),
              autovalidateMode:AutovalidateMode.onUserInteraction,
              validator: (value) {
                if(value != null && value.isEmpty){
                  return "please  entre email";
                }
                if(!RegExp('^[a-zA-Z0-9.a-zA-Z0-9.!#%&*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+').hasMatch(value!)){
                  return "Please enter email";
                }
                return null ;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize:const Size.fromHeight(50)
              ),
              icon:const Icon(Icons.email_outlined),
              label:const Text("Reset Password",
                style: TextStyle(fontSize: 24),) ,
              onPressed: resetPassord,

            )

          ],
        ),
      ),
    ),
  );


  Future resetPassord() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim());
      showDialog(context: context, builder: (context){
        return const AlertDialog(
          content: Text("Password reset  link sent ! Check Your Email !"),
        );
      },);

    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      },
      );
    }
  }
}

