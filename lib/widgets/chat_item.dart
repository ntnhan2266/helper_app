import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String _name = "Anonymous";

class ChatMessage extends StatelessWidget {
  final String text;

  // Constructor to get text from textfield
  ChatMessage({this.text});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.symmetric(
          vertical: ScreenUtil.instance.setHeight(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                right: ScreenUtil.instance.setWidth(16),
              ),
              child: CircleAvatar(
                child: Image.network(
                  "http://res.cloudinary.com/kennyy/image/upload/v1531317427/avatar_z1rc6f.png",
                  width: ScreenUtil.instance.setWidth(100),
                ),
              ),
            ),
            Container(
              width: screenWidth - ScreenUtil.instance.setWidth(140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _name,
                    style: TextStyle(
                      fontSize: ScreenUtil.instance.setSp(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: ScreenUtil.instance.setSp(12),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
