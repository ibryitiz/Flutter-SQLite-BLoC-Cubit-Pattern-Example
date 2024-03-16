import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_app/data/entity/kategoriler.dart';
import 'package:todolist_app/ui/cubit/anasayfa_cubit.dart';
import 'package:todolist_app/ui/cubit/dropdown_cubit.dart';
import 'package:todolist_app/ui/views/anasayfa.dart';
import 'package:todolist_app/ui/views/task.dart';

class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var controller = TextEditingController();
  int secilenIndeks = 0;
  var sayfalar = [const AnaSayfa(), const Task()];

  @override
  void initState() {
    super.initState();
    context.read<AnaSayfaCubit>().kategorileriGetir();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFloatinActionButton(),
        bottomNavigationBar: _buildBottomNavigation(),
        backgroundColor:const Color(0xFFFFFCF2),
        body: sayfalar[secilenIndeks],
      ),
    );
  }


  Widget _buildBottomNavigation(){
    return BottomNavigationBar(
          currentIndex: secilenIndeks,
          iconSize: 36,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          backgroundColor: const Color(0xFFFFFCF2),
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home_outlined),
            ),
            BottomNavigationBarItem(
              label: "Task",
              icon: Icon(Icons.menu),
            ),
          ],
          onTap: (value) {
            setState(() {
              secilenIndeks = value;
            });
          },
        );
  }



  Widget _buildFloatinActionButton(){
    return FloatingActionButton(
      backgroundColor: Colors.purple[900],
          child: Icon(Icons.add,color: Colors.white,size: 36,),
          shape: const CircleBorder(),
          elevation: 5,
          onPressed: (){
           showDialog(
              context: context, 
              builder: (context) {
                return BlocBuilder<AnaSayfaCubit , List<Kategoriler>>(
                  builder: (context, kategoriler) {
                    return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor:const Color(0xFFFFFCF2),
                    actionsPadding: const EdgeInsets.all(5),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[300],
                            filled: true,
                            hintText: "Yeni görevi buraya girin",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 16,),
                          // _buildDropDownButton(),
                          BlocBuilder<DropdownCategoryCubit, int>(
                          builder: (context, selectedCategoryId) {
                            if (kategoriler.isEmpty) {
                              return const CircularProgressIndicator();
                            }
                            else {
                              return DropdownButton<int>(
                                  value: selectedCategoryId,
                                  items: kategoriler
                                      .map((kategori) =>
                                      DropdownMenuItem(
                                          value: kategori.kategori_id,
                                          child: Text(kategori.kategori_ad)))
                                      .toList(),
                                  onChanged: (int? value) {
                                    if (value != null) {
                                      context
                                          .read<DropdownCategoryCubit>()
                                          .changeCategory(value);
                                    }
                                  });
                            }
                          }),
                          IconButton(
                            onPressed: (){
                              showDatePicker(
                                context: context, 
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000), 
                                lastDate: DateTime(2030),
                              );
                            }, 
                            icon: const Icon(Icons.calendar_month)
                          ),
                          const Spacer(),
                          IconButton(onPressed: (){
                            int selectedId = context.read<DropdownCategoryCubit>().state;
                            context.read<AnaSayfaCubit>().bilgileriKaydet(selectedId, controller.text);
                            controller.text =  "";
                            Navigator.pop(context);
                            context.read<AnaSayfaCubit>().kategorileriGetir();
                          }, icon: const Icon(Icons.navigation,)),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
      );
  }
}