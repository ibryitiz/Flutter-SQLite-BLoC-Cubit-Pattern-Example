class Yapilacaklar{
  int id;
  String yapilacak;
  int kategori_id;
  bool isCompleted;
  Yapilacaklar({
    required this.id,
    required this.yapilacak,
    required this.kategori_id,
    this.isCompleted = false,
  });
}