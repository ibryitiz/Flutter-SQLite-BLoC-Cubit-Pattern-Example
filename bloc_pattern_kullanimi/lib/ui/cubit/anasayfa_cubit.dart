import 'package:bloc_pattern_kullanimi/data/repo/matematik_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnaSayfaCubit extends Cubit<int>{
  AnaSayfaCubit():super(0);

  var matematikRepository = MatematikRepository();

  void toplamaYap(String alinanSayi1 , String alinanSayi2){
    int toplam = matematikRepository.toplamaYap(alinanSayi1,alinanSayi2);
    emit(toplam); // tetikleme ve veri gönderme
  }

  void carpmaYap(String alinanSayi1 , String alinanSayi2){
    int carpim = matematikRepository.carpmaYap(alinanSayi1,alinanSayi2);
    emit(carpim); // tetikleme ve veri gönderme
  }
}