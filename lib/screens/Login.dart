import 'package:chat_app/Cubits/Auth_Bloc/auth_bloc.dart';
import 'package:chat_app/Widgets/CustomTextField.dart';
import 'package:chat_app/Widgets/Custom_Button.dart';
import 'package:chat_app/helper/showsnackBar.dart';
import 'package:chat_app/screens/Chat_Page.dart';
import 'package:chat_app/screens/Register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class login extends StatelessWidget {
  static String id = 'Login';
  GlobalKey<FormState> vk = GlobalKey();
  bool loading = false;
  static String? email, password;

  login({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          loading = true;
        }
        if (state is LoginFailure) {
          showSnackBar(context, state.ErrorMessage);
          loading = false;
        }
        if (state is LoginSuccess) {
          Navigator.of(context)
              .pushReplacementNamed(Chatpage.id, arguments: email);
          showSnackBar(context, 'Success');
          loading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: loading,
          child: Form(
            key: vk,
            child: Scaffold(
              backgroundColor: Kprimarycolor,
              body: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: SizedBox(
                      height: 100,
                      child: Image.asset("assets/images/scholar.png"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
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
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.only(left: 10, bottom: 5),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: Custom_TextField(
                      hint: 'Email',
                      onChanged: (data) {
                        email = data;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: Custom_TextField(
                      obscuretext: true,
                      hint: 'Password',
                      onChanged: (data) {
                        password = data;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: CustomButton(
                      onPressed: () async {
                        if (vk.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                              LoginEvent(email: email!, password: password!));
                        }
                      },
                      title: 'Log In',
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
                              .pushReplacementNamed(Register.id);
                        },
                        child: const Text(
                          "Register",
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
        );
      },
    );
  }
}
