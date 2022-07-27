import 'package:geolocator/geolocator.dart';
import 'package:upentregas/app/shared/constants/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'localizacao.dart';

mixin LocalizationFirestore {
  Future<Map<String, String>> localizacao() async {
    Map<String, String> location = {};
    try {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best,
              forceAndroidLocationManager: true)
          .then((Position position) {
        location = {
          'latitude': position.latitude.toString(),
          'longitude': position.latitude.toString()
        };
      });
      return location;
    } on Exception {
      return {'latitude': '', 'longitude': ''};
    }
  }

  Future<void> updateLocalizacaoEntrega(
      {required int romId,
      required int item,
      required String latitude,
      required String longitude}) async {
    try {
      content.firebaseContent.db!
          .collection('Romaneios')
          .doc(romId.toString())
          .collection('Itens')
          .doc(item.toString())
          .set({
        'latitude': latitude,
        'longitude': longitude,
      }, SetOptions(merge: true));
      updateCoordenada(romId, item);
    } catch (e) {
      //return false;
    }
  }
}
