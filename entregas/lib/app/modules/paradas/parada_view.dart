import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/modules/paradas/parada_controller.dart';
import 'package:upentregas/app/modules/paradas/widgets/button/button_widget.dart';
import 'package:upentregas/app/modules/romaneio/romaneio_view.dart';
import 'package:upentregas/app/services/database.dart';
import 'package:upentregas/app/shared/constants/variables.dart';
import 'package:upentregas/app/shared/styles/app_colors.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';
import 'package:upentregas/app/shared/textcontrollers/textfield_controllers.dart';
import 'package:upentregas/app/shared/ui/messages/message_provisorio.dart';
import 'package:upentregas/app/shared/widgets/loader/loader_widget.dart';

class ParadaView extends StatefulWidget {
  final int docId;
  final bool emParada;

  const ParadaView({
    Key? key,
    required this.docId,
    required this.emParada,
  }) : super(key: key);

  @override
  _ParadaViewState createState() => _ParadaViewState();
}

class _ParadaViewState extends State<ParadaView> {
  String? selectedCurrency;
  String? descricao;
  bool state = false;
  bool isLoading = false;
  ParadaController paradaController = ParadaController();

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: Text(
          'stops'.tr,
          style: AppTextStyles.title20,
        ),
        toolbarHeight: 90,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            observacaoParadaController.clear();
            Get.back();
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<QuerySnapshot>(
                future: content.firebaseContent.db!.collection('Paradas').get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DropdownMenuItem> currencyItems = [];
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      DocumentSnapshot snap = snapshot.data!.docs[i];
                      currencyItems.add(
                        DropdownMenuItem(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            removeBottom: true,
                            child: Text(
                              snap['Descricao'],
                              style: theme.brightness == Brightness.dark
                                  ? AppTextStyles.title14
                                  : AppTextStyles.title14Black,
                            ),
                          ),
                          value: snap.id,
                        ),
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: Get.width * 0.90,
                          height: Get.height * 0.12,
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(9.0),
                                ),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                items: currencyItems,
                                onChanged: (dynamic currencyValue) {
                                  int codDescricao = int.parse(currencyValue);
                                  DocumentSnapshot snap =
                                      snapshot.data!.docs[codDescricao - 1];
                                  setState(() {
                                    selectedCurrency = currencyValue;
                                    descricao = snap['Descricao'];
                                  });
                                },
                                value: selectedCurrency,
                                isExpanded: true,
                                isDense: true,
                                hint: Text(
                                  'selectStop'.tr,
                                  style: theme.brightness == Brightness.dark
                                      ? AppTextStyles.title16
                                      : AppTextStyles.title16Black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: Get.width * 0.90,
                height: Get.height * 0.096,
                child: TextField(
                  controller: observacaoParadaController,
                  textAlign: TextAlign.justify,
                  decoration: InputDecoration(
                    labelText: 'startobs'.tr,
                    labelStyle: theme.brightness == Brightness.dark
                        ? AppTextStyles.title16
                        : AppTextStyles.title16Black,
                    fillColor: Theme.of(context).primaryColor,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(9.0),
                      ),
                    ),
                  ),
                  style: theme.brightness == Brightness.dark
                      ? AppTextStyles.title16
                      : AppTextStyles.title16Black,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Visibility(
                visible: !isLoading,
                child: SizedBox(
                  width: Get.width * 0.90,
                  height: Get.height * 0.090,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: widget.emParada,
                        child: SizedBox(
                          width: Get.width * 0.90,
                          child: ButtonParadaWidget(
                            color: Colors.red,
                            title: 'endStop'.tr,
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });

                              if (selectedCurrency == null) {
                                MessageProvisorio()
                                    .showMessage(message: 'selectStop'.tr);
                              } else {
                                try {
                                  Position position =
                                      await Geolocator.getCurrentPosition(
                                          desiredAccuracy:
                                              LocationAccuracy.high);

                                  bool fimParada =
                                      await paradaController.endParada(
                                          context: context,
                                          latitude:
                                              position.latitude.toString(),
                                          longitude:
                                              position.longitude.toString(),
                                          observacao:
                                              observacaoParadaController.text,
                                          romId: widget.docId,
                                          paradaSelecionada: selectedCurrency);
                                  if (fimParada == false) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else {
                                    var id = await recId();

                                    var nomeFantasia =
                                        await getNomeFantasia(id);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Get.off(() => RomaneioView(
                                          id: widget.docId,
                                          descParada: descricao,
                                          nomeFantasia: nomeFantasia,
                                        ));
                                  }
                                } catch (e) {
                                  //print(e);
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !widget.emParada,
                        child: SizedBox(
                          width: Get.width * 0.90,
                          child: ButtonParadaWidget(
                            color: AppColors.defaultGreen,
                            title: 'startStop'.tr,
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              if (selectedCurrency == null) {
                                MessageProvisorio()
                                    .showMessage(message: 'selectStop'.tr);
                              } else {
                                try {
                                  Position position =
                                      await Geolocator.getCurrentPosition(
                                          desiredAccuracy:
                                              LocationAccuracy.high);
                                  bool inicioParada =
                                      await paradaController.beginParada(
                                          context: context,
                                          latitude:
                                              position.latitude.toString(),
                                          longitude:
                                              position.longitude.toString(),
                                          observacao:
                                              observacaoParadaController.text,
                                          romId: widget.docId,
                                          paradaSelecionada: selectedCurrency);
                                  if (inicioParada == false) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else {
                                    var id = await recId();

                                    var nomeFantasia =
                                        await getNomeFantasia(id);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Get.off(() => RomaneioView(
                                          id: widget.docId,
                                          descParada: descricao,
                                          nomeFantasia: nomeFantasia,
                                        ));
                                  }
                                } catch (e) {
                                  //print(e);
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              LoaderWidget(
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    observacaoParadaController.clear();
    super.dispose();
  }
}
