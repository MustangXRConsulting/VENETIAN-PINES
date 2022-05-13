import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:venetian_pines/Providers/UserProvider.dart';

class UpdateInfoScreen extends StatefulWidget {
  @override
  _UpdateInfoScreenState createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  OutlineInputBorder focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(width: 1, color: Colors.black),
  );

  Color hintColor = Color(0xff747474);

  TextEditingController nameController = TextEditingController();
  TextEditingController addrressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isUpdating = false;

  UserProvider userProvider;

  updateAccount() async {
    try {
      if (nameController.text.trim().isEmpty)
        return Toast.show("Name cannot be empty", context);
      if (addrressController.text.trim().isEmpty)
        return Toast.show("Address cannot be empty", context);
      if (phoneController.text.trim().isEmpty)
        return Toast.show("Phone number cannot be empty", context);

      setState(() => isUpdating = true);

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userProvider.currentUser.email)
          .update({
        "name": nameController.text.trim(),
        "address": addrressController.text.trim(),
        "phone": phoneController.text.trim()
      });

      userProvider.updateInfo(
          name: nameController.text.trim(),
          address: addrressController.text.trim(),
          phone: phoneController.text.trim());

      Toast.show("Info updated", context);
    } catch (e) {
      Toast.show("Something went wrong", context);
    } finally {
      setState(() => isUpdating = false);
    }
  }

  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    nameController = TextEditingController(text: userProvider.currentUser.name);
    addrressController =
        TextEditingController(text: userProvider.currentUser.address);
    phoneController =
        TextEditingController(text: userProvider.currentUser.phone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/back.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Image.asset('assets/grad2.png',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill),
            Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Back',
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        )
                      ],
                    ),
                  ),
                  Center(
                      child: SvgPicture.asset(
                    'assets/bottom_nav/logo.svg',
                    width: w * .4,
                    height: w * .4,
                    semanticsLabel: 'Close',
                  )),
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Update Account',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff01443A)),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/bottom_nav/user.svg',
                                semanticsLabel: 'User',
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                'Full Name*',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 22),
                              ),
                              Spacer(),
                              Text(
                                '*required field',
                                style: TextStyle(
                                    color: Color(0xff747474),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19),
                              )
                            ],
                          ),
                          Container(
                            height: 60,
                            margin: EdgeInsets.only(top: 5),
                            child: Theme(
                              data: ThemeData(hintColor: Colors.black),
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                    focusedBorder: focusBorder,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: hintColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 19),
                                    hintText: "Enter name",
                                    fillColor: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/bottom_nav/address.svg',
                                semanticsLabel: 'Address',
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                'Address*',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Theme(
                              data: ThemeData(hintColor: Colors.black),
                              child: TextField(
                                minLines: null,
                                controller: addrressController,
                                maxLines: 2,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: InputDecoration(
                                    focusedBorder: focusBorder,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: hintColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 19),
                                    hintText: 'Enter address',
                                    fillColor: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/bottom_nav/phone.svg',
                                semanticsLabel: 'Phone',
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                'Phone*',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 60,
                            margin: EdgeInsets.only(top: 5),
                            child: Theme(
                              data: ThemeData(hintColor: Colors.black),
                              child: TextField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                    focusedBorder: focusBorder,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: hintColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 19),
                                    hintText: "+1 000 0000 0000",
                                    fillColor: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: updateAccount,
                              child: Container(
                                height: h * 0.08,
                                width: w * 0.89,
                                decoration: BoxDecoration(
                                  color: Color(0xff01443A),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: isUpdating
                                      ? CircularProgressIndicator()
                                      : Text(
                                          'Update Account',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
