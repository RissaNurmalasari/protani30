// ignore_for_file: duplicate_import, deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petani_30/models/erorrmsg.dart';
import 'package:petani_30/models/kelompok_tani_model.dart';
import 'package:petani_30/models/petani_model.dart';
import 'package:petani_30/models/petani_model.dart';
import 'package:image_picker/image_picker.dart';

class APiService {
  //static final host='http://192.168.43.189/webtani/public';
  static final host = 'http://10.10.58.123/webtani/public';
  static var _token = "8|x6bKsHp9STb0uLJsM11GkWhZEYRWPbv0IqlXvFi7";
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  static Future<void> getPref() async {
    Future<SharedPreferences> preferences = SharedPreferences.getInstance();
    final SharedPreferences prefs = await preferences;
    _token = prefs.getString('token') ?? "";
  }

  static getHost() {
    return host;
  }

  // Fetch all petani
  Future<List<Petani>> fetchPetani() async {
    final response =
        await http.get(Uri.parse('https://dev.wefgis.com/api/petani?s'));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      final data = json['data'];

      if (data is List) {
        return data.map((petaniJson) => Petani.fromJson(petaniJson)).toList();
      } else {
        throw Exception('Data is not in the expected format');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

Future<Petani> createPetani(Petani petani) async {
    try {
      var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery); // Mengambil foto dari galeri
      var url = Uri.parse('$host/api/petani');

      var request = http.MultipartRequest('POST', url);
request.fields['id_kelompok_tani'] = petani.idKelompokTani!;
request.fields['nama'] = petani.nama!;
request.fields['nik'] = petani.nik!;
request.fields['alamat'] = petani.alamat!;
request.fields['telp'] = petani.telp!;
request.fields['status'] = petani.status!;


      // Jika file dipilih, tambahkan file foto ke permintaan multipart
      if (pickedFile != null) {
        request.files.add(await http.MultipartFile.fromPath('foto', pickedFile.path));
      }

      request.headers.addAll({
        'Authorization': 'Bearer $_token',
      });

      var response = await request.send();

      if (response.statusCode == 201) {
        final respStr = await response.stream.bytesToString();
        return Petani.fromJson(jsonDecode(respStr));
      } else {
        throw Exception('Failed to create petani');
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }

  // Update an existing petani
  static Future<ErrorMSG> editPetani(idPenjual, petani, filepath) async {
    try {
      print(petani);
      print(idPenjual);

      var url = Uri.parse('https://dev.wefgis.com/api/petani/$idPenjual');

      var request = http.MultipartRequest('POST', url);
      request.fields['nama'] = petani.nama!;
      request.fields['nik'] = petani.nik!;
      request.fields['alamat'] = petani.alamat!;
      request.fields['telp'] = petani.telp!;
      request.fields['status'] = petani.status!;
      request.fields['id_kelompok_tani'] = petani.idKelompokTani!;
      if (filepath != '') {
        request.files.add(await http.MultipartFile.fromPath('foto', filepath));
      }
      request.headers.addAll({
        'Authorization': 'Bearer ' + _token,
      });
      var response = await request.send();

      if (response.statusCode == 200) {
        // return Petani.fromJson(jsonDecode(response.body));
        final respStr = await response.stream.bytesToString();
        print(jsonDecode(respStr));
        // print(respStr);

        // return Petani.fromJson(jsonDecode(response.body));
        return ErrorMSG.fromJson(jsonDecode(respStr));
        // return ErrorMSG.fromJson(jsonDecode(respStr));
      } else {
        //return ErrorMSG.fromJson(jsonDecode(response.body));
        // return ErrorMSG(success: false, message: 'err Request');

        throw Exception('Failed to update petani');
      }
    } catch (e) {
      // ErrorMSG responseRequest =
      //     ErrorMSG(success: false, message: 'error caught: $e');
      // return responseRequest;
      print(e);
      throw Exception('Error $e');
    }
  }

  // Delete a petani
  Future<void> deletePetani(String idPenjual) async {
    final response = await http.delete(
      Uri.parse('https://dev.wefgis.com/api/petani/$idPenjual'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete petani');
    }
  }

  // get kelompok petani
  static Future<List<KelompokPetani>> getKelompokTani() async {
    try {
      final response =
          await http.get(Uri.parse("$host/api/kelompoktani"), headers: {
        'Authorization': 'Bearer ' + _token,
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        final parsed = json.cast<Map<String, dynamic>>();
        return parsed
            .map<KelompokPetani>((json) => KelompokPetani.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<ErrorMSG> savePetani(petani, filepath) async {
    try {
      print(petani);
      var url = Uri.parse('https://dev.wefgis.com/api/petani');
      // if (id != 0) {
      //   url = Uri.parse('$host/api/petani/' + id.toString());
      // }

      var request = http.MultipartRequest('POST', url);
      request.fields['nama'] = petani.nama;
      request.fields['nik'] = petani.nik;
      request.fields['alamat'] = petani.alamat;
      request.fields['telp'] = petani.telp;
      request.fields['status'] = petani.status;
      request.fields['id_kelompok_tani'] = petani.idKelompokTani;
      if (filepath != '') {
        request.files.add(await http.MultipartFile.fromPath('foto', filepath));
      }
      request.headers.addAll({
        'Authorization': 'Bearer ' + _token,
      });
      var response = await request.send();

      if (response.statusCode == 200) {
        // return Petani.fromJson(jsonDecode(response.body));
        final respStr = await response.stream.bytesToString();
        print(jsonDecode(respStr));
        // print(respStr);

        // return Petani.fromJson(jsonDecode(response.body));
        return ErrorMSG.fromJson(jsonDecode(respStr));
        // return ErrorMSG.fromJson(jsonDecode(respStr));
      } else {
        //return ErrorMSG.fromJson(jsonDecode(response.body));
        // return ErrorMSG(success: false, message: 'err Request');

        throw Exception('Failed to update petani');
      }
    } catch (e) {
      // ErrorMSG responseRequest =
      //     ErrorMSG(success: false, message: 'error caught: $e');
      // return responseRequest;
      print(e);
      throw Exception('Error $e');
    }
  }
}
