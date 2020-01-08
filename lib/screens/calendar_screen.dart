import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_rabbit/services/booking.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController;
  Map<DateTime, List> _events = {};
  List _selectedEvents = [];
  DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    DateTime now = new DateTime.now();
    _selectedDay = new DateTime(now.year, now.month, now.day);
    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _onVisibleDaysChanged(null, null, null);
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) async {
    var now = new DateTime.now();
    var from = first ?? new DateTime(now.year, now.month, 1);
    var to = last ??
        ((now.month < 12)
            ? new DateTime(now.year, now.month + 1, 0)
            : new DateTime(now.year + 1, 1, 0));
    final res = await BookingService.getBookingByDate(from, to);
    if (res['isValid']) {
      Map<String, dynamic> data = res['data'];
      Map<DateTime, List> events = Map();
      data.forEach((k, v) {
        events.putIfAbsent(DateTime.parse(k), () => v);
      });
      setState(() {
        _events = events;
        _selectedEvents = events[_selectedDay] ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Localization
    var data = EasyLocalizationProvider.of(context).data;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).tr('calendar'),
        ),
      ),
      body: Column(
        children: <Widget>[
          TableCalendar(
            calendarController: _calendarController,
            locale: data.savedLocale.toString(),
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              centerHeaderTitle: true,
            ),
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
            ),
            events: _events,
            onDaySelected: _onDaySelected,
            onVisibleDaysChanged: _onVisibleDaysChanged,
            availableGestures: AvailableGestures.horizontalSwipe,
            builders: CalendarBuilders(
              markersBuilder: (context, date, events, holidays) {
                final children = <Widget>[];
                if (events.isNotEmpty) {
                  children.add(
                    Positioned(
                      right: 1,
                      bottom: 1,
                      child: _buildEventsMarker(date, events),
                    ),
                  );
                }
                return children;
              },
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(child: _buildEventList(data)),
        ],
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Theme.of(context).primaryColor,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildEventList(data) {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text((event['startTime'] ?? "") +
                      " - " +
                      (event['endTime'] ?? "-")),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      _iconAndText(
                          Icons.category,
                          data.savedLocale != Locale("vi", "VN")
                              ? event['categoryEn']
                              : event['categoryVi']),
                      _iconAndText(Icons.location_on, event['address'])
                    ],
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _iconAndText(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          icon,
          size: 20,
          color: Colors.blueGrey[300],
        ),
        SizedBox(width: 5),
        Expanded(child: Text(text ?? "-")),
      ],
    );
  }
}
