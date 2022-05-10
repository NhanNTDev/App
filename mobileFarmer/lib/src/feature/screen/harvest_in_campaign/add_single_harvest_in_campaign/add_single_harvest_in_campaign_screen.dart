import 'package:dropdown_search/dropdown_search.dart';
import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/model/farm.dart';
import 'package:farmer_application/src/feature/model/harvest.dart';
import 'package:farmer_application/src/feature/model/harvest_in_campaign.dart';
import 'package:farmer_application/src/feature/repository/farm_repository.dart';
import 'package:farmer_application/src/feature/repository/harvest_in_campaign_repository.dart';
import 'package:farmer_application/src/feature/repository/harvest_repository.dart';
import 'package:farmer_application/src/feature/screen/campaign_apply_request/campaign_apply_request_screen.dart';
import 'package:farmer_application/src/feature/screen/fill_account_info/components/custom_text_field.dart';
import 'package:farmer_application/src/feature/screen/harvest_in_campaign/harvest_in_campaign_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/constants/app_uidata.dart';
import 'package:farmer_application/src/share/constants/validation.dart';
import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
import 'package:farmer_application/src/share/widget/stateless/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

import 'components/add_new_harvest_in_campaign_header.dart';

class AddSingleHarvestInCampaignScreen extends StatefulWidget {
  // final List<HarvestInCampaign> listProducts;
  final int campaignId;
  final int farmId;
  final String farmName;
  final String campaignName;

  const AddSingleHarvestInCampaignScreen(
      {Key? key,
      // required this.listProducts,
      required this.campaignId,
      required this.farmId,
      required this.farmName,
      required this.campaignName})
      : super(key: key);

  @override
  _AddSingleHarvestInCampaignScreenState createState() =>
      _AddSingleHarvestInCampaignScreenState();
}

class _AddSingleHarvestInCampaignScreenState
    extends State<AddSingleHarvestInCampaignScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isPress = false;
  List<String> listImages = [];

  HarvestSuggest _selectHarvest = HarvestSuggest(id: 0, name: '');
  double _currentSliderValue = 0;
  bool isChange = false;
  String image =
      'https://dacnguyen.vn/wp-content/uploads/2021/10/5-tac-dung-cua-dau-tay.jpg';
  String harvestName = '';
  String productName = '';
  String productNameDisplay = 'Dâu tây loại 1';
  String unitChange = '';
  int valueChange = 0;
  String priceChange = '';
  int inventory = 0;

  List<HarvestSuggest> listHarvests = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getListFarmCanJoin();
    getListHarvestInFarm(widget.farmId, widget.campaignId);
    print(widget.campaignId);
    // print(widget.campaignName);
    print(widget.farmId);
    // print(widget.farmName);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isPress = false;
    _selectHarvest = HarvestSuggest(id: 0, name: '');
    harvestName = '';
    productName = '';
    isChange = false;
    listHarvests = [];
    isCall = false;
    listRequests = [];
    super.dispose();
  }

  int statusCode = 0;
  final _harvestInCampaignRepository = HarvestInCampaignRepository();
  List<CreateHarvestInCampaign> listRequests = [];

  Future<void> createHarvestInCampaign() async {
    statusCode = await _harvestInCampaignRepository
        .createListHarvestInCampaign(listRequests);
    setState(() {
      if (statusCode == 200) {
        UIData.toastMessage("Đăng kí thành công");
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  HarvestInCampaignScreen(campaignId: widget.campaignId, farmId: widget.farmId, farmName: widget.farmName, status: "Sắp mở bán", campaignName: widget.campaignName)),
        );
      } else {
        print("tạo thất bại");
      }
    });
  }

  Harvest _harvest = Harvest(
    image1: '',
    image2: '',
    image3: '',
    image4: '',
    image5: '',
    name: '',
    farmName: '',
    productName: '',
    startAt: '',
    estimatedTime: '',
    estimatedProduction: 0,
    unit: '',
    categoryName: '',
    inventoryTotal: 0,
    description: '',
    maxPrice: 0,
    minPrice: 0,
    productSystemName: '', productNameChange: '', actualProduction: 0,
  );

  final _harvestRepository = HarvestRepository();
  bool isCall = false;

  Future<void> getListHarvestInFarm(int farmId, int campaignId) async {
    if (listHarvests.isNotEmpty) {
      setState(() {
        listHarvests.clear();
        _selectHarvest = HarvestSuggest(id: 0, name: '');
        _currentSliderValue = 0;
        _harvest = Harvest(
          image1: '',
          image2: '',
          image3: '',
          image4: '',
          image5: '',
          name: '',
          farmName: '',
          productName: '',
          startAt: '',
          estimatedTime: '',
          estimatedProduction: 0,
          unit: '',
          categoryName: '',
          inventoryTotal: 0,
          description: '',
          maxPrice: 10,
          minPrice: 0,
          productSystemName: '', productNameChange: '', actualProduction: 0,
        );
      });
    }
    var list = await _harvestRepository.getHarvestSuggestByFarm(farmId, campaignId);
    setState(() {
      isCall = false;
      listHarvests = list;
      if(listHarvests.isNotEmpty){
        isCall = false;
      }
    });
  }

  Future<void> getHarvestById(int? harvestId) async {
    _harvest = await _harvestRepository.getHarvestById(harvestId!);
    setState(() {
      if (_harvest.name != '') {
        isCall =false;
        _currentSliderValue = double.parse(_harvest.minPrice.toString());
        // isLoading = false;
      }
      if (_harvest.image1 != '') {
        listImages.add(_harvest.image1);
      }
      if (_harvest.image2 != '') {
        listImages.add(_harvest.image2);
      }
      if (_harvest.image3 != '') {
        listImages.add(_harvest.image3);
      }
      if (_harvest.image4 != '') {
        listImages.add(_harvest.image4);
      }
      if (_harvest.image5 != '') {
        listImages.add(_harvest.image5);
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
            inAsyncCall: isCall,
            child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode:
                  isPress ? AutovalidateMode.always : AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      const AddNewHarvestInCampaignHeader(),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        // width: _size.width * 0.63,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.campaignName,
                          style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        // width: _size.width * 0.63,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconWidget(
                                icon: Iconsax.house_2,
                                color: Colors.grey,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Nông trại tham gia',
                              style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: Colors.black),
                            ),
                            Text(
                              ':',
                              style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.farmName,
                              style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      listImages.isNotEmpty
                          ? Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        // height: MediaQuery.of(context).size.height * .65,
                        height: MediaQuery.of(context).size.height * .25,
                        child: ImageSlideshow(
                            width: double.infinity,
                            indicatorPosition: 10,
                            // height: 200,
                            height: 250,
                            initialPage: 0,
                            indicatorColor: Colors.blue,
                            indicatorBackgroundColor: Colors.white,
                            // onPageChanged: (value) {
                            //   debugPrint('Page changed: $value');
                            // },
                            autoPlayInterval: 5000,
                            isLoop: true,
                            children: listImages
                                .map(
                                  (item) => ClipRRect(
                                child: Image.network(
                                  item,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                                .toList()),
                      )
                          : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        // height: MediaQuery.of(context).size.height * .65,
                        height: MediaQuery.of(context).size.height * .25,
                        width: MediaQuery.of(context).size.width * .8,
                      ),



                      SizedBox(
                        height:15,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        // width: _size.width * 0.9,
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPaddingDefault * 2),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            IconWidget(
                                icon: Iconsax.sun_1,
                                color: Colors.grey,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Mùa vụ',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: const Color.fromRGBO(61, 55, 55, 1.0))),
                            Text('*',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                    color: Colors.redAccent)),
                            Text(':',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: Colors.black.withOpacity(0.5))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: _size.width * 0.9,
                        height: 51,
                        child: DropdownSearch<HarvestSuggest>(
                            mode: Mode.MENU,
                            itemAsString: (item) {
                              return item!.name;
                            },
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                              hintText: "--chọn sản phẩm tương ứng với mùa vụ",
                              prefix: _selectHarvest.name == '' ?  const Text('--chọn mùa vụ tương ứng với sản phẩm') : null,
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
                            // showSelectedItem: true,
                            items: listHarvests,
                            // label: "Menu mode",
                            hint: "--chọn sản phẩm tương ứng với mùa vụ",
                            popupItemDisabled: (HarvestSuggest s) =>
                                s.name.startsWith('I'),
                            onChanged: (value) {
                              setState(() {
                                _selectHarvest = value!;
                                listImages.clear();
                                isCall = true;
                                getHarvestById(_selectHarvest.id);
                                // productName = _selectHarvest.productSystemName;
                                // print(_selectProductSystem.id);
                              });
                            },
                            selectedItem: _selectHarvest),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      isPress && _selectHarvest.name == ''
                          ? Container(
                        // width: _size.width * 0.45,
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        alignment: Alignment.centerLeft,
                        child: Text('Vui lòng chọn chỗ này',
                            style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w400,
                                fontSize: 10.sp,
                                color: Colors.red[700])),
                      )
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // width: _size.width * 0.9,
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPaddingDefault * 2),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            IconWidget(
                                icon: Iconsax.box,
                                color: Colors.grey,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Loại sản phẩm',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: const Color.fromRGBO(61, 55, 55, 1.0))),
                            Text('*',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                    color: Colors.redAccent)),
                            Text(':',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: Colors.black.withOpacity(0.5))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPaddingDefault * 2),
                        child: CustomTextField(
                          initValue: _harvest.productSystemName,
                          enable: false,
                          isDense: true,
                          hintText: "--sản phẩm tương ứng với mùa vụ",
                          onChanged: (value) {
                            // farmName = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        // width: _size.width * 0.9,
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPaddingDefault * 2),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            IconWidget(
                                icon: Iconsax.edit,
                                color: Colors.grey,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Số lượng sản phẩm hiện có: ',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: const Color.fromRGBO(61, 55, 55, 1.0))),
                            Text('*',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                    color: Colors.redAccent)),
                            Text(':',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: Colors.black.withOpacity(0.5))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPaddingDefault * 2),
                        child: CustomTextField(
                          initValue: _harvest.inventoryTotal.toString() +
                              ' ' +
                              _harvest.unit,
                          enable: false,
                          isDense: true,
                          hintText: "--số lượng sản phẩm hiện có",
                          onChanged: (value) {
                            // farmName = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        // width: _size.width * 0.9,
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPaddingDefault * 2),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            IconWidget(
                                icon: Iconsax.edit,
                                color: Colors.grey,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Số lượng sản phẩm cho phép đăng bán',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: const Color.fromRGBO(61, 55, 55, 1.0))),
                            Text('*',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                    color: Colors.redAccent)),
                            Text(':',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: Colors.black.withOpacity(0.5))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPaddingDefault * 2),
                        child: CustomTextField(
                          initValue: _harvest.inventoryTotal.toString() +
                              ' ' +
                              _harvest.unit,
                          enable: false,
                          isDense: true,
                          hintText: "--số lượng sản phẩm hiện có",
                          onChanged: (value) {
                            // farmName = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        // width: _size.width * 0.9,
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPaddingDefault * 2),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            IconWidget(
                                icon: Iconsax.directbox_default,
                                color: Colors.grey,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Tổng kho (${_harvest.unit})',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: const Color.fromRGBO(61, 55, 55, 1.0))),
                            Text('*',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                    color: Colors.redAccent)),
                            Text(':',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: Colors.black.withOpacity(0.5))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPaddingDefault * 2),
                        child: CustomTextField(
                          inputAction: TextInputAction.done,
                          initValue: inventory.toString(),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Vui lòng điền vào chỗ này';
                            }else if (isPositiveNumber((value)) == false) {
                              return 'Tổng kho phải là số';
                            } else if (isPositiveNumber((value))) {
                              if (value.length == 1 && value.contains('-')) {
                                return 'Tổng kho phải là số';
                              } else {
                                if (num.parse(value) <= 0) {
                                  return 'Tổng kho phải lớn hơn 0';
                                }
                              }
                            }
                          },
                          border: isPress &&
                              ((inventory != 0 ? inventory : 0) >
                                  (_harvest.inventoryTotal) || inventory == 0)? BorderSide(color: Colors.red, width: 1, style: BorderStyle.solid):BorderSide(color: Colors.grey.withOpacity(0.4), width: 1, style: BorderStyle.solid),
                          keyboardType: TextInputType.number,
                          isDense: true,
                          hintText: "Nhập tổng kho",
                          onChanged: (value) {
                            inventory = int.parse(value);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      isPress &&
                          (inventory != 0 ? inventory : 0) >
                              (_harvest.inventoryTotal)
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
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        // width: _size.width * 0.9,
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPaddingDefault * 2),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            IconWidget(
                                icon: Iconsax.money,
                                color: Colors.grey,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Giá sản phẩm',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: const Color.fromRGBO(61, 55, 55, 1.0))),
                            Text('*',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                    color: Colors.redAccent)),
                            Text(':',
                                style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: Colors.black.withOpacity(0.5))),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              width: _size.width * 0.15,
                              color: const Color.fromRGBO(231, 221, 221, 0.62),
                              child: Text(_harvest.minPrice.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: const Color.fromRGBO(61, 55, 55, 1.0))),
                            ),
                            _currentSliderValue != 0
                                ? Container(
                              width: _size.width * 0.59,
                              child: Slider(
                                value: double.parse(
                                    _currentSliderValue.toString()),
                                min: double.parse(_harvest.minPrice.toString()),
                                max: double.parse(_harvest.maxPrice.toString()),
                                divisions: int.parse(
                                    (((_harvest.maxPrice - _harvest.minPrice) /
                                        1000)
                                        .round())
                                        .toString()),
                                label: _currentSliderValue.round().toString(),
                                onChanged: (double value) {
                                  setState(() {
                                    print(int.parse((((_harvest.maxPrice -
                                        _harvest.minPrice) /
                                        1000)
                                        .round())
                                        .toString()));
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
                                label: _currentSliderValue.round().toString(),
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
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              width: _size.width * 0.15,
                              color: const Color.fromRGBO(231, 221, 221, 0.62),
                              child: Text(_harvest.maxPrice.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: const Color.fromRGBO(61, 55, 55, 1.0))),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 8),
                              // width: _size.width * 0.15,
                              color: const Color.fromRGBO(231, 221, 221, 0.62),
                              child: Text(_currentSliderValue.round().toString() + 'vnd',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: const Color.fromRGBO(61, 55, 55, 1.0))),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 5),
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
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              width: _size.width * 0.15,
                              color: const Color.fromRGBO(231, 221, 221, 0.62),
                              child: Text(_harvest.unit,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: const Color.fromRGBO(61, 55, 55, 1.0))),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: _size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(8)),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                isChange = !isChange;
                              });
                            },
                            child: Row(
                              children: [
                                Text('Quy đổi ',
                                    style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: Colors.white)),
                                Text('(không bắt buộc)',
                                    style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: Colors.white)),
                                Spacer(),
                                IconWidget(
                                    icon: Iconsax.arrow_down_1,
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700),
                              ],
                            )),
                      ),
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
                                  // color:
                                  // const Color.fromRGBO(231, 221, 221, 0.62),
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
                                            textInputAction: TextInputAction.next,
                                            textAlign: TextAlign.center,
                                            validator: isChange ? (value){
                                              if(value!.trim().isEmpty){
                                                return "Vui lòng điền\nvào chỗ này";
                                              }
                                            } : null,
                                            onChanged: (value) {
                                              unitChange = value;
                                            },
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              // padding:
                              // const EdgeInsets.symmetric(horizontal: 5),
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
                                Text('Giá trị tương ứng',
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
                                Row(
                                  children: [
                                    Container(
                                        color: Colors.white,
                                        width: 85,
                                        // height: 30,
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          validator: isChange ? (value){
                                            if (value!.trim().isEmpty) {
                                              return 'Vui lòng điền\nvào chỗ này';
                                            } else if (isPositiveNumber((value)) == false) {
                                              return 'Sản lượng\nphải là số';
                                            } else if (isPositiveNumber((value))) {
                                              if (value.length == 1 && value.contains('-')) {
                                                return 'Sản lượng\nphải là số';
                                              } else {
                                                if (num.parse(value) <= 0) {
                                                  return 'Sản lượng\nphải lớn hơn 0';
                                                }else if(inventory % num.parse(value) != 0){
                                                  return 'Giá trị quy\nđổi phải bị\nchia hết bởi\ntổng kho';
                                                }
                                              }
                                            }
                                          } : null,
                                          onChanged: (value) {
                                            valueChange = int.parse(value);
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
                                )
                            
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
                            Container(
                              width: 90,
                              child: Column(
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
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 3),
                                    width: 90,
                                    // width: _size.width * 0.15,
                                    color: Color.fromRGBO(231, 221, 221, 0.62),
                                    child: Text(
                                        (_currentSliderValue * valueChange).round()
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
                                  // SizedBox(height: 15,)
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                          : Container(),
                      isPress && isChange && (valueChange > inventory) ?
                      Container(
                        // width: 120,
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        alignment: Alignment.center,
                        child: Text(
                            'Giá trị quy đổi phải nhỏ hơn tổng kho',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontWeight: FontWeight.w400,
                                fontSize: 10.sp,
                                color: Colors.red[700])),)
                          : Container(),
                      // isPress &&
                      //     inventory == 0 ? Container(
                      //   // width: _size.width * 0.45,
                      //   padding: EdgeInsets.symmetric(horizontal: 30),
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //       'Tổng kho phải lớn hơn 0',
                      //       style: TextStyle(
                      //           fontFamily: 'BeVietnamPro',
                      //           fontWeight: FontWeight.w400,
                      //           fontSize: 10.sp,
                      //           color: Colors.red[700])),
                      // )
                      //     : Container(),
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
                                  // Navigator.pop(context, widget.listProducts);
                                  // Navigator.popUntil(context, ModalRoute.withName('/home'));
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => const FarmManagementScreen()),
                                  // );
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
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Xác nhận'),
                                      content: const Text('Bạn muốn thêm sản phẩm này vào chiến dịch?'),
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
                                                if(inventory != 0 && (inventory != 0 ? inventory : 0) <=
                                                    (_harvest.inventoryTotal) && _currentSliderValue != 0 &&
                                                    widget.campaignId != 0 && _harvest.id != 0){
                                                  listRequests.add(CreateHarvestInCampaign(
                                                      inventory: valueChange != 0 ? int.parse((inventory/valueChange).round().toString()) : inventory,
                                                      price: unitChange != '' && valueChange != 0 && isChange
                                                          ? int.parse((_currentSliderValue * valueChange).round().toString())
                                                          : int.parse(_currentSliderValue.round().toString()),
                                                      unit: unitChange != ''
                                                          ? unitChange.toString()
                                                          : _harvest.unit,
                                                      valueChangeOfUnit: valueChange,
                                                      harvestId: _harvest.id as int,
                                                      campaignId: widget.campaignId));
                                                }


                                                if (listRequests.isNotEmpty) {
                                                  // print(isChange);
                                                  if(isChange){
                                                    if(valueChange <= inventory){
                                                      print(listRequests.length);
                                                      createHarvestInCampaign();
                                                    }else{
                                                      print(valueChange <= inventory);
                                                      isCall = false;
                                                    }
                                                  }else{
                                                    print(listRequests.length);
                                                    createHarvestInCampaign();
                                                  }
                                                } else {
                                                  isCall = false;
                                                  // UIData.toastMessage("Danh sách sản phẩm trống");
                                                }
                                              }else{
                                                isCall = false;
                                              }
                                            });
                                          }, child: const Text('Có'),
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
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
      tablet: Scaffold(
        appBar: AppBar(),
      ),
      desktop: Scaffold(
        appBar: AppBar(),
      ),
    );
  }
}
