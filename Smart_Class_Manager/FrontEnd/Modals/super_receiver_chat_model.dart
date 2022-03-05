import 'package:api_check/Modals/receiver_chat_model.dart';

class SuperReceiverChatModel {
  List<ReceiverChatModel> data;
  SuperReceiverChatModel({this.data});
  SuperReceiverChatModel.fromJson(Map<String, dynamic> json) 
  : data = (json['data'] as List)
  ?.map((e) => e == null ? null 
  :ReceiverChatModel.fromJson(e as Map<String, dynamic>))
  ?.toList();
}