import 'dart:async';
import 'dart:io';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/model/harvest.dart';
import 'package:farmer_application/src/feature/repository/harvest_repository.dart';
import 'package:farmer_application/src/feature/screen/farm_management/add_new_farm/components/dotted_border_button.dart';
import 'package:farmer_application/src/feature/screen/farm_management/add_new_farm/components/label_widget.dart';
import 'package:farmer_application/src/feature/screen/fill_account_info/components/custom_text_field.dart';
import 'package:farmer_application/src/feature/screen/harvest_management/harvest_detail/harvest_detail_screen.dart';
import 'package:farmer_application/src/feature/screen/harvest_management/update_harvest/components/update_harvest_header.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/constants/app_uidata.dart';
import 'package:farmer_application/src/share/constants/converts.dart';
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

import '../../../../share/constants/validation.dart';

class UpdateHarvestScreen extends StatefulWidget {
  final int harvestId;

  const UpdateHarvestScreen({Key? key, required this.harvestId}) : super(key: key);

  @override
  _UpdateHarvestScreenState createState() => _UpdateHarvestScreenState();
}

class _UpdateHarvestScreenState extends State<UpdateHarvestScreen> {
  final _harvestRepository = HarvestRepository();
  final _formKey = GlobalKey<FormState>();
  bool isPress = false;
  int statusCode = 0;
  List<Asset> images = <Asset>[];
  String harvestName = '';
  String productNameChange = '';
  String harvestDescription = '';
  String estimatedProduction = '';
  String actualProduction = '';
  DateTime _selectDateHarvest = DateTime.now();
  DateTime _selectDateStart = DateTime.now();
  List<String> listImages = [];
  bool isChangeMultiImage = false;
  bool isCall = true;
  Harvest _harvest = Harvest(name: '', productName: '', image1: '', image2: '', image3: '', image4: '', image5: '',
      description: '', startAt: DateTime.now().toString(), estimatedTime: DateTime.now().toString(), estimatedProduction: 0,
      inventoryTotal: 0, unit: '', farmName: '', categoryName: '', maxPrice: 0, minPrice: 0,
      productSystemName: '', productNameChange: '', actualProduction: 0);

  Future<void> getHarvestById(int harvestId) async {
    _harvest = await _harvestRepository.getHarvestById(harvestId);
    if(mounted){
      setState(() {
        if (_harvest.name != '') {
          isCall = false;
          harvestName = _harvest.name;
          harvestDescription = _harvest.description;
          productNameChange = _harvest.productNameChange;
          estimatedProduction = _harvest.inventoryTotal.toString();
          _selectDateHarvest = DateTime.parse(_harvest.estimatedTime);
          _selectDateStart = DateTime.parse(_harvest.startAt);
          actualProduction = _harvest.actualProduction.toString();
        }
        if (_harvest.image1 != '') {listImages.add(_harvest.image1);}
        if (_harvest.image2 != '') {listImages.add(_harvest.image2);}
        if (_harvest.image3 != '') {listImages.add(_harvest.image3);}
        if (_harvest.image4 != '') {listImages.add(_harvest.image4);}
        if (_harvest.image5 != '') {listImages.add(_harvest.image5);}
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHarvestById(widget.harvestId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isPress = false;
    images = <Asset>[];
    harvestName = '';
    _harvest = Harvest(name: '', productName: '', image1: '', image2: '', image3: '', image4: '', image5: '',
        description: '', startAt: DateTime.now().toString(), estimatedTime: DateTime.now().toString(), estimatedProduction: 0,
        inventoryTotal: 0, unit: '', farmName: '', categoryName: '', maxPrice: 0, minPrice: 0,
        productSystemName: '', productNameChange: '', actualProduction: 0);
    _selectDateHarvest = DateTime.now();
    harvestDescription = '';
    isCall = true;
    super.dispose();
  }

  Future<void> updateHarvest() async {
    statusCode = await _harvestRepository.updateHarvest(widget.harvestId, _listPath != [] ? _listPath : [], harvestName,
        harvestDescription, productNameChange, actualProduction != '' ? int.parse(actualProduction) : 0, _selectDateHarvest);
    setState(() {
      if (statusCode == 200) {
        UIData.toastMessage('Cập nhật thành công');
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HarvestDetailScreen(harvestId: widget.harvestId,)),
        );
      } else {
        isCall = false;
        UIData.toastMessage('Đã có lỗi xảy ra');
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
                autovalidateMode: isPress ? AutovalidateMode.always : AutovalidateMode.disabled,
                child: Column(
                  children: [
                    UpdateHarvestHeader(),
                    titleLabelRequired('Tên sản phẩm', Iconsax.box, Colors.grey, true, false),
                    SizedBox(height: 8,),
                    Container(
                      height: 51,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.withOpacity(0.2)),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(_harvest.productName),
                    ),
                    SizedBox(height: 20,),
                    titleLabelRequired('Tên nông trại', Iconsax.house_2, Colors.grey, true, false),
                    SizedBox(height: 8,),
                    Container(
                      height: 51,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.withOpacity(0.2)),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(_harvest.farmName),
                    ),
                    SizedBox(height: 20,),
                    titleLabelRequired('Ảnh chi tiết của mùa vụ', Iconsax.image, Colors.grey, true, true),
                    TextButton(
                      child: const Text('Chỉnh sửa'),
                      onPressed: () {
                        setState(() {isChangeMultiImage = !isChangeMultiImage;});
                      },
                    ),
                    listImages != [] && isChangeMultiImage == false ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Semantics(
                                child: SizedBox(
                                  height: 130,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Semantics(
                                          label: 'image_picker_example_picked_image',
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 5),
                                            alignment: Alignment.center,
                                            height: 120, width: 160,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.network(listImages[index], fit: BoxFit.fitWidth,
                                                height: 120, width: 180,),
                                            ),
                                          ));
                                    }, itemCount: listImages.length,
                                  ),
                                ), label: 'image_picker_example_picked_images'),
                          ) : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    (_imageMultiFileList == null || _imageMultiFileList == []) && isChangeMultiImage == false ? Container()
                        : Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                            child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android ? FutureBuilder<void>(
                                    future: retrieveMultiLostData(),
                                    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.waiting:
                                          _listPath = [];
                                          return DottedBorderButton(
                                            color: Colors.blueAccent,
                                            onPressed: () {
                                              _onImageMultiButtonPressed(ImageSource.gallery, context: context);
                                            },
                                          );
                                        case ConnectionState.done:return _handleMultiPreview();
                                        default:
                                          if (snapshot.hasError) {
                                            return DottedBorderButton(
                                              color: Colors.blueAccent,
                                              onPressed: () {
                                                _onImageMultiButtonPressed(ImageSource.gallery, context: context);
                                              },
                                            );
                                          } else {
                                            return DottedBorderButton(
                                              color: Colors.blueAccent,
                                              onPressed: () {
                                                _onImageMultiButtonPressed(ImageSource.gallery, context: context);
                                              },
                                            );
                                          }}},) : _handleMultiPreview(),
                          ),
                    SizedBox(height: 15,),
                    (_imageMultiFileList == null || _imageMultiFileList == []) && isPress && isChangeMultiImage
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            alignment: Alignment.centerLeft,
                            child: Text('Bạn cần chọn tối thiểu 1 ảnh',
                                style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                    fontSize: 10.sp, color: Colors.red[700])),) : Container(),
                    SizedBox(height: 20,),
                    titleLabelRequired('Tên mùa vụ', Iconsax.house_2, Colors.grey, true, false),
                    const SizedBox(height: 8,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
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
                        onChanged: (value) {harvestName = value.trim();},
                      ),
                    ),
                    SizedBox(height: 20,),
                    titleLabelRequired('Thông tin mùa vụ', Iconsax.message_question,
                        Color.fromRGBO(255, 210, 95, 1.0), false, false),
                    const SizedBox(height: 10,),
                    Container(
                      height: 110,
                      padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
                      child: CustomTextField(
                        initValue: harvestDescription,
                        isDense: true, maxLines: 50,
                        hintText: "Thêm mô tả về nông trại",
                        onChanged: (value) {harvestDescription = value.trim();},
                      ),
                    ),
                    SizedBox(height: 20,),
                    titleLabelRequired('Tên hiển thị của sản phẩm', Iconsax.edit, Colors.grey, false, false),
                    const SizedBox(height: 8,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
                      child: CustomTextField(
                        initValue: productNameChange, isDense: true,
                        hintText: "Nhập tên hiển thị của sản phẩm",
                        onChanged: (value) {productNameChange = value.trim();},
                      ),
                    ),
                    SizedBox(height: 20,),
                    titleLabelRequired('Ngày bắt đầu mùa vụ', Iconsax.timer_1, Colors.grey, true, false),
                    const SizedBox(height: 8,),
                    Container(
                      height: 51,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.withOpacity(0.2)),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(convertFormatDate(DateTime.parse(_harvest.startAt))),),
                    SizedBox(height: 20,),
                    titleLabelRequired('Ngày thu hoạch dự kiến', Iconsax.timer_start, Colors.grey, true, false),
                    const SizedBox(height: 8,),
                    Container(
                      width: _size.width * 0.9,
                      height: 51,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1, style: BorderStyle.solid)))),
                        child: Row(
                          children: [
                            _selectDateHarvest == '' ? Text('Chọn ngày thu hoạch dự kiến',
                                    style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                        fontSize: 11.sp, color: Colors.grey),) : Text(
                                    convertFormatDate(DateTime.parse(_selectDateHarvest.toString())),
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
                            if (!currentFocus.hasPrimaryFocus) {currentFocus.unfocus();}
                          });
                          var datePicked =
                              await DatePicker.showSimpleDatePicker(context,
                                  initialDate: _selectDateHarvest,
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2024),
                                  dateFormat: "dd-MMMM-yyyy",
                                  locale: DateTimePickerLocale.en_us,
                                  looping: true,
                                  itemTextStyle: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w500,
                                      fontSize: 13.sp, color: Colors.black));
                          setState(() {_selectDateHarvest = datePicked!;});
                        },
                      ),
                    ),
                    isPress && diffInDays(_selectDateHarvest, _selectDateStart) <= 0 ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            alignment: Alignment.centerLeft,
                            child: Text('Ngày thu hoạch dự kiến phải xảy ra sau ngày bắt đầu',
                                style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
                                    fontSize: 10.sp, color: Colors.red[700])),) : Container(),
                    SizedBox(height: 20,),
                    titleLabelRequired('Sản lượng thu hoạch dự kiến', Iconsax.box_2, Colors.grey, true, false),
                    const SizedBox(height: 8,),
                    Container(
                      height: 51,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.withOpacity(0.2)),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(_harvest.estimatedProduction.toString()),),
                    SizedBox(height: 20,),
                    titleLabelRequired('Sản lượng thu hoạch thực tế', Iconsax.box_2, Colors.grey, false, false),
                    const SizedBox(height: 8,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
                      child: CustomTextField(
                        keyboardType: TextInputType.number,
                        // initValue: actualProduction == '0' ? 'Chưa có' : actualProduction,
                        initValue: actualProduction,
                        validator: (value) {
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
                        },
                        isDense: true,
                        hintText: "Nhập sản lượng thu hoạch thực tế",
                        onChanged: (value) {actualProduction = value;},
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.redAccent,),
                            width: _size.width * 0.4, height: _size.height * 0.065,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                });
                                Navigator.pop(context);
                              },
                              child: Text('Hủy bỏ',
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                      fontSize: 12.sp, color: Colors.white)),)),
                        SizedBox(width: 10,),
                        Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(95, 212, 144, 1.0),),
                            width: _size.width * 0.4, height: _size.height * 0.065,
                            child: TextButton(
                              onPressed: () {
                               setState(() {
                                 FocusScopeNode currentFocus = FocusScope.of(context);
                                 if (!currentFocus.hasPrimaryFocus) {
                                   currentFocus.unfocus();
                                 }
                               });
                                showDialog<String>(context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Xác nhận'),
                                    content: const Text('Bạn muốn cập nhật mùa vụ này?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, 'Cancel'),
                                        child: const Text('Không'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'ON');
                                          setState(() {
                                            isPress = true;
                                            isCall = true;
                                            if (_formKey.currentState!.validate()) {
                                              // If the form is valid, display a snackbar. In the real world,
                                              // you'd often call a server or save the information in a database.
                                              if (_imageMultiFileList != null && _imageMultiFileList!.isNotEmpty) {
                                                for (XFile file in _imageMultiFileList!) {
                                                  _listPath.add(file.path);
                                                }
                                              }
                                              if (diffInDays(_selectDateHarvest, _selectDateStart) <= 0) {
                                                isCall = false;
                                              } else {
                                                if (_listPath == [] && isChangeMultiImage) {
                                                  isCall = false;
                                                } else {updateHarvest();}
                                              }
                                            } else {isCall = false;}
                                          });
                                        },
                                        child: const Text('Có'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Text('Xác nhận',
                                  style: TextStyle(fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600,
                                      fontSize: 12.sp, color: Colors.white)),)),
                      ],
                    ),
                    SizedBox(height: 30,),
                  ],
                ),
              )), inAsyncCall: isCall,
            )),
      ),
      tablet: Scaffold(appBar: AppBar(),),
      desktop: Scaffold(appBar: AppBar(),),);
  }

  int diffInDays(DateTime date1, DateTime date2) {
    return ((date1.difference(date2) - Duration(hours: date1.hour) + Duration(hours: date2.hour)).inHours / 24).round();
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
    await _displayPickMultiImageDialog(context!, (double? maxWidth, double? maxHeight, int? quality) async {
      try {
        final List<XFile>? pickedFileList = await _picker2.pickMultiImage(
          maxWidth: maxWidth, maxHeight: maxHeight, imageQuality: quality,);
        setState(() {
          if(pickedFileList!.length > 5){
            UIData.toastMessage('Chỉ được chọn tối đa 5 ảnh');
          }else{
            _imageMultiFileList = pickedFileList;
            for (XFile file in _imageMultiFileList!) {
              _listPath.add(file.path);
            }
          }
        });
      } catch (e) {
        setState(() {_pickImageMultiError = e;});
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
                if (index == _imageMultiFileList!.length - 1) {
                  return Container(
                    child: Row(
                      children: [
                        Semantics(
                            label: 'image_picker_example_picked_image',
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              alignment: Alignment.center, height: 100, width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(_imageMultiFileList![index].path), fit: BoxFit.fitWidth, height: 100, width: 150,),
                              ),
                            )),
                        DottedBorderButton(
                          color: Colors.blueAccent,
                          onPressed: () {_onImageMultiButtonPressed(ImageSource.gallery, context: context);},
                        ),
                      ],
                    ),
                  );
                }
                return Semantics(
                    label: 'image_picker_example_picked_image',
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center, height: 100, width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(File(_imageMultiFileList![index].path),
                          fit: BoxFit.fitWidth, height: 100, width: 150,),
                      ),
                    ));
              }, itemCount: _imageMultiFileList!.length,
            ),), label: 'image_picker_example_picked_images');
    } else if (_pickImageMultiError != null) {
      return DottedBorderButton(
        color: isPress ? Colors.redAccent : Colors.blueAccent,
        onPressed: () {_onImageMultiButtonPressed(ImageSource.gallery, context: context);},
      );
    } else {
      return DottedBorderButton(
        color: isPress ? Colors.redAccent : Colors.blueAccent,
        onPressed: () {_onImageMultiButtonPressed(ImageSource.gallery, context: context);},
      );
    }
  }

  Future<void> _displayPickMultiImageDialog(BuildContext context, OnPickImageCallback onPick) async {
    onPick(4000.0, 4000.0, 100);
  }

  Future<void> retrieveMultiLostData() async {
    final LostDataResponse response = await _picker2.retrieveLostData();
    if (response.isEmpty) {return;}
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        setState(() {
          _imageMultiFile = response.file;
          _imageMultiFileList = response.files;
        });
      }
    } else {_retrieveMultiDataError = response.exception!.code;}
  }
}
