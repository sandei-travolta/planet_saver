import 'package:cloud_firestore/cloud_firestore.dart';

class MessageView{
  final String conversationId;
  final String lastMessage;
  final String from;
  final String to;
  final Timestamp lastTimeStamp;

  MessageView({
    required this.conversationId,
    required this.lastMessage,
    required this.lastTimeStamp,
    required this.from,
    required this.to,}
      );
   Map<String,dynamic> toJson()=>{
     "conversationId":conversationId,
     "lastMessage":lastMessage,
     "lastTimeStamp":lastTimeStamp,
     "to":to,
     "from":from
  };
  static MessageView fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return MessageView(
      conversationId: snap["conversationId"] ?? "",
      lastMessage: snap["lastMessage"] ?? "",
      lastTimeStamp: snap["lastTimeStamp"] ?? Timestamp.now(),
      to: snap["to"],
      from:snap["from"]
    );
  }
}