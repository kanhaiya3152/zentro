import 'package:flutter/material.dart';
import 'package:zentro/audioplayer.dart';
import 'package:zentro/form.dart';
import 'package:zentro/home_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    // final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor:  Colors.white,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.grey[400],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_rounded),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.audio_file),
            icon: Icon(Icons.audio_file_outlined),
            label: 'Form',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.summarize_sharp),
            icon: Icon(Icons.summarize_outlined),
            label: 'Music',
          ),
        ],
      ),
      body: <Widget>[
         const HomeScreen(),
         const FormScreen(),
         const AudioScreen(),
      ][currentPageIndex],
    );
  }
}
