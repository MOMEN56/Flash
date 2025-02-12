import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('ar')); // افتراضيًا اللغة العربية

  void toggleLocale() {
    emit(state.languageCode == 'ar' ? const Locale('en', 'US') : const Locale('ar', 'AE'));
  }
}
