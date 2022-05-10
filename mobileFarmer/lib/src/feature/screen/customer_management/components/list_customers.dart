import 'package:farmer_application/src/share/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../customer_management_bloc.dart';
import 'customer_card.dart';

class ListCustomer extends StatefulWidget {
  const ListCustomer({Key? key}) : super(key: key);

  @override
  _ListCustomerState createState() => _ListCustomerState();
}

class _ListCustomerState extends State<ListCustomer>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerManagementBloc, CustomerManagementState>(
      builder: (context, state) {
        switch (state.status) {
          case CustomerStatus.failure:
            return Container(
              padding: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: Text(
                'Đã có lỗi xảy ra',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    height: 1.5,
                    fontFamily: 'BeVietnamPro',
                    fontWeight: FontWeight.w400,
                    fontSize: 11.sp,
                    color: Colors.grey),
              ),
            );
          case CustomerStatus.success:
            if (state.customers.isEmpty) {
              return Container(
                padding: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text(
                  'Chưa có khách hàng',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      height: 1.5,
                      fontFamily: 'BeVietnamPro',
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                      color: Colors.grey),
                ),
              );
            }
            return SizedBox(
                height: MediaQuery.of(context).size.height * 0.82,
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      left: kPaddingDefault * 0.6,
                      right: kPaddingDefault * 0.6),
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.hasReachedMax
                      ? state.customers.length
                      : state.customers.length + 1,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.customers.length
                        ? Container(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                          width: 30,
                          height: 30,
                          child: SpinKitHourGlass(
                            color: kBlueDefault,
                            size: 30.sp,
                          )),
                    )
                        : GestureDetector(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: CustomerCard(
                                customer: state.customers[index],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ));
                  },
                ));
          default:
            return Container(
              padding: const EdgeInsets.only(top: 30),
              alignment: Alignment.topCenter,
              child: SizedBox(
                  width: 30,
                  height: 30,
                  child: SpinKitHourGlass(
                    color: kBlueDefault,
                    size: 30.sp,
                  )),
            );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<CustomerManagementBloc>().add(CustomerFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
