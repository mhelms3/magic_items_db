
import 'package:flutter/material.dart';

List<DropdownMenuItem> pickList () {

  return(<int> [0,1,2,3,4,5].map<DropdownMenuItem<int>>((int value) {
      return DropdownMenuItem<int>
      (value: value,
      child: Text(value.toString()),
      );
    }).toList());
  }