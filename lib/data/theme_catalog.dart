import 'package:flutter/material.dart';

class ThemeItem {
  final String id;
  final String name;
  final Color primaryColor;
  final int cost;
  final String tier;

  const ThemeItem({
    required this.id,
    required this.name,
    required this.primaryColor,
    required this.cost,
    required this.tier,
  });
}

class ThemeCatalog {
  static const List<ThemeItem> all = [
    // ---- Free ----
    ThemeItem(
      id: 't1',
      name: 'Indigo',
      primaryColor: Color(0xFF6366F1),
      cost: 0,
      tier: 'Starter',
    ),
    ThemeItem(
      id: 't2',
      name: 'Ocean',
      primaryColor: Color(0xFF0EA5E9),
      cost: 0,
      tier: 'Starter',
    ),

    // ---- Bronze ----
    ThemeItem(
      id: 't3',
      name: 'Forest',
      primaryColor: Color(0xFF22C55E),
      cost: 99,
      tier: 'Bronze',
    ),
    ThemeItem(
      id: 't4',
      name: 'Sunset',
      primaryColor: Color(0xFFF97316),
      cost: 99,
      tier: 'Bronze',
    ),

    // ---- Silver ----
    ThemeItem(
      id: 't5',
      name: 'Rose',
      primaryColor: Color(0xFFEC4899),
      cost: 499,
      tier: 'Silver',
    ),
    ThemeItem(
      id: 't6',
      name: 'Amethyst',
      primaryColor: Color(0xFFA855F7),
      cost: 499,
      tier: 'Silver',
    ),

    // ---- Gold ----
    ThemeItem(
      id: 't7',
      name: 'Gold Rush',
      primaryColor: Color(0xFFEAB308),
      cost: 999,
      tier: 'Gold',
    ),
    ThemeItem(
      id: 't8',
      name: 'Crimson',
      primaryColor: Color(0xFFEF4444),
      cost: 999,
      tier: 'Gold',
    ),

    // ---- Legendary ----
    ThemeItem(
      id: 't9',
      name: 'Cyber Teal',
      primaryColor: Color(0xFF14B8A6),
      cost: 1999,
      tier: 'Legendary',
    ),
    ThemeItem(
      id: 't10',
      name: 'Royal',
      primaryColor: Color(0xFF7C3AED),
      cost: 1999,
      tier: 'Legendary',
    ),
  ];

  static ThemeItem get defaultTheme => all.first;

  static ThemeItem? byId(String? id) {
    if (id == null) return null;
    try {
      return all.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }
}
