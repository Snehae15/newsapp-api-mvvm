import 'package:flutter/material.dart';
import 'package:newapp_usingapi_mvvm_/screens/general_screen.dart';
import 'package:newapp_usingapi_mvvm_/screens/health_screen.dart';
import 'package:newapp_usingapi_mvvm_/screens/science_screen.dart';
import 'package:newapp_usingapi_mvvm_/screens/technology_screen.dart';
import 'package:newapp_usingapi_mvvm_/screens/top_headlines_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "News App",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(),
              ),
              child: const TabBar(
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(fontSize: 15),
                indicator: BoxDecoration(
                  color: Colors
                      .transparent, // Transparent to let the container color show
                ),
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
                tabs: [
                  Tab(text: "General"),
                  Tab(text: "Health"),
                  Tab(text: "Technology"),
                  Tab(text: "Science"),
                  Tab(text: "Top Headlines"),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            GeneralScreen(),
            HealthScreen(),
            TechnologyScreen(),
            ScienceScreen(),
            TopHeadlinesScreen(),
          ],
        ),
      ),
    );
  }
}
