import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard UI',
      theme: ThemeData(
        fontFamily: 'Helvetica',
        primarySwatch: Colors.blue,
      ),
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  int _selectedIndex = 0;

  List<String> tabs = ["Upcoming schedule", "Completed"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 16),
              _buildTabBar(),
              SizedBox(height: 16),
              _buildCalendar(),
              SizedBox(height: 24),
              Text("Upcoming Appointments", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildAppointmentCard(
                name: "Dr. Sachith Abhayaratna",
                specialty: "Cardiologist | Lanka Hospitals",
                rating: "4.6",
                time: "3:30pm - 4:30pm",
                imageUrl: "https://i.imgur.com/QCNbOAo.png",
              ),
              SizedBox(height: 16),
              _buildAppointmentCard(
                name: "Siri Paint Colombo",
                specialty: "Consultation",
                rating: "4.2",
                time: "10:00am - 10:45am",
                imageUrl: "https://i.imgur.com/u5vZEDP.png",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Good Evening,", style: TextStyle(fontSize: 16, color: Colors.grey)),
            Text("Vihanga K", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.orange.shade100,
          child: Icon(Icons.person, color: Colors.blue),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = _selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue.shade100 : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.blue : Colors.black54,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(color: Colors.blue.shade100, shape: BoxShape.circle),
        selectedDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
        selectedTextStyle: TextStyle(color: Colors.white),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
    );
  }

  Widget _buildAppointmentCard({
    required String name,
    required String specialty,
    required String rating,
    required String time,
    required String imageUrl,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 24),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(specialty, style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Icon(Icons.favorite_border, color: Colors.red),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.star, size: 16, color: Colors.orange),
              SizedBox(width: 4),
              Text(rating),
              Spacer(),
              Icon(Icons.access_time, size: 16),
              SizedBox(width: 4),
              Text(time),
            ],
          ),
          SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Cancel Appointment", style: TextStyle(color: Colors.red)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
