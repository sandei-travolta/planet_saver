import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planet_saver/Models/ChartModel.dart';
import 'package:planet_saver/Models/MessageViewModel.dart';


class MessagingService {
  FirebaseFirestore db=FirebaseFirestore.instance;
  void sendMessage(String from,String to,String message,bool inquiry,String converstionId)async{
    ChartModel _chartModel=ChartModel(
        from: from,
        to: to,
        message: message,
        dateStamp: Timestamp.now(),
        inquiry: inquiry
    );
    await db.collection("chats").doc(converstionId).collection("messages").doc().set(_chartModel.toJson());
    updateLastMessage(converstionId,message,from,to);
  }
    ///Save chart to Charts collection in t
  void updateLastMessage(String conversationId,String lastMessage,String from,String to)async{
    MessageView messageView1=MessageView(
        conversationId: conversationId,
        lastMessage: lastMessage,
        lastTimeStamp: Timestamp.now(),
        from:from,
         to: to
    );
    MessageView messageView2=MessageView(
        conversationId: conversationId,
        lastMessage: lastMessage,
        lastTimeStamp: Timestamp.now(),
        from:to,
        to: from,
    );
    await db.collection("Users").doc(from).collection('chats').doc(conversationId).set(messageView1.toJson());
    await db.collection("Users").doc(to).collection('chats').doc(conversationId).set(messageView2.toJson());
    ///Save to charts subcollection n users
  }
  String createChatId(String from,String to){
    return from+"-"+to;
  }
  void createFirstMessage(String from,String to,String message,bool inquiry)async{
    String converstionId=createChatId(from, to);
    ChartModel chartModel=ChartModel(
        from: from,
        to: to,
        message: message,
        dateStamp: Timestamp.now(),
        inquiry: inquiry
    );
    await db.collection("chats").doc(converstionId).collection("messages").doc().set(chartModel.toJson());
    updateLastMessage(converstionId,message,from,to);
  }

  Stream<List<MessageView>> fetchUserChats(String uid){
    return db.collection("Users").doc(uid).collection('chats').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => MessageView.fromSnap(doc)).toList();
    });
  }

}
