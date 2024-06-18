import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stopit_frontend/services/auth_service.dart';
import 'package:stopit_frontend/services/checkup_service.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:stopit_frontend/globals.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key, required this.title});
  final String title;

  @override
  _JournalPageState createState() => _JournalPageState();
}

const List<Widget> difficulty = <Widget>[
  Text("Very Hard"),
  Text("Hard"),
  Text("Medium"),
  Text("Easy"),
  Text("Very Easy")
];

class _JournalPageState extends State<JournalPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime _firstDay = DateTime.now(); //Default value for now
  List<CheckupTransferObject> _checkupList = []; // List to store CheckupModel objects
  String _selectedComment = ''; // Variable to store the selected comment
  bool _hasSmokedToday = false;
  String _dayDifficulty = '';

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _fetchCheckup(); // Fetch checkup data when initializing the state
    _getUserData();
  }

  Future<void> _getUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      if (accessToken != null) {
        Map<String, dynamic> data = await getUserData(accessToken);
        setState(() {
          _firstDay = DateTime.parse(data['accountCreated']);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get user data: $e')),
      );
    }
  }

  Future<void> _fetchCheckup() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      String? email = prefs.getString('email');
      if (accessToken != null && email != null) {
        List<CheckupTransferObject> data = await fetchCheckup(accessToken, email);
        setState(() {
          _checkupList = data;
          // Set the comment for the current day
          _onDaySelected(_focusedDay, _focusedDay);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get checkup: $e')),
      );
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      // Find the checkup corresponding to the selected day and update the comment, hasSmokedToday, and dayDifficulty
      CheckupTransferObject checkup = _checkupList.firstWhere(
            (checkup) => isSameDay(checkup.date, selectedDay),
        orElse: () => CheckupTransferObject(
          hasSmoked: false,
          comment: 'No checkup comment :(',
          difficultyScale: "MEDIUM",
          date: DateTime.now(),
        ),
      );

      _selectedComment = checkup.comment;
      _hasSmokedToday = checkup.hasSmoked;
      _dayDifficulty = checkup.difficultyScale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => pages[currentPageIndex]),
          );
        },
        indicatorColor: AppColors.primaryColor,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: "Home"),
          NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book),
              label: "Journal"),
          NavigationDestination(
              icon: Icon(Icons.person_outlined),
              selectedIcon: Icon(Icons.person),
              label: "Profile"),
          NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: "Settings")
        ],
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Journal", style: AppStyles.headerStyle()),
            TableCalendar(
              firstDay: _firstDay,
              lastDay: DateTime.now(),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarStyle: CalendarStyle(
                defaultTextStyle: TextStyle(
                    color: AppColors.black, fontWeight: FontWeight.bold),
                defaultDecoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                selectedTextStyle: TextStyle(
                    color: AppColors.black, fontWeight: FontWeight.bold),
                selectedDecoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border.all(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(8)),
                todayTextStyle: TextStyle(
                    color: AppColors.black, fontWeight: FontWeight.bold),
                todayDecoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                ),
                outsideTextStyle: TextStyle(
                    color: AppColors.black, fontWeight: FontWeight.bold),
                outsideDecoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                ),
                weekendTextStyle: TextStyle(
                    color: AppColors.black, fontWeight: FontWeight.bold),
                weekendDecoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                ),
                markersAlignment: Alignment.bottomCenter,
                markersMaxCount: 1,
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.red),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    return Positioned(
                      right: 1,
                      bottom: 1,
                      child: _buildEventsMarker(date, events),
                    );
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Did you smoke?  ", style: AppStyles.labelStyle(),),
                    Text(_hasSmokedToday ? "Yes" : "No", style: TextStyle(color: _hasSmokedToday ? Colors.red : Colors.green, fontWeight: FontWeight.bold, fontSize: 20)),
                  ],
                ),
                CustomSizedBox.small(),
                Row(children: [
                  Text("How you felt: ", style: AppStyles.labelStyle(),),
                  Text(_dayDifficulty.toLowerCase(), style: AppStyles.labelStyle(),)
                ],),
                CustomSizedBox.small(),
                Text("Your comment:", style: AppStyles.labelStyle(),),
                Text(_selectedComment),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
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

}