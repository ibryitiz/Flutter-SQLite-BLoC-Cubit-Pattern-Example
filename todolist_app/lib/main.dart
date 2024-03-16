import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_app/ui/cubit/anasayfa_cubit.dart';
import 'package:todolist_app/ui/cubit/dropdown_cubit.dart';
import 'package:todolist_app/ui/cubit/ikincisayfa_cubit.dart';
import 'package:todolist_app/ui/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnaSayfaCubit(),),
        BlocProvider(create: (context) => IkinciSayfaCubit(),),
        BlocProvider(create: (context) => DropdownCategoryCubit(),),
        

      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
