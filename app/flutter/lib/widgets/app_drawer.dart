import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:whats_is/screens/home.dart';
import 'package:whats_is/screens/terms.dart';
import 'package:whats_is/screens/howto.dart';
import 'package:whats_is/screens/status-viewer.dart';

class CustomAppDrawer extends StatefulWidget {
  @override
  _CustomAppDrawerState createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: "Menu".text.white.xl2.make(),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          ListTile(
            leading: Icon(Icons.message_outlined),
            title: Text('WhatsApp Message'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.group_work),
            title: Text('WhatsApp Status'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatusViewerScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('How to Use?'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HowToScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Terms & Privacy'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
