import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:xomultiplayer/models/guest_model.dart';
import 'package:xomultiplayer/models/turn_model.dart';
import 'package:xomultiplayer/modelviews/game_model_view.dart';
import 'package:xomultiplayer/services/game_service.dart';
import 'package:xomultiplayer/services/room_service.dart';
import 'package:xomultiplayer/services/turn_service.dart';

class StartGameModelView extends ChangeNotifier {

  GuestModel? you=null;

  GuestModel? opponent=null;


  bool startGameLoading=false;

  StreamSubscription<DatabaseEvent>? _opponentSubscription;


  RoomService _roomService=RoomService();

  TurnService _turnService=TurnService();

  GameService _gameService=GameService();


  late String roomid;
  late BuildContext _currentContext;

  
   final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

     final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref();



  StartGameModelView(){

    
  }



  Future<void> fetchYou() async{


    GuestModel youu=GuestModel.fromJson(jsonDecode((await _secureStorage.read(key:  "guest"))!)) ; 

    you=youu;

    notifyListeners();



  }

  Future<void> listenToanyJoiningOpponent() async{

    _opponentSubscription= _databaseReference.child('rooms').child(roomid).onValue.listen((event) async{


             Map<String, dynamic> jsonData = Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>);

      if(jsonData["opponent_id"]==null){


        opponent=null;
        notifyListeners();
      }
      else {
       DataSnapshot opponentSnapshot =(await _databaseReference.child("guests").child(jsonData["opponent_id"].toString()).once().then((event)=>event.snapshot));
        Map<String, dynamic> opponentData =
                  Map<String, dynamic>.from(opponentSnapshot.value as Map<dynamic, dynamic>);

       GuestModel opponentModel=new GuestModel(id: opponentData["guestId"].toString(), username: opponentData["username"]);


      opponent=opponentModel;

      notifyListeners();







      }


    });
    


  }

  void setRoomId(String id){

    roomid=id;
  }

  void dispose(){
    opponent=null;
    you=null;
    _opponentSubscription!.cancel();

    startGameLoading=false;
    




  }


  Future<void> startGameClick() async{

    if(opponent==null || you==null){


                                        Fluttertoast.showToast(
              msg:"there is no opponent  to start the game",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );



    }

    else{

      try{

        startGameLoading=true;
        notifyListeners();

        await _turnService.createTurn(roomid, you!.id);

        await _roomService.startGame(this.roomid);
        await _gameService.generateGame(this.roomid);

        startGameLoading=false;
        notifyListeners();

        GetIt.instance.get<GameModelView>().setPlayers(you!, opponent!);

        GetIt.instance.get<GameModelView>().setTurns(TurnModel(creatorId: you!.id, guestTurnId: you!.id, roomId: roomid));
        GetIt.instance.get<GameModelView>().setType("creator");

                                GetIt.instance.get<GameModelView>().setRoomId(roomid);

                         GetIt.instance.get<GameModelView>().setCreator(true);

        GetIt.instance.get<GameModelView>().listenToGame(roomid);
        GetIt.instance.get<GameModelView>().listenToTurn(roomid);


        Navigator.pushReplacementNamed(_currentContext, "gameView");


      }catch(e){

        startGameLoading=false;

        notifyListeners();

        

                                        Fluttertoast.showToast(
              msg:e.toString(),
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

  void setCurrentContext(BuildContext context){

    _currentContext=context;
  }



}