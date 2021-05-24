import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:demo_app/business_logic/view_models/root_viewmodel.dart';
import 'package:demo_app/ui/pages/add/add_item_page.dart';
import 'package:demo_app/ui/pages/compare_page.dart';
import 'package:demo_app/ui/pages/home_page.dart';
import 'package:demo_app/ui/pages/market_page.dart';
import 'package:demo_app/ui/pages/sales_page.dart';
import 'package:demo_app/ui/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class RootPage extends StatelessWidget {
  final List<Widget> pages = [
    HomePage(),
    SalesPage(),
    MarketPage(),
    ComparePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final _rootViewModel = Provider.of<RootViewModel>(context, listen: false);

    return Consumer<RootViewModel>(builder: (context, provider, child) {
      return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: _rootViewModel.pageIndex,
            children: pages,
          ),
        ),
        bottomNavigationBar: getFooter(_rootViewModel),
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

  Widget getFooter(RootViewModel provider) {
    List<IconData> iconItems = [
      Ionicons.md_pie,
      Ionicons.md_analytics,
      Ionicons.md_stats,
      Ionicons.md_shuffle,
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
