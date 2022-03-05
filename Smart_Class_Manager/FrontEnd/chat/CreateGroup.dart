import 'package:api_check/CustomUI/AvtarCard.dart';
import 'package:api_check/CustomUI/ContactCard.dart';
import 'package:api_check/Modals/receiver_chat_model.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key key, this.contacts}) : super(key: key);
  final List<ReceiverChatModel> contacts;
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  
  List<ReceiverChatModel> groups = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create Group",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              "Add Participants",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 26,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: widget.contacts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  height: groups.length > 0 ? 90 : 10,
                );
              }
              return InkWell(
                onTap: () {
                  if (widget.contacts[index - 1].select == true) {
                    setState(() {
                      groups.remove(widget.contacts[index - 1]);
                      widget.contacts[index - 1].select = false;
                    });
                  } else {
                    setState(() {
                      groups.add(widget.contacts[index - 1]);
                      widget.contacts[index - 1].select = true;
                    });
                  }
                },
                child: ContactCard(
                  contact: widget.contacts[index - 1],
                ),
              );
            },
          ),
          groups.length > 0
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      color: Colors.white,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.contacts.length,
                          itemBuilder: (context, index) {
                            if (widget.contacts[index].select == true) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    groups.remove(widget.contacts[index]);
                                    widget.contacts[index].select = false;
                                  });
                                },
                                child: AvtarCard(
                                  contact: widget.contacts[index],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
