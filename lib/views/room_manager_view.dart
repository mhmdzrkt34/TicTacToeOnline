import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:xomultiplayer/modelviews/room_manager_model_view.dart';

class RoomManagerView extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {

    return RoomManagerViewState();

  }
}


class RoomManagerViewState extends State<RoomManagerView> {

  late double _deviceWidth=MediaQuery.of(context).size.width;





  @override
  Widget build(BuildContext context) {

    GetIt.instance.get<RoomManagerModelView>().setContext(context);

    return MultiProvider(providers: [ChangeNotifierProvider.value(value: GetIt.instance.get<RoomManagerModelView>())],
    
    child: Scaffold(
      backgroundColor: Colors.black,


      appBar: AppBar(

        backgroundColor: Colors.black,
      ),

      body: Center(child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(child: Column(children: [
          createRoomButton(),
          joinRoomButton()
        
        
        
        
        ],),),
      ),),

      

    
    )
    );

  }


  Widget createRoomButton(){

    
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: _deviceWidth,
      child: OutlinedButton(
       style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(10),


        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(


          borderRadius: BorderRadius.circular(10)
        )
       ),
        
        onPressed: (){

          GetIt.instance.get<RoomManagerModelView>().createRoomClick();



     
      
      }, child: Text("Create Room",style: TextStyle(color:Colors.black,fontSize:_deviceWidth*0.06 ),)),
    );


  }


  Widget joinRoomButton(){

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

          GetIt.instance.get<RoomManagerModelView>().joinRoomClick();

     
      
      }, child: Text("Join Room",style: TextStyle(color:Colors.white,fontSize:_deviceWidth*0.06 ),)),
    );



  }
}