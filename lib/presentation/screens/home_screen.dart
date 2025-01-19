import 'package:flash/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? rates; // لتخزين أسعار العملات
  bool isLoading = true; // للتحكم في حالة التحميل
  String errorMessage = ''; // لتخزين رسائل الخطأ

  // جلب البيانات من الـ API
  Future<void> fetchRates() async {
    try {
      const url = baseUrl;
      final dio = Dio();
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        setState(() {
          rates = response.data['conversion_rates']; 
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load data.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred: $e';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRates(); // جلب البيانات عند تحميل الشاشة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // مؤشر تحميل أثناء جلب البيانات
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage)) // في حالة حدوث خطأ
              : ListView.separated(
                  itemCount: rates?.length ?? 0,
                  itemBuilder: (context, index) {
                    // الحصول على اسم العملة وسعرها
                    final currency = rates!.keys.elementAt(index);
                    final rate = rates![currency];

                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                        children: [
                          Text(
                            currency, // اسم العملة
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            rate.toString(), // سعر العملة
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.white, 
                      thickness: 2,
                    );
                  },
                ),
    );
  }
}
