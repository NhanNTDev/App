import 'package:farmer_application/src/core/authentication/authentication.dart';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/model/geography.dart';
import 'package:farmer_application/src/feature/repository/account_repository.dart';
import 'package:farmer_application/src/feature/repository/geography_repository.dart';
import 'package:farmer_application/src/feature/screen/farm_management/add_new_farm/components/label_widget.dart';
import 'package:farmer_application/src/feature/screen/fill_account_info/components/custom_text_field.dart';
import 'package:farmer_application/src/feature/screen/fill_account_info/components/dropdown_list_widget.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/constants/app_uidata.dart';
import 'package:farmer_application/src/share/constants/converts.dart';
import 'package:farmer_application/src/share/constants/validation.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:farmer_application/src/share/widget/stateless/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class UpdateInfoAccountScreen extends StatefulWidget {
  final String farmerId;

  const UpdateInfoAccountScreen({Key? key, required this.farmerId}) : super(key: key);

  @override
  _UpdateInfoAccountScreenState createState() => _UpdateInfoAccountScreenState();
}

class _UpdateInfoAccountScreenState extends State<UpdateInfoAccountScreen> {
  final _accountRepository = AccountRepository();
  final _formKey = GlobalKey<FormState>();
  final _geographyRepository = GeographyRepository();
  bool isPress = false;
  List<ProvinceOrCity?> _provinces = [];
  String _selectProvince = '';
  List<District?> _districts = [];
  String _selectDistrict = '';
  List<SubDistrictOrVillage?> _subDistrictOrVillages = [];
  String _selectSubDistrictOrVillage = '';
  List<String?> _genders = [];
  String _selectGender = '';
  bool isEdit = false;
  String _selectDate = '';
  String fullName = '';
  String address = '';
  String email = '';
  String oldElement = '';
  String newElement = '';
  bool isChange = false;
  String name = '';
  String gmail = '';
  String gender = '';
  String dateOfBirth = '';
  String addressFarmer = '';

  int statusCode = 0;
  bool isCall = true;

  Future<dynamic> updateAccount(String farmerId, String fullName,
      String dateOfBirth, String gmail, String gender, String address) async {
    statusCode = await _accountRepository.updateAccount(farmerId, fullName, dateOfBirth, gmail, gender, address);
    setState(() {
      if (statusCode == 200) {
        isCall = false;
        changePathInStorage(fullName, dateOfBirth, gmail, gender, address);
        UIData.toastMessage('Cập nhật thành công');
        Navigator.pop(context);
      } else {
        isCall = false;
        UIData.toastMessage('Cập nhật thất bại');
      }
    });
  }

  Future<void> changePathInStorage(String fullName, String dateOfBirth, String gmail, String gender, String address) async {
    await storage.write(key: 'name', value: fullName);
    await storage.write(key: 'email', value: gmail);
    await storage.write(key: 'gender', value: gender);
    await storage.write(key: 'address', value: address);
    await storage.write(key: 'dateOfBirth', value: dateOfBirth);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFarmerId();
    _genders = ['Nam', 'Nữ', 'Khác'];
    getProvinceOrCity();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    gmail = '';
    gender = '';
    dateOfBirth = '';
    addressFarmer = '';
    isPress = false;
    _provinces = [];
    statusCode = 0;
    _selectProvince = '';
    _districts = [];
    _selectDistrict = '';
    _subDistrictOrVillages = [];
    _selectSubDistrictOrVillage = '';
    _genders = [];
    isEdit = false;
    _selectGender = '';
    _selectDate = '';
    oldElement = '';
    newElement = '';
    fullName = '';
    address = '';
    email = '';
    isChange = false;
    isCall = true;
    super.dispose();
  }

  _getFarmerId() async {
    final all = await storage.readAll();
    setState(() {
      isCall = false;
      all.entries.map((entry) => {
                if (entry.key == 'name')
                  {fullName = entry.value,},
                if (entry.key == 'email')
                  {email = entry.value,},
                if (entry.key == 'gender')
                  {_selectGender = entry.value,},
                if (entry.key == 'address')
                  {address = entry.value,},
                if (entry.key == 'dateOfBirth')
                  {_selectDate = convertFormatDate(DateTime.parse(entry.value)),}
              }).toList(growable: false);
    });
  }

  Future<void> getProvinceOrCity() async {
    Map<String, dynamic> response = await _geographyRepository.getProvinceOrCity();
    for (var key in response.keys) {
      ProvinceOrCity element = ProvinceOrCity.fromJson(response[key]);
      _provinces.add(element);
    }
    if (_provinces.isNotEmpty) {
      _provinces.sort((a, b) => a!.name.compareTo(b!.name));
      setState(() {});
    }
  }

  Future<void> getDistrictByCode(String filename) async {
    if (_districts.isNotEmpty) {
      oldElement = _districts[0]!.nameWithType.toString();
    }
    _districts.clear();

    Map<String, dynamic> response = await _geographyRepository.getDistrictByCode(filename);

    for (var key in response.keys) {
      District element = District.fromJson(response[key]);
      _districts.add(element);
    }
    if (_districts.isNotEmpty) {
      _districts.sort((a, b) => a!.name.compareTo(b!.name));
      setState(() {
        newElement = _districts[0]!.nameWithType.toString();
        isListChange();
      });
    }
  }

  Future<void> getSubDistrictOrVillageByCode(String filename) async {
    _subDistrictOrVillages.clear();
    Map<String, dynamic> response =
        await _geographyRepository.getSubDistrictOrVillageByCode(filename);

    for (var key in response.keys) {
      SubDistrictOrVillage element =
          SubDistrictOrVillage.fromJson(response[key]);
      _subDistrictOrVillages.add(element);
    }
    if (_subDistrictOrVillages.isNotEmpty) {
      _subDistrictOrVillages.sort((a, b) => a!.name.compareTo(b!.name));
      setState(() {});
    }
  }

  isListChange() {
    setState(() {
      if (oldElement != newElement) {
        isChange = true;
        _selectDistrict = '';
        _selectSubDistrictOrVillage = '';
      } else {
        isChange = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: ProgressHUD(
              child: Container(
                padding: const EdgeInsets.only(left: kPaddingDefault, right: kPaddingDefault, top: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: isPress ? AutovalidateMode.always : AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {Navigator.pop(context);},
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: IconWidget(icon: Iconsax.arrow_left, color: Color.fromRGBO(107, 114, 128, 1.0),
                                fontSize: 22.sp, fontWeight: FontWeight.w600),),),
                        SizedBox(height: _size.height * 0.01,),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault),
                          child: Text("Cập nhật thông tin cá nhân",
                              style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                  fontSize: 22.sp, color: Color.fromRGBO(54, 49, 71, 1.0))),),
                        SizedBox(height: 40,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: kPaddingDefault),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text('Tên đầy đủ',
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                      fontSize: 12.sp, color: Color.fromRGBO(61, 55, 55, 1.0))),
                              Text('*',
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                      fontSize: 15.sp, color: Colors.redAccent)),
                              Text(':',
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                      fontSize: 12.sp, color: Colors.black.withOpacity(0.5))),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomTextField(
                            inputAction: TextInputAction.next,
                            initValue: fullName,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Vui lòng điền vào chỗ này';
                              }
                            },
                            isDense: true,
                            hintText: "Nhập địa chỉ cụ thể của bạn",
                            onChanged: (value) {
                              fullName = value.trim();
                            },
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: kPaddingDefault),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text('Gmail',
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                      fontSize: 12.sp, color: Color.fromRGBO(61, 55, 55, 1.0))),
                              Text('*',
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                      fontSize: 15.sp, color: Colors.redAccent)),
                              Text(':',
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                      fontSize: 12.sp, color: Colors.black.withOpacity(0.5))),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomTextField(
                            inputAction: TextInputAction.next,
                            initValue: email,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Vui lòng điền vào chỗ này';
                              } else if (isValidEmail(value) == false) {
                                return 'Vui lòng nhập đúng cú pháp email';
                              }
                            },
                            isDense: true,
                            hintText: "Nhập email của bạn",
                            onChanged: (value) {
                              email = value.trim();
                            },
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: kPaddingDefault),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Text('Giới tính',
                                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                              fontSize: 12.sp, color: Color.fromRGBO(61, 55, 55, 1.0))),
                                      Text('*',
                                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                              fontSize: 15.sp, color: Colors.redAccent)),
                                      Text(':',
                                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                              fontSize: 12.sp, color: Colors.black.withOpacity(0.5))),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Container(
                                  width: _size.width * 0.4,
                                  padding: EdgeInsets.only(left: kPaddingDefault),
                                  child: DropdownListWidget(
                                      widthTextInList: 50, color: Colors.black,
                                      width: _size.width, hintText: _selectGender, labelText: 'Giới tính',
                                      onChange: (int value, int index) {
                                        setState(() {
                                          FocusScopeNode currentFocus = FocusScope.of(context);
                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }
                                          _selectGender = _genders[index]!.toString();
                                        });
                                      }, items: _genders),),
                                SizedBox(height: 8,),
                                _selectGender == '' && isPress
                                    ? Container(
                                        padding: const EdgeInsets.only(left: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text('Vui lòng điền vào chỗ \nnày',
                                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                                fontSize: 10.sp, color: Colors.red[700])),) : Container()
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: kPaddingDefault),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Text('Ngày sinh',
                                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                              fontSize: 12.sp, color: Color.fromRGBO(61, 55, 55, 1.0))),
                                      Text('*',
                                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                              fontSize: 15.sp, color: Colors.redAccent)),
                                      Text(':',
                                          style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                              fontSize: 12.sp, color: Colors.black.withOpacity(0.5))),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Container(
                                  padding: EdgeInsets.only(left: kPaddingDefault),
                                  width: _size.width * 0.519,
                                  height: 51,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        backgroundColor: MaterialStateProperty.all(Colors.white),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                                side: isPress && _selectDate == ''
                                                    ? BorderSide(color: Colors.redAccent, width: 1, style: BorderStyle.solid)
                                                    : BorderSide(color: Colors.grey.withOpacity(0.4), width: 1, style: BorderStyle.solid)))),
                                    child: Row(
                                      children: [
                                        _selectDate == '' ? Text(
                                                'Chọn ngày sinh',
                                                style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                                    fontSize: 11.sp, color: Colors.grey),) : Text(_selectDate,
                                                style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp, color: Colors.black),),
                                        Spacer(),
                                        IconWidget(icon: Iconsax.calendar_1, color: Colors.grey,
                                            fontSize: 16.sp, fontWeight: FontWeight.w600)
                                      ],
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        FocusScopeNode currentFocus = FocusScope.of(context);
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                      });
                                      var datePicked = await DatePicker.showSimpleDatePicker(context,
                                              initialDate: DateTime.parse(
                                                  DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(_selectDate))),
                                              firstDate: DateTime(1960),
                                              lastDate: DateTime.now(),
                                              dateFormat: "dd-MMMM-yyyy",
                                              locale: DateTimePickerLocale.en_us,
                                              looping: true,
                                              titleText: 'Chọn ngày sinh',
                                              itemTextStyle: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                                  fontSize: 13.sp, color: Colors.black));
                                      setState(() {
                                        _selectDate = convertFormatDate(DateTime.parse(datePicked.toString()));
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 8,),
                                _selectDate == '' && isPress ? Container(
                                        padding: const EdgeInsets.only(left: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text('Vui lòng điền vào chỗ này',
                                            style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                                fontSize: 10.sp, color: Colors.red[700])),) : Container()
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  IconWidget(icon: Iconsax.location, color: Colors.redAccent,
                                      fontSize: 15.sp, fontWeight: FontWeight.w700),
                                  const SizedBox(width: 5,),
                                  Text('Địa chỉ',
                                      style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                          fontSize: 12.sp, color: Color.fromRGBO(61, 55, 55, 1.0))),
                                  Text('*',
                                      style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                          fontSize: 15.sp, color: Colors.redAccent)),
                                  Text(':',
                                      style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                          fontSize: 12.sp, color: Colors.black.withOpacity(0.5))),
                                ],
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    isEdit = !isEdit;
                                  });
                                },
                                child: const Text('Chỉnh sửa'))
                          ],
                        ),
                        isEdit == false ? Container(
                                height: 51,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(address),) : Container(),
                        isEdit == true ? titleLabel('Tỉnh/Thành phố') : Container(),
                        isEdit == true ? const SizedBox(height: 8,) : Container(),
                        isEdit == true ? Container(
                                width: _size.width * 0.9,
                                decoration: !_selectProvince.isNotEmpty && isPress
                                    ? BoxDecoration(border: Border.all(color: Colors.red),
                                    borderRadius: BorderRadius.circular(8)) : BoxDecoration(
                                        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 0),
                                        borderRadius: BorderRadius.circular(8)),
                                child: DropdownListWidget(
                                    width: _size.width,
                                    hintText: '--chọn tỉnh/thành phố',
                                    labelText: 'Tỉnh/Thành phố',
                                    onChange: (int value, int index) {
                                      setState(() {
                                        FocusScopeNode currentFocus = FocusScope.of(context);
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                      });
                                      getDistrictByCode(_provinces[index]!.code.toString());
                                      if (_provinces.isNotEmpty) {
                                        setState(() {
                                          _selectProvince = _provinces[index]!.nameWithType.toString();
                                        });
                                      }
                                    }, items: _provinces),) : Container(),
                        isEdit == true ? const SizedBox(height: 5,) : Container(),
                        !_selectProvince.isNotEmpty && isPress && isEdit == true
                            ? Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                alignment: Alignment.centerLeft,
                                child: Text('Bạn cần chọn tỉnh/thành phố',
                                    style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                        fontSize: 10.sp, color: Colors.red[700])),) : Container(),
                        isEdit == true ? const SizedBox(height: 20,) : Container(),
                        isEdit == true ? titleLabel('Quận/Huyện') : Container(),
                        isEdit == true ? const SizedBox(height: 8,) : Container(),
                        isEdit == true ? Container(
                                width: _size.width * 0.9,
                                decoration: !_selectDistrict.isNotEmpty && isPress
                                    ? BoxDecoration(border: Border.all(color: Colors.red),
                                        borderRadius: BorderRadius.circular(8)) : BoxDecoration(
                                        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 0),
                                        borderRadius: BorderRadius.circular(8)),
                                child: DropdownListWidget(
                                    isChange: isChange,
                                    width: _size.width,
                                    hintText: '--chọn quận/huyện',
                                    labelText: 'Quận/Huyện',
                                    onChange: (int value, int index) {
                                      setState(() {
                                        FocusScopeNode currentFocus = FocusScope.of(context);
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                      });
                                      getSubDistrictOrVillageByCode(_districts[index]!.code.toString());
                                      if (_districts.isNotEmpty) {
                                        setState(() {
                                          _selectDistrict = _districts[index]!.nameWithType.toString();
                                          isChange = false;
                                        });
                                      }
                                    }, items: _districts),) : Container(),
                        isEdit == true ? const SizedBox(height: 5,) : Container(),
                        !_selectDistrict.isNotEmpty && isPress && isEdit == true
                            ? Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                alignment: Alignment.centerLeft,
                                child: Text('Bạn cần chọn quận/huyện',
                                    style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                        fontSize: 10.sp, color: Colors.red[700])),) : Container(),
                        const SizedBox(height: 20,),
                        isEdit == true ? titleLabel('Phường/Xã') : Container(),
                        isEdit == true ? const SizedBox(height: 8,) : Container(),
                        isEdit == true ? Container(
                                width: _size.width * 0.9,
                                decoration: !_selectSubDistrictOrVillage.isNotEmpty && isPress
                                    ? BoxDecoration(border: Border.all(color: Colors.red),
                                        borderRadius: BorderRadius.circular(8))
                                    : BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.2), width: 0),
                                        borderRadius: BorderRadius.circular(8)),
                                child: DropdownListWidget(
                                    isChange: isChange,
                                    width: _size.width,
                                    hintText: '--chọn phường/xã',
                                    labelText: 'Phường/Xã',
                                    onChange: (int value, int index) {
                                      setState(() {
                                        FocusScopeNode currentFocus = FocusScope.of(context);
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                      });
                                      if (_subDistrictOrVillages.isNotEmpty) {
                                        setState(() {
                                          _selectSubDistrictOrVillage = _subDistrictOrVillages[index]!.nameWithType.toString();
                                        });
                                      }
                                    }, items: _subDistrictOrVillages),) : Container(),
                        isEdit == true ? const SizedBox(height: 5,) : Container(),
                        !_selectSubDistrictOrVillage.isNotEmpty && isPress && isEdit == true
                            ? Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                alignment: Alignment.centerLeft,
                                child: Text('Bạn cần chọn phường/xã',
                                    style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                        fontSize: 10.sp, color: Colors.red[700])),) : Container(),
                        isEdit == true ? const SizedBox(height: 20,) : Container(),
                        isEdit == true ? titleLabel('Địa chỉ cụ thể (Thôn/Xóm/Số nhà)') : Container(),
                        isEdit == true ? const SizedBox(height: 8,) : Container(),
                        isEdit == true ? Container(
                                height: 110,
                                padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
                                child: CustomTextField(
                                  inputAction: TextInputAction.done,
                                  initValue: addressFarmer,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return 'Bạn cần nhập địa chỉ cụ thể của mình';
                                    }
                                  },
                                  isDense: true,
                                  maxLines: 50,
                                  hintText: "Nhập địa chỉ cụ thể của bạn",
                                  onChanged: (value) {
                                    addressFarmer = value.trim();
                                  },
                                ),) : Container(),
                        SizedBox(height: 160,),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(95, 212, 144, 1.0),),
                            width: _size.width * 0.9,
                            height: _size.height * 0.065,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  isPress = true;
                                  isCall = true;
                                  if (_formKey.currentState!.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Text('Xác nhận'),
                                        content: const Text('Bạn muốn đổi cập nhật thông tin?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                isCall = false;
                                              });
                                              Navigator.pop(context, 'Cancel');
                                            },
                                            child: const Text('Không'),),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, 'OK');
                                              if (_selectDate != '' && _selectGender != '' &&
                                                  _selectDistrict != '' && _selectProvince != '' &&
                                                  _selectSubDistrictOrVillage != '') {
                                                updateAccount(widget.farmerId, fullName,
                                                    DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(_selectDate)),
                                                    email, _selectGender, addressFarmer + ", " + _selectSubDistrictOrVillage +
                                                        ", " + _selectDistrict +
                                                        ", " + _selectProvince);
                                              } else {
                                                updateAccount(widget.farmerId, fullName,
                                                    DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(_selectDate)),
                                                    email, _selectGender, address);
                                              }
                                            },
                                            child: const Text('Có'),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {isCall = false;}
                                });
                              },
                              child: Text('Xác nhận',
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                      fontSize: 12.sp, color: Colors.white)),)),
                        SizedBox(height: 30,),
                      ],
                    ),),),), inAsyncCall: isCall,),
          ),
        ),
        tablet: SafeArea(child: Scaffold(appBar: AppBar(),),),
        desktop: SafeArea(child: Scaffold(appBar: AppBar(),),));
  }
}
