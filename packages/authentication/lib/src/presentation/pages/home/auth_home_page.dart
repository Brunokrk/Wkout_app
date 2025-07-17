import "package:authentication/authentication.dart";
import "package:design_system/design_system.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthHomePage extends StatefulWidget {
  const AuthHomePage({super.key});

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AuthHomeViewModel>();
    return Scaffold(
      backgroundColor: viewModel.isRed ? Colors.red : Colors.black,
      body: WkoutLoading<AuthHomeViewModel>(
        child: Consumer<AuthHomeViewModel>(builder: (context, viewModel, child) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: Column(
                    children: [
                      Text('Auth Home Page'),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.toggleRed();
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                ),
              ),
              
            ],
          );
        }),
      ),
    );
  }
}
