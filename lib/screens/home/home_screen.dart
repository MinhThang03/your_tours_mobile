import 'package:flutter/material.dart';

import 'components/app_bar.dart';
import 'components/body.dart';
import 'components/categories.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isInnerScroll) {
          return [
            SliverAppBar(
              toolbarHeight: 2.5 * kToolbarHeight,
              automaticallyImplyLeading: false,
              elevation: 2,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              title: Column(
                children: [AppBarHome(), Categories()],
              ),
              pinned: true,
            ),
            // SliverToBoxAdapter(child:                     Categories(),
            //     )
          ];
        },
        body: Body(),
      ),
    );
  }
}
