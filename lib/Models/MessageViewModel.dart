import 'package:cloud_firestore/cloud_firestore.dart';

class MessageView{
  final String conversationId;
  final String lastMessage;
  final String lastTimeStamp;

  MessageView({required this.conversationId, required this.lastMessage, required this.lastTimeStamp});
   Map<String,dynamic> toJson()=>{
     "conversationId":conversationId,
     "lastMessage":lastMessage,
     "lastTimestamp":lastTimeStamp
  };
   static MessageView fromSnap(DocumentSnapshot snapshot){
     var snap =snapshot as Map<String,dynamic>;
     return MessageView(
         conversationId: snap["conversationId"],
         lastMessage: snap["lastMessage"],
         lastTimeStamp: snap["lastTimeStamp"]
     );
   }
}