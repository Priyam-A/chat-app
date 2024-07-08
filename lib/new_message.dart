import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});
  @override
  State<NewMessage> createState() {
    // TODO: implement createState
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  final _control = TextEditingController();
  void _onSubmit() async{
    final enteredMessage = _control.text;
    if (enteredMessage == null || enteredMessage.trim().isEmpty) {
      return;
    }
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    FirebaseFirestore.instance.collection('chat').add(
      {
        'Text': enteredMessage,
        'CreatedAt':Timestamp.now(),
        'CurrentUser':user.uid,
        'UserName': userData.data()!['username'],
        'ImageURL': userData.data()!['imageURL'],
      },
    );
    _control.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 12, 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                label: Text("Send a message"),
              ),
              controller: _control,
            ),
          ),
          IconButton(
            onPressed: _onSubmit,
            icon: Icon(Icons.send_rounded),
          ),
        ],
      ),
    );
  }
}
