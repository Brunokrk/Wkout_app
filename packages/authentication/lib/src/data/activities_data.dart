import 'package:flutter/material.dart';

class ActivitiesData {
  static final List<Map<String, dynamic>> availableActivities = [
    // Treinos de Força
    {'name': 'Treino Tradicional de Força', 'icon': Icons.fitness_center, 'category': 'strength'},
    {'name': 'Musculação', 'icon': Icons.fitness_center, 'category': 'strength'},
    {'name': 'CrossFit', 'icon': Icons.sports_gymnastics, 'category': 'strength'},
    {'name': 'Calistenia', 'icon': Icons.accessibility_new, 'category': 'strength'},
    {'name': 'Powerlifting', 'icon': Icons.fitness_center, 'category': 'strength'},
    
    // Cardio
    {'name': 'Corrida', 'icon': Icons.directions_run, 'category': 'cardio'},
    {'name': 'Ciclismo', 'icon': Icons.directions_bike, 'category': 'cardio'},
    {'name': 'Natação', 'icon': Icons.pool, 'category': 'cardio'},
    {'name': 'Caminhada', 'icon': Icons.directions_walk, 'category': 'cardio'},
    {'name': 'Elíptico', 'icon': Icons.trending_up, 'category': 'cardio'},
    {'name': 'Esteira', 'icon': Icons.directions_run, 'category': 'cardio'},
    {'name': 'Remo', 'icon': Icons.rowing, 'category': 'cardio'},
    
    // Esportes
    {'name': 'Futebol', 'icon': Icons.sports_soccer, 'category': 'sports'},
    {'name': 'Basquete', 'icon': Icons.sports_basketball, 'category': 'sports'},
    {'name': 'Tênis', 'icon': Icons.sports_tennis, 'category': 'sports'},
    {'name': 'Vôlei', 'icon': Icons.sports_volleyball, 'category': 'sports'},
    {'name': 'Handball', 'icon': Icons.sports_handball, 'category': 'sports'},
    {'name': 'Badminton', 'icon': Icons.sports_tennis, 'category': 'sports'},
    
    // Artes Marciais
    {'name': 'Boxe', 'icon': Icons.sports_martial_arts, 'category': 'martial_arts'},
    {'name': 'Muay Thai', 'icon': Icons.sports_martial_arts, 'category': 'martial_arts'},
    {'name': 'Jiu-Jitsu', 'icon': Icons.sports_martial_arts, 'category': 'martial_arts'},
    {'name': 'Karatê', 'icon': Icons.sports_martial_arts, 'category': 'martial_arts'},
    {'name': 'Kung Fu', 'icon': Icons.sports_martial_arts, 'category': 'martial_arts'},
    {'name': 'Taekwondo', 'icon': Icons.sports_martial_arts, 'category': 'martial_arts'},
    
    // Flexibilidade e Equilíbrio
    {'name': 'Yoga', 'icon': Icons.self_improvement, 'category': 'flexibility'},
    {'name': 'Pilates', 'icon': Icons.accessibility_new, 'category': 'flexibility'},
    {'name': 'Alongamento', 'icon': Icons.accessibility_new, 'category': 'flexibility'},
    {'name': 'Balé', 'icon': Icons.music_note, 'category': 'flexibility'},
    {'name': 'Dança', 'icon': Icons.music_note, 'category': 'flexibility'},
    {'name': 'Contorcionismo', 'icon': Icons.accessibility_new, 'category': 'flexibility'},
    
    // Funcional
    {'name': 'Treino Funcional', 'icon': Icons.fitness_center, 'category': 'functional'},
    {'name': 'HIIT', 'icon': Icons.timer, 'category': 'functional'},
    {'name': 'Circuit Training', 'icon': Icons.repeat, 'category': 'functional'},
    {'name': 'Bootcamp', 'icon': Icons.fitness_center, 'category': 'functional'},
    {'name': 'TRX', 'icon': Icons.fitness_center, 'category': 'functional'},
    
    // Esportes de Aventura
    {'name': 'Escalada', 'icon': Icons.terrain, 'category': 'adventure'},
    {'name': 'Surf', 'icon': Icons.waves, 'category': 'adventure'},
    {'name': 'Skate', 'icon': Icons.sports_esports, 'category': 'adventure'},
    {'name': 'Patins', 'icon': Icons.sports_esports, 'category': 'adventure'},
    {'name': 'Montanhismo', 'icon': Icons.terrain, 'category': 'adventure'},
    {'name': 'Rapel', 'icon': Icons.terrain, 'category': 'adventure'},
    
    // Esportes Aquáticos
    {'name': 'Hidroginástica', 'icon': Icons.pool, 'category': 'water'},
    {'name': 'Polo Aquático', 'icon': Icons.sports_soccer, 'category': 'water'},
    {'name': 'Mergulho', 'icon': Icons.water, 'category': 'water'},
    {'name': 'Canoagem', 'icon': Icons.directions_boat, 'category': 'water'},
    {'name': 'Stand Up Paddle', 'icon': Icons.waves, 'category': 'water'},
    
    // Esportes de Inverno
    {'name': 'Esqui', 'icon': Icons.ac_unit, 'category': 'winter'},
    {'name': 'Snowboard', 'icon': Icons.ac_unit, 'category': 'winter'},
    {'name': 'Patinação', 'icon': Icons.ac_unit, 'category': 'winter'},
    
    // Outros
    {'name': 'Golfe', 'icon': Icons.sports_golf, 'category': 'other'},
    {'name': 'Tiro com Arco', 'icon': Icons.sports_tennis, 'category': 'other'},
    {'name': 'Tênis de Mesa', 'icon': Icons.sports_tennis, 'category': 'other'},
    {'name': 'Squash', 'icon': Icons.sports_tennis, 'category': 'other'},
    {'name': 'Rugby', 'icon': Icons.sports_rugby, 'category': 'other'},
    {'name': 'Hóquei', 'icon': Icons.sports_hockey, 'category': 'other'},
  ];

  static List<Map<String, dynamic>> getActivitiesByCategory(String category) {
    return availableActivities.where((activity) => activity['category'] == category).toList();
  }

  static List<String> getCategories() {
    return availableActivities.map((activity) => activity['category'] as String).toSet().toList();
  }

  static String getCategoryDisplayName(String category) {
    switch (category) {
      case 'strength':
        return 'Treinos de Força';
      case 'cardio':
        return 'Cardio';
      case 'sports':
        return 'Esportes';
      case 'martial_arts':
        return 'Artes Marciais';
      case 'flexibility':
        return 'Flexibilidade';
      case 'functional':
        return 'Funcional';
      case 'adventure':
        return 'Aventura';
      case 'water':
        return 'Esportes Aquáticos';
      case 'winter':
        return 'Esportes de Inverno';
      case 'other':
        return 'Outros';
      default:
        return category;
    }
  }
} 