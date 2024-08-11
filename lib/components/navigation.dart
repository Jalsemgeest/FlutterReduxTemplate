import "package:flutter/material.dart";
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import "../store/storage.dart";
import "./home.dart";
import "../store/storage.dart";

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _HomeState();
}

class _HomeState extends State<Navigation> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Food Tracker"),
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          indicatorColor: Colors.amber,
          selectedIndex: currentIndex,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: "Home"),
            // NavigationDestination(
            //     icon: Icon(Icons.person_outlined),
            //     selectedIcon: Icon(Icons.person),
            //     label: "Profile"),
          ],
        ),
        body: [
          Home(),
        ][currentIndex]);
  }
}
