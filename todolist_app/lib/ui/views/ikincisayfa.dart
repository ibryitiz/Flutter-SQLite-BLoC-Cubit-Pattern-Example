import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_app/data/entity/yapilacaklar.dart';
import 'package:todolist_app/ui/cubit/anasayfa_cubit.dart';
import 'package:todolist_app/ui/cubit/ikincisayfa_cubit.dart';

class IkinciSayfa extends StatefulWidget {
   final int categoryId;
   final String categoryName;
   IkinciSayfa(this.categoryId,this.categoryName );

  @override
  State<IkinciSayfa> createState() => _IkinciSayfaState();
}

class _IkinciSayfaState extends State<IkinciSayfa> {
  bool isChecked = false;
   List<Color> renkListesi = [
      Colors.green[800]!,
      Colors.amber[800]!,
      Colors.pink[800]!,
      Colors.orange[800]!,
      Colors.blue[800]!,
      Colors.yellow[800]!,
    ];

  @override
  void initState() {
    super.initState();
    context.read<IkinciSayfaCubit>().yapilacaklariGetir(widget.categoryId);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      backgroundColor: const Color(0xFFFFFCF2),
      body: _buildBody(),
    );
    }
    

      AppBar _buildAppbar() {
        return AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.purple[900],
          title: Text(
            widget.categoryName,
            style: const TextStyle(color:Color(0xFFFFFCF2)),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
              context.read<AnaSayfaCubit>().kategorileriGetir();
            },
          ),
        );
      }
      
       Widget  _buildBody() {
        return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: BlocBuilder<IkinciSayfaCubit, List<Yapilacaklar>>(
          builder: (context, yapilacaklarListesi) {
            print("bloc builder çalıştı list");
            print("yapilacakalr listesi: $yapilacaklarListesi");
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Yapılacaklar",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),),
                ),
                Expanded(
                  child: ListView.builder(
                          itemCount: yapilacaklarListesi.length,
                          itemBuilder: (context, index) {
                            var yapilacak = yapilacaklarListesi[index];
                            return Card(
                              elevation: 2,
                              shadowColor: Colors.black,
                              surfaceTintColor: const Color(0xFFFFFCF2),
                              color: const Color(0xFFFFFCF2),
                              child: ListTile(
                                title: Text(yapilacak.yapilacak,style: TextStyle(color: Colors.black,fontSize: 18),),
                                trailing: Checkbox(
                                  activeColor: Colors.blue,
                                  checkColor: Colors.white,
                                  value: yapilacak.isCompleted,
                                  onChanged:  (bool? checkValue) {
                                        if (checkValue != null) {
                                          yapilacak.isCompleted = checkValue;
                                      }
                                    },
                                  ),
                              ),
                            );
                    },
                  ),
                ),
              ],
            );
          },
        )
      );
    }
  }