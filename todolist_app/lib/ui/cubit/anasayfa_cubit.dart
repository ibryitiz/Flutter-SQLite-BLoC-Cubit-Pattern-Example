import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_app/data/entity/kategoriler.dart';
import 'package:todolist_app/data/entity/yapilacaklar.dart';
import 'package:todolist_app/data/repo/kategorilerdao_repository.dart';


class AnaSayfaCubit extends Cubit<List<Kategoriler>>{
  AnaSayfaCubit():super(<Kategoriler>[]);

  var kRepo = KategorilerDaoRepository();
 
  
  Future<void> kategorileriGetir() async{
    var liste = await kRepo.kategorileriGetir();
    emit(liste);
  }

  Future<void> bilgileriKaydet(int kategoriId, String yapilacak) async{
    await kRepo.bilgileriKaydet(kategoriId, yapilacak);
  }

Future<int> getTaskCountForCategory(int kategoriId) async {
    // Kategoriye ait görev sayısını veritabanından al
    List<Yapilacaklar> tasks = await kRepo.yapilacakSayisiniGetir(kategoriId);
    return tasks.length;
  }
 
}