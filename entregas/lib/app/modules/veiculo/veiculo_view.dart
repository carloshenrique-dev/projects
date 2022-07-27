import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/modules/veiculo/veiculo_controller.dart';
import 'package:upentregas/app/services/database.dart';
import 'package:upentregas/app/shared/textcontrollers/textfield_controllers.dart';
import 'package:upentregas/app/shared/ui/messages/message_provisorio.dart';
import 'package:upentregas/app/shared/widgets/buttons/button_default.dart';
import 'package:upentregas/app/shared/widgets/dialogs/dialog_localizacao.dart';
import 'package:upentregas/app/shared/widgets/loader/loader_widget.dart';
import 'package:upentregas/app/shared/widgets/titles/titles_default.dart';
import 'widgets/placa_nova_widget/placa_nova_widget.dart';
import 'widgets/placa_padrao_widget/placa_padrao_widget.dart';

class VeiculoView extends StatefulWidget {
  const VeiculoView({Key? key}) : super(key: key);

  @override
  _VeiculoViewState createState() => _VeiculoViewState();
}

class _VeiculoViewState extends State<VeiculoView> {
  bool isVisiblePadrao = true;
  bool isVisibleNovo = false;
  bool isLoading = false;
  String nomeEmpresa = 'UPSOFTWARE';
  VeiculoController controller = VeiculoController();

  @override
  void initState() {
    super.initState();
    getEmpresa();
  }

  getEmpresa() async {
    var id = await recId();
    var nomeFantasia = await getNomeFantasia(id);
    nomeEmpresa = nomeFantasia;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  const Center(
                    child: ImageIcon(
                      AssetImage('assets/images/logo.png'),
                      size: 140.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TitleDefault(
                    title: nomeEmpresa,
                  ),
                  SizedBox(
                    width: Get.width * 0.85,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: isVisiblePadrao,
                          child: const PlacaPadraoWidget(),
                        ),
                        Visibility(
                          visible: isVisibleNovo,
                          child: const PlacaNovaWidget(),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.swap_horizontal_circle_rounded,
                            size: 35,
                          ),
                          onPressed: () {
                            setState(() {
                              isVisibleNovo == true
                                  ? isVisibleNovo = false
                                  : isVisibleNovo = true;
                              isVisiblePadrao == false
                                  ? isVisiblePadrao = true
                                  : isVisiblePadrao = false;
                            });
                            placaAntigaController.clear();
                            placaNovaController.clear();
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: !isLoading,
                    child: SizedBox(
                      width: Get.width * 0.75,
                      child: DefaultButton(
                        function: () async {
                          setState(() {
                            isLoading = true;
                          });
                          bool hasPermission =
                              await controller.checkPermission();

                          if (hasPermission) {
                            String placa = '';
                            if (isVisibleNovo) {
                              setState(() {
                                placa = placaNovaController.text;
                              });
                            } else if (isVisiblePadrao) {
                              setState(() {
                                placa = placaAntigaController.text;
                              });
                            }

                            bool retorno = await controller.redirectRomaneio(
                                placa: placa, nomeFantasia: nomeEmpresa);
                            if (retorno) {
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              MessageProvisorio()
                                  .showMessage(message: 'validatedPlate'.tr);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const DialogLocation();
                              },
                            );
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        text: 'verifylicenseplate'.tr,
                      ),
                    ),
                  ),
                  Visibility(
                    child: LoaderWidget(isLoading: isLoading),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
