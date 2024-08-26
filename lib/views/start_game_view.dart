import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:xomultiplayer/models/guest_model.dart';
import 'package:xomultiplayer/modelviews/start_game_model_view.dart';

class StartGameView extends StatefulWidget {




  StartGameView({Key?key}):super(key: key);


  @override
  State<StatefulWidget> createState() {

    return StartGameViewState();

  }
}

class StartGameViewState extends State<StartGameView> {

  late double _deviceWidth;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    GetIt.instance.get<StartGameModelView>().setCurrentContext(context);
    _deviceWidth=MediaQuery.of(context).size.width;

    return MultiProvider(providers: [ChangeNotifierProvider.value(value: GetIt.instance.get<StartGameModelView>())],
    
    child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,),
      backgroundColor: Colors.black,
      body: Center(child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(child: Column(children: [
        
           Container(width: _deviceWidth,
        
           child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            
            
            Expanded(child: youProfileSelector()),
        
        
           Expanded(child: opponentProfileSelector())
        
        
           ],),
            
           
           
           ),
           startGameButtonSelector()
        
        ],),),
      ),),
    
    
    ),

    
    );
  

  }
  Selector<StartGameModelView,GuestModel?> youProfileSelector(){

    return   Selector<StartGameModelView,GuestModel?>(selector: (context,provider)=>provider.you,
    
    shouldRebuild: (previous,next)=>!identical(previous, next),

    builder: (context,value,child){

      return youProfile(value);


    },
    );
  }


    Selector<StartGameModelView,GuestModel?> opponentProfileSelector(){

    return   Selector<StartGameModelView,GuestModel?>(selector: (context,provider)=>provider.opponent,
    
    shouldRebuild: (previous,next)=>!identical(previous, next),

    builder: (context,value,child){

      return opponentProfile(value);


    },
    );
  }

  Widget youProfile(GuestModel? guest){

    return Column(children: [Container(
      margin: EdgeInsets.all(20),
      child: guest==null?CircularProgressIndicator(color: Colors.white,):Text("you:${guest.username}",style:TextStyle(fontSize: _deviceWidth*0.05,color: Colors.red),),
    
    ),
    Container(child: Icon(Icons.person,color: Colors.white,
    size:_deviceWidth*0.4

    
    
    ),)
    ],);
  }

    Widget opponentProfile(GuestModel? guest){

    return Column(
     
      children: [Container(
    
      margin: EdgeInsets.all(20),
      child: guest==null?CircularProgressIndicator(color: Colors.white,):Text("opponent:${guest.username}",style:TextStyle(fontSize: _deviceWidth*0.05,color: Colors.redAccent),),
    
    ),
    Container(child: Icon(Icons.person,color: Colors.grey,
    size:_deviceWidth*0.4

    
    
    ),)
    ],);
  }


  Selector<StartGameModelView,bool> startGameButtonSelector(){


    return Selector<StartGameModelView,bool>(selector: (context,provider)=>provider.startGameLoading,
    
    shouldRebuild: (previous,next)=>!identical(previous, next),


    builder: (context,isLoading,child){

      return startGameButton(isLoading);


    },
    );
  }

    Widget startGameButton(bool isLoading){

        return Container(
      width: _deviceWidth,
      child: OutlinedButton(
       style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(10),


        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(


          borderRadius: BorderRadius.circular(10)
        )
       ),
        
        onPressed: (){

          if(isLoading==true){


          }

          else{

            GetIt.instance.get<StartGameModelView>().startGameClick();
          }

     
      
      }, child:isLoading==true?CircularProgressIndicator(color: Colors.white,):Text("Start Game",style: TextStyle(color:Colors.white,fontSize:_deviceWidth*0.06 ),)),
    );



  }





  @override
  void dispose() {
    // TODO: implement dispose

    GetIt.instance.get<StartGameModelView>().dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    if(!ModalRoute.of(context)!.isCurrent){



    }
    super.didChangeDependencies();
  }
  

}