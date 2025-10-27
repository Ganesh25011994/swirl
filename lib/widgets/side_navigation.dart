
/*
 @created on : May 7,2025
 @author : Akshayaa 
 Description : Drawer at the side for navigation between pages
*/

import 'package:flutter/material.dart';

class Sidenavigationbar extends StatelessWidget {
  const Sidenavigationbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: Icon(Icons.dashboard_rounded, color: Colors.teal),
            title: Text("Dashboard"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.mail_rounded, color: Colors.teal),
            title: Text("Application Inbox"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.message_rounded, color: Colors.teal),
            title: Text("Query Inbox"),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.update_rounded, color: Colors.teal),
            title: Text("Masters Update"),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}