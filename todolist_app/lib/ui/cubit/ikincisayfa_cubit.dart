import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_app/data/entity/yapilacaklar.dart';
import 'package:todolist_app/data/repo/yapilacaklardao_repository.dart';


// Yeni bir durum türü tanımlayın
class IkinciSayfaCubit extends Cubit<List<Yapilacaklar>> {
  IkinciSayfaCubit() : super(<Yapilacaklar>[]);

  var yRepo = YapilacaklarDaoRepository();
  
  Future<void> yapilacaklariGetir(int kategoriId) async{
    var liste = await yRepo.yapilacaklariGetir(kategoriId);
    emit(liste);
  }
  Future<void> sil(int id ) async{
      await yRepo.sil(id);
    }
   
}
