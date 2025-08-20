import 'package:authentication/authentication.dart';
import 'package:authentication/src/presentation/parameters/register_profile_parameters.dart';
import 'package:authentication/src/routes/auth_routes.dart';
import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:wkout_core/wkout_core.dart';
import 'package:authentication/src/data/activities_data.dart';
import 'package:provider/provider.dart';
import 'register_password_view_model.dart';
import '../../widgets/profile_image_picker.dart';

class RegisterPasswordPage extends StatefulWidget {
  const RegisterPasswordPage({super.key});

  @override
  State<RegisterPasswordPage> createState() => _RegisterPasswordPageState();
}

class _RegisterPasswordPageState extends State<RegisterPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Criação de conta',
          onBackPressed: () {
            WkoutNavigationService().pop(context);
          },
        ),
        backgroundColor: AppColors.primary,
        body: WkoutLoading<RegisterPasswordViewModel>(
          child: Consumer<RegisterPasswordViewModel>(
            builder: (context, viewModel, child) {
              return KeyboardDismissible(
                child: Column(
                  children: [
                    // Área inferior com borda superior arredondada
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  children: [
                                    Spacing.vertical(10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Defina suas credenciais:',
                                        style: AppTypography.bodyText1,
                                      ),
                                    ),
                                    Spacing.vertical(30),
                                    CustomTextInput(
                                      label: 'E-mail',
                                      controller: viewModel.emailController,
                                      inputType: InputType.email,
                                      prefixIcon: Icons.email,
                                      haveInformation: true,
                                      information:
                                          'Seu e-mail, será usado para acessar o app.',
                                      validator: Validators.email(),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                    Spacing.vertical(30),
                                    CustomTextInput(
                                      label: 'Senha',
                                      controller: viewModel.passwordController,
                                      inputType: InputType.password,
                                      prefixIcon: Icons.lock,
                                      haveInformation: true,
                                      information:
                                          'Sua senha, será usada para acessar o app.',
                                      validator: Validators.password(),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                    Spacing.vertical(30),
                                    CustomTextInput(
                                      label: 'Confirme a Senha',
                                      controller:
                                          viewModel.confirmPasswordController,
                                      inputType: InputType.password,
                                      prefixIcon: Icons.lock,
                                      haveInformation: true,
                                      information:
                                          'Confirme sua senha, para garantir que você digitou corretamente.',
                                      validator: (value) {
                                        if (value !=
                                            viewModel.passwordController.text) {
                                          return 'As senhas não coincidem';
                                        }
                                        return null;
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                    Spacing.vertical(50),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Nos informe mais sobre você:',
                                        style: AppTypography.bodyText1,
                                      ),
                                    ),
                                    Spacing.vertical(30),
                                    CustomTextInput(
                                      label: 'Nome completo',
                                      controller: viewModel.nameController,
                                      inputType: InputType.name,
                                      prefixIcon: Icons.person,
                                      haveInformation: true,
                                      information:
                                          'Seu nome, será usado para identificar você no app.',
                                      validator: Validators.fullName(),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                    Spacing.vertical(30),
                                    CustomTextInput(
                                      label: 'Número de telefone',
                                      controller: viewModel.phoneController,
                                      inputType: InputType.phone,
                                      prefixIcon: Icons.phone,
                                      haveInformation: true,
                                      information:
                                          'Seu número de telefone, pode ser usado para envios de SMS.',
                                      validator: Validators.phone(),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                    Spacing.vertical(30),
                                    CustomTextInput(
                                      label: 'Data de nascimento',
                                      controller: viewModel.birthDateController,
                                      inputType: InputType.date,
                                      prefixIcon: Icons.calendar_month,
                                      haveInformation: true,
                                      information:
                                          'Sua data de nascimento, será usada para calcular sua idade e para fins de segurança.',
                                      validator: Validators.birthDate(),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                    Spacing.vertical(30),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(24.0),
                              child: AppButton(
                                //onPressed: () => _handleContinuePressed(context, viewModel),
                                onPressed: () {
                                  final mockRegisterProfileParameters =
                                      RegisterProfileParameters(
                                    email: 'usuario.teste@exemplo.com',
                                    password: 'Senha123!',
                                    name: 'João Silva Santos',
                                    phone: '+55 11 99999-8888',
                                    birthDate: '1990-05-15',
                                  );
                                  WkoutNavigationService().pushWithExtra(
                                      context,
                                      AuthRoutes.registerProfile,
                                      mockRegisterProfileParameters.toExtra());
                                },
                                label: 'Continuar',
                                color: AppColors.primary,
                                textColor: Colors.white,
                                disabled: false,
                                //  disabled: !viewModel.isFormValid,
                              ),
                            ),
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
    );
  }

  void _handleContinuePressed(
      BuildContext context, RegisterPasswordViewModel viewModel) {
    // Validar todos os campos
    final errors = viewModel.validateAllFields();

    if (errors.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Por favor, corrija os seguintes erros:\n${errors.join('\n')}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
      return;
    }

    // Se todos os campos estão válidos, navegar para a próxima tela
    try {
      final parameters = viewModel.getRegistrationParameters();
      debugPrint('RegisterPasswordPage: ${parameters.toString()}');
      WkoutNavigationService().pushWithExtra(
          context, AuthRoutes.registerProfile, parameters.toExtra());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao processar dados: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
