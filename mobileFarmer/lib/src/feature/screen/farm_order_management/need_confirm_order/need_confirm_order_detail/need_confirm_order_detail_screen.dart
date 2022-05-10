import 'package:farmer_application/src/core/config/responsive/app_responsive.dart';
import 'package:farmer_application/src/feature/model/farm_order.dart';
import 'package:farmer_application/src/feature/repository/farm_order_repository.dart';
import 'package:farmer_application/src/feature/screen/farm_order_management/order_management_screen.dart';
import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:farmer_application/src/share/constants/app_uidata.dart';
import 'package:farmer_application/src/share/constants/converts.dart';
import 'package:farmer_application/src/share/widget/stateless/progress_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class NeedConfirmOrderDetailScreen extends StatefulWidget {
  final int farmOrderId;
  const NeedConfirmOrderDetailScreen({Key? key, required this.farmOrderId}) : super(key: key);

  @override
  _NeedConfirmOrderDetailScreenState createState() =>
      _NeedConfirmOrderDetailScreenState();
}

class _NeedConfirmOrderDetailScreenState
    extends State<NeedConfirmOrderDetailScreen> {
  final _needConfirmFarmOrderRepository = NeedConfirmFarmOrderRepository();
  FarmOrderDetail _farmOrder = FarmOrderDetail(code: '',
      total: 0,
      status: '',
      createAt: '',
      orderId: 0,
      customerName: ''
      ,
      campaignName: '',
      address: '',
      paymentStatus: '',
      paymentTypeName: '',
      farmName: '',
      harvestOrders: [],
      phone: '', feedBackCreateAt: '', content: '', star: 0, note: '');

  int statusCode = 0;
  bool isLoading = true;
  bool isCall = false;

  final _formKey = GlobalKey<FormState>();
  bool isPress = false;
  String cancelReason = '';

  Future<void> getFarmOrderById(int farmOrderId) async {
    _farmOrder =
    await _needConfirmFarmOrderRepository.getFarmOrderById(farmOrderId);
    setState(() {
      if (_farmOrder.code != '') {
        isLoading = false;
      }
    });
  }

  Future<dynamic> updateStatusFarmOrder() async {
    statusCode = await _needConfirmFarmOrderRepository.updateStatusFarmOrder(
        widget.farmOrderId, 1);
    setState(() {
      if (statusCode == 200) {
        isCall = false;
        UIData.toastMessage("Cập nhật thành công");
        // Navigator.popUntil(context, ModalRoute.withName('/home'));
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const OrderManagementScreen(initPage: 0)),);
      } else {
        isCall = false;
        UIData.toastMessage("Cập nhật thất bại");
      }
    });
  }

  Future<dynamic> cancelFarmOrder(int farmOrderId, String note) async {
    var statusCode = 0;
    statusCode = await _needConfirmFarmOrderRepository.cancelFarmOrder(
        farmOrderId, note);
    setState(() {
      if (statusCode == 200) {
        isCall = false;
        UIData.toastMessage("Hủy đơn thành công");
        // Navigator.popUntil(context, ModalRoute.withName('/home'));
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const OrderManagementScreen(initPage: 0)),);
      } else {
        isCall = false;
        UIData.toastMessage("Hủy đơn thất bại");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFarmOrderById(widget.farmOrderId);
  }

  @override
  void dispose() {
    _farmOrder = FarmOrderDetail(code: '',
        total: 0,
        status: '',
        createAt: '',
        orderId: 0,
        customerName: ''
        ,
        campaignName: '',
        address: '',
        paymentStatus: '',
        paymentTypeName: '',
        farmName: '',
        harvestOrders: [],
        phone: '', content: '', star: 0, feedBackCreateAt: '', note: '');
    statusCode = 0;
    isLoading = true;
    isCall = false;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery
        .of(context)
        .size;
    return Responsive(
        mobile: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: kBlueDefault,
              toolbarHeight: 70,
              elevation: 0,
              leading: Container(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Icon(Icons.arrow_back, color: Colors.white,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              leadingWidth: 25,
              title: Center(
                child: Text('Thông tin đơn hàng',
                    style: TextStyle(
                        fontFamily: 'BeVietnamPro',
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: Colors.white)),
              ),
            ),
            body: Skeleton(
              isLoading: isLoading,
              // skeleton: SkeletonListView(),
              skeleton: SkeletonItem(
                child: Column(
                  children: [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: double.infinity,
                        minHeight: MediaQuery.of(context).size.height / 5,
                        maxHeight: MediaQuery.of(context).size.height / 3,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 1, spacing: 8,
                          lineStyle: SkeletonLineStyle(randomLength: true, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,
                          )),
                    ),
                    const SizedBox(height: 6),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 2, spacing: 3,
                          lineStyle: SkeletonLineStyle(randomLength: true, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,
                          )),
                    ),
                    const SizedBox(height: 12),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 6, spacing: 8,
                          lineStyle: SkeletonLineStyle(randomLength: true, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,
                          )),
                    ),
                    const SizedBox(height: 8),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 2, spacing: 8,
                          lineStyle: SkeletonLineStyle(randomLength: false, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,
                          )),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: double.infinity,
                          minHeight: MediaQuery.of(context).size.height / 4,
                          maxHeight: MediaQuery.of(context).size.height / 3,
                        ),
                      ),
                    ),
                    SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 1, spacing: 8,
                          lineStyle: SkeletonLineStyle(randomLength: true, height: 10,
                            borderRadius: BorderRadius.circular(0), minLength: MediaQuery.of(context).size.width / 2,
                          )),),
                  ],
                ),
              ),
              child: ProgressHUD(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Đơn hàng: ' + _farmOrder.code,
                              style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  color: Colors.black)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.amber,
                                size: 16.sp,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(_farmOrder.status,
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.sp,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Text('Khách hàng: ' + _farmOrder.customerName,
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      color: Colors.black.withOpacity(0.8))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Text('Số điện thoại: ' + _farmOrder.phone,
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      color: Colors.black.withOpacity(0.8))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Địa chỉ: ',
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                      color: Colors.black.withOpacity(0.8))),
                              Container(
                                width: 300,
                                child: Text(_farmOrder.address,
                                    style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp,
                                        color: Colors.black.withOpacity(0.8))),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Đặt hàng tại: ',
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                      color: Colors.black.withOpacity(0.8))),
                              Container(
                                width: 273,
                                child: Text(_farmOrder.farmName,
                                    style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp,
                                        color: Colors.black.withOpacity(0.8))),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Chiến dịch: ',
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                      color: Colors.black.withOpacity(0.8))),
                              Container(
                                width: 285,
                                child: Text(_farmOrder.campaignName,
                                    style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp,
                                        color: Colors.black.withOpacity(0.8))),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Text('Ngày đặt: ',
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                      color: Colors.black.withOpacity(0.8))),
                              _farmOrder.createAt != ''
                                  ? Text(convertFormatHour(
                                  DateTime.parse(_farmOrder.createAt)) +
                                  ' ' +
                                  convertFormatDate(
                                      DateTime.parse(_farmOrder.createAt)),
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                      color: Colors.black.withOpacity(0.8)))
                                  : Container(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Trạng thái: ',
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                      color: Colors.black.withOpacity(0.8))),
                              Container(
                                width: 255,
                                child: Text(_farmOrder.paymentStatus,
                                    style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp,
                                        color: Colors.black.withOpacity(0.8))),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hình thức thanh toán: ',
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                      color: Colors.black.withOpacity(0.8))),
                              Text(_farmOrder.paymentTypeName,
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp,
                                      color: Colors.black.withOpacity(0.8))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                          thickness: 6,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Text('Sản phẩm của đơn hàng',
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          shrinkWrap: true,
                          itemCount: _farmOrder.harvestOrders.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 10);
                          },
                          itemBuilder: (context, index) {
                            return Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  width: 60,
                                  child: Row(
                                    children: [
                                      Text(_farmOrder.harvestOrders[index]
                                          .quantity.toString(),
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11.sp,
                                              color: Colors.black)),
                                      SizedBox(width: 4),
                                      Text(_farmOrder.harvestOrders[index].unit,
                                          style: TextStyle(
                                              fontFamily: 'BeVietnamPro',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11.sp,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 50),
                                Text(
                                    _farmOrder.harvestOrders[index].productName,
                                    style: TextStyle(
                                        fontFamily: 'BeVietnamPro',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.sp,
                                        color: Colors.black)),
                                Spacer(),
                                Text(_farmOrder.harvestOrders[index].price
                                    .toString() + " vnd", style: TextStyle(
                                    fontFamily: 'BeVietnamPro',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.sp,
                                    color: Colors.black)),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                          thickness: 6,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Text('Tổng:', style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: Colors.black)),
                              Spacer(),
                              Text(_farmOrder.total.toString() + ' vnd',
                                  style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: Colors.black))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                          thickness: 6,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Spacer(),
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
                                    FocusScopeNode currentFocus = FocusScope.of(
                                        context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => StatefulBuilder(builder: (context, setState){
                                        return AlertDialog(
                                          title: const Text('Xác nhận'),
                                          content: SizedBox(
                                            height: 110,
                                            child: Form(
                                              key: _formKey,
                                              autovalidateMode: isPress
                                                  ? AutovalidateMode.always
                                                  : AutovalidateMode.disabled,
                                              child: Column(
                                                children: [
                                                  Text('Bạn xác nhận hủy đơn hàng này?'),
                                                  SizedBox(height: 10,),
                                                  TextFormField(
                                                    style: TextStyle(
                                                        fontFamily: 'BeVietnamPro',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 13.sp,
                                                        color: Colors.black),
                                                    textInputAction: TextInputAction.done,
                                                    onChanged: (value){
                                                      setState(() {
                                                        cancelReason = value;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      // contentPadding: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
                                                      // labelText: "Resevior Name",
                                                      fillColor: Colors.white,
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide:  BorderSide(
                                                            color: Colors.grey.withOpacity(0.4),
                                                            width: 1,
                                                            style: BorderStyle.solid),
                                                        borderRadius: BorderRadius.circular(10.0),
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderSide: const BorderSide(color: Colors.orange, width: 1.0),
                                                        borderRadius: BorderRadius.circular(10.0),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide:
                                                        BorderSide(color: Colors.lightBlue.withOpacity(0.6), width: 2.5),
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                      // labelText: "Tên nông trại",
                                                      // labelStyle: TextStyle(fontSize: 18),
                                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                                      // prefixIcon: prefixIcon,
                                                      hintText: 'Nhập lí do hủy đơn',
                                                      hintStyle: TextStyle(
                                                          fontFamily: 'BeVietnamPro',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 11.sp,
                                                          color: Colors.grey),
                                                    ),
                                                    // The validator receives the text that the user has entered.
                                                    autovalidateMode: AutovalidateMode.disabled,
                                                    validator: (value){
                                                      if(value!.trim().isEmpty){
                                                        return 'Vui lòng điền vào chỗ này';
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(context, 'Cancel'),
                                              child: const Text('Không'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    Navigator.pop(
                                                        context, 'ON');
                                                    isCall = true;
                                                    cancelFarmOrder(widget.farmOrderId, cancelReason);
                                                  }
                                                });
                                              }, child: const Text('Có'),
                                            ),
                                          ],
                                        );
                                      }),
                                    );
                                  },
                                  child: Text('Hủy đơn', style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: Colors.white)),
                                )),
                            const SizedBox(width: 10,),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromRGBO(
                                      95, 212, 144, 1.0),),
                                width: _size.width * 0.4,
                                height: _size.height * 0.065,
                                child: TextButton(
                                  onPressed: () {
                                    FocusScopeNode currentFocus = FocusScope.of(
                                        context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: const Text('Xác nhận'),
                                            content: const Text(
                                                'Bạn muốn xác nhận đơn hàng này?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('Không'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, 'ON');
                                                  setState(() {
                                                    isCall = true;
                                                    updateStatusFarmOrder();
                                                  });
                                                  // });
                                                }, child: const Text('Có'),
                                              ),
                                            ],
                                          ),
                                    );
                                  },
                                  child: Text('Xác nhận', style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: Colors.white)),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                inAsyncCall: isCall,
              ),
            ),
          ),
        ),
        tablet: SafeArea(
          child: AppBar(),
        ),
        desktop: SafeArea(
          child: AppBar(),
        ));
  }
}