import 'package:flash/constants.dart';
import 'package:flash/data/models/matal_model.dart';
import 'package:flash/data/web_services/metal_web_services.dart';
import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flash/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MetalRatesScreen extends StatefulWidget {
  @override
  _MetalRatesScreenState createState() => _MetalRatesScreenState();
}

class _MetalRatesScreenState extends State<MetalRatesScreen> {
  late Future<MetalModel> futureMetalPrices;
  int currentIndex = 2; //  هذا هو الرقم الصحيح لشاشة المعادن
  bool _isSearching = false;
  final TextEditingController _searchTextController = TextEditingController();
  List<String> metalList = [];
  List<String> filteredMetalList = [];
  String errorMessage = '';
  Map<String, bool> favoriteMetals = {};

  @override
  void initState() {
    super.initState();
    futureMetalPrices = WebService().fetchMetalPrices();
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
        errorMessage = filteredMetalList.isEmpty
            ? 'No metals found'
            : '';
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
      appBar: _isSearching
          ? AppBar(
              backgroundColor: const Color(kPrimaryColor),
              title: TextField(
                controller: _searchTextController,
                decoration: InputDecoration(
                  hintText: 'Search for a metal...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
                onChanged: addSearchedForMetalToSearchedList,
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: _stopSearching,
              ),
            )
          : CustomAppBar(onSearchPressed: _startSearch, showBackButton: false),
      body: FutureBuilder<MetalModel>(
        future: futureMetalPrices,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final prices = snapshot.data!.getMetalPrices();
            metalList = prices.keys.toList();
            if (filteredMetalList.isEmpty) {
              filteredMetalList.addAll(metalList);
            }

            if (errorMessage.isNotEmpty) {
              return Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      errorMessage,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.h),
                    Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 35.w,
                    ),
                  ],
                ),
              );
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
                    margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5d6d7e),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              SizedBox(width: 8.h),
                              Text(
                                metal,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Text(
                                '${price?.toStringAsFixed(2)}\$',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
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
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
