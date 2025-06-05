import 'package:flutter/material.dart';
import 'package:to_do_app/const/colors.dart';
import 'package:to_do_app/data/firestore.dart';
import 'package:to_do_app/model/notes_model.dart';

class EditScreen extends StatefulWidget {

  Note _note;
  EditScreen(this._note,{super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController? title;
  TextEditingController? subtitle;


  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  int indexx = 0;
  @override

  void initState(){
    super.initState();

    title = TextEditingController(text: widget._note.title);
    subtitle = TextEditingController(text: widget._note.subtitle);
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title_widget(),
            SizedBox(height: 20,),
            subtitle_widget(),
            SizedBox(height: 20,),
            CarruselImages(),
            SizedBox(height: 20,),
            button()
          ],
        )
      ),
    );
  }

  Widget button() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: custom_green,
                  minimumSize: Size(170, 48)
                ),
                onPressed: () {
                  FirestoreDataSource().UpdateNote(widget._note.id, 
                  indexx, title!.text, subtitle!.text);
                  Navigator.pop(context);
                }, 
                child: Text('Add Task', style: TextStyle(color: Colors.white),)
              ),
              SizedBox(width: 15,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(170, 48)
                ),
                onPressed: () {
                  Navigator.pop(context);
                }, 
                child: Text('Cancel Task', style: TextStyle(color: Colors.white),)
              ),
            ],
          );
  }

  Container CarruselImages() {
    return Container(
      height: 180,
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                indexx = index;     
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: indexx == index ? custom_green : Colors.grey,               
                )
              ),
              width: 140,
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  Image.asset('images/${index}.png'),
                ]
              ),
            ),
          );
        },
      ),
    );
  }

  Widget title_widget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: TextField(
          controller: title,
          focusNode: _focusNode1,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: 'title',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xffc5c5c5), width: 2.0)
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: custom_green, width: 2.0)
            )
          ),
        ),
      ),
    );
  }

  Widget subtitle_widget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: TextField(
          maxLines: 3,
          controller: subtitle,
          focusNode: _focusNode2,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: 'subtitle',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xffc5c5c5), width: 2.0)
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: custom_green, width: 2.0)
            )
          ),
        ),
      ),
    );
  }
}