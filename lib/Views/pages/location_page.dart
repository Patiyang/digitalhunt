import 'dart:convert';

import 'package:digitalhunt/Blocs/sign_in_bloc.dart';
import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
    List<String> states = [];
  List<dynamic> districts = [];
  String selectedState = '';
  String selectedDistricts = '';

  @override
  void initState() {
    super.initState();
    getStates();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: 'select_location'.tr())),
      body: Container(child: ListView(shrinkWrap: true,children: [],),),
    );
  }
    getStates() async {
    final sb = context.read<SignInBloc>();
    // bioCtrl.text = sb.userModel.about_me!;
    String data = await DefaultAssetBundle.of(context).loadString(Config.citiesAndDistricts);
    final jsonResult = jsonDecode(data);
    // print(jsonResult);
    for (int i = 0; i < jsonResult['states'].length; i++) {
      states.add(jsonResult['states'][i]['state']);
    }
    // Fluttertoast.showToast(msg: 'Already present $state!');
    selectedState = 'Karnataka';
    selectedDistricts = sb.district ?? '';
    if (selectedState.isNotEmpty) {
      getDistricts();
    } else {
      setState(() {});
    }
  }
   getDistricts() async {
    districts = [];
    String data = await DefaultAssetBundle.of(context).loadString(Config.citiesAndDistricts);
    final jsonResult = jsonDecode(data);
    // print(jsonResult['states'][0]);
    districts = jsonResult['states'][states.indexOf(selectedState)]['districts'];
    setState(() {});
    print(districts);
  }

}
