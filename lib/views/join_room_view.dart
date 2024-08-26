import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:xomultiplayer/modelviews/join_room_model_view.dart';

class JoinRoomView extends StatefulWidget {







  @override
  State<StatefulWidget> createState() {


    return JoinRoomViewState();

  }
}


class JoinRoomViewState extends State<JoinRoomView> {
late double _deviceWidth;

GlobalKey<FormState> _key=GlobalKey<FormState>();
    String roomId="";



  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;


    GetIt.instance.get<JoinRoomModelView>().setCurrentContext(context);


    return MultiProvider(providers: [ChangeNotifierProvider.value(value: GetIt.instance.get<JoinRoomModelView>())],
    
    child: Scaffold(
      
      appBar: AppBar(
        iconTheme: IconThemeData(

          color: Colors.white,
        ),
        

        backgroundColor: Colors.black,
      ),
      body: Center(child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(child: Column(children: [

            roomForm(),
            joinButtonSelector()

        ],),),
      ),),
      backgroundColor: Colors.black,),
    );

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    if(!ModalRoute.of(context)!.isCurrent){


    }
    super.didChangeDependencies();
  }


    Widget roomForm(){

    return Container(
      margin: EdgeInsets.only(bottom: 19),
      child: Form(
      key: _key,
      child: Column(children: [

        TextFormField(

          

          onSaved: (value){

            roomId=value!;

          },

          validator: (value){

            bool result=value!.contains(RegExp(r'^.{20}$')



);

return result? null:'invalid room id';



          },

          style: TextStyle(color: Colors.white,fontSize: _deviceWidth*0.048),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            
             errorMaxLines: 10, // Limit error text to 2 lines
             errorStyle: TextStyle(fontSize: _deviceWidth*0.036),
            label: Text("Room id:",style: TextStyle(
            fontSize: _deviceWidth*0.06,
            color: Colors.white),),

             enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
                focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
          
          ),
        )

      
    ],)));
  }

  Selector<JoinRoomModelView,bool> joinButtonSelector(){

    return Selector<JoinRoomModelView,bool>(selector: (context,provider)=>provider.JoinIsLoading,
    
    shouldRebuild: (previous,next)=>!identical(previous, next),

    builder: (context,value,child){

      return joinButton(value);


    },
    );



  }


    Widget joinButton(bool isLoading){

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
          else {

            if(_key.currentState!.validate()){

              _key.currentState!.save();

              GetIt.instance.get<JoinRoomModelView>().joinClick(roomId);
            }
          }

      

     
      
      }, child: isLoading==true?CircularProgressIndicator(): Text("Join",style: TextStyle(color:Colors.white,fontSize:_deviceWidth*0.06 ),)),
    );



  }
}