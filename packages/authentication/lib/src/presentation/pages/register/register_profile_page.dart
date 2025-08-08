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
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  
  // Lista de atividades favoritas
  final List<String> _selectedActivities = [];
  
  final List<Map<String, dynamic>> _availableActivities = [
    {'name': 'Treino Tradicional de Força', 'icon': Icons.fitness_center},
    {'name': 'Corrida', 'icon': Icons.directions_run},
    {'name': 'Musculação', 'icon': Icons.fitness_center},
    {'name': 'Yoga', 'icon': Icons.self_improvement},
    {'name': 'Natação', 'icon': Icons.pool},
    {'name': 'Ciclismo', 'icon': Icons.directions_bike},
    {'name': 'Boxe', 'icon': Icons.sports_martial_arts},
    {'name': 'Pilates', 'icon': Icons.accessibility_new},
    {'name': 'Dança', 'icon': Icons.music_note},
  ];

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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Spacing.vertical(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomProfileImage(
                            showEditIcon: true,
                            onTap: () {},
                            imagePath: AuthenticationImagePaths.genericAvatar,
                            borderColor: Colors.white,
                          ),
                        ],
                      ),
                      Spacing.vertical(20),
                      CustomTextInput(
                        label: 'Nome de usuário',
                        controller: _userNameController,
                        inputType: InputType.genericPrefixIcon,
                        prefixIcon: Icons.alternate_email_rounded,
                        haveInformation: true,
                        information:
                            'É um nome único, por onde outros usuários poderão te encontrar.',
                      ),
                      Spacing.vertical(20),
                      CustomTextInput(
                        label: 'Número de telefone',
                        controller: _phoneController,
                        inputType: InputType.phone,
                        prefixIcon: Icons.phone,
                        haveInformation: true,
                        information:
                            'Seu número de telefone, pode ser usado para envios de SMS.',
                      ),
                      Spacing.vertical(20),
                      CustomTextInput(
                        label: 'Biografia',
                        controller: _bioController,
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
                                .copyWith(color: AppColors.primary),
                          ),
                          Spacing.horizontal(10),
                          InfoTooltip(
                            message: 'Selecione suas atividades favoritas, para auxiliar o algoritmo de recomendações',
                            iconSize: 20,
                          ),
                        ],
                      ),
                      Spacing.vertical(16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: _availableActivities.map((activity) {
                          final isSelected = _selectedActivities.contains(activity['name']);
                          return ActivityChip(
                            activity: activity['name'],
                            isSelected: isSelected,
                            icon: activity['icon'],
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  _selectedActivities.remove(activity['name']);
                                } else {
                                  _selectedActivities.add(activity['name']);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      Spacing.vertical(32),
                      AppButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
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
      ),
    );
  }
}
