import "package:authentication/authentication.dart";
import 'package:authentication/src/presentation/enum/authSteps.dart';
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
                      if (viewModel.authStep == AuthSteps.initial)
                        _buildAuthOptions(viewModel),
                      if (viewModel.authStep == AuthSteps.login)
                        _buildLoginForm(viewModel),
                      if (viewModel.authStep == AuthSteps.register)
                        _buildRegisterForm(),
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _buildLoginForm(AuthHomeViewModel viewModel) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Container(
      width: 340,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextInput(
              label: "Email",
              hint: "Digite seu email",
              inputType: InputType.email,
              controller: emailController,
            ),
            Spacing.vertical(16),
            CustomTextInput(
              label: "Senha",
              hint: "Digite sua senha",
              controller: passwordController,
              inputType: InputType.password,
            ),
            Spacing.vertical(16),
            AppButton(
              label: "Entrar",
              onPressed: () {
                viewModel.makeLogin(emailController.text, passwordController.text);
              },
            ),
            Spacing.vertical(16),
            AppButton(
                label: "Ainda não possuo uma conta",
                kind: ButtonKind.secondary,
                onPressed: () {
                  viewModel.toggleAuthStep(AuthSteps.register);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterForm() {
    return SliverToBoxAdapter(
      child: Container(),
    );
  }

  Widget _buildAuthOptions(AuthHomeViewModel viewModel) {
    return Center(
      child: Container(
        width: 340,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 16, 40, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppButton(
                label: "Já possuo uma conta",
                kind: ButtonKind.primary,
                onPressed: () {
                  viewModel.toggleAuthStep(AuthSteps.login);
                },
              ),
              Spacing.vertical(16),
              AppButton(
                label: "Ainda não possuo uma conta",
                kind: ButtonKind.secondary,
                onPressed: () {
                  viewModel.toggleAuthStep(AuthSteps.register);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
