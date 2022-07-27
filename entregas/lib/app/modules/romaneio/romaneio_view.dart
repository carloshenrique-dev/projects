import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/models/romaneio/romaneio_item.dart';
import 'package:upentregas/app/models/item_romaneio/romaneio_itens.dart';
import 'package:upentregas/app/modules/inicio_fim_romaneio/entrega_view.dart';
import 'package:upentregas/app/modules/paradas/parada_view.dart';
import 'package:upentregas/app/modules/romaneio/widgets/list_default_widget.dart';
import 'package:upentregas/app/shared/styles/app_colors.dart';
import 'package:upentregas/app/shared/ui/messages/message_provisorio.dart';
import 'package:upentregas/app/shared/widgets/card/romaneio_card_widget.dart';
import 'package:upentregas/app/modules/romaneio/widgets/card_parada.dart';
import 'package:upentregas/app/services/database.dart';
import 'package:upentregas/app/shared/constants/variables.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';

class RomaneioView extends StatefulWidget {
  final int id;
  final String? descParada;
  final String nomeFantasia;

  const RomaneioView({
    Key? key,
    required this.id,
    this.descParada,
    required this.nomeFantasia,
  }) : super(key: key);

  @override
  _RomaneioState createState() => _RomaneioState();
}

class _RomaneioState extends State<RomaneioView> {
  bool emParada = false;
  RomaneioItem romaneioItem = RomaneioItem();
  String nomeEmpresa = 'UPSOFTWARE';

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    recNomeEmpresa();
  }

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      MessageProvisorio().showMessage(message: 'permissionsDenied'.tr);
    } else if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best,
              forceAndroidLocationManager: true)
          .then((Position position) {
        setState(() {
          currentPosition = position;
        });
      }).catchError((e) {
        //print(e);
      });
    } else {
      MessageProvisorio().showMessage(message: 'errorVerifyPermissions'.tr);
    }
  }

  Future isParada() async {
    try {
      await content.firebaseContent.db!
          .collection('Romaneios')
          .doc(widget.id.toString())
          .get()
          .then((data) async {
        if (data.data()!.containsKey('emParada') == false) {
          if (mounted) {
            setState(() {
              emParada = false;
            });
          }
        } else {
          if (mounted) {
            setState(() {
              emParada = data['emParada'];
            });
          }
        }
      });
    } catch (e) {
      setState(() {
        emParada = false;
      });
    }
  }

  void recNomeEmpresa() async {
    try {
      var id = await recId();
      //print(id);
      var empresa = await getNomeFantasia(id);
      setState(() {
        nomeEmpresa = empresa != 'UP' ? empresa : 'UPSOFTWARE';
      });
    } catch (e) {
      setState(() {
        nomeEmpresa = 'UPSOFTWARE';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String? descParada = widget.descParada ?? 'stopInProgress'.tr;
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBar(
            elevation: 6,
            title: Text(nomeEmpresa, style: AppTextStyles.title18),
            toolbarHeight: 80,
            actions: [
              IconButton(
                onPressed: () async {
                  Get.to(() => ParadaView(
                        emParada: emParada,
                        docId: widget.id,
                      ));
                },
                icon: const Icon(Icons.add),
              )
            ],
          ),
          Visibility(
            visible: emParada,
            child: CardParada(
                id: widget.id, emParada: emParada, descParada: descParada),
          ),
          AbsorbPointer(
            absorbing: emParada,
            child: RomaneioCardWidget(
              color: AppColors.defaultGreen,
              funcao: () {
                Get.to(() => EntregaView(
                      id: widget.id,
                      label: 'Inicio',
                    ));
              },
              id: widget.id,
              icon: Icons.play_arrow,
              titulo: 'startdeliveries'.tr,
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: getItensRomaneio(widget.id),
              builder: (context, AsyncSnapshot<List<RomaneioItens>> snapshot) {
                if (snapshot.hasData) {
                  isParada();
                  return AbsorbPointer(
                    absorbing: emParada,
                    child: ListView(
                        padding: EdgeInsets.zero,
                        children: snapshot.data!.map((RomaneioItens e) {
                          return Column(
                            children: [
                              ListDefaultWidget(
                                item: e,
                                romaneioId: widget.id,
                              ),
                            ],
                          );
                        }).toList()),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          AbsorbPointer(
            absorbing: emParada,
            child: RomaneioCardWidget(
              id: widget.id,
              color: Colors.redAccent,
              funcao: () {
                Get.to(() => EntregaView(
                      id: widget.id,
                      label: 'Fim',
                    ));
              },
              icon: Icons.stop_rounded,
              titulo: 'enddeliveries'.tr,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
