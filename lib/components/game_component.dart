

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:xomultiplayer/models/game_model.dart';
import 'package:xomultiplayer/modelviews/game_model_view.dart';

class GameComponent extends StatelessWidget {

  late GameModel game;

  late double width;





  GameComponent({required this.game,required this.width,});



  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        GetIt.instance.get<GameModelView>().gameComponentClick(this.game);



      },
      
      child: Container(

      width: width,
      height: width,

      decoration: BoxDecoration(

        border: Border.all(

          color: Colors.white
        ),
      ),

      child: game.type==null?SizedBox():game.type=="o"?Icon(
        
        
        Icons.circle,color: Colors.blue):Icon(Icons.cancel,color: Colors.red,)


    ));
  
    
  }





}