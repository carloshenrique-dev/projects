import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:upentregas/app/shared/constants/variables.dart';

//COORDENADAS
updateCoordenada(int? docId, int item) {
  localizacaoAtual();
  Timer.periodic(const Duration(minutes: 2), (timer) async {
    DocumentSnapshot snapshot = await content.firebaseContent.db!
        .collection('Romaneios')
        .doc(docId.toString())
        .collection('Itens')
        .doc(item.toString())
        .get();
    bool? rotaEntrega = snapshot['rotaEntrega'];
    bool? entregaConcluida = snapshot['entregaConcluida'];
    if ((rotaEntrega == true && entregaConcluida == null) ||
        (rotaEntrega == true && entregaConcluida == false)) {
      content.firebaseContent.db!
          .collection('Romaneios')
          .doc(docId.toString())
          .collection('Itens')
          .doc(item.toString())
          .set({
        'latitude': latitudeAuto,
        'longitude': longitudeAuto,
      }, SetOptions(merge: true));
    } else if (rotaEntrega == true && entregaConcluida == true) {
      getStreamSubscription.cancel();
      timer.cancel();
    } else {
      getStreamSubscription.cancel();
      timer.cancel();
    }
  });
}

localizacaoAtual() {
  getStreamSubscription = Geolocator.getPositionStream(
          desiredAccuracy: LocationAccuracy.best,
          intervalDuration: const Duration(minutes: 2))
      .listen((position) {
    latitudeAuto = position.latitude.toString();
    longitudeAuto = position.longitude.toString();
  });
}
//FIM COORDENADAS
