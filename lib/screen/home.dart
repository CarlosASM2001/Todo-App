
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:to_do_app/const/colors.dart';
import 'package:to_do_app/screen/add_note_screen.dart';
import 'package:to_do_app/widget/stream_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool show =true;

class _HomeScreenState extends State<HomeScreen> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNoteScreen()),);
          },
          backgroundColor: custom_green,
        child: Icon(Icons.add, size: 30,), 
        ),
      ),

      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification){
            if(notification.direction == ScrollDirection.forward){
              setState(() {
                show =true;
              });
            }
            if(notification.direction == ScrollDirection.reverse){
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: StreamNote(),
        )
      ),
    );
  }
}