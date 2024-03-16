import 'package:filmler_app/filmler.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetaySayfa extends StatefulWidget {
  Filmler film;
  DetaySayfa({required this.film});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.film.ad),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("resimler/${widget.film.resim}",fit: BoxFit.cover,),
            Text("${widget.film.fiyat.toString()} ₺",style: TextStyle(fontSize: 40),),
          ],
        ),
      ),
    );
  }
}