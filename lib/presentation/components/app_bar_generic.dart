import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

class AppDrawerItems {
  final String? name;
  final IconData icon;

  AppDrawerItems(this.name, this.icon);
}

class AppBarGeneric extends StatelessWidget {
  const AppBarGeneric({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      toolbarHeight: 86,
      backgroundColor: theme.appBarTheme.backgroundColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Builder(
            builder: (context) => IconButton(
                icon: Icon(
                  FeatherIcons.menu,
                  color: theme.primaryColor,
                ),
                onPressed: () => Scaffold.of(context).openDrawer()),
          ),
          Expanded(
              child: FxText.titleLarge(
            'GO-GO-GO',
            textAlign: TextAlign.center,
            color: theme.primaryColor,
          )),
          const SizedBox(
            width: 16,
          ),
          Icon(
            FeatherIcons.search,
            color: theme.primaryColor,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
