import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

const double _kViewportFraction = 0.75;

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  int _page = 0;

  void _handlePageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Color> _getColor(int page) {
    switch (page) {
      case 0:
        return [const Color(0xFFFD8183), const Color(0xFFFB425A)];
        break;
      case 1:
        return [const Color(0xFFF8C08E), const Color(0xFFFDA65B)];
        break;
      case 2:
        return [const Color(0xFF6CD8F0), const Color(0xFF6AD89D)];
        break;
      default:
        return [const Color(0xFFFD8183), const Color(0xFFFB425A)];
    }
  }

  String _getTitle(int page) {
    switch (page) {
      case 0:
        return "About App";
        break;
      case 1:
        return "Teacher";
        break;
      case 2:
        return "Student";
        break;
      default:
        return "About App";
    }
  }

  Widget _renderBackground(int page) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: _getColor(page),
          ),
        ),
      ),
    );
  }

  Widget _renderContents(int page) {
    return PageView(
      controller: PageController(
        initialPage: _page,
        viewportFraction: _kViewportFraction,
      ),
      children: [
        _renderPage(0, _page),
        _renderPage(1, _page),
        _renderPage(2, _page),
      ],
      onPageChanged: _handlePageChanged,
    );
  }

  Widget _renderPage(int fromPage, int toPage) {
    var resizeFactor = 1 - ((toPage - fromPage).abs() * 0.2).clamp(0.0, 1.0);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _getTitle(toPage).toUpperCase(),
            style: TextStyle(
              fontSize: 26,
              color: fromPage == toPage ? Colors.white : Colors.transparent,
              fontWeight: FontWeight.w600,
              letterSpacing: 3,
            ),
          ),
          Container(
            alignment: Alignment.center +
                Alignment((toPage - fromPage) * _kViewportFraction, 0.0),
            width: (MediaQuery.of(context).size.width - 100) * resizeFactor,
            height: (MediaQuery.of(context).size.height - 200) * resizeFactor,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 25.0,
                  child: Container(
                      // height: MediaQuery.of(context).size.height - 250,
                      // width: MediaQuery.of(context).size.width - 150,
                      // child: Container(
                      //   margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
                      //   // child: child,
                      // ),
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        body: Container(
          child: Stack(
            children: <Widget>[
              _renderBackground(_page),
              _renderContents(_page),
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
