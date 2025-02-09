import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flash/constants.dart';
import 'package:flash/data/models/matal_model.dart';
import 'package:flash/data/web_services/metal_web_services.dart';
import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flash/presentation/widgets/error_message_widget.dart';
import 'package:flash/presentation/widgets/comparison_unit_container.dart';

class MetalRatesScreen extends StatefulWidget {
  @override
  _MetalRatesScreenState createState() => _MetalRatesScreenState();
}

class _MetalRatesScreenState extends State<MetalRatesScreen> {
  late Future<MetalModel> futureMetalPrices;
  bool _isSearching = false;
  final TextEditingController _searchTextController = TextEditingController();
  List<String> metalList = [];
  List<String> filteredMetalList = [];
  String errorMessage = '';
  Map<String, bool> favoriteMetals = {};

  @override
  void initState() {
    super.initState();
    futureMetalPrices = WebService().fetchMetalPrices(unit); // نمرر الوحدة هنا
  }

  void addSearchedForMetalToSearchedList(String searchedMetal) {
    setState(() {
      if (searchedMetal.isEmpty) {
        filteredMetalList.clear();
        filteredMetalList.addAll(metalList);
        errorMessage = '';
      } else {
        filteredMetalList.clear();
        filteredMetalList.addAll(metalList
            .where((metal) =>
                metal.toLowerCase().startsWith(searchedMetal.toLowerCase()))
            .toList());
        errorMessage = filteredMetalList.isEmpty ? 'No metals found' : '';
      }
    });
  }

  void _stopSearching() {
    setState(() {
      _isSearching = false;
      _searchTextController.clear();
      addSearchedForMetalToSearchedList('');
    });
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onSearchPressed: _startSearch,
        showSearchIcon: true,
        showBackButton: false,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 12.0.h),
                child: ComparisonUnitContainer(
                  unit: unit,
                  onUnitSelected: (selectedUnit) {
                    setState(() {
                      unit = selectedUnit; // تغيير الوحدة
                      futureMetalPrices = WebService().fetchMetalPrices(
                          unit); // تحديث الطلب مع الوحدة الجديدة
                    });
                  },
                ),
              ),
            ),
          ];
        },
        body: FutureBuilder<MetalModel>(
          future: futureMetalPrices,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return ErrorMessageWidget(
                  errorMessage: 'Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final prices = snapshot.data!.getMetalPrices();
              metalList = prices.keys.toList();
              if (filteredMetalList.isEmpty) {
                filteredMetalList.addAll(metalList);
              }

              if (errorMessage.isNotEmpty) {
                return ErrorMessageWidget(errorMessage: errorMessage);
              }

              return ListView.builder(
                itemCount: filteredMetalList.length,
                itemBuilder: (context, index) {
                  final metal = filteredMetalList[index];
                  final price = prices[metal];

                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 72.5.h,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5d6d7e),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // توزيع المسافة بين المجموعات فقط
                        children: [
                          // المجموعة الأولى: اسم المعدن والعلم
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.h),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    'assets/images/images.jpg',
                                    width: 40.h,
                                    height: 40.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        8.h), // المسافة بين الصورة واسم المعدن
                                Text(
                                  metal,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),

                          // المجموعة الثانية: السعر وأيقونة المفضلة
                          Row(
                            children: [
                              Text(
                                '${price?.toStringAsFixed(2)}\$',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: (price != null &&
                                          price!.toStringAsFixed(2).length > 7)
                                      ? 14.sp
                                      : 16.sp, // Ensure price is not null before checking length
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  size: 22.w,
                                  color: favoriteMetals[metal] ?? false
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    favoriteMetals[metal] =
                                        !(favoriteMetals[metal] ?? false);
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return ErrorMessageWidget(errorMessage: 'No data available');
            }
          },
        ),
      ),
    );
  }
}
