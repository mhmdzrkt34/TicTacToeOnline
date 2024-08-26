import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:xomultiplayer/modelviews/create_room_model_view.dart';

class CreateRoomView extends StatefulWidget {




  @override
  State<StatefulWidget> createState() {

    return CreateRoomViewState();

  }



}

class CreateRoomViewState extends State<CreateRoomView> {

  TextEditingController roomIdController=TextEditingController();

  GlobalKey<FormState> _key=GlobalKey<FormState>();

  late double _deviceWidth;

  String roomId="";





  @override
  Widget build(BuildContext context) {

    GetIt.instance.get<CreateRoomModelView>().setContext(context);
  _deviceWidth=MediaQuery.of(context).size.width;

    return MultiProvider(providers: [ChangeNotifierProvider.value(value: GetIt.instance.get<CreateRoomModelView>())],
    
    child: Scaffold(
      
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.black,
        
        
        ),
        body: Center(child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(child: SizedBox(
          
            width: _deviceWidth,
            child: Column(children: [
          
              RoomForm(),
                 
              
              Row(children: [Expanded(child: Container(
                
                margin: EdgeInsets.only(right: 10),
                child: generateRoomIDButton())),
          
              Expanded(child: createButtonSelector(),)
              ],)
            
              
            ],),
          ),),
        ),),
    
    
    ),
    );




  }

    @override
  void dispose() {
    // TODO: implement dispose


    GetIt.instance.get<CreateRoomModelView>().dispose();
    super.dispose();
  }
  



  


  
  Widget RoomForm(){

    return Container(
 
      margin: EdgeInsets.only(bottom: 19),
      child: Form(
      key: _key,
      child: Column(children: [

        TextFormField(
          readOnly: true,
          controller: roomIdController,

          

          onSaved: (value){
            

            roomId=value!;

          },

          validator: (value){

            bool result=value!.contains(RegExp(r'^.{20}$')



);

return result? null:'you must generate room id';



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

    Widget generateRoomIDButton(){

        return 
        
         Container(
        
     
      child: OutlinedButton(
       style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(10),


        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(


          borderRadius: BorderRadius.circular(10)
        )
       ),
        
        onPressed: (){

          GetIt.instance.get<CreateRoomModelView>().generateRandomIdClick(roomIdController);

     
      
      }, child: Text("Generate room id",style: TextStyle(color:Colors.white,fontSize:_deviceWidth*0.05 ),)),
    );
    



  }



  Selector<CreateRoomModelView,bool> createButtonSelector(){


    return Selector<CreateRoomModelView,bool>(selector: (context,provider)=>provider.isLoadingCreateRequest,
    
    shouldRebuild: (previous,next)=>!identical(previous, next),


    builder: (context,value,child){

      return createButton(value);


    },
    );
  }


    Widget createButton(bool value){

           return 
           
     
           
           
           Container(
          
    
      child: OutlinedButton(
       style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(10),


        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(


          borderRadius: BorderRadius.circular(10)
        )
       ),
        
        onPressed: (){

          if(value==true){


          }

          else{

          if(_key.currentState!.validate()){


            _key.currentState!.save();

           GetIt.instance.get<CreateRoomModelView>().CreateClick(roomId);



          }

          }

     
      
      }, child: value==true? Center(child: CircularProgressIndicator(color: Colors.white,),):Text("Create",style: TextStyle(color:Colors.black,fontSize:_deviceWidth*0.05 ),)),
    ) ;


  }
}