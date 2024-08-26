

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xomultiplayer/models/game_model.dart';
import 'package:xomultiplayer/models/guest_model.dart';
import 'package:xomultiplayer/models/turn_model.dart';

class GameModelView extends ChangeNotifier {

  TurnModel? turn;


  GuestModel? you;

  GuestModel? opponent;

  String? type;


  String? roomId;
  bool? creator;

  List<GameModel>? games;
       final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref();


    StreamSubscription<DatabaseEvent>? _gamesListner;

    StreamSubscription<DatabaseEvent>? _turnListner;


  

 


  



  void setPlayers(GuestModel your,GuestModel opponentt){

    you=your;
    opponent=opponentt;

    print(you!.id);

    print(opponent!.id);



  }

  void setCreator(bool creatorr){

    creator=creatorr;



  }

  void setTurns(TurnModel turnn){

    turn=turnn;
    print(turn!.guestTurnId);
  }

  void setType(String typee){

    type=typee;
  }

  void onDispose(){
    turn=null;
    you=null;
    opponent=null;
    type=null;

    _gamesListner?.cancel();
    _turnListner?.cancel();
    roomId=null;

  }

  void setRoomId(String roomID){

    roomId=roomID;


  }

Future<void> listenToGame(String roomId) async {
  try {
    _gamesListner = _databaseReference
        .child("games")
        .orderByChild("room_id")
        .equalTo(roomId)
        .onValue
        .listen((event) {
      List<GameModel> gamesList = [];

      if (event.snapshot.value != null) {
        // Cast the snapshot value to a Map
        Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;

        // Iterate over each key-value pair in the map
        data.forEach((key, value) {
          // Ensure the value is a Map before converting to GameModel
        
            gamesList.add(GameModel.fromJson(value));
          
        });

        // Sort the gamesList by 'position'
        gamesList.sort((a, b) => a.position!.compareTo(b.position!));

        games=List.from(gamesList);

        notifyListeners();

        print("Games list updated. Total games: ${gamesList.length}");
      } else {
        print('No data found for roomId: $roomId');
      }
    });
  } catch (e) {
    print('Error: $e');
  }
  }


  Future<void> listenToTurn(String roomId) async {
  try {
    _gamesListner = _databaseReference
        .child("turns")
        .orderByChild("room_id")
        .equalTo(roomId)
        .onValue
        .listen((event) {
      
      if (event.snapshot.value != null) {
        // Cast the snapshot value to a Map
        Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
        turn=TurnModel.fromJson(data[data.keys.first]);

        print(turn!.guestTurnId);


      } else {
        print('No data found for roomId: $roomId');
      }
    });
  } catch (e) {
    print('Error: $e');
  }
  }


  Future<void> gameComponentClick(GameModel game) async{

print("position ${game.position}");
    try{

      if(turn!.guestTurnId==you!.id){

        GameModel findedGame=games!.where((item)=>item.position==game.position).first;

        if(findedGame.type!=null){

                                               Fluttertoast.showToast(
              msg: "it is not empty",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );



        }

        else {
       
_databaseReference
      .child("games")
      .orderByChild("room_id")
      .equalTo(roomId)
      .once().then((DatabaseEvent event){

          if (event.snapshot.value != null) { 
            

             Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;

         
             var key=data.keys.first;


               Map<dynamic, dynamic> dataInside=data[key] as Map<dynamic, dynamic>;



          data.forEach((key, value) {
            if (value != null && value is Map<dynamic, dynamic>) {
              Map<dynamic, dynamic> gameData = value;

              // Check if both room_id and position match
              if (gameData["room_id"] == roomId && gameData["position"] == game.position) {
                print("Found matching game entry");
                
                // Update the game data
                gameData["type"] = creator==true ? "x" : "o";
                gameData["guest_action_creator_id"] = you!.id;

                // Convert the dynamic map to Map<String, Object>
                Map<String, Object> updatedData = Map<String, Object>.from(gameData);

                // Update the entry in Firebase
                _databaseReference.child("games/$key").update(updatedData).then((_) {
                  print('Game updated successfully.');
                }).catchError((error) {
                  print('Failed to update game: $error');
                });

                                      _databaseReference.child("turns").orderByChild("room_id").equalTo(roomId).once().then((DatabaseEvent event){

              Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;

              
                var key=data.keys.first;

               Map<dynamic, dynamic> dataInside=data[key] as Map<dynamic, dynamic>;

               dataInside["guest_turn_id"]=opponent!.id;
                Map<String, Object> updatedData = Map<String, Object>.from(dataInside);


                  _databaseReference.child("turns/${key}").update(updatedData as Map<String,Object>).then((_) {


                  }).catchError((error) {
              print('Failed to update turn: $error');
            });
;







             });
              }
            }
          });
        


               




           }



      });}


        

        



      }

      else {

                                     Fluttertoast.showToast(
              msg: "it is not your turn",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );


      }


    }catch(e){

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





  GameModelView();
}