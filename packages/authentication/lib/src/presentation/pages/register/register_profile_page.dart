import 'package:authentication/authentication.dart';
import 'package:authentication/src/presentation/parameters/register_profile_parameters.dart';
import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:wkout_core/wkout_core.dart';
import 'package:authentication/src/data/activities_data.dart';
import 'package:provider/provider.dart';
import 'register_profile_view_model.dart';
import '../../widgets/profile_image_picker.dart';

class RegisterProfilePage extends StatefulWidget {
  const RegisterProfilePage({super.key, required this.registerProfileParameters});
  final RegisterProfileParameters registerProfileParameters;
  @override
  State<RegisterProfilePage> createState() => _RegisterProfilePageState();
}

class _RegisterProfilePageState extends State<RegisterProfilePage> {
  @override
  void initState() {
    super.initState();
    debugPrint('RegisterProfilePage: ${widget.registerProfileParameters.toString()}');
  }

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
      body: Consumer<RegisterProfileViewModel>(
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
                    child: SafeArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Spacing.vertical(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ProfileImagePicker(
                                  imageBytes: viewModel.selectedProfileImage,
                                  placeholderImagePath: AuthenticationImagePaths.genericAvatar,
                                  borderColor: Colors.white,
                                  placeholderText: 'Adicionar foto',
                                  onImageSelected: viewModel.setProfileImage,
                                ),
                              ],
                            ),
                            Spacing.vertical(20),
                            CustomTextInput(
                              label: 'Nome de usuário',
                              controller: viewModel.userNameController,
                              inputType: InputType.genericPrefixIcon,
                              prefixIcon: Icons.alternate_email_rounded,
                              haveInformation: true,
                              information:
                                  'É um nome único, por onde outros usuários poderão te encontrar.',
                            ),
                            Spacing.vertical(20),
                            CustomTextInput(
                              label: 'Número de telefone',
                              controller: viewModel.phoneController,
                              inputType: InputType.phone,
                              prefixIcon: Icons.phone,
                              haveInformation: true,
                              information:
                                  'Seu número de telefone, pode ser usado para envios de SMS.',
                            ),
                            Spacing.vertical(20),
                            CustomTextInput(
                              label: 'Biografia',
                              controller: viewModel.bioController,
                              inputType: InputType.largeTextInput,
                              prefixIcon: Icons.description,
                              haveInformation: true,
                              information:
                                  'Um resumo sobre você, que ficará visível para outros usuários.',
                            ),
                            Spacing.vertical(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.fitness_center),
                                Spacing.horizontal(10),
                                Text(
                                  'Atividades favoritas',
                                  style: AppTypography.headline2
                                      .copyWith(color: AppColors.blackText),
                                ),
                                Spacing.horizontal(10),
                                InfoTooltip(
                                  message:
                                      'Selecione suas atividades favoritas, para auxiliar o algoritmo de recomendações',
                                  iconSize: 20,
                                ),
                              ],
                            ),
                            Spacing.vertical(16),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              alignment: WrapAlignment.center,
                              children:
                                  ActivitiesData.availableActivities.map((activity) {
                                final isSelected = viewModel.isActivitySelected(activity['name']);
                                return ActivityChip(
                                  activity: activity['name'],
                                  isSelected: isSelected,
                                  icon: activity['icon'],
                                  onTap: () => viewModel.toggleActivity(activity['name']),
                                );
                              }).toList(),
                            ),
                            Spacing.vertical(32),
                            AppButton(
                              onPressed: viewModel.isFormValid 
                                ? () {
                                    viewModel.submitRegistration();
                                  }
                                : () {},
                              label: 'Cadastrar',
                              color: AppColors.primary,
                              textColor: Colors.white,
                            ),
                            Spacing.vertical(20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
          );
        },
      ),
    );
  }
}
