import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:tuple/tuple.dart';
import 'package:xomultiplayer/modelviews/waiting_start_model_view.dart';
import 'package:xomultiplayer/services/room_service.dart';

class JoinRoomModelView extends ChangeNotifier {

  late BuildContext currentContext;

  bool JoinIsLoading=false;

  RoomService _roomService= RoomService();

   FlutterSecureStorage _secureStorage=FlutterSecureStorage();





  JoinRoomModelView();


  void setCurrentContext(BuildContext context){

    currentContext=context;

  }



  void onDispose(){


  }

  Future<void> joinClick(String roomID) async{

    try{
      JoinIsLoading=true;
      notifyListeners();


       


         Tuple2<DatabaseReference,DataSnapshot> data=await _roomService.joinRoom(roomID);


         if(data.item2.exists && data.item2.value!=null){

              Map<String, dynamic> rowValue = Map<String, dynamic>.from(
      data.item2.value as Map<dynamic, dynamic>
    );

          
          Map<String,dynamic> guest= jsonDecode((await _secureStorage.read(key:  "guest"))!);

          rowValue["opponent_id"]=guest["id"];

          await data.item1.update(rowValue);

          JoinIsLoading=false;
          notifyListeners();

          GetIt.instance.get<WaitingStartModelView>().fetchYou();

          GetIt.instance.get<WaitingStartModelView>().listenToRoom(roomID);

          GetIt.instance.get<WaitingStartModelView>().listenToTurns(roomID);
          



          Navigator.pushReplacementNamed(currentContext, "waitingStartView");




         }

         else{

          
   
          JoinIsLoading=false;
          notifyListeners();
          

                                  Fluttertoast.showToast(
              msg:"there is no room with this id",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );


         }
         


       



      


    }catch(e){

      JoinIsLoading=false;

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



  


}