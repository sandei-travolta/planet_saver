import 'package:cloud_firestore/cloud_firestore.dart';

class ChartModel{
  final String from;
  final String to;
  final String message;
  final Timestamp dateStamp;
  final bool inquiry;

  ChartModel(
      {
        required this.from,
        required this.to,
        required this.message,
        required this.dateStamp,
        required this.inquiry
      }
      );
  Map<String,dynamic> toJson()=>{
    "from":from,
    "to":to,
    "message":message,
    "dateStamp":FieldValue.serverTimestamp(),
    "inquiry":inquiry
  };
  static ChartModel fromSnap(DocumentSnapshot snapshot){
    var snap=snapshot.data() as Map<String,dynamic>;
    return ChartModel(
        from: snap['from'],
        to: snap['to'],
        message: snap['message'],
        dateStamp: snap['dateStamp'],
        inquiry: snap['inquiry']
    );
  }
}