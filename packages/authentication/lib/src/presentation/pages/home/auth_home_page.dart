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

  // Controllers para o formulário de login
  late TextEditingController _loginEmailController;
  late TextEditingController _loginPasswordController;

  // Controllers para o formulário de registro
  late TextEditingController _registerNameController;
  late TextEditingController _registerEmailController;
  late TextEditingController _registerPasswordController;
  late TextEditingController _registerAgeController;
  late TextEditingController _registerNicknameController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });

    // Inicializar controllers
    _loginEmailController = TextEditingController();
    _loginPasswordController = TextEditingController();
    _registerNameController = TextEditingController();
    _registerEmailController = TextEditingController();
    _registerPasswordController = TextEditingController();
    _registerAgeController = TextEditingController();
    _registerNicknameController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerNameController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    _registerAgeController.dispose();
    super.dispose();
  }

  void _clearLoginFields() {
    _loginEmailController.clear();
    _loginPasswordController.clear();
  }

  void _clearRegisterFields() {
    _registerNameController.clear();
    _registerEmailController.clear();
    _registerPasswordController.clear();
    _registerAgeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AuthHomeViewModel>();
    return Scaffold(
      //backgroundColor: viewModel.isRed ? Colors.red : Colors.black,
      body: WkoutLoading<AuthHomeViewModel>(
        child:
            Consumer<AuthHomeViewModel>(builder: (context, viewModel, child) {
          return GestureDetector(
            onTap: () {
              // Fecha o teclado quando tocar fora dos campos
              FocusScope.of(context).unfocus();
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      children: [
                        AuthImageWidget(
                          imagePath: AuthenticationImagePaths.logoPNG,
                          width: 300,
                        ),
                        if (viewModel.authStep == AuthSteps.initial)
                          _buildAuthOptions(viewModel),
                        if (viewModel.authStep == AuthSteps.login)
                          _buildLoginForm(viewModel),
                        if (viewModel.authStep == AuthSteps.register)
                          _buildRegisterForm(viewModel),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextInput(
              label: "Email",
              inputType: InputType.email,
              controller: _loginEmailController,
            ),
            Spacing.vertical(16),
            CustomTextInput(
              label: "Senha",
              controller: _loginPasswordController,
              inputType: InputType.password,
            ),
            Spacing.vertical(16),
            AppButton(
              label: "Entrar",
              onPressed: () {
                viewModel.makeLogin(
                    _loginEmailController.text, _loginPasswordController.text);
              },
            ),
            //
            TextButton(
                onPressed: () {
                  _clearLoginFields();
                  viewModel.toggleAuthStep(AuthSteps.register);
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

  Widget _buildRegisterForm(AuthHomeViewModel viewModel) {
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
                label: "Nome completo",
                controller: _registerNameController,
                inputType: InputType.name),
            Spacing.vertical(16),
            CustomTextInput(
                label: "Email",
                inputType: InputType.email,
                controller: _registerEmailController),
            Spacing.vertical(16),
            CustomTextInput(
                label: "Senha",
                controller: _registerPasswordController,
                inputType: InputType.password),
            Spacing.vertical(16),
            AppButton(
                label: "Continuar",
                onPressed: () {
                  WkoutNavigationService()
                      .go(context, AuthRoutes.registerProfile);
                  // viewModel.makeRegister(
                  //     name: _registerNameController.text,
                  //     email: _registerEmailController.text,
                  //     password: _registerPasswordController.text);
                }),
            TextButton(
                onPressed: () {
                  _clearRegisterFields();
                  viewModel.toggleAuthStep(AuthSteps.login);
                },
                child: Text(
                  "Já possuo uma conta!",
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
          padding: const EdgeInsets.fromLTRB(40, 16, 40, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppButton(
                label: "Já possuo uma conta",
                kind: ButtonKind.primary,
                onPressed: () {
                  _clearRegisterFields();
                  viewModel.toggleAuthStep(AuthSteps.login);
                },
              ),
              Spacing.vertical(16),
              AppButton(
                label: "Ainda não possuo uma conta",
                kind: ButtonKind.secondary,
                onPressed: () {
                  _clearLoginFields();
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
