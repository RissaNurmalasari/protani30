import 'package:flutter/material.dart';
import 'package:petani_30/UI/detail_petani.dart';
import 'package:petani_30/models/petani.dart';
import 'package:petani_30/services/apiStatic.dart';
import 'package:petani_30/utils/const.dart';

class PetaniPage extends StatefulWidget {
  @override
  _PetaniPageState createState() => _PetaniPageState();
}

class _PetaniPageState extends State<PetaniPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Petani"),
      ),
      body: FutureBuilder<List<Petani>>(
        future: ApiStatic.getPetani(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<Petani> listPetani = snapshot.data!;
            return Container(
              padding: EdgeInsets.all(5),
              child: ListView.builder(
                itemCount: listPetani.length,
                itemBuilder: (BuildContext context, int index) => Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => DetailPetaniPage(
                                  petani: listPetani[index],
                                )));
                      },
                      child: Text('${listPetani[index].nama}'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
