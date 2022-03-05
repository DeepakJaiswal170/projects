import 'package:api_check/CustomUI/OwnMessageCard.dart';
import 'package:api_check/CustomUI/ReplyCard.dart';
import 'package:api_check/Modals/receiver_chat_model.dart';
import 'package:api_check/chat/DataModel.dart';
import 'package:api_check/chat/Database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_svg/svg.dart';

class IndividualPage extends StatefulWidget {
  IndividualPage({Key key, this.chatModel, this.sourchat}) : super(key: key);
  final ReceiverChatModel chatModel;
  final ReceiverChatModel sourchat;
  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  List<DataModel> datas = [];
  bool fetching = true;
  DB db;
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  IO.Socket socket;
  // List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    db = DB();
    getData2();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    // connect();
  }

  void getData2() async {
    datas = await db.getData();
    setState(() {
      fetching = false;
    });
  }

  void connect() {
    socket =
        IO.io("https://secret-castle-69868.herokuapp.com", <String, dynamic>{
      // IO.io("192.168.43.161", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": true,
    });
    socket.connect();
    socket.emit("signin", widget.sourchat.id);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"]);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print(socket.connect);
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  // void setMessage(String type, String message) {
  //   MessageModel messageModel = MessageModel(
  //       type: type,
  //       message: message,
  //       time: DateTime.now().toString().substring(10, 16));
  //   db.insertData(messageModel);
  //   setState(() {
  //     messages.add(messageModel);
  //   });
  // }
  void setMessage(String type, String message) {
    DataModel dataModel = DataModel(
      type: type,
      msg: message,
      time: DateTime.now().toString().substring(10, 16),
      chatId: widget.chatModel.id.toString(),
      srcId: widget.sourchat.id.toString() + widget.chatModel.id.toString(),
      // chatId: null,
      // srcId: null,
    );
    db.insertData(dataModel);
    setState(() {
      datas.add(dataModel);
    });
  }

  @override
  void setState(fn) {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var svgPicture = SvgPicture;
    return Stack(
      children: [
        Image.asset(
          "assets/chats_back1.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: 70.0,
            titleSpacing: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                  CircleAvatar(
                    child: SvgPicture.asset(
                      "assets/person.svg",
                      color: Colors.white,
                      height: 26,
                      width: 26,
                    ),
                    radius: 20.0,
                    backgroundColor: Colors.blueGrey,
                  ),
                ],
              ),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatModel.fullName,
                      style: TextStyle(
                          fontSize: 18.5, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "last seen today at 12:02",
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
              ),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height - 140,
                    child: ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      controller: _scrollController,
                      itemCount: datas.length + 1,
                      itemBuilder: (context, index) {
                        if (index == datas.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        String str = widget.sourchat.id.toString() +
                            widget.chatModel.id.toString();
                        if (datas[datas.length - index - 1].type == "source" &&
                            datas[datas.length - index - 1].srcId == str) {
                          return OwnMessageCard(
                            message: datas[datas.length - index - 1].msg,
                            time: DateTime.now().toString().substring(10, 16),
                          );
                        }
                        if (datas[datas.length - index - 1].chatId ==
                            widget.chatModel.id.toString()) {
                          return ReplyCard(
                            message: datas[datas.length - index - 1].msg,
                            time: DateTime.now().toString().substring(10, 16),
                          );
                        } else {
                          _scrollController.animateTo(
                              _scrollController.position.minScrollExtent,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut);
                          return SizedBox(height: 1);
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 55,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  margin: EdgeInsets.only(
                                      left: 5, right: 8, bottom: 8),
                                  child: TextFormField(
                                    controller: _controller,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        setState(() {
                                          sendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type A Message",
                                      prefixIcon: Icon(Icons.keyboard),
                                      contentPadding: EdgeInsets.all(5),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 8, right: 4),
                                child: CircleAvatar(
                                  radius: 25,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.send,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      if (sendButton) {
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.minScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut);
                                        sendMessage(
                                            _controller.text,
                                            widget.sourchat.id,
                                            widget.chatModel.id);
                                        _controller.clear();
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }
}
