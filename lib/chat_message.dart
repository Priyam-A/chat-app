import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/bubble.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({super.key});
  
  final currUser = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('CreatedAt', descending: true).snapshots(),
      builder: (ctx, snp) {
        if (snp.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          );
        } else if (!snp.hasData || snp.data!.docs.isEmpty) {
          return Center(
            child: Text("Wow such empty..."),
          );
        }
        if (snp.hasError) {
          return Center(
            child: Text("AHHHH!!!! Error"),
          );
        }
        bool me = false;
        final loaded = snp.data!.docs;
        //String prev = "";
        return ListView.builder(
          reverse: true,
          itemCount: loaded.length,
          itemBuilder: (context, index) {
            var data = loaded[index].data();
            String? nextUser = (index!=loaded.length-1)?loaded[index+1].data()['CurrentUser']:null;
            if(data['CurrentUser']!=nextUser){
              //prev = data['CurrentUser'];
              //me = checkIfMe(data['CurrentUser']);
              return MessageBubble.first(userImage: data['ImageURL'], username: data['UserName'], message: data['Text'], isMe:data['CurrentUser']==currUser );
            }
            return MessageBubble.next(message: data['Text'], isMe:data['CurrentUser']==currUser);
          },
        );
      },
    );
  }
}
