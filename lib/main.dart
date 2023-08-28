import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCHqBTtp_8_qm3k6gpD2unOOEWWW6W6a90",
          appId: "1:802384217643:android:969f4f684c748e536c8c6e",
          messagingSenderId: "802384217643",
          projectId: "flash-chat-f9848"));
  // await Firebase.initializeApp().whenComplete(() => print("COMPLETED"));
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: WelcomeScreen.id, routes: {
      WelcomeScreen.id: (context) => const WelcomeScreen(),
      ChatScreen.id: (context) => const ChatScreen(),
      LoginScreen.id: (context) => const LoginScreen(),
      RegistrationScreen.id: (context) => const RegistrationScreen(),
    });
  }
}
