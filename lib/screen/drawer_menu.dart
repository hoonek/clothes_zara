import 'package:flutter/material.dart';

import '../menu/inner.dart';
import '../menu/outer.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('메뉴'),
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
          ),
          ListTile(
            title: Text('Outer_관리자'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Outer()),
              );
            },
          ),
         ListTile(
            title: Text('Inner_사용자'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Inner()),
              );
            },
          ),

        ],
      ),
    );
  }
}
