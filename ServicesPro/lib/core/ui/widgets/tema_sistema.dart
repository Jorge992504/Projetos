// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class TemaSistema {
  bool temaSistema(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
