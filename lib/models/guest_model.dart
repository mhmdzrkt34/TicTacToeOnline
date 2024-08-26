class GuestModel{



  late String id ;

  late String username;





  GuestModel({required this.id,required this.username});


  static GuestModel fromJson(Map<String,dynamic> jsonGuest){


    return GuestModel(id: jsonGuest["id"],username: jsonGuest["username"]);
  }


  Map<String,dynamic> toJson(){


    return {


      "id":this.id,

      "username":this.username,
    };
  }





}