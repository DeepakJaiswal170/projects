import 'Pages/Records.dart';
import 'Pages/chatpage.dart';
import 'Pages/dashboard.dart';
import 'Pages/profilepage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/classroom.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  PageController _pageController;
  dynamic routine;
  var usertype;
  var dept;

  @override
  void initState() {
    _pageController = PageController(initialPage: _page);
    super.initState();
    getData();
  }

  Future getData() async {
    Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usertype = prefs.getString('usertype');
    var token = prefs.getString('logToken');
    var id = prefs.getInt('id');
    dept = prefs.getString('dept');
    var sem = prefs.getInt('sem');
    Response routineResponse;
    if (usertype == "student") {
      routineResponse = await dio.get(
          'https://scm007v2.herokuapp.com/student/routine/$dept-$sem',
          options: Options(
            headers: {"authorization": token},
          ));
    } else {
      routineResponse = await dio.get(
          'https://scm007v2.herokuapp.com/teacher/routine/$dept-$id',
          options: Options(
            headers: {"authorization": token},
          ));
    }
    if (mounted) {
      setState(() {
        routine = routineResponse.data;
        usertype = prefs.getString('usertype');
        dept = prefs.getString('dept');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          onTap: (index) {
            this._pageController.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.easeIn);
          },
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Dashboard'),
            new BottomNavigationBarItem(
                icon: Icon(Icons.class_), label: 'Classroom'),
            new BottomNavigationBarItem(
                icon: Icon(Icons.class_), label: 'Records'),
            new BottomNavigationBarItem(
                icon: Icon(Icons.chat), label: 'Messages'),
            new BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Profile'),
          ]),
      body: PageView(
        controller: _pageController,
        onPageChanged: (newpage) {
          setState(() {
            this._page = newpage;
          });
        },
        children: [
          new MainPage(),
          new Classroom(
            data: routine,
            usertype: usertype,
          ),
          new Records(
            dept: dept,
            usertype: usertype,
          ),
          new ChatPage(),
          new UserProfile(),
        ],
      ),
    );
  }
}
