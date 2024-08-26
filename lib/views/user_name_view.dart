import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:xomultiplayer/modelviews/user_name_model_view.dart';

class UserNameView extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {

    return UserNameViewState();

  }
}

class UserNameViewState extends State<UserNameView> {
  final GlobalKey<FormState> _key=GlobalKey<FormState>();

  late double _deviceWidth;

  late double _deviceHeight;
  String username="";





  @override
  Widget build(BuildContext context) {
    GetIt.instance.get<UserNameModelView>().setCurrentContext(context);

    _deviceHeight=MediaQuery.of(context).size.height;


    _deviceWidth=MediaQuery.of(context).size.width;

    return MultiProvider(providers: [

      ChangeNotifierProvider.value(value: GetIt.instance.get<UserNameModelView>())
    ],
    
    child: Scaffold(backgroundColor: Colors.black,
    
    appBar: AppBar(

      backgroundColor: Colors.black,
    ),

    body: Center(child: SingleChildScrollView(child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
      
        userNameForm(),
        ConfirmButtonSelector()
      ],),
    ),),)


    ),);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  Widget userNameForm(){

    return Container(
      margin: EdgeInsets.only(bottom: 19),
      child: Form(
      key: _key,
      child: Column(children: [

        TextFormField(

          

          onSaved: (value){

            username=value!;

          },

          validator: (value){

            bool result=value!.contains(RegExp(r'^(?=.*[A-Za-z])[A-Za-z\d]{5,}$')



);

return result? null:'Please enter at least 5 characters without any special characters with at least one letter ';



          },

          style: TextStyle(color: Colors.white,fontSize: _deviceWidth*0.048),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            
             errorMaxLines: 10, // Limit error text to 2 lines
             errorStyle: TextStyle(fontSize: _deviceWidth*0.036),
            label: Text("Your Username:",style: TextStyle(
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

Selector<UserNameModelView,bool> ConfirmButtonSelector(){



  return Selector<UserNameModelView,bool>(selector: (context,provider)=>provider.isloading,
  
  shouldRebuild: (previous,next)=>!identical(previous, next),


  builder: (context,isloading,child){

    return ConfirmButton(isloading);


  },
  );
}


  Widget ConfirmButton(bool isloading){




    return Container(
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

          if(isloading==true){


          }
          else{

          

          if(_key.currentState!.validate()){

            _key.currentState!.save();
            GetIt.instance.get<UserNameModelView>().confirmClick(username);

          
          }}
      
      }, child: isloading==true?Center(child: CircularProgressIndicator(color: Colors.black,),):Text("Confirm",style: TextStyle(color:Colors.black,fontSize:_deviceWidth*0.06 ),)),
    );
  }


}