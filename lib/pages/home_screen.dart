import 'package:dashboard/pages/split_screen.dart';
import 'package:dashboard/widgets/api_split_panel.dart';
import 'package:dashboard/widgets/custom_navigation_rail.dart';
import 'package:dashboard/widgets/my_Projects.dart';
import 'package:dashboard/widgets/search_bar.dart';
import 'package:dashboard/widgets/split_panels.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navSelectedIndex = 0;
  List<Map<String, dynamic>> myProjects = [
    {
      "icon": Icons.bike_scooter,
      "projectName": "Vehicle Loan",
      "projectId": 00000000018,
      "createdOn": "22/10/2025",
    },
    {
      "icon": Icons.agriculture,
      "projectName": "Agriculture Loan",
      "projectId": 00000000019,
      "createdOn": "18/10/2025",
    },
    {
      "icon": Icons.diamond,
      "projectName": "Gold Loan",
      "projectId": 00000000020,
      "createdOn": "12/10/2025",
    },
    {
      "icon": Icons.home,
      "projectName": "Housing Loan",
      "projectId": 00000000021,
      "createdOn": "01/10/2025",
    },
    {
      "icon": Icons.factory,
      "projectName": "MSME",
      "projectId": 00000000022,
      "createdOn": "02/09/2025",
    },
  ];
  Widget getContentWidget(int index) {
    switch (index) {
      case 0:
        return MyProjects(cardData: myProjects);
    }
    return Text("No Project created Yet!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(color: Colors.grey, height: 1),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min, // Shrink wrap the Row horizontally
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_tree),
            SizedBox(width: 10),
            Text(
              "BUILD PERFECT",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            SearchBarWidget(hintText: "Search here"),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SplitScreen()),
                  );
                },
                child: Text("Create New Project"),
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(Colors.black),
                  backgroundColor: WidgetStateProperty.all(Colors.transparent),
                  shadowColor: WidgetStateProperty.all(Colors.transparent),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey, width: 1)),
              ),
              child: CustomNavigationRail(
                selectedIndex: navSelectedIndex,
                isExtend: true,
                label: [
                  "My Project",
                  "Templates",
                  "Data Source",
                  "Integrations",
                ],
                icons: [Icons.home, Icons.file_copy, Icons.more, Icons.abc],
                // backgroundColor: Colors.pink.shade100,
                onDestinationSelected: (value) {
                  setState(() {
                    navSelectedIndex = value;
                  });
                  if (value == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyWidget()),
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey, width: 1)),
              ),
              child: getContentWidget(navSelectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}
