class GameModel {


  late String? roomId;

  late String? guestActionCreatorId;


  late int? position;

  late String? type;


  GameModel({required this.roomId,required this.guestActionCreatorId,required this.position,required this.type});



       static GameModel fromJson(Map<dynamic,dynamic> data){

        return GameModel(roomId: data["room_id"],guestActionCreatorId:data["guest_action_creator_id"],position: data["position"],type: data["type"]);
       }





}