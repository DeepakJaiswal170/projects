import 'package:api_check/Posts/create_post.dart';
import 'package:api_check/Posts/posts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String usertype;
  
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      usertype = prefs.getString('usertype');
    });
  }
  Widget build(BuildContext context) {
    
    print("usertype = $usertype");
    if (usertype == "teacher") {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
            floatingActionButton: Visibility(
              child: FloatingActionButton(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreatePost()),
                  );
                },
                child: Icon(Icons.add),
              ),
              // visible: shouldShow,
            ),
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                      child: Text("Announcements",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic))),
                  Tab(
                      child: Text("My Posts",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic))),
                ],
              ),
              // automaticallyImplyLeading: false,
              title: Text("Dashboard"),
              
              backgroundColor: Colors.blueAccent,
            ),
            body: TabBarView(
              children: [
                allPost(),
                myPost(),
              ],
            )),
      );
    } else if (usertype == "student") {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: Text("Announcements",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic)),
                  ),
                  Tab(
                    child: Text("For Me",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic)),
                  ),
                ],
              ),
              // automaticallyImplyLeading: false,
              title: Text("Dashboard"),
              
              backgroundColor: Colors.blueAccent,
            ),
            body: TabBarView(
              children: [
                allPost(),
                mySemPosts(),
              ],
            )),
      );
    } else {
      return Center(child: Text("Nothing To Show"));
    }
  }

  allPost() {
    return Scaffold(
      backgroundColor: Color(0xffEEEEFF),
      body: SingleChildScrollView(
        child: Posts(
          url: "https://scm007v2.herokuapp.com/post/other_post",
          del: false,
          
        ),
      ),
    );
  }

  myPost() {
    
    return Scaffold(
      backgroundColor: Color(0xffEEEEFF),
      body: SingleChildScrollView(
        child: Posts(
          url: "https://scm007v2.herokuapp.com/post/my_post",
          del: true,
          
        ),
      ),
    );
  }

  mySemPosts() {
    
    return Scaffold(
      backgroundColor: Color(0xffEEEEFF),
      body: SingleChildScrollView(
        child: Posts(
          url: "https://scm007v2.herokuapp.com/post/for_student",
          del: false,
          
        ),
      ),
    );
  }
}
