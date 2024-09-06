import 'package:bio_medika_web/core/constant/app_assets_svg.dart';
import 'package:bio_medika_web/core/constant/app_colors.dart';
import 'package:bio_medika_web/core/constant/app_constant.dart';
import 'package:bio_medika_web/core/constant/app_fonts.dart';
import 'package:bio_medika_web/core/services/my_services.dart';
import 'package:bio_medika_web/core/utils/show_image_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextFieldWithIcon extends StatelessWidget {
  const CustomTextFieldWithIcon({
    super.key,
    required this.imagePath,
    this.iconColor,
    this.keyboardType,
    this.iconWidth,
    required this.focusNode,
    this.iconHeight,
    required this.controllerText,
    this.validator,
    required this.hintText,
    this.alwaysVisble = true,
    this.suffixIcon = false,
    this.isObscureText = false,
    this.onPressed,
    this.readOnly = false,
    this.textDirection = TextDirection.ltr,
    this.inputFormat,
  });
  final List<TextInputFormatter>? inputFormat;
  final bool readOnly;
  final String imagePath;
  final Color? iconColor;
  final double? iconWidth;
  final double? iconHeight;
  final FocusNode focusNode;
  final TextEditingController controllerText;
  final String? Function(String?)? validator;
  final String hintText;
  final bool suffixIcon;
  final bool alwaysVisble;
  final TextInputType? keyboardType;
  final bool isObscureText;
  final TextDirection textDirection;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    TextStyle? hintStyle() {
      return TextStyle(
        fontSize: AppConstants.val_14,
        fontFamily: !Get.find<MyAppServices>().appIsArabic() ? AppFonts.montserrat : AppFonts.cairo,
        color: AppColor.iconAndTextGrey,
        fontWeight: FontWeight.bold,
      );
    }

    TextStyle? style() {
      return TextStyle(
        fontFamily: textDirection == TextDirection.ltr ? AppFonts.montserrat : AppFonts.cairo,
        fontWeight: FontWeight.bold,
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppConstants.val_18),
          child: ShowImageSvg(
            path: !suffixIcon
                ? imagePath
                : isObscureText
                    ? AppAssetsSvg.lockClosed
                    : imagePath,
            color: !focusNode.hasFocus ? AppColor.iconAndTextGrey : AppColor.primary,
            width: iconWidth ?? AppConstants.val_22,
            height: iconHeight ?? AppConstants.val_22,
          ),
        ),
        const SizedBox(width: AppConstants.val_8),
        Expanded(
          child: TextFormField(
            // textDirection: TextDirection.ltr,
            // textAlign: TextAlign.right,
            inputFormatters: inputFormat,
            autofocus: true,
            style: style(),
            readOnly: readOnly,
            enableInteractiveSelection: !readOnly,
            keyboardType: keyboardType,
            focusNode: focusNode,
            validator: validator,
            cursorColor: AppColor.primary,
            obscureText: isObscureText && !alwaysVisble,
            controller: controllerText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: AppConstants.val_10),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColor.primary)),
              hintText: hintText,
              hintStyle: hintStyle(),
              suffixIconConstraints: const BoxConstraints(maxHeight: AppConstants.val_35),
              suffixIcon: Visibility(
                visible: suffixIcon,
                child: IconButton(
                  splashRadius: AppConstants.val_8,
                  onPressed: onPressed,
                  icon: Icon(
                    size: AppConstants.val_20,
                    !isObscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: !focusNode.hasFocus ? AppColor.iconAndTextGrey : AppColor.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
