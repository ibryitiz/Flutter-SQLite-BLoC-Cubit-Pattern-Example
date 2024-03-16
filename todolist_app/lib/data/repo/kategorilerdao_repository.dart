import 'package:todolist_app/data/entity/kategoriler.dart';
import 'package:todolist_app/data/entity/yapilacaklar.dart';
import 'package:todolist_app/sqlite/veritabani_yardimcisi.dart';

class KategorilerDaoRepository{

  Future<List<Kategoriler>> kategorileriGetir() async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM kategoriler");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kategoriler(kategori_id: satir["kategori_id"], kategori_ad: satir["kategori_ad"]);
    });
  }

  Future<void> bilgileriKaydet(int kategoriId, String yapilacak) async{
    var db  = await VeritabaniYardimcisi.veritabaniErisim();
    var yeniYapilacak = Map<String, dynamic>();
    yeniYapilacak["kategori_id"] = kategoriId;
    yeniYapilacak["yapilacak"] = yapilacak;
    await db.insert("yapilacaklar", yeniYapilacak);
  }

  Future<List<Yapilacaklar>> yapilacakSayisiniGetir(int kategoriId) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    final List<Map<String, dynamic>> maps = await db.query(
      'yapilacaklar',
      where: 'kategori_id = ?',
      whereArgs: [kategoriId],
    );

    return List.generate(maps.length, (index)  {
      var satir = maps[index];
      return Yapilacaklar(id: satir["id"], yapilacak: satir["yapilacak"], kategori_id: satir["kategori_id"]);}
    );
  }

}