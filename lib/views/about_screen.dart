import 'package:flutter/material.dart';
import 'package:sandwich_shop/widgets/app_drawer.dart';
import 'package:sandwich_shop/widgets/app_bar_widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(title: 'About'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('About this app: A tiny sandwich shop demo.'),
      ),
    );
  }
}
