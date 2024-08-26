import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:xomultiplayer/components/game_component.dart';
import 'package:xomultiplayer/models/game_model.dart';
import 'package:xomultiplayer/modelviews/game_model_view.dart';

class GameView extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {

    return GameViewState();

  }
}


class GameViewState extends State<GameView> {

  late double _deviceWidth;
  late double _deviceHeight;



  @override
  Widget build(BuildContext context) {

    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;

    return MultiProvider(providers: [ChangeNotifierProvider.value(value: GetIt.instance.get<GameModelView>())],
    
    child: Scaffold(
      backgroundColor: Colors.black,


      body: SafeArea(child:Center(child: GamesSelector(),) 
        

),
    ),);

  }

  @override
  void dispose() {
    // TODO: implement dispose

    GetIt.instance.get<GameModelView>().dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    if(!ModalRoute.of(context)!.isCurrent){



    }
    super.didChangeDependencies();
  }

  Selector<GameModelView,List<GameModel>?> GamesSelector(){


    return Selector<GameModelView,List<GameModel>?>(selector: (context,provider)=>provider.games,
    
    shouldRebuild: (previous,next)=>!identical(previous, next),

    builder: (context,value,child){

      if(value==null){

        return CircularProgressIndicator(color: Colors.white,);
      }

      return Container(
        width: _deviceWidth,
        height: _deviceHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        
          children: [Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [GameComponent(game: value[0], width: _deviceWidth*0.2),
          GameComponent(game: value[1], width: _deviceWidth*0.2),
          GameComponent(game: value[2], width: _deviceWidth*0.2)
          
          
          ],),
        
          Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
        
            GameComponent(game: value[3], width: _deviceWidth*0.2),
          GameComponent(game: value[4], width: _deviceWidth*0.2),
          GameComponent(game: value[5], width: _deviceWidth*0.2)
          
          ],),
          Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
        
            GameComponent(game: value[6], width: _deviceWidth*0.2),
          GameComponent(game: value[7], width: _deviceWidth*0.2),
          GameComponent(game: value[8], width: _deviceWidth*0.2)
          
          ],)
          
          ],
        ),
      );



    },
    );
  }




}