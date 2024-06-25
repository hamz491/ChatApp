import 'package:chat_app/Cubits/Auth_Bloc/auth_bloc.dart';
import 'package:chat_app/Widgets/CustomTextField.dart';
import 'package:chat_app/Widgets/Custom_Button.dart';
import 'package:chat_app/helper/showsnackBar.dart';
import 'package:chat_app/screens/Chat_Page.dart';
import 'package:chat_app/screens/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static String id = 'Register';

  @override
  State<Register> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  String? Email;
  String? password;

  CollectionReference user = FirebaseFirestore.instance.collection("Users");
  GlobalKey<FormState> vk = GlobalKey();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          loading = true;
        }
        if (state is RegisterSuccess) {
          Navigator.of(context).pushReplacementNamed(
            Chatpage.id,
            arguments: Email,
          );
          showSnackBar(context, 'Success');
          loading = false;
        }
        if (state is RegisterFailure) {
          showSnackBar(context, state.ErrorMessage);
          loading = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Kprimarycolor,
          body: ModalProgressHUD(
            inAsyncCall: loading,
            child: Form(
              key: vk,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        height: 100,
                        child: Image.asset("assets/images/add.png"),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Scholar Chat',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Pacifico",
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.only(left: 10, bottom: 5),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      child: Custom_TextField(
                          onChanged: (value) {
                            Email = value;
                          },
                          hint: 'Email'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      child: Custom_TextField(
                          obscuretext: true,
                          onChanged: (value) {
                            password = value;
                          },
                          hint: 'Password'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 5),
                      child: CustomButton(
                        onPressed: () async {
                          if (vk.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(
                                RegisterEvent(
                                    Email: Email!, password: password!));
                          }
                        },
                        title: 'Register',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "don't have an account  ",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(login.id);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Color(0xffC7EDE6),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
