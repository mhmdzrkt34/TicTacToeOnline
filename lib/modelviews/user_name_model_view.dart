import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:xomultiplayer/inventories/routes_inventory.dart';
import 'package:xomultiplayer/models/guest_model.dart';
import 'package:xomultiplayer/services/guest_service.dart';

class UserNameModelView extends ChangeNotifier{



  GuestService _guestService=GuestService();


  FlutterSecureStorage _secureStorage=FlutterSecureStorage();

  late BuildContext _currentContext;




  bool isloading=false;




  UserNameModelView();

  Future<void> confirmClick(String username) async{



    try{
      isloading=true;
      notifyListeners();
      GuestModel guest=await _guestService.insertGuest(username);


      await _secureStorage.write(key: "guest", value: jsonEncode(guest.toJson()));

      isloading=false;
      notifyListeners();

      Navigator.pushReplacementNamed(_currentContext, GetIt.instance.get<RoutesInventory>().getRoutes().keys.toList()[1]);



      





    }catch(e){

                  Fluttertoast.showToast(
              msg: e.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );

      isloading=false;
      notifyListeners();


    }
  }


  void setCurrentContext(BuildContext context){

    _currentContext=context;


  }

  
}