import "package:authentication/authentication.dart";
import 'package:authentication/src/presentation/enum/authSteps.dart';
import 'package:authentication/src/routes/auth_routes.dart';
import "package:design_system/design_system.dart";
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wkout_core/wkout_core.dart';

class AuthHomePage extends StatefulWidget {
  const AuthHomePage({super.key});

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
  late ScrollController _scrollController;
  bool _showValidationErrors = false;

  // Controllers para o formulário de login
  late TextEditingController _loginEmailController;
  late TextEditingController _loginPasswordController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });

    _loginEmailController = TextEditingController();
    _loginPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    super.dispose();
  }

  void _clearLoginFields() {
    _loginEmailController.clear();
    _loginPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SolidBackgroundWidget(
          color: AppColors.backgroundLight,
          child: WkoutLoading<AuthHomeViewModel>(
            child: Consumer<AuthHomeViewModel>(
              builder: (context, viewModel, child) {
                return KeyboardDismissible(
                  child: viewModel.authStep == AuthSteps.initial
                      ? Container(
                          height: MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: AuthImageWidget(
                                  imagePath: AuthenticationImagePaths.logoPNG,
                                  width: 200,
                                ),
                              ),
                              Spacing.vertical(80),
                              _buildAuthOptions(viewModel),
                            ],
                          ),
                        )
                      : CustomScrollView(
                          controller: _scrollController,
                          slivers: [
                            SliverToBoxAdapter(
                              child: Container(
                                height: MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).padding.top,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: AuthImageWidget(
                                        imagePath:
                                            AuthenticationImagePaths.logoPNG,
                                        width: 200,
                                      ),
                                    ),
                                    Spacing.vertical(60),
                                    _buildLoginForm(viewModel),
                                    // if (viewModel.authStep == AuthSteps.register)
                                    //   _buildRegisterForm(viewModel),
                                    // if (viewModel.authStep == AuthSteps.login)
                                    //   _buildLoginForm(viewModel),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(AuthHomeViewModel viewModel) {
    return Container(
      width: 340,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextInput(
              label: "Email",
              inputType: InputType.email,
              controller: _loginEmailController,
            ),
            Spacing.vertical(24),
            CustomTextInput(
              label: "Senha",
              controller: _loginPasswordController,
              inputType: InputType.password,
            ),
            Spacing.vertical(32),
            AppButton(
              label: "Entrar",
              onPressed: () {
                viewModel.makeLogin(
                    _loginEmailController.text, _loginPasswordController.text);
              },
            ),
            Spacing.vertical(16),
            TextButton(
                onPressed: () {
                  _clearLoginFields();
                  WkoutNavigationService()
                      .push(context, AuthRoutes.registerPassword);
                },
                child: Text(
                  "Ainda não possuo uma conta!",
                  style: TextStyle(
                      color: AppColors.blackText,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )),
          ],
        ),
      ),
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
          padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppButton(
                label: "Já possuo uma conta",
                kind: ButtonKind.primary,
                onPressed: () {
                  viewModel.toggleAuthStep(AuthSteps.login);
                },
              ),
              Spacing.vertical(24),
              AppButton(
                label: "Ainda não possuo uma conta",
                kind: ButtonKind.secondary,
                onPressed: () {
                  _clearLoginFields();
                  WkoutNavigationService()
                      .push(context, AuthRoutes.registerPassword);
                  //viewModel.toggleAuthStep(AuthSteps.register);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
