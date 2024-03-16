import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/repo/kisilerdao_repository.dart';

class KayitSayfaCubit extends Cubit<void>{
  KayitSayfaCubit():super(0);

  var kisilerDaoRepo = KisilerDaoRepository();

  Future<void> bilgileriKaydet(String kisi_ad, String kisi_tel) async{
    await kisilerDaoRepo.bilgileriKaydet(kisi_ad, kisi_tel);
  }
}