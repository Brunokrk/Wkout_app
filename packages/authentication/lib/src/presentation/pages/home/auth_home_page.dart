import 'package:authentication/src/presentation/pages/home/auth_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthHomePage extends StatefulWidget {
  const AuthHomePage({super.key});

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
    late AuthHomeViewModel viewModel;
    late ScrollController _scrollController;

    @override
    void initState() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel = Provider.of<AuthHomeViewModel>(context, listen: false);
      });
      _scrollController = ScrollController()..addListener((){setState(() {});});
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Auth Home'),
        ),
        body: const Center(
          child: Text('Auth Home Page'),
        ),
      );
    }
  }