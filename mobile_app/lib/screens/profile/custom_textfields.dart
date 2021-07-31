import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateOfBirthTextField extends StatefulWidget {
  final String title;
  final String initialVal;

  DateOfBirthTextField({required this.title, required this.initialVal, Key? key}) : super(key: key);

  @override
  _DateOfBirthTextFieldState createState() => _DateOfBirthTextFieldState();
}


class _DateOfBirthTextFieldState extends State<DateOfBirthTextField> {
  bool isFocused = false;
  FocusNode focusNode = FocusNode();
  late TextEditingController datetimeController;

  @override
  void initState() {
    super.initState();
    datetimeController = TextEditingController(text: widget.initialVal);
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isFocused = true;
        });
      } else {
        setState(() {
          isFocused = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: datetimeController,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        labelText: widget.title,
        suffixIcon: isFocused
            ? IconButton(
            onPressed: () async {
              final datetime = await showDatePicker(
                  context: context,
                  initialDate: DateFormat("yyyy-MM-dd").parse(widget.initialVal),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now());
              if (datetime != null) {
                final formattedDate = DateFormat("yyyy-MM-dd").format(datetime);
                datetimeController.text = formattedDate;
              } else {
                datetimeController.text = "";
              }
            },
            icon: Icon(Icons.date_range))
            : Icon(
          Icons.edit,
          size: 20,
        ),
      ),
      focusNode: focusNode,
    );
  }
}

Widget buildCustomTextField(
    {required String title, required String initialVal, bool isEditable = true, IconData? icon}) {
  return TextFormField(
    style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    initialValue: initialVal,
    decoration: InputDecoration(
      border: UnderlineInputBorder(
        borderSide: BorderSide.none,
      ),
      labelText: title,
      suffixIcon: isEditable
          ? Icon(
        Icons.edit,
        size: 20,
      )
          : null,
      prefixIcon: icon != null ? Icon(icon) : null,
    ),
  );
}