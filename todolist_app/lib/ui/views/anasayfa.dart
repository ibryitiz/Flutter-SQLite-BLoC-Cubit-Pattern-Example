import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_app/data/entity/kategoriler.dart';
import 'package:todolist_app/ui/cubit/anasayfa_cubit.dart';
import 'package:todolist_app/ui/views/ikincisayfa.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  @override
  void initState() {
    super.initState();
    context.read<AnaSayfaCubit>().kategorileriGetir();
  }
  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    List<Icon> iconlar = [
      const Icon(Icons.work, color: Colors.green,),
      Icon(Icons.person_add_alt_sharp,color: Colors.amber[600],),
      const Icon(Icons.meeting_room_sharp,color: Colors.pink),
      Icon(Icons.shopping_basket, color: Colors.orange[900],),
      const Icon(Icons.health_and_safety,color: Colors.blue,),
      Icon(Icons.sports_baseball,color: Colors.yellowAccent[400],),

    ];

    List<Color> renkListesi = [
      Colors.green[100]!,
      Colors.amber[100]!,
      Colors.pink[100]!,
      Colors.orange[100]!,
      Colors.blue[100]!,
      Colors.yellow[100]!,
    ];
 
    return Column(
          children: [
            Container(
              width: deviceWidth,
              height: deviceHeight / 3.5,
              decoration: const BoxDecoration(
                color: Colors.purple,
                image: DecorationImage(image: AssetImage("assets/header.png"),fit: BoxFit.cover),
              ),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "March 8, 2024",
                      style: TextStyle(
                          color: Color(0xFFFFFCF2),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      "My Todo List",
                      style: TextStyle(
                          color: Color(0xFFFFFCF2),
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: BlocBuilder<AnaSayfaCubit, List<Kategoriler>>(
                  builder: (context, kategorilerListesi) {
                    print("bloc builder çalşıtı grid");
                    return GridView.builder(
                      itemCount: kategorilerListesi.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1/1.2), 
                      itemBuilder: (context, index) {
                        var kategori = kategorilerListesi[index];
                        var icon = iconlar[index];
                        var renk = renkListesi[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => IkinciSayfa(kategori.kategori_id, kategori.kategori_ad),));
                          },
                          child: Card(
                            elevation: 2,
                            shadowColor: Colors.black,
                            surfaceTintColor: Color(0xFFFFFCF2),
                            margin: const EdgeInsets.only(top: 23,left: 7,right: 5,bottom: 15),
                            color: const Color(0xFFFFFCF2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  child: icon,
                                  maxRadius: 32,
                                  backgroundColor: renk,
                                ),
                                const SizedBox(height: 7,),
                                Text(
                                  kategori.kategori_ad,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5,),
                               _buildCategoryCountWidget(kategori.kategori_id),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              ),
            ),
          ],
        );
  }

Widget _buildCategoryCountWidget(int categoryID) {
    return FutureBuilder<int>(
      future: context.read<AnaSayfaCubit>().getTaskCountForCategory(categoryID),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(color: Colors.blueAccent);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text("${snapshot.data?.toString()} task",);
        }
      },
    );
  }

  
}