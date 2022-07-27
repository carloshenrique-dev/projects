import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/models/fim_entrega/ocorrencias_model.dart';
import 'package:upentregas/app/shared/styles/app_colors.dart';
import 'package:upentregas/app/shared/widgets/romaneio_button/elevated_button_widget.dart';
import 'package:upentregas/app/modules/signature/signature_view.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';
import 'package:upentregas/app/shared/widgets/view_custom/functions_custom.dart';
import 'fim_entrega_controller.dart';

class FimEntregaView extends GetView<FimEntregaController> {
  const FimEntregaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Get.width * 0.85,
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
                              isExpanded: true,
                              isDense: true,
                              items: controller.ocorrencias
                                  .map((OcorrenciasModel e) => DropdownMenuItem(
                                        child: Text(
                                          e.descricao!,
                                          style: theme.brightness ==
                                                  Brightness.dark
                                              ? AppTextStyles.title14
                                              : AppTextStyles.title14Black,
                                        ),
                                        value: e.id!,
                                      ))
                                  .toList(),
                              onChanged: (dynamic currencyValue) {
                                controller.itemSelecionado = currencyValue;
                                controller.changeSelect(currencyValue);
                                controller.alteraIconeOcorrencia(currencyValue);
                              },
                              value: controller.itemSelecionado,
                              hint: Text(
                                controller.selectedItem.value,
                                style: theme.brightness == Brightness.dark
                                    ? AppTextStyles.title16
                                    : AppTextStyles.title16Black,
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(width: 10),
                    Icon(controller.ocorrenciaIcon,
                        size: 25.0,
                        color: controller.ocoPositiva.value
                            ? const Color(0xff11b719)
                            : Colors.red),
                  ],
                );
              }),
              SizedBox(
                height: Get.height * 0.04,
              ),
              SizedBox(
                  width: Get.width * 0.95,
                  child: TextFormField(
                    controller: controller.ocorrenciaController,
                    textAlign: TextAlign.justify,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).primaryColor,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(9.0),
                        ),
                      ),
                      hintText: 'startobs'.tr,
                      hintStyle: theme.brightness == Brightness.dark
                          ? AppTextStyles.title16
                          : AppTextStyles.title16Black,
                    ),
                    style: theme.brightness == Brightness.dark
                        ? AppTextStyles.title16
                        : AppTextStyles.title16Black,
                  )),
              SizedBox(
                height:
                    Get.height < 820 ? Get.height * 0.035 : Get.height * 0.025,
              ),
              Container(
                width: Get.width * 0.95,
                alignment: Alignment.topLeft,
                child: Text(
                  'deliveriesPhotos'.tr,
                  style: theme.brightness == Brightness.dark
                      ? AppTextStyles.title16
                      : AppTextStyles.title16Black,
                ),
              ),
              SizedBox(
                height: Get.height * 0.009,
              ),
              Obx(() {
                return controller.photos.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          Get.to(() => CameraCamera(
                                onFile: (file) {
                                  controller.photos.add(file);
                                  Get.back();
                                },
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xff404040),
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            width: Get.width * 0.95,
                            height: Get.height < 820
                                ? Get.height * 0.20
                                : Get.height * 0.23,
                            decoration: BoxDecoration(
                                color: const Color(0xff404040),
                                borderRadius: BorderRadius.circular(10)),
                            child: controller.photos.isNotEmpty
                                ? GridView.count(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(10),
                                    scrollDirection: Axis.horizontal,
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 4,
                                    children: List.generate(
                                        controller.photos.length, (index) {
                                      return Image.file(
                                        controller.photos[index],
                                        fit: BoxFit.cover,
                                        width: 300,
                                        height: 300,
                                      );
                                    }),
                                  )
                                : Container(),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          Get.to(() => CameraCamera(
                                onFile: (file) {
                                  controller.photos.add(file);
                                  Get.back();
                                },
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(10)),
                          width: Get.width * 0.95,
                          height: Get.height < 820
                              ? Get.height * 0.20
                              : Get.height * 0.23,
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ));
              }),
              SizedBox(
                height: Get.height * 0.035,
              ),
              Container(
                width: Get.width * 0.95,
                alignment: Alignment.topLeft,
                child: Text(
                  'signature'.tr,
                  style: theme.brightness == Brightness.dark
                      ? AppTextStyles.title16
                      : AppTextStyles.title16Black,
                ),
              ),
              SizedBox(
                height: Get.height * 0.009,
              ),
              Center(
                child: GestureDetector(
                    onTap: () {
                      Get.to(() => const SignatureView());
                    },
                    child: Container(
                      width: Get.width * 0.95,
                      height: Get.height < 820
                          ? Get.height * 0.20
                          : Get.height * 0.23,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ValueListenableBuilder<ByteData?>(
                        valueListenable: rawImage,
                        builder: (context, data, child) {
                          if (data == null) {
                            return Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[700],
                                    borderRadius: BorderRadius.circular(10)),
                                width: Get.width * 0.85,
                                height: Get.height < 820
                                    ? Get.height * 0.20
                                    : Get.height * 0.23,
                                child: const Icon(
                                  FontAwesomeIcons.signature,
                                  color: Colors.white,
                                ));
                          } else {
                            controller.signature = data.buffer.asUint8List();
                            return Container(
                              decoration: BoxDecoration(
                                  color: backgSignature(context),
                                  borderRadius: BorderRadius.circular(10)),
                              width: Get.width * 0.85,
                              height: Get.height < 820
                                  ? Get.height * 0.20
                                  : Get.height * 0.23,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.memory(
                                  controller.signature!,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.03, vertical: Get.height * 0.02),
          child: SizedBox(
            width: Get.width * 0.95,
            height: Get.height * 0.090,
            child: ElevatedButtonWidget(
              funcao: () async => controller.sendData(context),
              text: 'confirm'.tr,
              color: AppColors.defaultGreen,
            ),
          ),
        ),
      ),
    );
  }
}
