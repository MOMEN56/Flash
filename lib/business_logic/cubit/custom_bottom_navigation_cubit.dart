import 'package:flash/data/models/cyrpto_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomNavigationCubit extends Cubit<int> {
  CustomBottomNavigationCubit() : super(0); // يبدأ الفهرس من 0 (Currency)

  CryptoModel? selectedCrypto;

  void updateIndex(int index) {
    emit(index); // تحديث الفهرس الحالي
  }

  void selectCrypto(CryptoModel crypto) {
    selectedCrypto = crypto;
    emit(2); // الانتقال إلى شاشة معلومات الكريبتو
  }

  void resetCrypto() {
    selectedCrypto = null;
    emit(0); // العودة إلى شاشة العملة
  }
}
