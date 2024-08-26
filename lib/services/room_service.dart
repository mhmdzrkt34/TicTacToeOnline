import 'package:firebase_database/firebase_database.dart';
import 'package:tuple/tuple.dart';

class RoomService {


   final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();


   Future<void> createRoom(String roomid,String creatorId) async{

    await _databaseReference.child("rooms/${roomid}").set(({



      "id":roomid,
      "creator_id":creatorId,

      "opponent_id":null,

      "isStarted":false
    }));


    try{




    }catch(e){

      throw e;
    }
   }


   Future<Tuple2<DatabaseReference,DataSnapshot>> joinRoom(String roomid) async {

    try{

        final DatabaseReference roomRef = _databaseReference
        .child('rooms')
        .child(roomid);

         DataSnapshot snapshot = await roomRef.once().then((event) => event.snapshot);

         return Tuple2<DatabaseReference,DataSnapshot>(roomRef, snapshot);



    }catch(e){

      throw e;
    }



   }

   Future<void> startGame(String roomId) async {


    try{

         final DatabaseReference roomRef = _databaseReference
          .child('rooms')
          .child(roomId);


                await roomRef.update({
        'isStarted': true,
      });

          

          


    }catch(e){

      throw e;



    }
   }




}