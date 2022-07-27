import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upentregas/app/models/content/isolate_romaneio_update.dart';
import 'package:upentregas/app/models/romaneio/romaneio.dart';
import 'package:upentregas/app/shared/styles/app_colors.dart';
import 'package:upentregas/app/shared/ui/messages/message_provisorio.dart';
import 'package:upentregas/app/shared/widgets/loader_custom/loader_widget.dart';
import 'package:upentregas/app/modules/veiculo/veiculo_view.dart';
import 'package:upentregas/app/services/database.dart';
import 'package:upentregas/app/shared/constants/variables.dart';
import 'package:upentregas/app/shared/controllers/conexao_controller/sem_conexao_controller.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';
import 'package:upentregas/app/shared/textcontrollers/textfield_controllers.dart';

class EntregaView extends StatefulWidget {
  final String label;
  final int? id;

  EntregaView({Key? key, required this.label, required this.id})
      : assert(['Inicio', 'Fim'].contains(label)),
        super(key: key);

  @override
  _EntregaViewState createState() => _EntregaViewState();
}

class _EntregaViewState extends State<EntregaView> {
  final config = {'Inicio': {}, 'Fim': {}};
  bool isVisible = true;
  bool isLoading = false;
  int? statusCode;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  SemConexaoController semConexaoController = SemConexaoController();

  //pegar imagem camera
  _imgFromCamera() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 25,
        maxWidth: 500,
        maxHeight: 500);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: Text(
          widget.label == 'Inicio' ? 'startdeliveries'.tr : 'enddeliveries'.tr,
          style: AppTextStyles.title18,
        ),
        toolbarHeight: 90,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: Get.height,
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: Get.width * 0.85,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: kmController,
                      textAlign: TextAlign.justify,
                      decoration: InputDecoration(
                        labelText: widget.label == 'Inicio'
                            ? 'startkm'.tr
                            : 'endkm'.tr,
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
                  SizedBox(
                    width: Get.width * 0.85,
                    child: TextField(
                      controller: obsRomaneioController,
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
                  Container(
                    width: Get.width * 0.85,
                    height: Get.height * 0.04,
                    alignment: Alignment.topLeft,
                    child: Text('odometerPhoto'.tr,
                        style: theme.brightness == Brightness.dark
                            ? AppTextStyles.title16
                            : AppTextStyles.title16Black),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _imgFromCamera();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xff404040),
                            borderRadius: BorderRadius.circular(10)),
                        child: _imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(_imageFile!.path),
                                  width: Get.width * 0.85,
                                  height: Get.height * 0.25,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[700],
                                    borderRadius: BorderRadius.circular(10)),
                                width: Get.width * 0.85,
                                height: Get.height * 0.25,
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: Get.width * 0.85,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.width * 0.41,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              primary: Colors.redAccent,
                            ),
                            child: Text(
                              'cancel'.tr,
                              style: AppTextStyles.button,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        SizedBox(
                          width: Get.width * 0.41,
                          child: isLoading == false
                              ? ElevatedButton(
                                  onPressed: () async {
                                    if (widget.label == 'Inicio') {
                                      await validacaoInicioRomaneio();
                                    } else if (widget.label == 'Fim') {
                                      await validacaoFimRomaneio();
                                    } else {
                                      MessageProvisorio()
                                          .showMessage(message: 'hasError'.tr);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    padding: const EdgeInsets.all(16.0),
                                    primary: AppColors.defaultGreen,
                                  ),
                                  child: Text(
                                    'confirm'.tr,
                                    style: AppTextStyles.button,
                                  ),
                                )
                              : LoaderFimWidget(
                                  isLoading: isLoading,
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  validacaoInicioRomaneio() async {
    setState(() {
      isLoading = true;
    });
    if (kmController.text == '') {
      MessageProvisorio().showMessage(message: 'informKmExit'.tr);
      clearControllerRomaneio();
      setState(() {
        isLoading = false;
      });
    } else if (kmController.text == '0') {
      MessageProvisorio().showMessage(message: 'kmGreater'.tr);
      clearControllerRomaneio();
      setState(() {
        isLoading = false;
      });
    } else {
      if (_imageFile == null || _imageFile.isBlank == true) {
        MessageProvisorio().showMessage(message: 'odometerRequired'.tr);

        setState(() {
          isLoading = false;
        });

        return false;
      } else {
        try {
          var imgOdometroInicio = readFileByteByByte(File(_imageFile!.path));
          bool conexao = await semConexaoController.checkConnectivity();
          if (conexao) {
            var id = await recId();

            int? statusCode = await (content.envioS3(
                base64: imgOdometroInicio,
                nomeArquivo: 'Odometro_Saida',
                path: '/$id/${widget.id}'));
            if (statusCode == 200) {
              await inicioRomaneio(
                widget.id,
                kmController.text,
                imgOdometroInicio,
                (obsRomaneioController.text == '')
                    ? 'obs nao informada'
                    : obsRomaneioController.text,
                context,
              );
            } else {
              MessageProvisorio().showMessage(message: 'hasError'.tr);
            }
          } else {
            await inicioRomaneio(
              widget.id,
              kmController.text,
              imgOdometroInicio,
              (obsRomaneioController.text == '')
                  ? 'obs nao informada'
                  : obsRomaneioController.text,
              context,
            );
          }
          setState(() {
            isLoading = false;
          });
        } catch (e) {
          //print('Stack Exception: $s');
        }
      }
    }
  }

  validacaoFimRomaneio() async {
    setState(() {
      isLoading = true;
    });
    var verificacao = await verificaPendencia(widget.id);
    var element = 'false';
    bool isConc = false;
    for (var itens in verificacao) {
      var dados = itens.split('|');
      var concluida = dados[1];
      if (concluida.contains(element) || concluida.contains('null')) {
        isConc = true;
      }
    }

    if (isConc) {
      MessageProvisorio().showMessage(message: 'deliveriesNotCompleted'.tr);
      setState(() {
        isLoading = false;
      });
    } else {
      if (kmController.text == '') {
        MessageProvisorio().showMessage(message: 'informKmArrival'.tr);
        clearControllerRomaneio();
        setState(() {
          isLoading = false;
        });
      } else if (kmController.text == '0') {
        MessageProvisorio().showMessage(message: 'kmIniGreater'.tr);
        clearControllerRomaneio();
        setState(() {
          isLoading = false;
        });
      } else {
        if (_imageFile == null || _imageFile.isBlank == true) {
          MessageProvisorio().showMessage(message: 'odometerRequired'.tr);

          setState(() {
            isLoading = false;
          });
          return false;
        } else {
          try {
            var imgOdometroFim = readFileByteByByte(File(_imageFile!.path));
            bool conexao = await semConexaoController.checkConnectivity();
            if (conexao) {
              bool endSenders = await endProcess();
              if (endSenders) {
                bool conclusaoRomaneio = await fimRomaneio(
                  widget.id,
                  kmController.text,
                  imgOdometroFim,
                  (obsRomaneioController.text == '')
                      ? 'ocorrencia nao informada'
                      : obsRomaneioController.text,
                  context,
                );
                if (conclusaoRomaneio) {
                  late IsolateRomaneioUpdate? isolateRomaneioUpdate = update;

                  if (isolateRomaneioUpdate != null) {
                    isolateRomaneioUpdate.killIsolate();
                    setState(() {
                      isLoading = false;
                    });
                    Get.offAll(() => const VeiculoView());
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                    Get.offAll(() => const VeiculoView());
                  }
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  MessageProvisorio().showMessage(message: 'hasError'.tr);
                }
              } else {
                setState(() {
                  isLoading = false;
                });
                MessageProvisorio().showMessage(message: 'hasError'.tr);
              }
            } else {
              setState(() {
                isLoading = false;
              });
              MessageProvisorio().showMessage(message: 'verifyConnection'.tr);
            }
          } catch (e) {
            setState(() {
              isLoading = false;
            });
            MessageProvisorio().showMessage(message: 'hasError'.tr);
          }
        }
      }
    }
  }

  Future<bool> endProcess() async {
    bool endValidation = false;
    final romaData = await Romaneio.getCurrentRomaneio();
    romaneio = Romaneio.fromJson(romaData);
    try {
      if (!romaneio.isRomaneioInicioSynchronized()) {
        try {
          await romaneio.setInicioRomaneio();
          endValidation = true;
        } catch (e) {
          endValidation = false;
        }
      } else if (romaneio.hasUnsyncrhonizedParadas()) {
        try {
          await romaneio.envParadas();
          endValidation = true;
        } catch (e) {
          endValidation = false;
        }
      } else if (romaneio.hasUnsyncrhonizedDeliveries()) {
        try {
          await romaneio.envEntregas();
          endValidation = true;
        } catch (e) {
          endValidation = false;
        }
      } else {
        endValidation = true;
      }
    } catch (e) {
      //print(e);
    }

    return endValidation;
  }
}
