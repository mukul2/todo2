import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var enabled = OutlineInputBorder(borderRadius:BorderRadius.circular(4),borderSide: BorderSide(width: 0.5,color:Colors.grey));
var focused = OutlineInputBorder(borderRadius: BorderRadius.circular(4),borderSide: BorderSide(width: 0.5,color:Colors.white));
var disabled = OutlineInputBorder(borderRadius: BorderRadius.circular(4),borderSide: BorderSide(width: 0.5,color:Colors.grey.withOpacity(0.5)));