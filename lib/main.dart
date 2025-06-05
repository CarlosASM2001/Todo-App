import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_app/auth/main_page.dart';
import 'package:to_do_app/screen/add_note_screen.dart';
import 'package:to_do_app/screen/edit_screen.dart';
import 'package:to_do_app/screen/home.dart';
import 'package:to_do_app/widget/task_widget.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Main_Page()
    );
  }
}
