import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/chat_item.dart';

class MessageScreen extends StatefulWidget {
  @override
  State createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  final TextEditingController _chatController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  void _handleSubmit(String text) {
    _chatController.clear();
    ChatMessage message = ChatMessage(text: text);

    setState(() {
      _messages.insert(0, message);
    });
  }

  Widget _chatEnvironment() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor,),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil.instance.setWidth(8),
        ),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                decoration: InputDecoration.collapsed(
                    hintText: AppLocalizations.of(context).tr('message_content'),
                    hintStyle: TextStyle(
                      fontSize: ScreenUtil.instance.setSp(12),
                      fontWeight: FontWeight.w300,
                    )),
                controller: _chatController,
                onSubmitted: _handleSubmit,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: ScreenUtil.instance.setWidth(8),
              ),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmit(_chatController.text),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).tr('message'),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(
                  ScreenUtil.instance.setWidth(12),
                ),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _chatEnvironment(),
            )
          ],
        ),
      ),
    );
  }
}
