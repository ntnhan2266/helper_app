import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String avatar;
  final String userName;
  final int timeStamp;
  final bool isLeftMessage;

  // Constructor to get text from textfield
  ChatMessage(
      {this.isLeftMessage = true,
      this.text,
      this.avatar,
      this.userName = 'test',
      this.timeStamp});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.symmetric(
          vertical: ScreenUtil.instance.setHeight(12),
        ),
        child: isLeftMessage
            ? Container(
                padding: EdgeInsets.all(ScreenUtil.instance.setWidth(8)),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                width: screenWidth * 0.8,
                margin:
                    EdgeInsets.only(left: ScreenUtil.instance.setWidth(100)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: ScreenUtil.instance.setSp(14),
                        color: Colors.white,
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Text(
                        '20:10 22/10/2019',
                        style: TextStyle(
                          fontSize: ScreenUtil.instance.setSp(9),
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      right: ScreenUtil.instance.setWidth(16),
                    ),
                    child: CircleAvatar(
                      child: Image.network(
                        'https://images2.minutemediacdn.com/image/upload/c_crop,h_1193,w_2121,x_0,y_64/f_auto,q_auto,w_1100/v1565279671/shape/mentalfloss/578211-gettyimages-542930526.jpg',
                        width: ScreenUtil.instance.setWidth(100),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(ScreenUtil.instance.setWidth(8)),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    width: screenWidth - ScreenUtil.instance.setWidth(140),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          userName,
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
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text(
                            '20:10 22/10/2019',
                            style: TextStyle(
                              fontSize: ScreenUtil.instance.setSp(9),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
  }
}
