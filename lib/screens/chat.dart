import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/chat_message.dart';
import 'package:flutter_application_3/new_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  
  void setUp() async{
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    final toku = await fcm.getToken();
    fcm.subscribeToTopic('chat');
    // print("HEY!! ");
    // print(toku);
  }
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    setUp();
    
  }
  void _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Chatter"),
          actions: [
            ElevatedButton(onPressed: _signOut, child: Text("Sign out"))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatMessage(),
            ),
            NewMessage(),
          ],
        ));
  }
}
