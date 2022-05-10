import 'dart:async';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/model/farm.dart';
import 'package:farmer_application/src/feature/model/product_system.dart';
import 'package:farmer_application/src/feature/repository/farm_repository.dart';
import 'package:farmer_application/src/feature/repository/harvest_repository.dart';
import 'package:farmer_application/src/feature/repository/product_system_repository.dart';
import 'package:farmer_application/src/feature/screen/farm_management/add_new_farm/components/dotted_border_button.dart';
import 'package:farmer_application/src/feature/screen/farm_management/add_new_farm/components/label_widget.dart';
import 'package:farmer_application/src/feature/screen/fill_account_info/components/custom_text_field.dart';
import 'package:farmer_application/src/feature/screen/harvest_management/harvest_management_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/constants/app_uidata.dart';
import 'package:farmer_application/src/share/constants/converts.dart';
import 'package:farmer_application/src/share/constants/validation.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:farmer_application/src/share/widget/stateless/progress_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'components/add_new_harvest_header.dart';

class AddNewHarvestScreen extends StatefulWidget {
  final String farmerId;

  const AddNewHarvestScreen({Key? key, required this.farmerId})
      : super(key: key);

  @override
  _AddNewHarvestScreenState createState() => _AddNewHarvestScreenState();
}

class _AddNewHarvestScreenState extends State<AddNewHarvestScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isPress = false;
  List<Asset> images = <Asset>[];
  String harvestName = '';
  String productNameChange = '';
  String harvestDescription = '';
  List<ProductSystem> productSystem = [];
  String estimatedProduction = '';
  String actualProduction = '';
  ProductSystem _selectProductSystem = ProductSystem(
      name: '',
      minPrice: 0,
      maxPrice: 0,
      unit: '',
      province: '',
      productCategoryId: 0);
  final _userEditTextController = TextEditingController(text: '');
  Farm _selectFarm = Farm(
      name: '',
      avatar: '',
      image1: '',
      image2: '',
      image3: '',
      image4: '',
      image5: '',
      description: '',
      address: '',
      active: false, totalStar: 0, feedbacks: 0);
  DateTime _selectDateStart = DateTime.now();
  DateTime _selectDateHarvest = DateTime.now();
  final ProductSystemRepository _productSystemRepository =
      ProductSystemRepository();
  final FarmRepository _farmRepository = FarmRepository();
  final HarvestRepository _harvestRepository = HarvestRepository();
  List<Farm> listFarms = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductSystem();
    getFarmByFarmerId();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isPress = false;
    images = <Asset>[];
    harvestName = '';
    _selectProductSystem = ProductSystem(
        name: '',
        minPrice: 0,
        maxPrice: 0,
        unit: '',
        province: '',
        productCategoryId: 0);
    _selectFarm = Farm(
        name: '',
        avatar: '',
        image1: '',
        image2: '',
        image3: '',
        image4: '',
        image5: '',
        description: '',
        address: '',
        active: false, totalStar: 0, feedbacks: 0);
    _selectDateStart = DateTime.now();
    _selectDateHarvest = DateTime.now();
    productSystem = [];
    listFarms = [];
    harvestDescription = '';
    isCall = false;
    super.dispose();
  }

  bool isCall = false;

  Future<void> getProductSystem() async {
    var list = (await _productSystemRepository.fetchAllProductSystem(1, 100));
    setState(() {
      productSystem = list.items;
    });
  }

  Future<void> getFarmByFarmerId() async {
    var list =
        await _farmRepository.fetchAllFarmByFarmer(1, 100, widget.farmerId);
    setState(() {
      listFarms = list.items;
    });
  }

  int statusCode = 0;

  Future<void> createNewHarvest() async {
    statusCode = await _harvestRepository.createNewHarvest(
        harvestName,
        productNameChange,
        _listPath,
        harvestDescription,
        _selectDateStart,
        _selectDateHarvest,
        int.parse(estimatedProduction),
        actualProduction != '' ? int.parse(actualProduction) : 0,
        _selectFarm.id as int,
        _selectProductSystem.id as int);
    setState(() {
      if (statusCode == 200) {
        isCall = false;
        UIData.toastMessage("Tạo thành công");
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const HarvestManagementScreen()),
        );
      } else {
        isCall = false;
        UIData.toastMessage("Đã có lỗi xảy ra");
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
              child: SingleChildScrollView(
                  child: Form(
                key: _formKey,
                autovalidateMode: isPress
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  children: [
                    AddNewHarvestHeader(),
                    titleLabelRequired(
                        'Loại sản phẩm', Iconsax.box, Colors.grey, true, false),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: _size.width * 0.9,
                      height: 51,
                      child: DropdownSearch<ProductSystem>(

                          mode: Mode.MENU,
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            controller: _userEditTextController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: "Tìm kiếm sản phẩm",
                              hintStyle: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: Colors.grey),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _userEditTextController.clear();
                                },
                              ),
                            ),
                          ),
                          itemAsString: (item) {
                            return item!.name;
                          },
                          dropdownSearchBaseStyle:
                              TextStyle(color: Colors.redAccent),
                          dropdownSearchDecoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
                            prefix: _selectProductSystem.name == '' ?  const Text('--chọn sản phẩm tương ứng với mùa vụ') : null,
                            prefixStyle: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp,
                              color: Colors.grey),
                            hintTextDirection: TextDirection.ltr,
                            hintText: "--chọn sản phẩm tương ứng với mùa vụ",
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.4))),
                          ),
                          // showSelectedItem: true,
                          items: productSystem,
                          // label: "Menu mode",
                          hint: "--chọn sản phẩm tương ứng với mùa vụ",
                          popupItemDisabled: (ProductSystem s) =>
                              s.name.startsWith('I'),
                          onChanged: (value) {
                            setState(() {
                              _selectProductSystem = value!;
                              // print(_selectProductSystem.id);
                            });
                          },
                          selectedItem: _selectProductSystem),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    isPress && _selectProductSystem.name == ''
                        ? Container(
                            // width: _size.width * 0.45,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            alignment: Alignment.centerLeft,
                            child: Text(
                                'Bạn cần chọn sản phẩm tương ứng với mùa vụ',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.sp,
                                    color: Colors.red[700])),
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    titleLabelRequired('Tên nông trại', Iconsax.house_2,
                        Colors.grey, true, false),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: _size.width * 0.9,
                      height: 51,
                      child: DropdownSearch<Farm>(
                          mode: Mode.MENU,
                          // showSearchBox: true,
                          // searchFieldProps: TextFieldProps(
                          //   controller: _userEditTextController,
                          //   decoration: InputDecoration(
                          //     prefixIcon: Icon(Icons.search),
                          //     suffixIcon: IconButton(
                          //       icon: Icon(Icons.clear),
                          //       onPressed: () {
                          //         _userEditTextController.clear();
                          //       },
                          //     ),
                          //   ),
                          // ),
                          itemAsString: (item) {
                            return item!.name;
                          },
                          // showSelectedItem: true,
                          items: listFarms,
                          // label: "Menu mode",
                          dropdownSearchDecoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                            prefix: _selectFarm.name == '' ?  const Text('--chọn nông trại gieo trồng mùa vụ') : null,
                            prefixStyle: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp,
                                color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.4))),
                          ),
                          // hint: "--chọn sản phẩm tương ứng với mùa vụ",
                          // popupItemDisabled: (Farm s) => s.name.startsWith('I'),
                          onChanged: (value) {
                            setState(() {
                              _selectFarm = value!;
                              // print(_selectFarm.name);
                            });
                          },
                          selectedItem: _selectFarm),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    isPress && _selectFarm.name == ''
                        ? Container(
                            // width: _size.width * 0.45,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            alignment: Alignment.centerLeft,
                            child: Text(
                                'Bạn cần chọn nông trại trồng mùa vụ này',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.sp,
                                    color: Colors.red[700])),
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    titleLabelRequired('Ảnh chi tiết của mùa vụ', Iconsax.image,
                        Colors.grey, true, true),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: !kIsWeb &&
                              defaultTargetPlatform == TargetPlatform.android
                          ? FutureBuilder<void>(
                              future: retrieveMultiLostData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<void> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                  case ConnectionState.waiting:
                                    _listPath = [];
                                    return DottedBorderButton(
                                      color: Colors.blueAccent,
                                      onPressed: () {
                                        _onImageMultiButtonPressed(
                                            ImageSource.gallery,
                                            context: context);
                                      },
                                    );
                                  case ConnectionState.done:
                                    return _handleMultiPreview();
                                  default:
                                    if (snapshot.hasError) {
                                      return DottedBorderButton(
                                        color: Colors.blueAccent,
                                        onPressed: () {
                                          _onImageMultiButtonPressed(
                                              ImageSource.gallery,
                                              context: context);
                                        },
                                      );
                                    } else {
                                      return DottedBorderButton(
                                        color: Colors.blueAccent,
                                        onPressed: () {
                                          _onImageMultiButtonPressed(
                                              ImageSource.gallery,
                                              context: context);
                                        },
                                      );
                                    }
                                }
                              },
                            )
                          : _handleMultiPreview(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    (_imageMultiFileList == null ||
                                _imageMultiFileList == []) &&
                            isPress
                        ? Container(
                            // width: _size.width * 0.45,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            alignment: Alignment.centerLeft,
                            child: Text('Bạn cần chọn tối thiểu 1 ảnh',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.sp,
                                    color: Colors.red[700])),
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    titleLabelRequired('Tên mùa vụ', Iconsax.house_2,
                        Colors.grey, true, false),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPaddingDefault * 2),
                      child: CustomTextField(
                        inputAction: TextInputAction.next,
                        initValue: harvestName,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Bạn cần phải nhập tên mùa vụ';
                          }
                        },
                        isDense: true,
                        hintText: "Nhập tên mùa vụ",
                        onChanged: (value) {
                          harvestName = value.trim();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    titleLabelRequired(
                        'Thông tin mùa vụ',
                        Iconsax.message_question,
                        Color.fromRGBO(255, 210, 95, 1.0),
                        false,
                        false),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 110,
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPaddingDefault * 2),
                      child: CustomTextField(
                        initValue: harvestDescription,
                        isDense: true,
                        maxLines: 50,
                        hintText: "Thêm mô tả về nông trại",
                        onChanged: (value) {
                          harvestDescription = value.trim();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    titleLabelRequired('Tên hiển thị của sản phẩm',
                        Iconsax.edit, Colors.grey, false, false),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPaddingDefault * 2),
                      child: CustomTextField(
                        initValue: productNameChange,
                        isDense: true,
                        hintText: "Nhập tên hiển thị của sản phẩm",
                        onChanged: (value) {
                          productNameChange = value.trim();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    titleLabelRequired('Ngày bắt đầu mùa vụ', Iconsax.timer_1,
                        Colors.grey, true, false),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: _size.width * 0.9,
                      height: 51,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                        color: Colors.grey.withOpacity(0.4),
                                        width: 1,
                                        style: BorderStyle.solid)))),
                        child: Row(
                          children: [
                            _selectDateStart == ''
                                ? Text(
                                    'Chọn ngày bắt đầu mùa vụ',
                                    style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp,
                                        color: Colors.grey),
                                  )
                                : Text(
                                    convertFormatDate(DateTime.parse(
                                        _selectDateStart.toString())),
                                    style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                        color: Colors.black),
                                  ),
                            Spacer(),
                            IconWidget(
                                icon: Iconsax.calendar_1,
                                color: Colors.grey,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600)
                          ],
                        ),
                        onPressed: () async {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          var datePicked =
                              await DatePicker.showSimpleDatePicker(context,
                                  initialDate: _selectDateStart,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2024),
                                  dateFormat: "dd-MMMM-yyyy",
                                  locale: DateTimePickerLocale.en_us,
                                  looping: true,
                                  itemTextStyle: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.sp,
                                      color: Colors.black));
                          setState(() {
                            _selectDateStart = datePicked!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    titleLabelRequired('Ngày thu hoạch dự kiến',
                        Iconsax.timer_start, Colors.grey, true, false),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: _size.width * 0.9,
                      height: 51,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: isPress &&
                                            diffInDays(_selectDateHarvest,
                                                    _selectDateStart) <=
                                                0
                                        ? BorderSide(
                                            color:
                                                Colors.redAccent.withOpacity(1),
                                            width: 1,
                                            style: BorderStyle.solid)
                                        : BorderSide(
                                            color: Colors.grey.withOpacity(0.4),
                                            width: 1,
                                            style: BorderStyle.solid)))),
                        child: Row(
                          children: [
                            _selectDateHarvest == ''
                                ? Text(
                                    'Chọn ngày thu hoạch dự kiến',
                                    style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp,
                                        color: Colors.grey),
                                  )
                                : Text(
                                    convertFormatDate(DateTime.parse(
                                        _selectDateHarvest.toString())),
                                    style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                        color: Colors.black),
                                  ),
                            Spacer(),
                            IconWidget(
                                icon: Iconsax.calendar_1,
                                color: Colors.grey,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600)
                          ],
                        ),
                        onPressed: () async {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          var datePicked =
                              await DatePicker.showSimpleDatePicker(context,
                                  titleText: 'Chọn ngày thu hoạch',
                                  initialDate: _selectDateHarvest,
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2024),
                                  dateFormat: "dd-MMMM-yyyy",
                                  locale: DateTimePickerLocale.en_us,
                                  looping: true,
                                  itemTextStyle: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.sp,
                                      color: Colors.black));
                          setState(() {
                            _selectDateHarvest = datePicked!;
                            print(diffInDays(
                                _selectDateHarvest, _selectDateStart));
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    isPress &&
                            diffInDays(_selectDateHarvest, _selectDateStart) <=
                                0
                        ? Container(
                            // width: _size.width * 0.45,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            alignment: Alignment.centerLeft,
                            child: Text(
                                'Ngày thu hoạch dự kiến phải xảy ra sau ngày bắt đầu',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.sp,
                                    color: Colors.red[700])),
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    titleLabelRequired('Sản lượng thu hoạch dự kiến',
                        Iconsax.box_2, Colors.grey, true, false),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPaddingDefault * 2),
                      child: CustomTextField(
                        keyboardType: TextInputType.number,
                        initValue: estimatedProduction,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Vui lòng điền vào chỗ này';
                          } else if (isPositiveNumber((value)) == false) {
                            return 'Sản lượng phải là số';
                          } else if (isPositiveNumber((value))) {
                            if (value.length == 1 && value.contains('-')) {
                              return 'Sản lượng phải là số';
                            } else {
                              if (num.parse(value) <= 0) {
                                return 'Sản lượng phải lớn hơn 0';
                              }
                            }
                          }
                          // else if(num.parse(value) <= 0){
                          //   return 'Sản lượng phải lớn hơn 0';
                          // }
                        },
                        suffix: Text(_selectProductSystem.unit),
                        suffixStyle: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w500, fontSize: 12.sp,
                            color: Colors.black),
                        isDense: true,
                        hintText: "Nhập sản lượng thu hoạch dự kiến",
                        onChanged: (value) {
                          estimatedProduction = value;
                          // print(harvestName);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    titleLabelRequired('Sản lượng thu hoạch thực tế',
                        Iconsax.box_2, Colors.grey, false, false),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPaddingDefault * 2),
                      child: CustomTextField(
                        keyboardType: TextInputType.number,
                        initValue: actualProduction,
                        validator: (value) {
                          // if (value!.trim().isEmpty) {
                          //   return 'Vui lòng điền vào chỗ này';
                          // } else
                            if (isPositiveNumber((value!.trim())) == false) {
                            return 'Sản lượng phải là số';
                          } else if (isPositiveNumber((value.trim()))) {
                            if (value.length == 1 && value.trim().contains('-')) {
                              return 'Sản lượng phải là số';
                            } else {
                              try{
                                if (num.parse(value.trim()) <= 0) {
                                  return 'Sản lượng phải lớn hơn 0';
                                }
                              }on Exception catch(_){}
                            }
                          }
                          // else if(num.parse(value) <= 0){
                          //   return 'Sản lượng phải lớn hơn 0';
                          // }
                        },
                        suffix: Text(_selectProductSystem.unit),
                        suffixStyle: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w500, fontSize: 12.sp,
                            color: Colors.black),
                        isDense: true,
                        hintText: "Nhập sản lượng thu hoạch thực tế",
                        onChanged: (value) {
                            actualProduction = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.redAccent,
                            ),
                            width: _size.width * 0.4,
                            height: _size.height * 0.065,
                            child: TextButton(
                              onPressed: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                Navigator.pop(context);
                              },
                              child: Text('Hủy bỏ',
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: Colors.white)),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(95, 212, 144, 1.0),
                            ),
                            width: _size.width * 0.4,
                            height: _size.height * 0.065,
                            child: TextButton(
                              onPressed: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Xác nhận'),
                                    content:
                                        const Text('Bạn muốn thêm mùa vụ này?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Không'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'ON');

                                          setState(() {
                                            isPress = true;
                                            isCall = true;
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // If the form is valid, display a snackbar. In the real world,
                                              // you'd often call a server or save the information in a database.
                                              if (_imageMultiFileList != null &&
                                                  _imageMultiFileList!
                                                      .isNotEmpty) {
                                                for (XFile file
                                                    in _imageMultiFileList!) {
                                                  _listPath.add(file.path);
                                                }
                                              }
                                              if (_listPath.isNotEmpty &&
                                                  _selectProductSystem.name !=
                                                      '' &&
                                                  _selectFarm.name != '' &&
                                                  diffInDays(_selectDateHarvest,
                                                          _selectDateStart) >
                                                      0) {
                                                createNewHarvest();
                                              } else {
                                                isCall = false;
                                              }
                                            } else {
                                              isCall = false;
                                            }
                                          });
                                        },
                                        child: const Text('Có'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Text('Xác nhận',
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: Colors.white)),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )),
              inAsyncCall: isCall,
            )),
      ),
      tablet: Scaffold(
        appBar: AppBar(),
      ),
      desktop: Scaffold(
        appBar: AppBar(),
      ),
    );
  }

  int diffInDays(DateTime date1, DateTime date2) {
    return ((date1.difference(date2) -
                    Duration(hours: date1.hour) +
                    Duration(hours: date2.hour))
                .inHours /
            24)
        .round();
  }

  List<XFile>? _imageMultiFileList;
  List<String> _listPath = [];

  set _imageMultiFile(XFile? value) {
    _imageMultiFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageMultiError;
  String? _retrieveMultiDataError;
  final ImagePicker _picker2 = ImagePicker();

  Future<void> _onImageMultiButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    await _displayPickMultiImageDialog(context!,
        (double? maxWidth, double? maxHeight, int? quality) async {
      try {
        final List<XFile>? pickedFileList = await _picker2.pickMultiImage(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );
        setState(() {
          if(pickedFileList!.length > 5){
            UIData.toastMessage('Chỉ được chọn tối đa 5 ảnh');
          }else{
            _imageMultiFileList = pickedFileList;
            // for (XFile file in _imageMultiFileList!) {
            //   _listPath.add(file.path);
            // }
          }
        });
      } catch (e) {
        setState(() {
          _pickImageMultiError = e;
        });
      }
    });
  }

  Text? _getRetrieveMultiErrorWidget() {
    if (_retrieveMultiDataError != null) {
      final Text result = Text(_retrieveMultiDataError!);
      _retrieveMultiDataError = null;
      return result;
    }
    return null;
  }

  Widget _handleMultiPreview() {
    return _previewMultiImages();
  }

  Widget _previewMultiImages() {
    final Text? retrieveError = _getRetrieveMultiErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageMultiFileList != null) {
      return Semantics(
          child: Container(
            height: 100,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              key: UniqueKey(),
              itemBuilder: (BuildContext context, int index) {
                // Why network for web?
                // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
                if (index == _imageMultiFileList!.length - 1) {
                  return Container(
                    // width: 100,
                    child: Row(
                      children: [
                        Semantics(
                            label: 'image_picker_example_picked_image',
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              alignment: Alignment.center,
                              height: 100,
                              width: 100,
                              // width: 100,
                              // color: Colors.redAccent,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(_imageMultiFileList![index].path),
                                  fit: BoxFit.fitWidth,
                                  height: 100,
                                  width: 150,
                                ),
                              ),
                            )),
                        DottedBorderButton(
                          color: Colors.blueAccent,
                          onPressed: () {
                            _onImageMultiButtonPressed(ImageSource.gallery,
                                context: context);
                          },
                        ),
                      ],
                    ),
                  );
                }
                return Semantics(
                    label: 'image_picker_example_picked_image',
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      // width: 100,
                      // color: Colors.redAccent,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(_imageMultiFileList![index].path),
                          fit: BoxFit.fitWidth,
                          height: 100,
                          width: 150,
                        ),
                      ),
                    ));
              },
              itemCount: _imageMultiFileList!.length,
            ),
          ),
          label: 'image_picker_example_picked_images');
    } else if (_pickImageMultiError != null) {
      return DottedBorderButton(
        color: isPress ? Colors.redAccent : Colors.blueAccent,
        onPressed: () {
          _onImageMultiButtonPressed(ImageSource.gallery, context: context);
        },
      );
    } else {
      return DottedBorderButton(
        color: isPress ? Colors.redAccent : Colors.blueAccent,
        onPressed: () {
          _onImageMultiButtonPressed(ImageSource.gallery, context: context);
        },
      );
    }
  }

  Future<void> _displayPickMultiImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    onPick(4000.0, 4000.0, 100);
  }

  Future<void> retrieveMultiLostData() async {
    final LostDataResponse response = await _picker2.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        setState(() {
          _imageMultiFile = response.file;
          _imageMultiFileList = response.files;
        });
      }
    } else {
      _retrieveMultiDataError = response.exception!.code;
    }
  }
}
