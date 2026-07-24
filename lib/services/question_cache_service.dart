import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/question_model.dart';

/// Local cache layer for questions — avoids re-fetching the same category
/// from Firestore repeatedly within the cache window (default 24 hours).
class QuestionCacheService {
  static const String _keyPrefix = 'cached_questions_';
  static const String _timestampSuffix = '_ts';
  static const Duration cacheDuration = Duration(hours: 24);

  static String _dataKey(String cacheKey) => '$_keyPrefix$cacheKey';
  static String _timestampKey(String cacheKey) =>
      '$_keyPrefix$cacheKey$_timestampSuffix';

  /// Returns cached questions if present AND still fresh, else null
  /// (null means: caller should fetch from Firestore).
  static List<QuestionModel>? getCached(
    SharedPreferences prefs,
    String cacheKey,
  ) {
    final timestampMillis = prefs.getInt(_timestampKey(cacheKey));
    if (timestampMillis == null) return null;

    final cachedAt = DateTime.fromMillisecondsSinceEpoch(timestampMillis);
    if (DateTime.now().difference(cachedAt) > cacheDuration) {
      return null; // expired — treat as cache miss
    }

    final jsonString = prefs.getString(_dataKey(cacheKey));
    if (jsonString == null) return null;

    try {
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded.map((item) {
        final map = item as Map<String, dynamic>;
        return QuestionModel.fromFirestore(
          Map<String, dynamic>.from(map['data']),
          map['id'] as String,
        );
      }).toList();
    } catch (e) {
      debugPrint('Cache decode error: $e');
      return null; // corrupted cache — treat as miss, will refetch
    }
  }

  /// Saves a freshly-fetched question pool to local cache with current timestamp.
  static Future<void> setCache(
    SharedPreferences prefs,
    String cacheKey,
    List<QuestionModel> questions,
  ) async {
    try {
      final encoded = jsonEncode(
        questions.map((q) => {'id': q.id, 'data': q.toFirestore()}).toList(),
      );
      await prefs.setString(_dataKey(cacheKey), encoded);
      await prefs.setInt(
        _timestampKey(cacheKey),
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      debugPrint('Cache write error: $e');
      // Non-fatal — quiz can still proceed with in-memory data even if caching fails
    }
  }

  /// Clears cache for one category, or everything if cacheKey is omitted.
  /// Useful for a "force refresh" debug button, or after adding new questions.
  static Future<void> clearCache(
    SharedPreferences prefs, [
    String? cacheKey,
  ]) async {
    if (cacheKey != null) {
      await prefs.remove(_dataKey(cacheKey));
      await prefs.remove(_timestampKey(cacheKey));
    } else {
      final keys = prefs.getKeys().where((k) => k.startsWith(_keyPrefix));
      for (final k in keys.toList()) {
        await prefs.remove(k);
      }
    }
  }
}
