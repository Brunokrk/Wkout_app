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
      //backgroundColor: viewModel.isRed ? Colors.red : Colors.black,
      body: WkoutLoading<AuthHomeViewModel>(
        child:
            Consumer<AuthHomeViewModel>(builder: (context, viewModel, child) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: Column(
                    children: [
                      AuthImageWidget(
                        imagePath: AuthenticationImagePaths.logoPNG,
                      ),
                      Container(
                        width: 340,
                        height: 180,
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40,0,40,0),
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppButton(
                              label: "Já possuo uma conta",
                              kind: ButtonKind.primary,
                              onPressed: () {
                                viewModel.toggleRed();
                              },
                            ),
                            AppButton(
                              label: "Ainda não possuo uma conta",
                              kind: ButtonKind.secondary,
                              onPressed: () {
                                viewModel.toggleRed();
                              },
                            ),
                            ],
                          ),
                        ),
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
