import 'package:firebase_database/firebase_database.dart';
import 'package:xomultiplayer/models/guest_model.dart';

class GuestService {


    final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

    Future<GuestModel> insertGuest(String username) async{


      try{

        DatabaseReference newGuestRef=_databaseReference.child("guests").push();
        

        String guestId=newGuestRef.key!;

        await newGuestRef.set({


          "guestId":guestId,

          "username":username


        }
        );

        return  GuestModel(id: guestId, username: username);




        

      }catch(exception){

        throw exception;
      }
    }



}