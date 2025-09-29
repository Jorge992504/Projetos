import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ichat/app/core/env/env.dart';
import 'package:ichat/app/core/http/my_http.dart';
import 'package:ichat/app/src/i_chat_app.dart';

void main() async {
  await Env.env.load();
  HttpOverrides.global = MyHttp();
  runApp(const IChatApp());
}
