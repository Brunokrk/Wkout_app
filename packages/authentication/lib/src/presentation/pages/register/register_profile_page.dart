import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:wkout_core/wkout_core.dart';

class RegisterProfilePage extends StatefulWidget {
  const RegisterProfilePage({super.key});

  @override
  State<RegisterProfilePage> createState() => _RegisterProfilePageState();
}

class _RegisterProfilePageState extends State<RegisterProfilePage> {
  final TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Complete seu perfil!',
        onBackPressed: () {
          WkoutNavigationService().pop(context);
        },
      ),
      backgroundColor: AppColors.primary,
      body: Column(
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
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Spacing.vertical(20),
                      CustomProfileImage(
                          showEditIcon: true,
                          onTap: () {},
                          imagePath: AuthenticationImagePaths.genericAvatar,
                          borderColor: Colors.white,
                          ),
                      Spacing.vertical(20),	
                      CustomTextInput(
                        label: 'Nome de usuário',
                        controller: _userNameController,
                        inputType: InputType.genericPrefixIcon,
                        prefixIcon: Icons.alternate_email_rounded,
                      ),
                      Spacer(),
                      AppButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        label: 'Cadastrar',
                        color: AppColors.primary,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
