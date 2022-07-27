import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/modules/romaneio/romaneio_view.dart';
import 'package:upentregas/app/shared/constants/variables.dart';

class VeiculoController {
  Future<List<dynamic>> getRomaneiosPlaca({required String placa}) async {
    var lista = [];
    try {
      await content.firebaseContent.db!
          .collection('Romaneios')
          .where('veiculo.placa', isEqualTo: placa)
          .where('romaneioAberto', isEqualTo: true)
          .where('romaneioConcluido', isEqualTo: false)
          .get()
          .then((data) async {
        if (data.docs.isNotEmpty) {
          for (var res in data.docs) {
            lista.add({
              'romaneioIniciado': res['romaneioIniciado'],
              'romId': res.id,
              'itinerario': res['itinerario']
            });
          }
          return true;
        } else {
          lista = [];
        }
      });
    } catch (e) {
      //print(e);
      lista = [];
    }

    return lista;
  }

  Future<bool> redirectRomaneio(
      {required String placa, required String nomeFantasia}) async {
    List<dynamic> romaneios = await getRomaneiosPlaca(placa: placa);
    List<dynamic> listaRomaneios = [];
    int romaneio = 0;

    try {
      if (romaneios.isNotEmpty) {
        for (Map map in romaneios) {
          if (map.containsKey('romaneioIniciado')) {
            if (map['romaneioIniciado'] == true) {
              romaneio = int.parse(map['romId']);
            } else {
              listaRomaneios.add(
                  {'romId': map['romId'], 'itinerario': map['itinerario']});
            }
          }
        }
        if (romaneio > 0) {
          idGeral = romaneio;
          Get.offAll(
              () => RomaneioView(id: romaneio, nomeFantasia: nomeFantasia));
        } else {
          Get.toNamed('/escolharomaneio',
              arguments: listaRomaneios,
              parameters: {'nomeFantasia': nomeFantasia});
        }
      } else {
        return false;
      }
      return true;
    } catch (e) {
      //print(e);
      return false;
    }
  }

  Future<bool> checkPermission() async {
    bool hasPermission = false;
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      hasPermission = true;
    } else {
      hasPermission = false;
    }

    return hasPermission;
  }
}
