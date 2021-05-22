import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:demo_app/providers/root_provider.dart';
import 'package:demo_app/theme/colors.dart';
import 'package:demo_app/views/add_item_page.dart';
import 'package:demo_app/views/home_page.dart';
import 'package:demo_app/views/sales_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class RootPage extends StatelessWidget {
  final List<Widget> pages = [
    HomePage(),
    SalesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final _rootProvider = Provider.of<RootProvider>(context, listen: false);

    return Consumer<RootProvider>(builder: (context, provider, child) {
      return Scaffold(
        body: IndexedStack(
          index: _rootProvider.pageIndex,
          children: pages,
        ),
        bottomNavigationBar: getFooter(_rootProvider),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              // selectedTab(4);

              Navigator.of(context).push(
                CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => AddItemPage(),
                ),
              );
            },
            child: Icon(
              Icons.add,
              size: 25,
            ),
            backgroundColor: Colors.pink
            //params
            ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    });
  }

  Widget getFooter(RootProvider provider) {
    List<IconData> iconItems = [
      Ionicons.md_home,
      Ionicons.md_stats,
    ];

    return AnimatedBottomNavigationBar(
      activeColor: primary,
      splashColor: secondary,
      inactiveColor: Colors.black.withOpacity(0.5),
      icons: iconItems,
      activeIndex: provider.pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      onTap: (index) {
        provider.updatePageIndex(index);
      },
      //other params
    );
  }
}
