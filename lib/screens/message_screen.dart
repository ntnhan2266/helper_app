import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../widgets/chat_item.dart';
import '../models/user.dart';
import '../models/service_details.dart';

class MessageScreen extends StatefulWidget {
  @override
  State createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
  }

  void _handleSubmit(String text, ServiceDetails booking) {
    final userProvider = Provider.of<User>(context, listen: false);
    if (text.trim() != '') {
      _chatController.clear();
    }
    var documentReference = Firestore.instance
        .collection('conversations')
        .document(booking.id)
        .collection(booking.id)
        .document(DateTime.now().millisecondsSinceEpoch.toString());
    Firestore.instance.runTransaction((transaction) async {
      await transaction.set(documentReference, {
        'from': userProvider.id,
        'to': userProvider.id == booking.maid.id
            ? userProvider.id
            : booking.createdBy.id,
        'content': text,
        'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      });
    });
    listScrollController.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  Widget _chatEnvironment(ServiceDetails data) {
    return IconTheme(
      data: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil.instance.setWidth(8),
        ),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                decoration: InputDecoration.collapsed(
                    hintText:
                        AppLocalizations.of(context).tr('message_content'),
                    hintStyle: TextStyle(
                      fontSize: ScreenUtil.instance.setSp(12),
                      fontWeight: FontWeight.w300,
                    )),
                controller: _chatController,
                onSubmitted: (String content) {
                  _handleSubmit(content, data);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: ScreenUtil.instance.setWidth(8),
              ),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  _handleSubmit(_chatController.text, data);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
      int index, DocumentSnapshot document, ServiceDetails booking) {
    final userProvider = Provider.of<User>(context, listen: false);
    var userName = booking.maid.name;
    var avatar = booking.maid.avatar;
    if (document['from'] == userProvider.id) {
      userName = userProvider.name;
      avatar = userProvider.avatar;
    }
    print('from: ' + document['from']);
    print('provider: ' + userProvider.id);
    return ChatMessage(
      isLeftMessage: document['from'] == userProvider.id,
      avatar: avatar,
      userName: userName,
      text: document['content'],
      timeStamp: int.parse(document['timestamp']),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ServiceDetails data = ModalRoute.of(context).settings.arguments;

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
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('conversations')
                      .document(data.id)
                      .collection(data.id)
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        return ListView.builder(
                          padding: EdgeInsets.all(
                            ScreenUtil.instance.setWidth(12),
                          ),
                          reverse: true,
                          itemBuilder: (_, int index) => _buildItem(
                              index, snapshot.data.documents[index], data),
                          itemCount: snapshot.data.documents.length,
                          controller: listScrollController,
                        );
                    }
                  }),
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _chatEnvironment(data),
            )
          ],
        ),
      ),
    );
  }
}
