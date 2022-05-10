import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/model/harvest_in_campaign.dart';
import 'package:farmer_application/src/feature/repository/harvest_in_campaign_repository.dart';
import 'package:farmer_application/src/feature/screen/farm_management/add_new_farm/components/label_widget.dart';
import 'package:farmer_application/src/feature/screen/fill_account_info/components/custom_text_field.dart';
import 'package:farmer_application/src/feature/screen/harvest_in_campaign/update_harvest_in_campaign/components/update_harvest_in_campaign_header.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/constants/validation.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class UpdateHarvestInCampaignScreen extends StatefulWidget {
  final int harvestInCampaignId;

  const UpdateHarvestInCampaignScreen(
      {Key? key, required this.harvestInCampaignId})
      : super(key: key);

  @override
  _UpdateHarvestInCampaignScreenState createState() =>
      _UpdateHarvestInCampaignScreenState();
}

class _UpdateHarvestInCampaignScreenState
    extends State<UpdateHarvestInCampaignScreen> {
  final _formKey = GlobalKey<FormState>();
  final _harvestInCampaignRepository = HarvestInCampaignRepository();
  HarvestInCampaignDetail _harvestInCampaign = HarvestInCampaignDetail(
      image1: '',
      image2: '',
      image3: '',
      image4: '',
      image5: '',
      harvestName: '',
      productName: '',
      productSystemName: '',
      productCategoryName: '',
      price: 0,
      unit: '',
      valueChangeOfUnit: 0,
      inventory: 0,
      quantity: 0,
      status: '',
      harvestDescription: '',
      harvestId: 0,
      campaignName: '',
      farmName: '',
      campaignId: 0);
  bool isCall = true;
  List<String> listImages = [];
  bool isPress = false;
  num _currentSliderValue = 0;
  bool isChange = false;
  String productName = '';
  String inventory = '0';
  String unit = '';
  num valueChange = 0;

  Future<void> getHarvestById(int harvestInCampaignId) async {
    _harvestInCampaign = await _harvestInCampaignRepository
        .getHarvestInCampaignById(harvestInCampaignId);
    setState(() {
      if (_harvestInCampaign.productName != '') {
        _currentSliderValue = _harvestInCampaign.price;
        productName = _harvestInCampaign.productName;
        inventory = _harvestInCampaign.inventory.toString();
        // unit = _harvestInCampaign.unit;
      }
      if (_harvestInCampaign.image1 != '') {
        listImages.add(_harvestInCampaign.image1);
      }
      if (_harvestInCampaign.image2 != '') {
        listImages.add(_harvestInCampaign.image2);
      }
      if (_harvestInCampaign.image3 != '') {
        listImages.add(_harvestInCampaign.image3);
      }
      if (_harvestInCampaign.image4 != '') {
        listImages.add(_harvestInCampaign.image4);
      }
      if (_harvestInCampaign.image5 != '') {
        listImages.add(_harvestInCampaign.image5);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHarvestById(widget.harvestInCampaignId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _harvestInCampaign = HarvestInCampaignDetail(
        image1: '',
        image2: '',
        image3: '',
        image4: '',
        image5: '',
        harvestName: '',
        productName: '',
        productSystemName: '',
        productCategoryName: '',
        price: 0,
        unit: '',
        valueChangeOfUnit: 0,
        inventory: 0,
        quantity: 0,
        status: '',
        harvestDescription: '',
        harvestId: 0,
        campaignName: '',
        farmName: '',
        campaignId: 0);
    isCall = true;
    List<String> listImages = [];
    isPress = false;
    _currentSliderValue = 0;
    isChange = false;
    productName = '';
    inventory = '0';
    unit = '';
    valueChange = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: isPress
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  children: [
                    const UpdateHarvestInCampaignHeader(),
                    titleLabel('Chiến dịch', Iconsax.status, Colors.grey),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 51,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        _harvestInCampaign.campaignName,
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    titleLabel('Nông trại', Iconsax.house_2, Colors.grey),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 51,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        _harvestInCampaign.farmName,
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    titleLabel('Mùa vụ', Iconsax.sun_1, Colors.grey),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 51,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        _harvestInCampaign.harvestName,
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    titleLabel('Sản phẩm', Iconsax.box_1, Colors.grey),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 51,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        _harvestInCampaign.productSystemName,
                        style: TextStyle(
                            fontFamily: 'BeVietnamPro',
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    titleLabel(
                        'Tên hiển thị của sản phẩm', Iconsax.edit, Colors.grey),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPaddingDefault * 2),
                      child: CustomTextField(
                        inputAction: TextInputAction.next,
                        initValue: productName,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Vui lòng điền vào chỗ này';
                          }
                        },
                        border: BorderSide(
                            color: Colors.grey.withOpacity(0.4),
                            width: 1,
                            style: BorderStyle.solid),
                        isDense: true,
                        hintText: "Nhập tổng kho",
                        onChanged: (value) {
                          productName = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        titleLabelRequired('Tổng kho', Iconsax.box_1,
                            Colors.grey, true, false),
                        SizedBox(
                          width: 5,
                        ),
                        Text("(" + _harvestInCampaign.unit + ")",
                            style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp,
                                color: Colors.black))
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPaddingDefault * 2),
                      child: CustomTextField(
                        initValue: inventory.toString(),
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
                        },
                        border: isPress &&
                            ((num.parse(inventory) != 0
                                ? num.parse(inventory)
                                : 0) >
                                (_harvestInCampaign.inventory) ||
                                num.parse(inventory) == 0)
                            ? BorderSide(
                            color: Colors.red,
                            width: 1,
                            style: BorderStyle.solid)
                            : BorderSide(
                            color: Colors.grey.withOpacity(0.4),
                            width: 1,
                            style: BorderStyle.solid),
                        keyboardType: TextInputType.number,
                        isDense: true,
                        hintText: "Nhập tổng kho",
                        onChanged: (value) {
                          // inventory = num.parse(value);
                          inventory = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    isPress &&
                        (num.parse(inventory) != 0
                            ? num.parse(inventory)
                            : 0) >
                            _harvestInCampaign.inventory
                        ? Container(
                      // width: _size.width * 0.45,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.centerLeft,
                      child: Text(
                          'Số lượng đăng bán phải nhỏ hơn số lượng hàng hiện có',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w400,
                              fontSize: 10.sp,
                              color: Colors.red[700])),
                    )
                        : Container(),
                    isPress && inventory == 0
                        ? Container(
                      // width: _size.width * 0.45,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.centerLeft,
                      child: Text('Tổng kho phải lớn hơn 0',
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w400,
                              fontSize: 10.sp,
                              color: Colors.red[700])),
                    )
                        : Container(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        titleLabelRequired('Gía sản phẩm', Iconsax.money,
                            Colors.grey, true, false),
                        Container(
                            width: 100,
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    isChange = !isChange;
                                  });
                                },
                                child: Text('Chỉnh sửa')))
                      ],
                    ),

                    // SizedBox(height: 5,),
                    isChange == false
                        ? Container(
                            height: 51,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              _harvestInCampaign.price.toString() +
                                  " vnd/" +
                                  _harvestInCampaign.unit,
                              style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: Colors.black),
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      width: _size.width * 0.15,
                                      color: const Color.fromRGBO(
                                          231, 221, 221, 0.62),
                                      child: Text('100000',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color: const Color.fromRGBO(
                                                  61, 55, 55, 1.0))),
                                    ),
                                    _currentSliderValue != 0
                                        ? Container(
                                            width: _size.width * 0.59,
                                            child: Slider(
                                              value: 120000,
                                              // (_harvestInCampaign.unit != "Kg" && _harvestInCampaign.unit != "Cành")
                                              // ? _currentSliderValue / _harvestInCampaign.valueChangeOfUnit : double.parse(_currentSliderValue.toString()),
                                              min: 100000,
                                              max: 200000,
                                              divisions: int.parse(
                                                  (((200000 - 100000) / 1000)
                                                          .round())
                                                      .toString()),
                                              label: _currentSliderValue
                                                  .round()
                                                  .toString(),
                                              onChanged: (double value) {
                                                setState(() {

                                                  _currentSliderValue = value;
                                                  // price = _currentSliderValue.toString() + " vnd";
                                                });

                                                // print(price);
                                              },
                                            ),
                                          )
                                        : Container(
                                            width: _size.width * 0.59,
                                            child: Slider(
                                              value: 1,
                                              min: 0,
                                              max: 10,
                                              divisions: 1,
                                              label: _currentSliderValue
                                                  .round()
                                                  .toString(),
                                              onChanged: (double value) {
                                                // setState(() {
                                                //   _currentSliderValue = value;
                                                //   // price = _currentSliderValue.toString() + " vnd";
                                                // });

                                                // print(price);
                                              },
                                            ),
                                          ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      width: _size.width * 0.15,
                                      color: const Color.fromRGBO(
                                          231, 221, 221, 0.62),
                                      child: Text('200000',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color: const Color.fromRGBO(
                                                  61, 55, 55, 1.0))),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 8),
                                      // width: _size.width * 0.15,
                                      color: const Color.fromRGBO(
                                          231, 221, 221, 0.62),
                                      child: Text(
                                          _currentSliderValue
                                                  .round()
                                                  .toString() +
                                              'vnd',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color: const Color.fromRGBO(
                                                  61, 55, 55, 1.0))),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text('/',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              color: Colors.black)),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      width: _size.width * 0.15,
                                      color: const Color.fromRGBO(
                                          231, 221, 221, 0.62),
                                      child: Text(_harvestInCampaign.unit,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color: const Color.fromRGBO(
                                                  61, 55, 55, 1.0))),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    isChange
                        ? Container(
                            width: _size.width * 0.9,
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Quy đổi ',
                                    style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: Colors.white)),
                              ],
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    isChange
                        ? Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Đơn vị quy đổi',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'BeVietnamPro',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11.sp,
                                            color: const Color.fromRGBO(
                                                61, 55, 55, 1.0))),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 5),
                                      // width: _size.width * 0.15,
                                      // color: const Color.fromRGBO(
                                      //     231, 221, 221, 0.62),
                                      child: Row(
                                        children: [
                                          Text('1',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'BeVietnamPro',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color: const Color.fromRGBO(
                                                      61, 55, 55, 1.0))),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                              color: Colors.white,
                                              width: 80,
                                              // height: 30,
                                              child: TextFormField(
                                                controller:
                                                    TextEditingController
                                                        .fromValue(
                                                  TextEditingValue(
                                                    text: unit,
                                                    selection:
                                                        TextSelection.collapsed(
                                                            offset:
                                                                unit.length),
                                                  ),
                                                ),
                                                textInputAction: TextInputAction.next,
                                                textAlign: TextAlign.center,
                                                validator: isChange ? (value){
                                                  if(value!.trim().isEmpty){
                                                    return "Vui lòng điền\nvào chỗ này";
                                                  }
                                                } : null,
                                                onChanged: (value) {
                                                  unit = value;
                                                },
                                              ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  alignment: Alignment.center,
                                  // padding:
                                  //     const EdgeInsets.symmetric(horizontal: 5),
                                  child: IconWidget(
                                    icon: Iconsax.arrow_swap_horizontal,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Đơn vị tương ứng',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'BeVietnamPro',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11.sp,
                                            color: const Color.fromRGBO(
                                                61, 55, 55, 1.0))),
                                    // const SizedBox(
                                    //   height: 5,
                                    // ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 8),
                                      // width: _size.width * 0.15,
                                      // color: const Color.fromRGBO(
                                      //     231, 221, 221, 0.62),
                                      child: Row(
                                        children: [
                                          Container(
                                              color: Colors.white,
                                              width: 85,
                                              // height: 30,
                                              child: TextFormField(
                                                controller:
                                                    TextEditingController
                                                        .fromValue(
                                                  TextEditingValue(
                                                    text:
                                                        valueChange.toString(),
                                                    selection:
                                                        TextSelection.collapsed(
                                                            offset: valueChange
                                                                .toString()
                                                                .length),
                                                  ),
                                                ),
                                                textInputAction: TextInputAction.next,
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.number,
                                                validator: isChange ? (value){
                                                  if (value!.trim().isEmpty) {
                                                    return 'Vui lòng điền\nvào chỗ này';
                                                  } else if (isPositiveNumber((value)) == false) {
                                                    return 'Giá trị phải\nlà số';
                                                  } else if (isPositiveNumber((value))) {
                                                    if (value.length == 1 && value.contains('-')) {
                                                      return 'Giá trị phải\nlà số';
                                                    } else {
                                                      if (num.parse(value) <= 0) {
                                                        return 'Giá trị phải\nlớn hơn 0';
                                                      }
                                                    }
                                                  }
                                                } : null,
                                                onChanged: (value) {
                                                  valueChange =
                                                      num.parse(value);
                                                },
                                              )),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text('kg',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'BeVietnamPro',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color: const Color.fromRGBO(
                                                      61, 55, 55, 1.0)))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  // padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text('/',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'BeVietnamPro',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                          color: Colors.black)),
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Giá sản phẩm',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'BeVietnamPro',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11.sp,
                                            color: const Color.fromRGBO(
                                                61, 55, 55, 1.0))),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 3),
                                      width: 90,
                                      // width: _size.width * 0.15,
                                      color:
                                          Color.fromRGBO(231, 221, 221, 0.62),
                                      child: Text(
                                          (_currentSliderValue * valueChange)
                                                  .round()
                                                  .toString() +
                                              ' vnd',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 11.sp,
                                              color: const Color.fromRGBO(
                                                  61, 55, 55, 1.0))),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(),


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
                                setState(() {
                                  isPress = true;
                                  if (_formKey.currentState!.validate()) {
                                    print(widget.harvestInCampaignId);
                                    if (productName != '') {
                                      print(productName);
                                    } else {
                                      print(_harvestInCampaign.productName);
                                    }
                                    if (isChange && unit != '') {
                                      print(unit);
                                    } else {
                                      print(_harvestInCampaign.unit);
                                    }
                                    if (isChange && valueChange != 0) {
                                      print(valueChange);
                                    } else {
                                      print(0);
                                    }
                                    print(inventory);
                                    if (isChange &&
                                        unit != '' &&
                                        valueChange != 0) {
                                      print(_currentSliderValue * valueChange);
                                    } else {
                                      print(_harvestInCampaign.price);
                                    }
                                    print(_harvestInCampaign.harvestId);
                                    print(_harvestInCampaign.campaignId);
                                  }
                                });
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
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        tablet: SafeArea(
          child: Scaffold(
            appBar: AppBar(),
          ),
        ),
        desktop: SafeArea(
          child: Scaffold(
            appBar: AppBar(),
          ),
        ));
  }
}

Widget titleLabel(String title, IconData icon, Color iconColor) {
  return Container(
    // width: _size.width * 0.9,
    padding: EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
    alignment: Alignment.centerLeft,
    child: Row(
      children: [
        IconWidget(
            icon: icon,
            color: iconColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700),
        SizedBox(
          width: 5,
        ),
        Text(title,
            style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: Color.fromRGBO(61, 55, 55, 1.0))),
        Text(':',
            style: TextStyle(
                fontFamily: 'BeVietnamPro',
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: Colors.black.withOpacity(0.5))),
      ],
    ),
  );
}
