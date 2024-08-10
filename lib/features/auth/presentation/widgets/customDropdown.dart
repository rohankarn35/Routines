// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:routines/features/auth/presentation/bloc/auth_bloc.dart';

class CustomDropDown extends StatefulWidget {
  final String title;
  final List<String> list;
  final ValueChanged<String> onChanged;
  final Map<String, dynamic>? electiveMap;
  final TextEditingController textEditingController;

  const CustomDropDown({
    Key? key,
    required this.title,
    required this.list,
    required this.onChanged,
    this.electiveMap,
    required this.textEditingController,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthBranchButton) {
            selectedValue = null;
          }
          if (state is AuthYearButton) {
            selectedValue = null;
          }
        }, builder: (context, state) {
          return DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              'Select ${widget.title}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            items: widget.list
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: widget.electiveMap == null
                          ? Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                          : Row(
                              children: [
                                Text(
                                  "${item}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // Change to white
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: Text(
                                  "(${widget.electiveMap![item]})",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                )),
                              ],
                            ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              selectedValue = value;
              context.read<AuthBloc>().add(
                  AuthSectionNameSelectedEvent(sectionName: selectedValue));
              if (value != null) {
                widget.onChanged(value);
              }
            },
            buttonStyleData: ButtonStyleData(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.transparent,
                ),
                color: Colors.grey.withOpacity(0.2),
              ),
              elevation: 2,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.white, // Change to white
              iconDisabledColor: Colors.grey, // Change to grey
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 250,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.black,
              ),
              offset: const Offset(-10, -7),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
            dropdownSearchData: DropdownSearchData(
              searchController: widget.textEditingController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: widget.textEditingController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Search for ${widget.title}',
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                if (widget.electiveMap == null) {
                  final cleanedItem = item.value!
                      .replaceAll(RegExp(r'[^A-Za-z0-9_]'), '')
                      .toLowerCase();
                  final cleanedSearchValue = searchValue
                      .replaceAll(RegExp(r'[^A-Za-z0-9_]'), '')
                      .toLowerCase();

                  return cleanedItem.contains(cleanedSearchValue);
                } else {
                  final cleanedItem = item.value!
                      .replaceAll(RegExp(r'[^A-Za-z0-9_]'), '')
                      .toLowerCase();
                  final cleanedJsonValue =
                      widget.electiveMap![item.value] != null
                          ? widget.electiveMap![item.value]!
                              .replaceAll(RegExp(r'[^A-Za-z0-9_]'), '')
                              .toLowerCase()
                          : '';

                  final cleanedSearchValue = searchValue
                      .replaceAll(RegExp(r'[^A-Za-z0-9_]'), '')
                      .toLowerCase();

                  return cleanedItem.contains(cleanedSearchValue) ||
                      cleanedJsonValue.contains(cleanedSearchValue);
                }
              },
            ),
            // This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                widget.textEditingController.clear();
              }
            },
          ));
        }));
  }
}
