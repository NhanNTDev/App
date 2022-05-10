// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
// import 'package:farmer_application/src/feature/model/farm.dart';
// import 'package:farmer_application/src/feature/model/harvest.dart';
// import 'package:farmer_application/src/feature/repository/farm_repository.dart';
// import 'package:farmer_application/src/feature/repository/harvest_repository.dart';
// import 'package:farmer_application/src/feature/screen/campaign_apply_request/campaign_apply_request_screen.dart';
// import 'package:farmer_application/src/feature/screen/fill_account_info/components/custom_text_field.dart';
// import 'package:farmer_application/src/share/constants/app_constant.dart';
// import 'package:farmer_application/src/share/constants/app_uidata.dart';
// import 'package:farmer_application/src/share/constants/validation.dart';
// import 'package:farmer_application/src/share/widget/stateless/icon_widget.dart';
// import 'package:farmer_application/src/share/widget/stateless/progress_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:iconsax/iconsax.dart';
//
// import 'components/add_new_harvest_in_campaign_header.dart';
//
// class AddNewHarvestInCampaignScreen extends StatefulWidget {
//   final List<HarvestInCampaign> listProducts;
//   final int campaignId;
//   final String farmerId;
//
//   const AddNewHarvestInCampaignScreen(
//       {Key? key,
//       required this.listProducts,
//       required this.campaignId,
//       required this.farmerId})
//       : super(key: key);
//
//   @override
//   _AddNewHarvestInCampaignScreenState createState() =>
//       _AddNewHarvestInCampaignScreenState();
// }
//
// class _AddNewHarvestInCampaignScreenState
//     extends State<AddNewHarvestInCampaignScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool isPress = false;
//   List<String> listImages = [];
//
//   HarvestModel _selectHarvest = HarvestModel(harvestId: 0, harvestName: '');
//   FarmModel _selectFarm = FarmModel(farmId: 0, farmName: '');
//   double _currentSliderValue = 0;
//   bool isChange = false;
//   String image =
//       'https://dacnguyen.vn/wp-content/uploads/2021/10/5-tac-dung-cua-dau-tay.jpg';
//   String harvestName = '';
//   String productName = '';
//   String productNameDisplay = 'Dâu tây loại 1';
//   String unitChange = '';
//   int valueChange = 0;
//   String priceChange = '';
//   int inventory = 0;
//
//   // int inventoryHarvest = 0;
//   List<FarmModel> listSuggestFarms = [];
//   List<HarvestModel> listHarvests = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getListFarmCanJoin();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     isPress = false;
//     _selectHarvest = HarvestModel(harvestId: 0, harvestName: '');
//     harvestName = '';
//     productName = '';
//     isChange = false;
//     listSuggestFarms = [];
//     listHarvests = [];
//     isCall = false;
//     super.dispose();
//   }
//
//   Harvest _harvest = Harvest(
//     image1: '',
//     image2: '',
//     image3: '',
//     image4: '',
//     image5: '',
//     name: '',
//     farmName: '',
//     productName: '',
//     startAt: '',
//     estimatedTime: '',
//     estimatedProduction: '',
//     unit: '',
//     categoryName: '',
//     inventoryTotal: 0,
//     description: '',
//     maxPrice: 0,
//     minPrice: 0,
//     productSystemName: '', productNameChange: '',
//   );
//
//   final _farmRepository = FarmRepository();
//   final _harvestRepository = HarvestRepository();
//   bool isCall = false;
//
//   Future<void> getListFarmCanJoin() async {
//     var list = await _farmRepository.getFarmCanJoinCampaign(
//         widget.farmerId, widget.campaignId);
//     setState(() {
//       listSuggestFarms = list;
//     });
//   }
//
//   Future<void> getListHarvestInFarm(int harvestId) async {
//     if (listHarvests.isNotEmpty) {
//       setState(() {
//         listHarvests.clear();
//         _selectHarvest = HarvestModel(harvestId: 0, harvestName: '');
//         _currentSliderValue = 0;
//         _harvest = Harvest(
//           image1: '',
//           image2: '',
//           image3: '',
//           image4: '',
//           image5: '',
//           name: '',
//           farmName: '',
//           productName: '',
//           startAt: '',
//           estimatedTime: '',
//           estimatedProduction: '',
//           unit: '',
//           categoryName: '',
//           inventoryTotal: 0,
//           description: '',
//           maxPrice: 10,
//           minPrice: 0,
//           productSystemName: '', productNameChange: '',
//         );
//       });
//     }
//     var list = await _harvestRepository.getHarvestInFarm(harvestId);
//     setState(() {
//       isCall = false;
//       listHarvests = list;
//       if(listHarvests.isNotEmpty){
//         isCall = false;
//       }
//     });
//   }
//
//   Future<void> getHarvestById(int? harvestId) async {
//     _harvest = await _harvestRepository.getHarvestById(harvestId!);
//     setState(() {
//       if (_harvest.name != '') {
//         isCall =false;
//         _currentSliderValue = double.parse(_harvest.minPrice.toString());
//         // isLoading = false;
//       }
//       if (_harvest.image1 != '') {
//         listImages.add(_harvest.image1);
//       }
//       if (_harvest.image2 != '') {
//         listImages.add(_harvest.image2);
//       }
//       if (_harvest.image3 != '') {
//         listImages.add(_harvest.image3);
//       }
//       if (_harvest.image4 != '') {
//         listImages.add(_harvest.image4);
//       }
//       if (_harvest.image5 != '') {
//         listImages.add(_harvest.image5);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size _size = MediaQuery.of(context).size;
//     return Responsive(
//       mobile: SafeArea(
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           body: ProgressHUD(
//             inAsyncCall: isCall,
//             child: SingleChildScrollView(
//                 child: Form(
//                   key: _formKey,
//                   autovalidateMode:
//                   isPress ? AutovalidateMode.always : AutovalidateMode.disabled,
//                   child: Column(
//                     children: [
//                       const AddNewHarvestInCampaignHeader(),
//                       listImages.isNotEmpty
//                           ? Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10)),
//                         padding: EdgeInsets.symmetric(horizontal: 15),
//                         // height: MediaQuery.of(context).size.height * .65,
//                         height: MediaQuery.of(context).size.height * .25,
//                         child: ImageSlideshow(
//                             width: double.infinity,
//                             indicatorPosition: 10,
//                             // height: 200,
//                             height: 250,
//                             initialPage: 0,
//                             indicatorColor: Colors.blue,
//                             indicatorBackgroundColor: Colors.white,
//                             // onPageChanged: (value) {
//                             //   debugPrint('Page changed: $value');
//                             // },
//                             autoPlayInterval: 5000,
//                             isLoop: true,
//                             children: listImages
//                                 .map(
//                                   (item) => ClipRRect(
//                                 child: Image.network(
//                                   item,
//                                   fit: BoxFit.cover,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             )
//                                 .toList()),
//                       )
//                           : Container(
//                         decoration: BoxDecoration(
//                             color: Colors.grey,
//                             borderRadius: BorderRadius.circular(10)),
//                         padding: EdgeInsets.symmetric(horizontal: 15),
//                         // height: MediaQuery.of(context).size.height * .65,
//                         height: MediaQuery.of(context).size.height * .25,
//                         width: MediaQuery.of(context).size.width * .8,
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                         // width: _size.width * 0.63,
//                         alignment: Alignment.centerLeft,
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             IconWidget(
//                                 icon: Iconsax.house_2,
//                                 color: Colors.grey,
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.w700),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Text(
//                               'Chọn nông trại tham gia',
//                               style: TextStyle(
//                                   fontFamily: 'BeVietnamPro',
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 13.sp,
//                                   color: Colors.black),
//                             ),
//                             Text(
//                               '*',
//                               style: TextStyle(
//                                   fontFamily: 'BeVietnamPro',
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 13.sp,
//                                   color: Colors.redAccent),
//                             ),
//                             Text(
//                               ':',
//                               style: TextStyle(
//                                   fontFamily: 'BeVietnamPro',
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 13.sp,
//                                   color: Colors.black),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 2,
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                         // width: _size.width * 0.63,
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           '(Hệ thống sẽ đưa ra những nông trại đủ điều kiện để tham gia)',
//                           style: TextStyle(
//                               fontFamily: 'BeVietnamPro',
//                               fontWeight: FontWeight.w400,
//                               fontStyle: FontStyle.italic,
//                               fontSize: 10.sp,
//                               color: Colors.grey),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       Container(
//                         width: _size.width * 0.9,
//                         height: 51,
//                         child: DropdownSearch<FarmModel>(
//                             mode: Mode.MENU,
//                             itemAsString: (item) {
//                               return item!.farmName;
//                             },
//                             dropdownSearchBaseStyle:
//                             TextStyle(color: Colors.redAccent),
//                             dropdownSearchDecoration: InputDecoration(
//                               contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                               // hintText: "--chọn sản phẩm tương ứng với mùa vụ",
//                               // labelText: 'Hello',
//                               // labelText: 'Hello',
//                               // hintText: "Select a country",
//                               // labelText: "Menu mode *",
//                               enabledBorder: OutlineInputBorder(
//                                   borderRadius:
//                                   BorderRadius.all(Radius.circular(8.0)),
//                                   borderSide: BorderSide(
//                                       color: Colors.grey.withOpacity(0.4))),
//                             ),
//                             // showSelectedItem: true,
//                             items: listSuggestFarms,
//                             // label: "Menu mode",
//                             // hint: "--chọn sản phẩm tương ứng với mùa vụ",
//                             popupItemDisabled: (FarmModel s) =>
//                                 s.farmName.startsWith('I'),
//                             onChanged: (value) {
//                               setState(() {
//                                 _selectFarm = value!;
//                                 isCall = true;
//                                 getListHarvestInFarm(_selectFarm.farmId);
//                                 // print(_selectProductSystem.id);
//                               });
//                             },
//                             selectedItem: _selectFarm),
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       isPress && _selectFarm.farmName == ''
//                           ? Container(
//                         // width: _size.width * 0.45,
//                         padding: EdgeInsets.symmetric(horizontal: 30),
//                         alignment: Alignment.centerLeft,
//                         child: Text('Vui lòng chọn chỗ này',
//                             style: TextStyle(
//                                 fontFamily: 'BeVietnamPro',
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 10.sp,
//                                 color: Colors.red[700])),
//                       )
//                           : Container(),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         // width: _size.width * 0.9,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: kPaddingDefault * 2),
//                         alignment: Alignment.centerLeft,
//                         child: Row(
//                           children: [
//                             IconWidget(
//                                 icon: Iconsax.sun_1,
//                                 color: Colors.grey,
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.w700),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Text('Mùa vụ',
//                                 style: TextStyle(
//                                     fontFamily: 'BeVietnamPro',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 12.sp,
//                                     color: const Color.fromRGBO(61, 55, 55, 1.0))),
//                             Text('*',
//                                 style: TextStyle(
//                                     fontFamily: 'BeVietnamPro',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 15.sp,
//                                     color: Colors.redAccent)),
//                             Text(':',
//                                 style: TextStyle(
//                                     fontFamily: 'BeVietnamPro',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 12.sp,
//                                     color: Colors.black.withOpacity(0.5))),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       Container(
//                         width: _size.width * 0.9,
//                         height: 51,
//                         child: DropdownSearch<HarvestModel>(
//                             mode: Mode.MENU,
//                             itemAsString: (item) {
//                               return item!.harvestName;
//                             },
//                             dropdownSearchDecoration: InputDecoration(
//                               contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                               hintText: "--chọn sản phẩm tương ứng với mùa vụ",
//                               enabledBorder: OutlineInputBorder(
//                                   borderRadius:
//                                   BorderRadius.all(Radius.circular(8.0)),
//                                   borderSide: BorderSide(
//                                       color: Colors.grey.withOpacity(0.4))),
//                             ),
//                             // showSelectedItem: true,
//                             items: listHarvests,
//                             // label: "Menu mode",
//                             hint: "--chọn sản phẩm tương ứng với mùa vụ",
//                             popupItemDisabled: (HarvestModel s) =>
//                                 s.harvestName.startsWith('I'),
//                             onChanged: (value) {
//                               setState(() {
//                                 _selectHarvest = value!;
//                                 listImages.clear();
//                                 isCall = true;
//                                 getHarvestById(_selectHarvest.harvestId);
//                                 // productName = _selectHarvest.productSystemName;
//                                 // print(_selectProductSystem.id);
//                               });
//                             },
//                             selectedItem: _selectHarvest),
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       isPress && _selectHarvest.harvestName == ''
//                           ? Container(
//                         // width: _size.width * 0.45,
//                         padding: EdgeInsets.symmetric(horizontal: 30),
//                         alignment: Alignment.centerLeft,
//                         child: Text('Vui lòng chọn chỗ này',
//                             style: TextStyle(
//                                 fontFamily: 'BeVietnamPro',
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 10.sp,
//                                 color: Colors.red[700])),
//                       )
//                           : Container(),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         // width: _size.width * 0.9,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: kPaddingDefault * 2),
//                         alignment: Alignment.centerLeft,
//                         child: Row(
//                           children: [
//                             IconWidget(
//                                 icon: Iconsax.box,
//                                 color: Colors.grey,
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.w700),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Text('Loại sản phẩm',
//                                 style: TextStyle(
//                                     fontFamily: 'BeVietnamPro',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 12.sp,
//                                     color: const Color.fromRGBO(61, 55, 55, 1.0))),
//                             Text('*',
//                                 style: TextStyle(
//                                     fontFamily: 'BeVietnamPro',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 15.sp,
//                                     color: Colors.redAccent)),
//                             Text(':',
//                                 style: TextStyle(
//                                     fontFamily: 'BeVietnamPro',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 12.sp,
//                                     color: Colors.black.withOpacity(0.5))),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: kPaddingDefault * 2),
//                         child: CustomTextField(
//                           initValue: _harvest.productSystemName,
//                           enable: false,
//                           isDense: true,
//                           hintText: "--sản phẩm tương ứng với mùa vụ",
//                           onChanged: (value) {
//                             // farmName = value;
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         // width: _size.width * 0.9,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: kPaddingDefault * 2),
//                         alignment: Alignment.centerLeft,
//                         child: Row(
//                           children: [
//                             IconWidget(
//                                 icon: Iconsax.edit,
//                                 color: Colors.grey,
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.w700),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Text('Số lượng sản phẩm hiện có: ',
//                                 style: TextStyle(
//                                     fontFamily: 'BeVietnamPro',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 12.sp,
//                                     color: const Color.fromRGBO(61, 55, 55, 1.0))),
//                             Text('*',
//                                 style: TextStyle(
//                                     fontFamily: 'BeVietnamPro',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 15.sp,
//                                     color: Colors.redAccent)),
//                             Text(':',
//                                 style: TextStyle(
//                                     fontFamily: 'BeVietnamPro',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 12.sp,
//                                     color: Colors.black.withOpacity(0.5))),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: kPaddingDefault * 2),
//                         child: CustomTextField(
//                           initValue: _harvest.inventoryTotal.toString() +
//                               ' ' +
//                               _harvest.unit,
//                           enable: false,
//                           isDense: true,
//                           hintText: "--số lượng sản phẩm hiện có",
//                           onChanged: (value) {
//                             // farmName = value;
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Container(
//                         // width: _size.width * 0.9,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: kPaddingDefault * 2),
//                         alignment: Alignment.centerLeft,
//                         child: Row(
//                           children: [
//                             IconWidget(
//                                 icon: Iconsax.directbox_default,
//                                 color: Colors.grey,
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.w700),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Text('Tổng kho',
//                                 style: TextStyle(
//                                     fontFamily: 'BeVietnamPro',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 12.sp,
//                                     color: const Color.fromRGBO(61, 55, 55, 1.0))),
//                             Text('*',
//                                 style: TextStyle(
//                                     fontFamily: 'BeVietnamPro',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 15.sp,
//                                     color: Colors.redAccent)),
//                             Text(':',
//                                 style: TextStyle(
//                                     fontFamily: 'BeVietnamPro',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 12.sp,
//                                     color: Colors.black.withOpacity(0.5))),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: kPaddingDefault * 2),
//                         child: CustomTextField(
//                           initValue: inventory.toString(),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Vui lòng điền vào chỗ này';
//                             }
//                           },
//                           border: isPress &&
//                               ((inventory != 0 ? inventory : 0) >
//                                   (_harvest.inventoryTotal) || inventory == 0)? BorderSide(color: Colors.red, width: 1, style: BorderStyle.solid):BorderSide(color: Colors.grey.withOpacity(0.4), width: 1, style: BorderStyle.solid),
//                           keyboardType: TextInputType.number,
//                           isDense: true,
//                           hintText: "Nhập tổng kho",
//                           onChanged: (value) {
//                             inventory = int.parse(value);
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       isPress &&
//                           (inventory != 0 ? inventory : 0) >
//                               (_harvest.inventoryTotal)
//                           ? Container(
//                         // width: _size.width * 0.45,
//                         padding: EdgeInsets.symmetric(horizontal: 30),
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                             'Số lượng đăng bán phải nhỏ hơn số lượng hàng hiện có',
//                             style: TextStyle(
//                                 fontFamily: 'BeVietnamPro',
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 10.sp,
//                                 color: Colors.red[700])),
//                       )
//                           : Container(),
//                       isPress &&
//                           inventory == 0 ? Container(
//                         // width: _size.width * 0.45,
//                         padding: EdgeInsets.symmetric(horizontal: 30),
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                             'Tổng kho phải lớn hơn 0',
//                             style: TextStyle(
//                                 fontFamily: 'BeVietnamPro',
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 10.sp,
//                                 color: Colors.red[700])),
//                       )
//                           : Container(),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         // width: _size.width * 0.9,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: kPaddingDefault * 2),
//                         alignment: Alignment.centerLeft,
//                         child: Row(
//                           children: [
//                             IconWidget(
//                                 icon: Iconsax.money,
//                                 color: Colors.grey,
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.w700),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Text('Giá sản phẩm',
//                                 style: TextStyle(
//                                     fontFamily: 'BeVietnamPro',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 12.sp,
//                                     color: const Color.fromRGBO(61, 55, 55, 1.0))),
//                             Text('*',
//                                 style: TextStyle(
//                                     fontFamily: 'BeVietnamPro',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 15.sp,
//                                     color: Colors.redAccent)),
//                             Text(':',
//                                 style: TextStyle(
//                                     fontFamily: 'BeVietnamPro',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 12.sp,
//                                     color: Colors.black.withOpacity(0.5))),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Row(
//                           children: [
//                             Container(
//                               alignment: Alignment.center,
//                               padding: const EdgeInsets.symmetric(vertical: 5),
//                               width: _size.width * 0.15,
//                               color: const Color.fromRGBO(231, 221, 221, 0.62),
//                               child: Text(_harvest.minPrice.toString(),
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       fontFamily: 'BeVietnamPro',
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 12.sp,
//                                       color: const Color.fromRGBO(61, 55, 55, 1.0))),
//                             ),
//                             _currentSliderValue != 0
//                                 ? Container(
//                               width: _size.width * 0.59,
//                               child: Slider(
//                                 value: double.parse(
//                                     _currentSliderValue.toString()),
//                                 min: double.parse(_harvest.minPrice.toString()),
//                                 max: double.parse(_harvest.maxPrice.toString()),
//                                 divisions: int.parse(
//                                     (((_harvest.maxPrice - _harvest.minPrice) /
//                                         1000)
//                                         .round())
//                                         .toString()),
//                                 label: _currentSliderValue.round().toString(),
//                                 onChanged: (double value) {
//                                   setState(() {
//                                     print(int.parse((((_harvest.maxPrice -
//                                         _harvest.minPrice) /
//                                         1000)
//                                         .round())
//                                         .toString()));
//                                     _currentSliderValue = value;
//                                     // price = _currentSliderValue.toString() + " vnd";
//                                   });
//
//                                   // print(price);
//                                 },
//                               ),
//                             )
//                                 : Container(
//                               width: _size.width * 0.59,
//                               child: Slider(
//                                 value: 1,
//                                 min: 0,
//                                 max: 10,
//                                 divisions: 1,
//                                 label: _currentSliderValue.round().toString(),
//                                 onChanged: (double value) {
//                                   // setState(() {
//                                   //   _currentSliderValue = value;
//                                   //   // price = _currentSliderValue.toString() + " vnd";
//                                   // });
//
//                                   // print(price);
//                                 },
//                               ),
//                             ),
//                             Container(
//                               alignment: Alignment.center,
//                               padding: const EdgeInsets.symmetric(vertical: 5),
//                               width: _size.width * 0.15,
//                               color: const Color.fromRGBO(231, 221, 221, 0.62),
//                               child: Text(_harvest.maxPrice.toString(),
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       fontFamily: 'BeVietnamPro',
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 12.sp,
//                                       color: const Color.fromRGBO(61, 55, 55, 1.0))),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               alignment: Alignment.center,
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 5, horizontal: 8),
//                               // width: _size.width * 0.15,
//                               color: const Color.fromRGBO(231, 221, 221, 0.62),
//                               child: Text(_currentSliderValue.round().toString() + 'vnd',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       fontFamily: 'BeVietnamPro',
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 12.sp,
//                                       color: const Color.fromRGBO(61, 55, 55, 1.0))),
//                             ),
//                             Container(
//                               alignment: Alignment.center,
//                               padding: const EdgeInsets.symmetric(horizontal: 5),
//                               child: Text('/',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       fontFamily: 'BeVietnamPro',
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14.sp,
//                                       color: Colors.black)),
//                             ),
//                             Container(
//                               alignment: Alignment.center,
//                               padding: const EdgeInsets.symmetric(vertical: 5),
//                               width: _size.width * 0.15,
//                               color: const Color.fromRGBO(231, 221, 221, 0.62),
//                               child: Text(_harvest.unit,
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       fontFamily: 'BeVietnamPro',
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 12.sp,
//                                       color: const Color.fromRGBO(61, 55, 55, 1.0))),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: _size.width * 0.9,
//                         decoration: BoxDecoration(
//                             color: Colors.redAccent,
//                             borderRadius: BorderRadius.circular(8)),
//                         child: TextButton(
//                             onPressed: () {
//                               setState(() {
//                                 isChange = !isChange;
//                               });
//                             },
//                             child: Row(
//                               children: [
//                                 Text('Quy đổi ',
//                                     style: TextStyle(
//                                         fontFamily: 'BeVietnamPro',
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 12.sp,
//                                         color: Colors.white)),
//                                 Text('(không bắt buộc)',
//                                     style: TextStyle(
//                                         fontFamily: 'BeVietnamPro',
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 12.sp,
//                                         color: Colors.white)),
//                                 Spacer(),
//                                 IconWidget(
//                                     icon: Iconsax.arrow_down_1,
//                                     color: Colors.white,
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.w700),
//                               ],
//                             )),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       isChange
//                           ? Container(
//                         alignment: Alignment.centerLeft,
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Đơn vị quy đổi',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         fontFamily: 'BeVietnamPro',
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 11.sp,
//                                         color: const Color.fromRGBO(
//                                             61, 55, 55, 1.0))),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Container(
//                                   alignment: Alignment.center,
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 5, horizontal: 8),
//                                   // width: _size.width * 0.15,
//                                   // color:
//                                   // const Color.fromRGBO(231, 221, 221, 0.62),
//                                   child: Row(
//                                     children: [
//                                       Text('1',
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                               fontFamily: 'BeVietnamPro',
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 12.sp,
//                                               color: const Color.fromRGBO(
//                                                   61, 55, 55, 1.0))),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       Container(
//                                           color: Colors.white,
//                                           width: 80,
//                                           // height: 30,
//                                           child: TextFormField(
//                                             textInputAction: TextInputAction.next,
//                                             textAlign: TextAlign.center,
//                                             validator: isChange ? (value){
//                                               if(value!.trim().isEmpty){
//                                                 return "Vui lòng điền\nvào chỗ này";
//                                               }
//                                             } : null,
//                                             onChanged: (value) {
//                                               unitChange = value;
//                                             },
//                                           ))
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Container(
//                               alignment: Alignment.center,
//                               // padding:
//                               // const EdgeInsets.symmetric(horizontal: 5),
//                               child: IconWidget(
//                                 icon: Iconsax.arrow_swap_horizontal,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 15.sp,
//                               ),
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('Đơn vị tương ứng',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         fontFamily: 'BeVietnamPro',
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 11.sp,
//                                         color: const Color.fromRGBO(
//                                             61, 55, 55, 1.0))),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Container(
//                                   alignment: Alignment.center,
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 5, horizontal: 8),
//                                   // width: _size.width * 0.15,
//                                   // color:
//                                   // const Color.fromRGBO(231, 221, 221, 0.62),
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                           color: Colors.white,
//                                           width: 85,
//                                           // height: 30,
//                                           child: TextFormField(
//                                             textInputAction: TextInputAction.next,
//                                             textAlign: TextAlign.center,
//                                             keyboardType: TextInputType.number,
//                                             validator: isChange ? (value){
//                                               if (value!.trim().isEmpty) {
//                                                 return 'Vui lòng điền\nvào chỗ này';
//                                               } else if (isPositiveNumber((value)) == false) {
//                                                 return 'Giá trị phải\nlà số';
//                                               } else if (isPositiveNumber((value))) {
//                                                 if (value.length == 1 && value.contains('-')) {
//                                                   return 'Giá trị phải\nlà số';
//                                                 } else {
//                                                   if (num.parse(value) <= 0) {
//                                                     return 'Giá trị phải\nlớn hơn 0';
//                                                   }
//                                                 }
//                                               }
//                                             } : null,
//                                             onChanged: (value) {
//                                               valueChange = int.parse(value);
//                                             },
//                                           )),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text('kg',
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                               fontFamily: 'BeVietnamPro',
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 12.sp,
//                                               color: const Color.fromRGBO(
//                                                   61, 55, 55, 1.0)))
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Container(
//                               alignment: Alignment.center,
//                               // padding: EdgeInsets.symmetric(horizontal: 5),
//                               child: Text('/',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       fontFamily: 'BeVietnamPro',
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14.sp,
//                                       color: Colors.black)),
//                             ),
//                             Spacer(),
//                             Container(
//                               width: 90,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('Giá sản phẩm',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontFamily: 'BeVietnamPro',
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 11.sp,
//                                           color: const Color.fromRGBO(
//                                               61, 55, 55, 1.0))),
//                                   SizedBox(
//                                     height: 30,
//                                   ),
//                                   Container(
//                                     alignment: Alignment.center,
//                                     padding: EdgeInsets.symmetric(
//                                         vertical: 5, horizontal: 3),
//                                     width: 90,
//                                     // width: _size.width * 0.15,
//                                     color: Color.fromRGBO(231, 221, 221, 0.62),
//                                     child: Text(
//                                         (_currentSliderValue * valueChange).round()
//                                             .toString() +
//                                             ' vnd',
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontFamily: 'BeVietnamPro',
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 11.sp,
//                                             color: const Color.fromRGBO(
//                                                 61, 55, 55, 1.0))),
//                                   ),
//                                   SizedBox(
//                                     height: 30,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                           : Container(),
//                       isPress && isChange && (valueChange > inventory) ?
//                       Container(
//                         // width: 120,
//                         padding: EdgeInsets.symmetric(horizontal: 30),
//                         alignment: Alignment.center,
//                         child: Text(
//                             'Giá trị quy đổi phải nhỏ hơn tổng kho',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontFamily: 'BeVietnamPro',
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 10.sp,
//                                 color: Colors.red[700])),)
//                           : Container(),
//
//                       SizedBox(
//                         height: 30,
//                       ),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.redAccent,
//                               ),
//                               width: _size.width * 0.4,
//                               height: _size.height * 0.065,
//                               child: TextButton(
//                                 onPressed: () {
//                                   FocusScopeNode currentFocus =
//                                   FocusScope.of(context);
//
//                                   if (!currentFocus.hasPrimaryFocus) {
//                                     currentFocus.unfocus();
//                                   }
//                                   Navigator.pop(context, widget.listProducts);
//                                   // Navigator.popUntil(context, ModalRoute.withName('/home'));
//                                   // Navigator.push(
//                                   //   context,
//                                   //   MaterialPageRoute(builder: (context) => const FarmManagementScreen()),
//                                   // );
//                                 },
//                                 child: Text('Hủy bỏ',
//                                     style: TextStyle(
//                                         fontFamily: 'BeVietnamPro',
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 12.sp,
//                                         color: Colors.white)),
//                               )),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: const Color.fromRGBO(95, 212, 144, 1.0),
//                               ),
//                               width: _size.width * 0.4,
//                               height: _size.height * 0.065,
//                               child: TextButton(
//                                 onPressed: () {
//                                   FocusScopeNode currentFocus =
//                                   FocusScope.of(context);
//
//                                   if (!currentFocus.hasPrimaryFocus) {
//                                     currentFocus.unfocus();
//                                   }
//                                   setState(() {
//                                     isPress = true;
//                                     if (_formKey.currentState!.validate()) {
//                                       if (_selectFarm.farmName != '' &&
//                                           (inventory != 0 ? inventory : 0) <=
//                                               (_harvest.inventoryTotal) && inventory > 0 && inventory != 0) {
//                                         HarvestInCampaign i = HarvestInCampaign(
//                                             farmName: _selectFarm.farmName,
//                                             image: listImages[0],
//                                             name: _selectHarvest.harvestName,
//                                             productName: _harvest.productSystemName,
//                                             inventory: valueChange != 0 ? int.parse((inventory/valueChange).round().toString()) : inventory,
//                                             price: unitChange != '' && valueChange != 0 && isChange
//                                                 ? int.parse((_currentSliderValue * valueChange).round().toString())
//                                                 : int.parse(_currentSliderValue.round().toString()),
//                                             unit: _harvest.unit,
//                                             unitChange: unitChange,
//                                             valueChange: valueChange,
//                                             harvestId: _selectHarvest.harvestId,
//                                             campaignId: widget.campaignId);
//                                         bool isCheck = false;
//                                         for(HarvestInCampaign h in widget.listProducts){
//                                           if(i.harvestId == h.harvestId){
//                                             isCheck = true;
//                                           }
//                                         }
//                                         if(isCheck){
//                                           UIData.toastMessage("Bạn đã thêm sản phẩm này");
//                                           isCheck = false;
//                                         }else{
//                                           if(isChange){
//                                             if(valueChange <= inventory){
//                                               widget.listProducts.add(i);
//                                               Navigator.pop(context, widget.listProducts);
//                                             }else{
//                                               isCheck = false;
//                                             }
//                                           }else{
//                                             widget.listProducts.add(i);
//                                             Navigator.pop(context, widget.listProducts);
//                                           }
//                                         }
//                                       }
//                                     }
//                                   });
//                                 },
//                                 child: Text('Xác nhận',
//                                     style: TextStyle(
//                                         fontFamily: 'BeVietnamPro',
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 12.sp,
//                                         color: Colors.white)),
//                               )),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       // RaisedButton(
//                       //   child: const Text(
//                       //     'Submit',
//                       //     style: TextStyle(color: Colors.white),
//                       //   ),
//                       //   color: Colors.blue,
//                       //   onPressed: () {
//                       //     print(_selectHarvest);
//                       //     print(listImages[0]);
//                       //     print(productName);
//                       //     print(productNameDisplay);
//                       //     print(unit);
//                       //     print(unitChange);
//                       //     print(valueChange);
//                       //     print(price);
//                       //     print(inventory);
//                       //     Item i = Item(
//                       //         image: listImages[0],
//                       //         name: _selectHarvest,
//                       //         productName: productName,
//                       //         inventory: inventory,
//                       //         price: unitChange != '' && valueChange != ''
//                       //             ? (_currentSliderValue * 5).toString()
//                       //             : price,
//                       //         unit: unit,
//                       //         unitChange: unitChange,
//                       //         valueChange: valueChange);
//                       //     print(i.name);
//                       //     widget.listProducts.add(i);
//                       //     Navigator.pop(context, widget.listProducts);
//                       //   },
//                       // )
//                     ],
//                   ),
//                 )),
//           ),
//         ),
//       ),
//       tablet: Scaffold(
//         appBar: AppBar(),
//       ),
//       desktop: Scaffold(
//         appBar: AppBar(),
//       ),
//     );
//   }
// }
