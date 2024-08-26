import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:xomultiplayer/firebase_options.dart';
import 'package:xomultiplayer/inventories/routes_inventory.dart';
import 'package:xomultiplayer/modelviews/create_room_model_view.dart';
import 'package:xomultiplayer/modelviews/game_model_view.dart';
import 'package:xomultiplayer/modelviews/join_room_model_view.dart';
import 'package:xomultiplayer/modelviews/room_manager_model_view.dart';
import 'package:xomultiplayer/modelviews/start_game_model_view.dart';
import 'package:xomultiplayer/modelviews/user_name_model_view.dart';
import 'package:xomultiplayer/modelviews/waiting_start_model_view.dart';

Future<void> main() async{



  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(



    options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseDatabase.instance.setPersistenceEnabled(false);
 


  GetIt.instance.registerSingleton<UserNameModelView>(UserNameModelView());

  GetIt.instance.registerSingleton<RoomManagerModelView>(RoomManagerModelView());

  GetIt.instance.registerSingleton<CreateRoomModelView>(CreateRoomModelView());

  GetIt.instance.registerSingleton<StartGameModelView>(StartGameModelView());
  GetIt.instance.registerSingleton<JoinRoomModelView>(JoinRoomModelView());

  GetIt.instance.registerSingleton<WaitingStartModelView>(WaitingStartModelView());

  GetIt.instance.registerSingleton<GameModelView>(GameModelView());


   final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  String initialroute=(await _secureStorage.read(key:  "guest"))==null?"userNameView":"roomManagerView";
  runApp(MyApp(initialRoute:initialroute ,));
}

class MyApp extends StatelessWidget {

  late String initialRoute;
   MyApp({super.key,required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
registerRoutesInventoryAsSingleton(context);
   

    return MaterialApp(


      title: "XOMULTIPLAYER",

      routes: GetIt.instance.get<RoutesInventory>().getRoutes(),
      initialRoute:initialRoute


      
    );
  
}

void registerRoutesInventoryAsSingleton(BuildContext context){

     if(GetIt.instance.isRegistered<RoutesInventory>()){


    }
    else {
GetIt.instance.registerSingleton<RoutesInventory>(RoutesInventory(materialPappContext: context));

    }


}


void registerOfflineInventoryAsSingleton(){




}



}



