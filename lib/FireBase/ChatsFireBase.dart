import 'package:planet_saver/Models/ChartModel.dart';
import 'package:planet_saver/Models/MessageViewModel.dart';

class MessagingService{
  void sendMessage(String from,String to,String message,String dateStamp,bool inquiry){
    ChartModel chat=ChartModel(
        from: from,
        to: to,
        message: message,
        dateStamp: dateStamp,
        inquiry: inquiry
    );
    ///Save chart to Charts collection in t
  }
  void updateLastMessage(String conversationId,String lastMessage,String lastTimeStamp){
    MessageView messageView=MessageView(conversationId: conversationId,
        lastMessage: lastMessage,
        lastTimeStamp: lastTimeStamp
    );
    ///Save to charts subcollection n users
  }
}