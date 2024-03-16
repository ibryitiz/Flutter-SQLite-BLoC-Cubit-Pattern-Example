import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_to_do_app/data/entity/yapilacaklar.dart';
import 'package:my_to_do_app/data/repo/yapilacaklardao_repository.dart';

class AnaSayfaCubit extends Cubit<List<Yapilacaklar>>{
  AnaSayfaCubit():super(<Yapilacaklar>[]);

  var yRepo = YapilacaklarDaoRepository();

Future<void> yapilacaklariYukle() async{
    var liste = await yRepo.yapilacaklariYukle();
    emit(liste);
  }

 Future<void> yapilacakEkle(String yapilacak) async {
    await yRepo.yapilacakEkle(yapilacak);
  }

}