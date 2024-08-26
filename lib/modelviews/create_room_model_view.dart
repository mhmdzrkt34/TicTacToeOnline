
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:xomultiplayer/models/guest_model.dart';
import 'package:xomultiplayer/modelviews/start_game_model_view.dart';
import 'package:xomultiplayer/services/room_service.dart';

class CreateRoomModelView extends ChangeNotifier {


  late BuildContext currentContext;
  bool isRoomIdGenerated=false;
  bool isLoadingCreateRequest=false;
    FlutterSecureStorage _secureStorage=FlutterSecureStorage();
  RoomService _roomService=RoomService();
  




  CreateRoomModelView(){



  }




  void setContext(BuildContext context){


    currentContext=context;
  }


  void generateRandomIdClick(TextEditingController controller){

    if(isRoomIdGenerated==true){

                    Fluttertoast.showToast(
              msg: "room id is already generated",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );


    }
else {


    String id=generateRandomString(20);

    controller.text=id;
    isRoomIdGenerated=true;

}







  }
  


  Future<void> CreateClick(String roomId) async{

    isLoadingCreateRequest=true;
    notifyListeners();

    try{

      Map<String,dynamic> guest= jsonDecode((await _secureStorage.read(key:  "guest"))!);





      await _roomService.createRoom(roomId, guest["id"]);


       isLoadingCreateRequest=false;
       notifyListeners();

       GetIt.instance.get<StartGameModelView>().setRoomId(roomId);
        GetIt.instance.get<StartGameModelView>().fetchYou();
       
       GetIt.instance.get<StartGameModelView>().listenToanyJoiningOpponent();

       Navigator.pushReplacementNamed(currentContext, "startGameView");




    }catch(e){

      isLoadingCreateRequest=false;

      notifyListeners();

                        Fluttertoast.showToast(
              msg: e.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );

      



    }



  }


  void dispose(){
    this.isRoomIdGenerated=false;
   


  }



  String generateRandomString(int length) {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
    length,
    (_) => characters.codeUnitAt(random.nextInt(characters.length)),
  ));
}









}