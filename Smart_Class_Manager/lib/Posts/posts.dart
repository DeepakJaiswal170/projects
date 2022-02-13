import 'dart:convert';
import 'package:api_check/Modals/post_model.dart';
import 'package:api_check/Modals/superPost_model.dart';
import 'package:api_check/Posts/postCard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Posts extends StatefulWidget {
  Posts({Key key, this.url, this.del}) : super(key: key);
  final String url;
  final bool del;
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  Dio dio = Dio();
  bool refresh = true;
  SuperModel superModel = SuperModel();
  List<Post> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (refresh) {
      String token = prefs.getString('logToken');
      var response = await dio.get(widget.url,
          options: Options(
            headers: {"authorization": token},
          ));

      var s = jsonEncode(response.data);
      prefs.setString(widget.url, s);
    }

    var s = prefs.getString(widget.url);
    var d = jsonDecode(s);

    superModel = SuperModel.fromJson(d); //response.data);
    setState(() {
      data = superModel.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return data.length > 0
        ? Column(
            children: data.reversed
                .map((item) => Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          child: PostCard(
                            post: item,
                            del: widget.del,
                          ),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                      ],
                    ))
                .toList(),
          )
        : Center(
            child: SpinKitRotatingCircle(
              color: Colors.white,
              size: 50.0,
              duration: Duration(milliseconds: 1200),
            ),
            // child: Text("No Posts to show!!"),
          );
  }
}
