class ReceiverChatModel {
  int id;
  bool select;
  String fullName;

  ReceiverChatModel({this.id, this.select, this.fullName});

  ReceiverChatModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    select = false;
    fullName = json['fullName'];
  }

}
