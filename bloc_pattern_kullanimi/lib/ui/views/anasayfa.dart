import 'package:bloc_pattern_kullanimi/ui/cubit/anasayfa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

 AppBar  _buildAppbar() {
    return AppBar(
      title: const Text("Bloc Kullanımı"),
    );
 }

 Widget _buildBody(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Dinleme yapısı
        BlocBuilder<AnaSayfaCubit , int>(
          builder: (context, sonucDeger) {
            return  Text(sonucDeger.toString() , style: const TextStyle(color: Colors.black, fontSize: 44),);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 16.0),
          child: TextFormField(
            controller: controller1,
            decoration: InputDecoration(
              hintText: "Sayı 1",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 16.0),
          child: TextFormField(
            controller: controller2,
            decoration: InputDecoration(
              hintText: "Sayı 2",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<AnaSayfaCubit>().toplamaYap(controller1.text, controller2.text);
               }, 
              child: const Text("TOPLAMA")
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AnaSayfaCubit>().carpmaYap(controller1.text, controller2.text);
                }, 
              child: const Text("ÇARPMA")
            ),
          ],
        ),
      ],
    ); 
 }
}