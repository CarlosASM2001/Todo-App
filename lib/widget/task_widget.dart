import 'package:flutter/material.dart';
import 'package:to_do_app/const/colors.dart';
import 'package:to_do_app/data/firestore.dart';
import 'package:to_do_app/model/notes_model.dart';
import 'package:to_do_app/screen/edit_screen.dart';

class TaskWidget extends StatefulWidget {

  Note _note;
  TaskWidget(this._note,{super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}



class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {    
    return get();
  }

  Widget get() {
    bool isDone = widget._note.isDone;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2)

            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              image(),
              SizedBox(width: 20,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget._note.title,style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold
                          ),
                        ),
                        Checkbox(
                          activeColor: custom_green,
                          value: isDone, 
                          onChanged: (value){
                            setState(() {
                              isDone = !isDone;
                            });
                            FirestoreDataSource().isdone(widget._note.id, isDone);
                          },

                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text(widget._note.subtitle,style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade400
                      ),
                    ),
                    Spacer(),
                    EditTime()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget EditTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 28,
            decoration: BoxDecoration(
              color: custom_green,
              borderRadius: BorderRadius.circular(18)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                children: [
                  Image.asset('images/icon_time.png'),
                  SizedBox(width: 5,),
                  Text(widget._note.time, style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 15,),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditScreen(widget._note)));
            },
            child: Container(
              width: 90,
              height: 28,
              decoration: BoxDecoration(
                color: Color(0xffE2f6f1),
                borderRadius: BorderRadius.circular(18)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Row(
                  children: [
                    Image.asset('images/icon_edit.png'),
                    SizedBox(width: 10,),
                    Text('edit', style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container image() {
    return Container(
      height: 130,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(image: AssetImage('images/${widget._note.image}.png'), fit: BoxFit.cover),
      ),
    );
  }
}