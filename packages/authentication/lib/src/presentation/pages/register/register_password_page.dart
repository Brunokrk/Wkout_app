import 'package:authentication/authentication.dart';
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
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController birthDateController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    birthDateController = TextEditingController();
    super.initState();
  }

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
              return Column(
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
                                    controller: emailController,
                                    inputType: InputType.email,
                                    prefixIcon: Icons.email,
                                    haveInformation: true,
                                    information:
                                        'Seu e-mail, será usado para acessar o app.',
                                    validator: Validators.email(),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                  ),
                                  Spacing.vertical(30),
                                  CustomTextInput(
                                    label: 'Senha',
                                    controller: passwordController,
                                    inputType: InputType.password,
                                    prefixIcon: Icons.lock,
                                    haveInformation: true,
                                    information:
                                        'Sua senha, será usada para acessar o app.',
                                    validator: Validators.password(),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                  ),
                                  Spacing.vertical(30),
                                  CustomTextInput(
                                    label: 'Confirme a Senha',
                                    controller: confirmPasswordController,
                                    inputType: InputType.password,
                                    prefixIcon: Icons.lock,
                                    haveInformation: true,
                                    information:
                                        'Confirme sua senha, para garantir que você digitou corretamente.',
                                    validator: (value) {
                                      if (value != passwordController.text) {
                                        return 'As senhas não coincidem';
                                      }
                                      return null;
                                    },
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                    controller: nameController,
                                    inputType: InputType.name,
                                    prefixIcon: Icons.person,
                                    haveInformation: true,
                                    information:
                                        'Seu nome, será usado para identificar você no app.',
                                    validator: Validators.fullName(),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                  ),
                                  Spacing.vertical(30),
                                  CustomTextInput(
                                    label: 'Número de telefone',
                                    controller: phoneController,
                                    inputType: InputType.phone,
                                    prefixIcon: Icons.phone,
                                    haveInformation: true,
                                    information:
                                        'Seu número de telefone, pode ser usado para envios de SMS.',
                                    validator: Validators.required(message: 'Informe seu número de telefone'),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                  ),
                                  Spacing.vertical(30),
                                  CustomTextInput(
                                    label: 'Data de nascimento',
                                    controller: birthDateController,  
                                    inputType: InputType.date,
                                    prefixIcon: Icons.calendar_month,
                                    haveInformation: true,
                                    information:
                                        'Sua data de nascimento, será usada para calcular sua idade e para fins de segurança.',
                                    validator: Validators.birthDate(),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                  ),
                                  Spacing.vertical(30),
                                ],
                              ),
                            ),
                          ),
                          // Botão fixo na parte inferior
                          Container(
                            padding: const EdgeInsets.all(24.0),
                            child: AppButton(
                              onPressed: (){
                                //WkoutNavigationService().pushWithExtra(context, AuthRoutes.registerProfile, null);
                              },
                              label: 'Continuar',
                              color: AppColors.primary,
                              textColor: Colors.white,
                              disabled: !viewModel.isFormValid,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
