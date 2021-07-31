import 'package:flutter/material.dart';

Widget buildSaveButton(bool isSaving, VoidCallback onPressed){
  return TextButton(
    onPressed: isSaving ? null : onPressed,
    // style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
    child: Row(
      children: [
        Text(isSaving ? "Saving": "Save"),
        if(isSaving)
          Container(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.grey,
            ),
            height: 18,
            width: 18,
            margin: EdgeInsets.only(left: 10),
          )
        else
          Icon(
            Icons.save,
            size: 18,
          ),
      ],
    ),
  );
}