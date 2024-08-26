import 'package:flutter/material.dart';

class RoomManagerModelView extends ChangeNotifier {


  late BuildContext currentContext;




  RoomManagerModelView();


  void createRoomClick(){

    Navigator.pushNamed(currentContext, "createRoomView");


  }

  void joinRoomClick(){

     Navigator.pushNamed(currentContext, "joinRoomView");



  }



  setContext(BuildContext context){
    currentContext = context;


  }
}