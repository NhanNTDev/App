import 'package:farmer_application/src/share/widget/dropdown_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownListWidget extends StatelessWidget {
  final String hintText;
  final String labelText;
  final double width;
  final void Function(int, int)? onChange;
  final List items;
  final double? widthLabel;
  final double? widthText;
  final String? field;
  final double? widthTextInList;
  final bool? isChange;
  final Color? color;

  const DropdownListWidget(
      {Key? key,
      required this.hintText,
      required this.labelText,
      required this.width,
      required this.onChange,
      required this.items,
      this.widthText,
      this.widthLabel,
      this.field,
        this.color,
      this.widthTextInList,
      this.isChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomDropdown<int>(
          isChange: isChange,
          child: SizedBox(
            width: widthText,
            child: Text(
              hintText,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: 'BeVietnamPro',
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                  color: color ?? Colors.grey),
            ),
          ),
          onChange: onChange,
          dropdownButtonStyle: DropdownButtonStyle(
            width: width,
            height: 51,
            // elevation: 1,
            backgroundColor: Colors.white,
            primaryColor: Colors.black87,
          ),
          dropdownStyle: DropdownStyle(
            borderRadius: BorderRadius.circular(8),
            elevation: 6,
            padding: const EdgeInsets.symmetric(vertical: 5),
          ),
          items: items
              .asMap()
              .entries
              .map(
                (item) => DropdownItem(
                  value: item.key + 1,
                  child: Container(
                    width: widthTextInList,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Text(
                      items.first.runtimeType != String
                          ? item.value.nameWithType.toString()
                          : item.value.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
