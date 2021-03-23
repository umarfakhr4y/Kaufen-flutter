import 'package:end_project/pages/admin/tools/product_page/action/addProduct.dart';
import 'package:end_project/pages/admin/tools/product_page/editImagekoperasi.dart';
import 'package:end_project/pages/admin/tools/product_page/editProduct.dart';
import 'package:end_project/pages/admin/tools/saving_page/saving_pageAdmin.dart';
// import 'package:end_project/pages/admin/tools/saving_page/saving.dart';
// import 'package:end_project/pages/admin/tools/savings_page/savings_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shimmer/shimmer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';


import './model/memberlistModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:end_project/size_helper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import './member_page/getdataMember.dart';
import 'package:hexcolor/hexcolor.dart';
import 'otherproduct_page/otherProduct_viewModel.dart';
import 'otherproduct_page/action/addOtherproduct.dart';
import 'otherproduct_page/editOtherproduct.dart';
import 'otherproduct_page/editImageProduct.dart';




import './model/otherproduct.dart';
import 'product_page/model/koperasi.dart';
import './viewModel/memberlistViewmodel.dart';
import './viewModel/productViewModel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:ui';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'model/productModel.dart';

import 'package:flutter_search_bar/flutter_search_bar.dart';


import 'member_page/membersingle.dart';
import 'member_page/memberSingleTest.dart';
import '../../admin/profilePage/botNavBar.dart';
import '../register/register.dart';
import 'debt_page/debt.dart';



part 'product_page/product.dart';
part 'product_page/search_product.dart';
part 'otherproduct_page/otherproduct.dart';
part 'toolspage.dart';
part '../register/registerAdmin.dart';
part 'member_page/memberlist.dart';

// part 'member_page/membersingle.dart';