import 'package:firebase_database/firebase_database.dart';

class TurnService {



  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();


     Future<void> createTurn(String roomid,String creatorId) async{


       DatabaseReference newRoomRef =_databaseReference.child("turns").push();




       Map<String,dynamic> turnData={


        "room_id":roomid,

        "creator_id":creatorId,



        "guest_turn_id":creatorId
       };








    try{

      await newRoomRef.set(turnData);




    }catch(e){

      throw e;
    }
   }




}