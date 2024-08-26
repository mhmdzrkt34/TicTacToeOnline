import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:xomultiplayer/models/guest_model.dart';
import 'package:xomultiplayer/models/turn_model.dart';
import 'package:xomultiplayer/modelviews/game_model_view.dart';

class WaitingStartModelView extends ChangeNotifier {


    GuestModel? you=null;

  GuestModel? opponent=null;

  StreamSubscription<DatabaseEvent>? _roomListener;


  StreamSubscription<DatabaseEvent>? _turnsListener;

   final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

       final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref();


      late BuildContext _currentContext;










  WaitingStartModelView();

  void onDispose(){

    opponent=null;
    you=null;
    _roomListener?.cancel();
    _turnsListener?.cancel();







  }


  Future<void> listenToRoom(String roomId) async{


    _roomListener=_databaseReference.child("rooms").child(roomId).onValue.listen((event) async{


        Map<String, dynamic> jsonData = Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>);


            if(jsonData["isStarted"]==true){


              GetIt.instance.get<GameModelView>().setPlayers(you!, opponent!);


              GetIt.instance.get<GameModelView>().setType("joiner");

              
               GetIt.instance.get<GameModelView>().setRoomId(roomId);

               GetIt.instance.get<GameModelView>().setCreator(false);


              GetIt.instance.get<GameModelView>().listenToGame(roomId);
              GetIt.instance.get<GameModelView>().listenToTurn(roomId);


              


              Navigator.pushNamed(_currentContext, "gameView");



              return;
            }

            DataSnapshot creatorSnapshot=await _databaseReference.child("guests").child(jsonData["creator_id"].toString()).once().then((event)=>event.snapshot);

   Map<String, dynamic> opponentData =
                  Map<String, dynamic>.from(creatorSnapshot.value as Map<dynamic, dynamic>);

       GuestModel opponentModel=GuestModel(id: opponentData["guestId"].toString(), username: opponentData["username"]);

       opponent=opponentModel;

       notifyListeners();
       


    });





  }

  Future<void> listenToTurns(String roomId) async {

    _turnsListener=_databaseReference.child("turns").orderByChild("room_id").equalTo(roomId).onValue.listen((event){

      if(event.snapshot.value!=null){

        Map<dynamic,dynamic> data=event.snapshot.value as Map<dynamic,dynamic>;


        TurnModel turn=TurnModel.fromJson(data);

        GetIt.instance.get<GameModelView>().setTurns(turn);







      }



      
    });



  }

    Future<void> fetchYou() async{


    GuestModel youu=GuestModel.fromJson(jsonDecode((await _secureStorage.read(key:  "guest"))!)) ; 

    you=youu;

    notifyListeners();



  }


  void setCurrentContext(BuildContext context){

    _currentContext=context;
  }




}