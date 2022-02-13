class DataModel {
  int id;
  final String type;
  final String msg;
  final String time;
  final String chatId;
  final String srcId;

  DataModel({this.id, this.type, this.msg, this.time, this.chatId, this.srcId});

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
        id: json['id'],
        type: json["type"],
        msg: json["msg"],
        time: json["time"],
        chatId: json["chatId"],
        srcId: json["srcId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "msg": msg,
        "time": time,
        "chatId": chatId,
        "srcId": srcId,
      };
}
