import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_fonts.dart';
import '../../../../core/config/theme/app_values.dart';
import '../../../../core/presentation/widgets/widgets.dart';

class InspectionScreen extends StatelessWidget {
  const InspectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
        backgroundColor: AppColors.primaryColor50,
        appBar: AppBarCustom(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Inspección de Vehículo',
                  style: getBoldStyle(fontSize: FontSize.s16)),
              Text('1100 [Toyota Prius]',
                  style: getMediumStyle(fontSize: FontSize.s14)),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  itemCount: 6,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) => Container(
                        color: AppColors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, bottom: 20, left: 20, right: 20),
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(bottom: AppMargin.m8),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.red500.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text('Requerido',
                                    style:
                                        getBoldStyle(color: AppColors.red500)),
                              ),
                              Text('Motor',
                                  style:
                                      getRegularStyle(fontSize: FontSize.s18)),
                              const SizedBox(height: 4),
                              Text('Item de la lista'.toUpperCase(),
                                  style:
                                      getRegularStyle(fontSize: FontSize.s12)),
                              const Spacer(),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppPadding.p14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color?>(
                                                        AppColors.red900),
                                                padding:
                                                    MaterialStateProperty.all<
                                                            EdgeInsetsGeometry?>(
                                                        const EdgeInsets.all(
                                                            20))),
                                            onPressed: () {},
                                            child: const Icon(Icons.close,
                                                color: AppColors.white)),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color?>(
                                                        AppColors.green400),
                                                padding:
                                                    MaterialStateProperty.all<
                                                            EdgeInsetsGeometry?>(
                                                        const EdgeInsets.all(
                                                            20))),
                                            onPressed: () {},
                                            child: const Icon(Icons.check,
                                                color: AppColors.white))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'observaciones'.toUpperCase(),
                                    style: getRegularStyle(
                                        color: AppColors.grey600,
                                        fontSize: FontSize.s12),
                                  ),
                                  const SizedBox(height: 4),
                                  const Wrap(
                                    spacing: 10,
                                    children: [
                                      OutlinedBtnInspec(
                                          icon: FluentIcons.comment_16_regular,
                                          text: 'Agregar'),
                                      OutlinedBtnInspec(
                                          icon: FluentIcons.image_16_regular,
                                          text: 'Agregar'),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
            ),
            const SizedBox(
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ButtonPageControl(text: 'anterior'),
                  Text('#1 de 20'),
                  _ButtonPageControl(
                    text: 'siguiente',
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class _ButtonPageControl extends StatelessWidget {
  const _ButtonPageControl({required this.text});
  final String text;


  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: null,
        child: Text(
          text.toUpperCase(),
          style: getBoldStyle(color: AppColors.black, fontSize: FontSize.s14),
        ));
  }
}

class OutlinedBtnInspec extends StatelessWidget {
  const OutlinedBtnInspec(
      {super.key, this.onPressed, required this.icon, required this.text});
  final void Function()? onPressed;
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          side: MaterialStateProperty.all(const BorderSide(
            color: AppColors.grey400,
          )),
          shape:
              MaterialStateProperty.all<OutlinedBorder?>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primaryColor),
          const SizedBox(width: 6),
          Text(text,
              style: getSemiBoldStyle(
                fontSize: FontSize.s14,
              )),
        ],
      ),
    );
  }
}



  // ElevatedButton(
  //                           onPressed: () {},
  //                           style: ElevatedButton.styleFrom(
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(
  //                                   60.0), // Ajusta el radio para hacerlo más o menos circular
  //                             ),
  //                             padding: const EdgeInsets.all(
  //                                 20), // Puedes ajustar el tamaño del botón aquí
  //                           ),
  //                           child: const Icon(
  //                             FluentIcons.camera_16_regular,
  //                             size: 26,
  //                           )),