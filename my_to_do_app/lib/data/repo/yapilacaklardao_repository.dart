import 'package:my_to_do_app/data/entity/yapilacaklar.dart';
import 'package:my_to_do_app/sqlite/veritabani_yardimcisi.dart';

class YapilacaklarDaoRepository{

   Future<List<Yapilacaklar>> yapilacaklariYukle() async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM yapilacaklar");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Yapilacaklar(id: satir["id"],yapilacak: satir["yapilacak"]);
    });
  }

  Future<void> yapilacakEkle(String yapilacak) async {
    var db  = await VeritabaniYardimcisi.veritabaniErisim();
    var yeniYapilacak = Map<String, dynamic>();
    yeniYapilacak["yapilacak"] = yapilacak;

    await db.insert("yapilacaklar", yeniYapilacak);
  }
}