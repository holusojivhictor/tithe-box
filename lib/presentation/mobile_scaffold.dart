import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/presentation/churches/churches_page.dart';
import 'package:tithe_box/presentation/income_record/income_record_page.dart';
import 'package:tithe_box/presentation/payments/payments_page.dart';
import 'package:tithe_box/presentation/shared/extensions/focus_scope_node_extensions.dart';

import 'home/home_page.dart';
import 'settings/settings_page.dart';

class MobileScaffold extends StatefulWidget {
  final int defaultIndex;
  final TabController tabController;

  const MobileScaffold({
    Key? key,
    required this.defaultIndex,
    required this.tabController,
  }) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  late int _index;

  @override
  void initState() {
    _index = widget.defaultIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<MainTabBloc, MainTabState>(
          listener: (ctx, state) async {
            state.maybeMap(
              initial: (s) => _changeCurrentTab(s.currentSelectedTab),
              orElse: () => {},
            );
          },
          child: TabBarView(
            controller: widget.tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              HomePage(),
              ChurchesPage(),
              IncomeRecordPage(),
              PaymentsPage(),
              SettingsPage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).dividerColor,
        currentIndex: _index,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Churches', icon: Icon(Icons.church_outlined), activeIcon: Icon(Icons.church)),
          BottomNavigationBarItem(label: 'Incomes', icon: Icon(Icons.add_circle_outline), activeIcon: Icon(Icons.add_circle)),
          BottomNavigationBarItem(label: 'Payments', icon: Icon(Icons.payments_outlined), activeIcon: Icon(Icons.payments)),
          BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings)),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: (index) => _goToTab(index),
      ),
    );
  }

  void _changeCurrentTab(int index) {
    FocusScope.of(context).removeFocus();
    widget.tabController.index = index;
    setState(() {
      _index = index;
    });
  }

  void _goToTab(int newIndex) => context.read<MainTabBloc>().add(MainTabEvent.goToTab(index: newIndex));
}
