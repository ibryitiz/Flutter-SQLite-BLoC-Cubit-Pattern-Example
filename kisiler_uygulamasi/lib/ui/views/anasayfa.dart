import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/entity/kisiler.dart';
import 'package:kisiler_uygulamasi/ui/cubit/anasayfa_cubit.dart';
import 'package:kisiler_uygulamasi/ui/views/detay_sayfa.dart';
import 'package:kisiler_uygulamasi/ui/views/kayit_sayfa.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  bool aramaYapiliyorMu = false;

@override
  void initState() {
    super.initState();
    context.read<AnaSayfaCubit>().kisileriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: aramaYapiliyorMu ?  TextField(decoration: InputDecoration(hintText: "Ara"),onChanged: (aramaSonucu){context.read<AnaSayfaCubit>().ara(aramaSonucu);},): const Text("Kişiler"), actions: [
        aramaYapiliyorMu ? IconButton(onPressed: (){
          setState(() {
            aramaYapiliyorMu = false;
          });
          context.read<AnaSayfaCubit>().kisileriYukle();
        }, icon: const Icon(Icons.clear)): 
        IconButton(onPressed: (){
          setState(() {
            aramaYapiliyorMu = true;
          });
        }, icon: Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<AnaSayfaCubit, List<Kisiler>>(
        builder: (context,kisilerListesi){
          if (kisilerListesi.isNotEmpty) {
           return ListView.builder(
            itemCount: kisilerListesi.length,
            itemBuilder: (context , indeks){
              var kisi = kisilerListesi[indeks];
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetaySayfa(kisi: kisi,))).then((value) => context.read<AnaSayfaCubit>().kisileriYukle());
                },
                child: SizedBox(height: 100,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(kisi.kisi_ad),
                        subtitle: Text(kisi.kisi_tel),
                        trailing: IconButton( onPressed: () { 
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("${kisi.kisi_ad} silinsin mi?"),
                            action: SnackBarAction(
                              label: "Evet",
                              onPressed: (){
                                context.read<AnaSayfaCubit>().sil(kisi.kisi_id);
                              },
                            ),
                          ));
                         },icon: Icon(Icons.clear),color: Colors.black54,),
                      ),
                    ),
                  ),
                ),
              );
            },
           );
          }else{
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> KayitSayfa())).then((value) => context.read<AnaSayfaCubit>().kisileriYukle());
        },
        child: Icon(Icons.add,color: Colors.white, size: 24),
        backgroundColor: Colors.blue[900],

      ),
    );
  }
}