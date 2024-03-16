import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_to_do_app/data/entity/yapilacaklar.dart';
import 'package:my_to_do_app/ui/cubit/anasayfa_cubit.dart';


class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  var tfYapilacak = TextEditingController();
  

  @override
  void initState() {
    super.initState();
     context.read<AnaSayfaCubit>().yapilacaklariYukle();
     }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildEkleFab(),
    );
  }
  
  AppBar _buildAppbar() {
    return AppBar(
      title: const Text("Hello İbrahim!",style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.blue[300],
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("assets/ibo.jpg"),
          maxRadius: 21,
        ),
        SizedBox(width: 17,)
      ],

    );
  }

  Widget _buildBody(){
    return BlocBuilder<AnaSayfaCubit , List<Yapilacaklar>>(
      builder: (context, yapilacaklarListesi) {
        return ListView.builder(
          itemCount: yapilacaklarListesi.length,
          itemBuilder: (context, index) {
            var yapilacak = yapilacaklarListesi[index];
            return Card(
              child: ListTile(
                title: Text(yapilacak.yapilacak),
                leading: Checkbox(
                  value: false,
                  onChanged: (bool? value) {
                    
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
  
  Widget _buildEkleFab() {
    return FloatingActionButton(
        onPressed: () {
         _pencereAc();
        },
        backgroundColor: Colors.blue[800],
        child: const Icon(Icons.add,color: Colors.white,),
      );
  }
  
  void _pencereAc() {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text("Yeni Yapılacak"),
          content: StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return  Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                   controller: tfYapilacak,
                   decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                   ),
                  ),
                ]
              );
            },
          ),
          actions: [
            TextButton(
              child: Text("İptal"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("Ekle"),
              onPressed: () {
                context.read<AnaSayfaCubit>().yapilacakEkle(tfYapilacak.text);
                Navigator.pop(context);
                context.read<AnaSayfaCubit>().yapilacaklariYukle();
              },
            ),
          ],
        );
      },
    );
  }
}