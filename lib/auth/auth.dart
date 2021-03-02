
// import 'dart:js';
import 'dart:ui';
import 'package:end_project/pages/admin/tools/model/dataprofile.dart';
import 'package:end_project/welcome.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/model.dart';
import '../pages/admin/profilePage/model/profilemodel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'forgot_pass.dart';
import '../auth/loginLagi.dart';


import '../pages/admin/profilePage/botNavBar.dart';
import '../pages/anggota/profilePage/botNavBar.dart';
import '../pages/penjual/profilePage/botNavBar.dart';

part 'login.dart';
part 'login_view_model.dart';
part 'userLogin.dart';
part 'getrole.dart';