import 'package:firebase_database/firebase_database.dart';

class GameService {


  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();


  Future<void> generateGame(String roomId) async {


    try{

      for(int i=1;i<=9;i++){

           DatabaseReference newRoomRef =_databaseReference.child("games").push();


                  Map<String,dynamic> gameData={


        "room_id":roomId,

       "guest_action_creator_id":null,

       "position":i,
       "type":null





       
       };

       await newRoomRef.set(gameData);








      }


    }catch(e){


      throw e;
    }



  }






}