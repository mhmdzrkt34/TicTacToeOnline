class TurnModel {




  late String? creatorId;


  late String? guestTurnId;


  late String? roomId;



  TurnModel({required this.creatorId,required this.guestTurnId,required this.roomId});




  static TurnModel fromJson(Map<dynamic,dynamic> json){


    return TurnModel(creatorId: json["creator_id"],guestTurnId: json["guest_turn_id"],roomId: json["room_id"]);
  }



}