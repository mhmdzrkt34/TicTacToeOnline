import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:xomultiplayer/models/guest_model.dart';
import 'package:xomultiplayer/modelviews/waiting_start_model_view.dart';

class WaitingStartView extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {


    return WaitingStartViewState();

  }
}


class WaitingStartViewState extends State<WaitingStartView> {
  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {


    GetIt.instance.get<WaitingStartModelView>().setCurrentContext(context);

    _deviceWidth=MediaQuery.of(context).size.width;

    return MultiProvider(providers: [ChangeNotifierProvider.value(value: GetIt.instance.get<WaitingStartModelView>())],
    
    child: Scaffold(
      
      backgroundColor: Colors.black,

    
    body: SafeArea(child: Padding(
      padding: const EdgeInsets.all(20),
      child: Center(child: SingleChildScrollView(


        child: Column(children: [
        
           Container(width: _deviceWidth,
        
           child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            
            
            Expanded(child: youProfileSelector()),
        
        
           Expanded(child: opponentProfileSelector())
        
        
           ],),
            
           
           
           ),
           waiting()
        
        
        ],),
      ),),
    ),))
    );
  
  }

    Selector<WaitingStartModelView,GuestModel?> youProfileSelector(){

    return   Selector<WaitingStartModelView,GuestModel?>(selector: (context,provider)=>provider.you,
    
    shouldRebuild: (previous,next)=>!identical(previous, next),

    builder: (context,value,child){

      return youProfile(value);


    },
    );
  }


    Selector<WaitingStartModelView,GuestModel?> opponentProfileSelector(){

    return   Selector<WaitingStartModelView,GuestModel?>(selector: (context,provider)=>provider.opponent,
    
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

  Widget waiting(){

    return Center(child: CircularProgressIndicator(color: Colors.white,),);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose

    GetIt.instance.get<WaitingStartModelView>().dispose();
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