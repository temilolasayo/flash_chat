import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String id = "chat_screen";

  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late String messageText;
  late User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final user = _auth.currentUser!;

    try {
      loggedInUser = user;
    } catch (e) {
      print(e.toString());
    }
  }

  void messageStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var messageList in snapshot.docs) {
        print("hello");

        print(messageList.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                //Logout
                //_auth.signOut();
                messageStream();
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream: _firestore.collection("messages").snapshots(),
              builder: (context, snapshots) {
                if (!snapshots.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
                final messages = snapshots.data!.docs;
                List<Text> textWidget = [];
                for (var message in messages) {
                  final messageText = message['text'];
                  final senderEmail = message['sender'];

                  final messageWidget = Text("$messageText from $senderEmail");

                  textWidget.add(messageWidget);
                }
                return Column(
                  children: textWidget,
                );

                return const Text("Helpppppppppppppppppppppppppppppppppppp");
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        _firestore.collection('messages').add({
                          "text": messageText,
                          "sender": loggedInUser.email,
                        });
                      },
                      child: const Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
