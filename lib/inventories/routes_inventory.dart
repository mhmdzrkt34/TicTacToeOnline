import 'package:flutter/material.dart';
import 'package:xomultiplayer/views/create_room_view.dart';
import 'package:xomultiplayer/views/game_view.dart';
import 'package:xomultiplayer/views/join_room_view.dart';
import 'package:xomultiplayer/views/room_manager_view.dart';
import 'package:xomultiplayer/views/start_game_view.dart';
import 'package:xomultiplayer/views/user_name_view.dart';
import 'package:xomultiplayer/views/waiting_start_view.dart';

class RoutesInventory {

  late Map<String,WidgetBuilder> _routes;



  late String _initalRoute;

  late BuildContext materialPappContext;


  RoutesInventory({required this.materialPappContext}){

    _routes={

      "userNameView":(context)=>UserNameView(),

      "roomManagerView":(context)=>RoomManagerView(),

      "createRoomView":(context)=>CreateRoomView(),
      
      "startGameView":(context)=>StartGameView(),
      "joinRoomView":(context)=>JoinRoomView(),
      "waitingStartView":(context)=>WaitingStartView(),
      "gameView":(context)=>GameView()




    };

    _initalRoute=_routes.keys.toList().first;


 
  }




  String getInitialRoute(){

    return this._initalRoute;
  }


  Map<String,WidgetBuilder> getRoutes(){

    return this._routes;
  }

  





}