import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_bubble.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) {
            return const Text('No Data');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final chatDocs = (snapshot.data as QuerySnapshot).docs;
          return ListView.builder(
            itemBuilder: (ctx, index) => MessageBubble(
                chatDocs[index]['text'],
                chatDocs[index]['username'],
                chatDocs[index]['userImage'],
                chatDocs[index]['userId'] ==
                    FirebaseAuth.instance.currentUser!.uid,
                key: ValueKey(chatDocs[index].id)),
            itemCount: chatDocs.length,
          );
        });
  }
}
