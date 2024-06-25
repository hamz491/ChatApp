import 'package:chat_app/Widgets/CustomBuble.dart';
import 'package:chat_app/helper/showsnackBar.dart';
import 'package:chat_app/screens/Login.dart';
import 'package:chat_app/screens/Register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  static String id = 'Chatpage';

  const Chatpage({super.key});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final ScrollController _controller = ScrollController();
  TextEditingController control = TextEditingController();
  CollectionReference message =
      FirebaseFirestore.instance.collection(CollectionName);
  @override
  Widget build(BuildContext context) {
    String? v;
    var mail = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder(
        stream: message.orderBy('CreatedAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List messagelist = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagelist.add(snapshot.data!.docs[i].get('message'));
            }

            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    padding: const EdgeInsets.only(right: 5),
                    color: Colors.white,
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacementNamed(login.id);
                    },
                    icon: const Icon(Icons.logout),
                    iconSize: 30,
                  )
                ],
                backgroundColor: Kprimarycolor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 50,
                    ),
                    const Text(
                      'Chat',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      controller: _controller,
                      itemCount: messagelist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return snapshot.data!.docs[index].get('id') == mail
                            ? CustomBuble(
                                message: messagelist[index],
                              )
                            : CustomBubleForFriend(
                                message: messagelist[index],
                              );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (value) {
                        v = value;
                      },
                      onSubmitted: (data) {
                        if (data.isNotEmpty) {
                          message.add({
                            "message": data,
                            "CreatedAt": DateTime.now(),
                            'id': mail,
                          });
                        }
                        control.clear();
                        _scrollDown();
                      },
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Send Messege',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            if (v!.isNotEmpty) {
                              message.add({
                                "message": v,
                                "CreatedAt": DateTime.now(),
                                'id': mail,
                              });
                            }
                            control.clear();
                            _scrollDown();
                            v = '';
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Kprimarycolor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Kprimarycolor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: control,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              body: Container(
                child: const Center(child: Text('Loading.....')),
              ),
            );
          }
        });
  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
    );
  }
}
