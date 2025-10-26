import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tharad_tech_task/core/utils/assets.dart';
import 'package:tharad_tech_task/core/utils/gaps.dart';
import 'package:tharad_tech_task/core/utils/helper.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';
import '../../manager/register_form/register_form_cubit.dart';
import 'custom_paint_dashed_border.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.screenHeight * .1;
    final cubit = RegisterFormCubit.get(context);

    return BlocBuilder<RegisterFormCubit, RegisterFormState>(
      builder: (context, state) {
        final image = cubit.selectedImage;

        return InkWell(
          onTap: () {
            _showImagePickerDialog(context);
          },
          borderRadius: BorderRadius.circular(12),
          child: CustomPaint(
            painter: DashedBorderPainter(
              color: kPrimaryColor,
              dashWidth: 10,
              dashSpace: 10,
              strokeWidth: 1,
              borderRadius: 12,
            ),
            child: Container(
              color: kGreyBgColor,
              height: height,
              width: double.infinity,
              alignment: Alignment.center,
              child: image == null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetsData.camera,
                          color: kPrimaryColor,
                          height: 24,
                          width: 24,
                        ),
                        Gaps.vGap6,
                        Text(
                          "الملفات المسموح بيها : JPEG , PNG",
                          style: Styles.textStyle10.copyWith(
                            color: kGreyTextColor,
                            fontSize: 8,
                          ),
                        ),
                        Text(
                          "الحد الأقصى : 5MB",
                          style: Styles.textStyle10.copyWith(
                            color: kGreyTextColor,
                            fontSize: 6,
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(image.path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: height,
                          ),
                        ),
                        IconButton(
                          onPressed: () => cubit.clearImage(),
                          icon: const Icon(Icons.close, color: Colors.red),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  void _showImagePickerDialog(BuildContext context) {
    final cubit = RegisterFormCubit.get(context);
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text("الكاميرا"),
              onTap: () {
                Navigator.pop(context);
                cubit.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("المعرض"),
              onTap: () {
                Navigator.pop(context);
                cubit.pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
