import 'package:SmartRabit/util/const.dart';
import 'package:flutter/material.dart';
import 'package:SmartRabit/screens/main_screen.dart';
import 'package:flutter/painting.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  Widget _homePage() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/home.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 60.0),
              child: RaisedButton(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0),
                  child: Text(
                    "ĐĂNG NHẬP",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Constants.primaryTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.white,
                onPressed: _gotoLogin,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 15.0, bottom: 45.0),
              child: OutlineButton(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0),
                  child: Text(
                    "ĐĂNG KÝ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Constants.lightTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.transparent,
                onPressed: _gotoSignup,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginPage() {
    return Container(
      color: Constants.primaryColor,
      child: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: Text(
                      "Smart Rabbit",
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: "Pacifico",
                          color: Constants.primaryTextColor),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "TÊN ĐĂNG NHẬP",
                      labelStyle: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "MẬT KHẨU",
                      labelStyle: TextStyle(fontSize: 12.0),
                    ),
                    obscureText: true,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
                    child: Text(
                      "Quên mật khẩu?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constants.primaryTextColor,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
                    child: RaisedButton(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.0),
                        child: Text(
                          "ĐĂNG NHẬP",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Constants.lightTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Constants.primaryColor,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return MainScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signupPage() {
    return Container(
      color: Constants.primaryColor,
      child: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: Text(
                      "Smart Rabbit",
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: "Pacifico",
                          color: Constants.primaryTextColor),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "TÊN ĐĂNG NHẬP",
                      labelStyle: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "MẬT KHẨU",
                      labelStyle: TextStyle(fontSize: 12.0),
                    ),
                    obscureText: true,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      labelText: "EMAIL",
                      labelStyle: TextStyle(fontSize: 12.0),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: "SỐ ĐIỆN THOẠI",
                      labelStyle: TextStyle(fontSize: 12.0),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.home),
                      labelText: "ĐỊA CHỈ",
                      labelStyle: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(top: 30.0),
                      child: Text(
                        "Đã có tài khoản?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Constants.primaryTextColor,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    onTap: _jumpToLogin,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 60.0),
                    child: RaisedButton(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.0),
                        child: Text(
                          "ĐĂNG KÝ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Constants.lightTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Constants.primaryColor,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _gotoLogin() {
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 750),
      curve: Curves.easeInOut,
    );
  }

  _gotoSignup() {
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 750),
      curve: Curves.easeInOut,
    );
  }

  _jumpToLogin() {
    _controller.jumpToPage(0);
  }

  PageController _controller =
      PageController(initialPage: 1, viewportFraction: 1.0);

  Future<bool> _onWillPop() {
    if (_controller.page != 1) {
      _controller.animateToPage(
        1,
        duration: Duration(milliseconds: 750),
        curve: Curves.easeInOut,
      );
      return Future.value(false);
    }
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Exit SmartRabbit'),
                content: new Text('Are you sure to close this app?'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: PageView(
          controller: _controller,
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[_loginPage(), _homePage(), _signupPage()],
          scrollDirection: Axis.horizontal,
        ),
      ),
      onWillPop: _onWillPop,
    );
  }
}
