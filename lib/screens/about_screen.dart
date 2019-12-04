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
        return AppLocalizations.of(context).tr('about_app');
        break;
      case 1:
        return AppLocalizations.of(context).tr('teacher');
        break;
      case 2:
        return AppLocalizations.of(context).tr('student');
        break;
      default:
        return AppLocalizations.of(context).tr('about_app');
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

  Widget _renderPages(int page) {
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
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 25.0,
                child: Container(
                  alignment: Alignment.center +
                      Alignment((toPage - fromPage) * _kViewportFraction, 0.0),
                  width:
                      (MediaQuery.of(context).size.width - 100) * resizeFactor,
                  height:
                      (MediaQuery.of(context).size.height - 200) * resizeFactor,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: _renderContents(fromPage, resizeFactor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderContents(int page, double resizeFactor) {
    switch (page) {
      case 0:
        return _renderAppContents(resizeFactor);
        break;
      case 1:
        return _renderTeacherContents(resizeFactor);
        break;
      case 2:
        return _renderStudentContents(resizeFactor);
        break;
      default:
        return _renderAppContents(resizeFactor);
    }
  }

  Widget _renderContentPrimaryText(String text, double resizeFactor) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 20 * resizeFactor,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor),
    );
  }

  Widget _renderContentNormalText(String text, double resizeFactor) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14 * resizeFactor,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _renderAppContents(double resizeFactor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.asset(
          'assets/images/logo_x5.png',
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.width * 0.3 * resizeFactor,
          width: MediaQuery.of(context).size.width * 0.3 * resizeFactor,
        ),
        Column(
          children: <Widget>[
            _renderContentPrimaryText("Smart Rabbit", resizeFactor),
            SizedBox(height: 10.0 * resizeFactor),
            _renderContentNormalText(
                AppLocalizations.of(context).tr('about_app_content'),
                resizeFactor),
          ],
        ),
      ],
    );
  }

  Widget _renderTeacherContents(double resizeFactor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.asset(
          'assets/images/avt_default.png',
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.width * 0.3 * resizeFactor,
          width: MediaQuery.of(context).size.width * 0.3 * resizeFactor,
        ),
        Column(
          children: <Widget>[
            _renderContentPrimaryText("Ths. Nguyễn Đình Thành", resizeFactor),
            SizedBox(height: 10.0 * resizeFactor),
            _renderContentNormalText(
                AppLocalizations.of(context).tr('about_app_teacher_content'),
                resizeFactor),
          ],
        ),
      ],
    );
  }

  Widget _renderStudentContents(double resizeFactor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width * 0.25 * resizeFactor,
          width: MediaQuery.of(context).size.width * 0.25 * resizeFactor,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/avt_default.png'),
          ),
        ),
        Column(
          children: <Widget>[
            _renderContentPrimaryText("Nguyễn Thanh Nhân", resizeFactor),
            SizedBox(height: 5.0 * resizeFactor),
            _renderContentNormalText(
                AppLocalizations.of(context).tr('about_app_student_content'),
                resizeFactor),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.width * 0.25 * resizeFactor,
          width: MediaQuery.of(context).size.width * 0.25 * resizeFactor,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/avt_default.png'),
          ),
        ),
        Column(
          children: <Widget>[
            _renderContentPrimaryText("Lê Duy Hiển", resizeFactor),
            SizedBox(height: 5.0 * resizeFactor),
            _renderContentNormalText(
                AppLocalizations.of(context).tr('about_app_student_content'),
                resizeFactor),
          ],
        ),
      ],
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
              _renderPages(_page),
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
