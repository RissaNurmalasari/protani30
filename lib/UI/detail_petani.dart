import 'package:flutter/material.dart';
import 'package:petani_30/models/petani.dart';

class DetailPetaniPage extends StatefulWidget {
  DetailPetaniPage({required this.petani});
  final Petani petani;

  @override
  State<DetailPetaniPage> createState() => _DetailPetaniPageState();
}

class _DetailPetaniPageState extends State<DetailPetaniPage> {
  @override
  Widget build(BuildContext context) {
    return Text('${widget.petani.nama}');
  }
}
