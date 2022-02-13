import 'package:api_check/Modals/receiver_chat_model.dart';
import 'package:api_check/chat/IndividualPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key key, this.chatModel, this.sourchat}) : super(key: key);
  final ReceiverChatModel chatModel;
  final ReceiverChatModel sourchat;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualPage(
              chatModel: chatModel,
              sourchat: sourchat,
            ),
          ),
        );
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              child: SvgPicture.asset(
                "assets/person.svg",
                color: Colors.white,
                height: 36,
                width: 36,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            trailing: Text("04:00"),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(
                  chatModel.id.toString(),
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            title: Text(
              chatModel.fullName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 80),
            child: Divider(
              thickness: 1.8,
            ),
          )
        ],
      ),
    );
  }
}
