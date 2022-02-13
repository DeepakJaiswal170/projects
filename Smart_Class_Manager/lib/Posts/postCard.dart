import 'package:api_check/Modals/post_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key key, this.post, this.del}) : super(key: key);

  final Post post;
  final bool del;

  @override
  Widget build(BuildContext context) {
    if (post.username == "") {
      return SizedBox(
        height: 10,
      );
    } else {
      if (post.coverImage != "") {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 4,
          ),
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                  ),
                  title: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        post.username,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      PopupMenuButton<String>(
                        enabled: del,
                        onSelected: (value) {
                          //write functionality here..
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              child: Text("Delete"),
                              value: "Delete",
                            ),
                            // PopupMenuItem(
                            //   child: Text("Hide"),
                            //   value: "Hide",
                            // ),
                          ];
                        },
                      ),
                    ],
                  ),
                  subtitle: Container(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(children: [
                      Text(
                        "Department: " + post.dept,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        "Year: " + post.year,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ]),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 5.0,
                ),
                SizedBox(
                  height: 8,
                  width: MediaQuery.of(context).size.width - 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://scm007v2.herokuapp.com/${post.coverImage}"),
                        fit: BoxFit.fitHeight),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
                  child: ExpandableText(
                    post.title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    expandText: 'show more',
                    collapseText: 'show less',
                    maxLines: 3,
                    linkColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 4,
          ),
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                  ),
                  title: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        post.username,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      PopupMenuButton<String>(
                        enabled: del,
                        onSelected: (value) {
                          //write functionality here Mr.Deefuck
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              child: Text("Delete"),
                              value: "Delete",
                            ),
                            // PopupMenuItem(
                            //   child: Text("Hide"),
                            //   value: "Hide",
                            // ),
                          ];
                        },
                      ),
                    ],
                  ),
                  subtitle: Container(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(children: [
                      Text(
                        "Department: " + post.dept,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        "Year: " + post.year,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ]),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 5.0,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: ExpandableText(
                    post.title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    expandText: 'show more',
                    collapseText: 'show less',
                    maxLines: 7,
                    linkColor: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        );
      }
    }
  }
}
