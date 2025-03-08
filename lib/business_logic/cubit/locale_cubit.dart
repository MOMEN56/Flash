import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en')) {
    _loadSavedLocale();
  }

  
  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode') ?? 'en'; 
    final countryCode = prefs.getString('countryCode') ?? ''; 
    emit(Locale(languageCode, countryCode));
  }

  
  void toggleLocale() async {
    final currentLocale = state.languageCode;
    final newLocale = currentLocale == 'ar' ? const Locale('en', 'US') : const Locale('ar', 'AE');

    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', newLocale.languageCode);
    await prefs.setString('countryCode', newLocale.countryCode ?? '');

    emit(newLocale); 
  }
}
