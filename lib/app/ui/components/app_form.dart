// ignore_for_file: avoid_positional_boolean_parameters, always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_starter_kit_2024/app/data/config/app_colors.dart';
import 'package:get_starter_kit_2024/app/ui/components/decimal_text_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

/// App form filed common widget
class AppForm extends StatelessWidget {
  /// App form filed common widget constructor
  const AppForm({
    required this.name,
    this.title,
    this.hintText,
    this.validate,
    this.preFixIcon,
    this.hintStyle,
    this.keyboardType = TextInputType.text,
    this.autoFillHints,
    this.readOnly = false,
    this.onTap,
    this.controller,
    this.onChange,
    this.maxLength = 225,
    this.enabled = true,
    this.suffixIcon,
    this.fontSize,
    this.hasBorder = false,
    this.minLines,
    this.maxLines = 1,
    this.fillColor = AppColors.kFFFFFF,
    this.borderColor = AppColors.k000000,
    this.hasLabel = false,
    this.textInputAction = TextInputAction.next,
    this.fontStyle,
    this.showCursor = true,
    this.isUpperCaseAll = false,
    this.isNumeric = false,
    this.labelText,
    this.contentPadding,
    this.inputFormatter,
    this.labelStyle,
    this.autoFocus = false,
    this.preFixWidget,
    this.suffixWidget,
    this.isShowLabel = false,
    this.textCapitalization = TextCapitalization.none,
    this.borderRadius = 12,
    this.prefixWidgetSize,
    this.suffixWidgetSize,
    this.constraints,
    this.counter,
    this.isObscure = false,
    this.textStyle,
    this.icon,
    this.isRequired,
    this.textFieldType = TextFieldType.textField,
    this.onDateChange,
    this.dateValidate,
    this.onCheckChange,
    this.validateCheckBox,
    this.items,
    this.margin,
    this.initialDate,
    this.initialValue,
    this.onDropDownReset,
    this.firstDate,
    this.helpText,
    this.titleStyle,
    this.infoWidget,
    Key? key,
  }) : super(key: key);

  ///Hint text
  final String? hintText;

  /// Is obscure
  final bool isObscure;

  /// Validate
  final String? Function(String? value)? validate;

  /// Date validate
  final String? Function(DateTime? value)? dateValidate;

  /// Validate check box
  final String? Function(bool?)? validateCheckBox;

  ///Prefix
  final Widget? preFixIcon;

  ///Prefix Widget
  final Widget? preFixWidget;

  /// Keyboard type of the text field
  final TextInputType keyboardType;

  ///List of autofill hints
  final List<String>? autoFillHints;

  ///Read only
  final bool readOnly;

  ///Read only
  final bool enabled;

  ///On tap
  final VoidCallback? onTap;

  ///Controller
  final TextEditingController? controller;

  ///Function of On change
  final void Function(String?)? onChange;

  /// On Date change
  final void Function(DateTime?)? onDateChange;

  /// On check
  final void Function(bool?)? onCheckChange;

  /// Border Radius
  final double borderRadius;

  ///Maximum Length
  final int? maxLength;

  ///Suffix icon
  final Widget? suffixIcon;

  ///Font Size of hintText
  final double? fontSize;

  /// Min lines of Text
  final int? minLines;

  /// Has Label
  final bool hasLabel;

  /// Min lines of Text
  final int? maxLines;

  ///TextFormField Background Color
  final Color fillColor;

  ///Input TextStyle
  final TextStyle? hintStyle;

  ///Input TextStyle
  final TextStyle? fontStyle;

  ///TextFormField Border Color
  final Color borderColor;

  ///Has Border
  final bool hasBorder;

  ///Text Input Action
  final TextInputAction? textInputAction;

  /// true if want to show cursor
  final bool showCursor;

  /// true if want to convert all text to uppercase
  final bool isUpperCaseAll;

  /// true if want to convert all text to uppercase
  final bool isNumeric;

  /// Label Text
  final String? labelText;

  /// Label Style
  final TextStyle? labelStyle;

  /// Suffix Widget
  final Widget? suffixWidget;

  /// Auto focus
  final bool autoFocus;

  /// show label initially
  final bool isShowLabel;

  /// Text Capitalization
  final TextCapitalization textCapitalization;

  /// Content Padding
  final EdgeInsetsGeometry? contentPadding;

  /// Input Formatter
  final List<TextInputFormatter>? inputFormatter;

  /// Prefix Icon Box constrain
  final Size? prefixWidgetSize;

  /// Suffix Icon Box constrain
  final Size? suffixWidgetSize;

  /// Text-field constraints
  final BoxConstraints? constraints;

  /// Text field key name
  final String name;

  /// Text field title
  final String? title;

  /// Text field text style
  final TextStyle? textStyle;

  /// Counter widget
  final Widget? counter;

  /// Drop down icon
  final Widget? icon;

  /// Is required field
  final bool? isRequired;

  /// TextField type
  final TextFieldType textFieldType;

  /// Items
  final List<String>? items;

  /// Margin
  final EdgeInsets? margin;

  /// Initial date
  final DateTime? initialDate;

  /// Initial value
  final String? initialValue;

  /// on drop down reset
  final void Function()? onDropDownReset;

  /// First date
  final DateTime? firstDate;

  /// Help text
  final String? helpText;

  /// Title style
  final TextStyle? titleStyle;

  /// Info widget
  final Widget? infoWidget;

  @override
  Widget build(BuildContext context) {
    switch (textFieldType) {
      case TextFieldType.textField:
        return textFieldView();
      case TextFieldType.datePicker:
        return datePickerView();
      case TextFieldType.checkBox:
        return checkBoxView();
      case TextFieldType.dropDown:
        return dropDownView();
      case TextFieldType.radioButton:
        return radioButtonView();
    }
  }

  /// Radio button view
  Widget radioButtonView() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      if (title != null) ...<Widget>[
        Row(
          children: [
            RichText(
              text: TextSpan(
                text: title,
                style: titleStyle ??
                    GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      color: AppColors.k000000,
                    ),
                children: (isRequired ?? false)
                    ? <TextSpan>[
                  TextSpan(
                    text: ' *',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kFF0000,
                    ),
                  ),
                ]
                    : <TextSpan>[],
              ),
            ),
            if (infoWidget != null) ...[
              SizedBox(
                width: 10.w,
              ),
              infoWidget!,
            ],
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
      FormBuilderRadioGroup<String>(
        name: name,
        decoration: inputDecoration(),
        validator: validate,
        enabled: enabled,
        initialValue: initialValue,
        activeColor: AppColors.k318CE7,
        onChanged: onChange,
        options: items
            ?.map((String val) => FormBuilderFieldOption(
          value: val,
          child: Text(
            '$val',
            style: textStyle,
          ),
        ))
            .toList() ??
            [],
      ),
    ],
  );

  /// Drop down view
  Widget dropDownView() => Padding(
    padding: margin ?? EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null) ...<Widget>[
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: title,
                  style: titleStyle ??
                      GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                        color: AppColors.k000000,
                      ),
                  children: (isRequired ?? false)
                      ? <TextSpan>[
                    TextSpan(
                      text: ' *',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kFF0000,
                      ),
                    ),
                  ]
                      : <TextSpan>[],
                ),
              ),
              if (infoWidget != null) ...[
                SizedBox(
                  width: 10.w,
                ),
                infoWidget!,
              ],
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
        ],
        FormBuilderDropdown<String>(
          name: name,
          autofocus: autoFocus,
          initialValue: initialValue,
          decoration: inputDecoration(),
          validator: validate,
          onTap: () {
            onTap?.call();
          },
          onReset: () {
            onDropDownReset?.call();
          },
          dropdownColor: AppColors.kF0F8FF,
          alignment: Alignment.centerLeft,
          enabled: enabled,
          style: fontStyle ??
              GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.k000000,
              ),
          onChanged: onChange,
          items: items
              ?.map((String val) => DropdownMenuItem(
            value: val,
            child: Text('$val'),
          ))
              .toList() ??
              [],
        ),
      ],
    ),
  );

  /// Check box view
  Widget checkBoxView() => FormBuilderCheckbox(
    name: name,
    initialValue: false,
    onChanged: onCheckChange,
    validator: validateCheckBox,
    activeColor: AppColors.k318CE7,
    side: BorderSide(
      width: 0.5.w,
    ),
    title: Text(
      title ?? '',
      style: titleStyle ??
          GoogleFonts.poppins(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.k000000,
          ),
    ),
    subtitle: (hintText != null && (hintText?.isNotEmpty ?? false))
        ? GestureDetector(
      onTap: onTap,
      child: Text(
        hintText ?? '',
        style: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.k318CE7,
        ),
      ),
    )
        : null,
  );

  /// Date picker view
  Column datePickerView() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      if (title != null) ...<Widget>[
        Row(
          children: [
            RichText(
              text: TextSpan(
                text: title,
                style: titleStyle ??
                    GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      color: AppColors.k000000,
                    ),
                children: (isRequired ?? false)
                    ? <TextSpan>[
                  TextSpan(
                    text: ' *',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kFF0000,
                    ),
                  ),
                ]
                    : <TextSpan>[],
              ),
            ),
            if (infoWidget != null) ...[
              SizedBox(
                width: 10.w,
              ),
              infoWidget!,
            ],
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
      FormBuilderDateTimePicker(
        obscureText: isObscure,
        name: name,
        initialValue: initialDate,
        textCapitalization: textCapitalization,
        autofocus: autoFocus,
        inputFormatters: <TextInputFormatter>[
          if (isUpperCaseAll)
            TextInputFormatter.withFunction(
                  (TextEditingValue oldValue, TextEditingValue newValue) =>
                  TextEditingValue(
                    text: newValue.text.toUpperCase(),
                    selection: newValue.selection,
                  ),
            ),
          if (isNumeric) DecimalTextInputFormatter(),
          if (inputFormatter != null) ...inputFormatter!,
        ],
        transitionBuilder: (context, child) => Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.k0098FF,
              shadow: AppColors.k000000,
            ),
          ),
          child: child!,
        ),
        decoration: inputDecoration(),
        inputType: InputType.date,
        format: DateFormat('dd-MM-yyyy'),
        validator: dateValidate,
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
        controller: controller,
        enabled: enabled,
        firstDate: firstDate,
        cursorColor: AppColors.k000000,
        helpText: helpText,
        style: fontStyle ??
            GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.k000000,
            ),
        showCursor: showCursor,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: onDateChange,
      ),
    ],
  );

  /// Text field view
  Widget textFieldView() => Padding(
    padding: margin ?? EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null) ...<Widget>[
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: title,
                  style: titleStyle ??
                      GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                        color: AppColors.k000000,
                      ),
                  children: (isRequired ?? false)
                      ? <TextSpan>[
                    TextSpan(
                      text: ' *',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kFF0000,
                      ),
                    ),
                  ]
                      : <TextSpan>[],
                ),
              ),
              if (infoWidget != null) ...[
                SizedBox(
                  width: 10.w,
                ),
                infoWidget!,
              ],
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
        ],
        FormBuilderTextField(
          obscureText: isObscure,
          name: name,
          initialValue: initialValue,
          textCapitalization: textCapitalization,
          autofocus: autoFocus,
          inputFormatters: <TextInputFormatter>[
            if (isUpperCaseAll)
              TextInputFormatter.withFunction(
                    (TextEditingValue oldValue, TextEditingValue newValue) =>
                    TextEditingValue(
                      text: newValue.text.toUpperCase(),
                      selection: newValue.selection,
                    ),
              ),
            if (isNumeric) DecimalTextInputFormatter(),
            if (inputFormatter != null) ...inputFormatter!,
          ],
          readOnly: readOnly,
          maxLength: maxLength,
          maxLines: maxLines,
          minLines: minLines,
          onTap: onTap,
          controller: controller,
          enabled: enabled,
          cursorColor: AppColors.k000000,
          style: fontStyle ??
              GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.k000000,
              ),
          showCursor: showCursor,
          decoration: inputDecoration(),
          keyboardType: keyboardType,
          validator: validate,
          autofillHints: autoFillHints,
          textInputAction: textInputAction,
          onChanged: onChange,
        ),
      ],
    ),
  );

  /// Input decoration
  InputDecoration inputDecoration() => InputDecoration(
    filled: true,
    counter: counter,
    labelStyle: isShowLabel ? labelStyle : fontStyle,
    labelText: isShowLabel ? labelText : null,
    hintText: hasLabel ? null : hintText,
    fillColor: fillColor,
    hintStyle: hintStyle ??
        GoogleFonts.poppins(
          fontSize: 12.sp,
          color: AppColors.k000000.withOpacity(0.3),
        ),
    prefixIcon: preFixIcon,
    suffixIcon: suffixIcon,
    suffix: suffixWidget,
    counterText: '',
    prefix: preFixWidget,
    prefixIconConstraints:
    BoxConstraints.tight(prefixWidgetSize ?? const Size(60, 50)),
    suffixIconConstraints:
    BoxConstraints.tight(suffixWidgetSize ?? const Size(50, 50)),
    constraints: constraints,
    focusedErrorBorder: _buildBorder(),
    enabledBorder: _buildBorder(),
    disabledBorder: _buildBorder(),
    focusedBorder: _buildBorder(),
    errorBorder: _buildBorder().copyWith(
      borderSide: hasBorder
          ? const BorderSide(
        width: 0.5,
      )
          : BorderSide.none,
    ),
    contentPadding: contentPadding ??
        REdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
    floatingLabelAlignment: FloatingLabelAlignment.start,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
  );

  InputBorder _buildBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius),
    borderSide: hasBorder
        ? BorderSide(
      color: borderColor,
      width: 0.5.w,
    )
        : BorderSide.none,
  );
}


/// Text field type
enum TextFieldType {
  /// Text field
  textField,

  /// Date picker
  datePicker,

  /// Check box
  checkBox,

  /// Drop down
  dropDown,

  /// Radio button
  radioButton
}

