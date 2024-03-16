
import 'package:todolist_app/data/entity/yapilacaklar.dart';
import 'package:todolist_app/sqlite/veritabani_yardimcisi.dart';

class YapilacaklarDaoRepository {

  Future<List<Yapilacaklar>> yapilacaklariGetir(int kategoriId) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM yapilacaklar WHERE kategori_id = $kategoriId");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Yapilacaklar(id: satir["id"],yapilacak: satir["yapilacak"], kategori_id: satir["kategori_id"],);
    });
   }

   Future<void> sil(int id ) async{
      var db  = await VeritabaniYardimcisi.veritabaniErisim();
      await db.delete("yapilacaklar",where: "id = ?", whereArgs: [id]);
    }

    

  }

  





  




