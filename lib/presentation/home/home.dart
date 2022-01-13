import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/presentation/home/fixed/fixed.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return FadedScaleAnimation(
      child: Stack(
        children: [
          ///  ====================  TAB BAR VIEW ======================
          TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children:  [
              Fixed(isBookmarked: false,),
              const Center(child: Text("BID")),
            ],
          ),

          ///  ====================  TAB BAR  ==========================
          FadedScaleAnimation(
            child: Container(
              margin: const EdgeInsets.all(MyApp.kDefaultPadding),
              height: MediaQuery.of(context).size.height * 0.05,
              width: double.infinity,
              decoration: BoxDecoration(
                color: MyApp.kDefaultBackgroundColorWhite,
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                labelColor: MyApp.kDefaultBackgroundColorWhite,
                unselectedLabelColor: Theme.of(context).primaryColor,
                tabs: const <Widget>[
                  Tab(
                    text: MyApp.fixed,
                  ),
                  Tab(
                    text: MyApp.bid,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
