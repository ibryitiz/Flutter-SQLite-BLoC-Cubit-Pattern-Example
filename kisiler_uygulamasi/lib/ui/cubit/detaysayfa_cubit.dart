import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/repo/kisilerdao_repository.dart';

class DetaySayfaCubit extends Cubit<void>{
  DetaySayfaCubit():super(0);

  var kdaoRepo = KisilerDaoRepository();

  Future<void> bilgileriGuncelle(int kisi_id, String kisi_ad, String kisi_tel) async{
    await kdaoRepo.bilgileriGuncelle(kisi_id, kisi_ad, kisi_tel);
  }
  
}