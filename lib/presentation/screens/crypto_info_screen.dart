import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flash/data/models/cyrpto_model.dart';
import 'package:flash/presentation/widgets/custom_bottom_navigation_bar.dart';

class CryptoInfoScreen extends StatelessWidget {
  final CryptoModel crypto;

  const CryptoInfoScreen({Key? key, required this.crypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showSearchIcon: false, titlePaddingLeft: 50),
      body: SingleChildScrollView( // Wrap the content with SingleChildScrollView to enable scrolling
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ClipOval(
                  child: Image.network(
                    crypto.image,
                    width: 180.h,
                    height: 180.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Add CryptoModel details below
              _buildInfoText('Name', crypto.name),
              _buildInfoText('Symbol', crypto.symbol),
              _buildInfoText('Current Price', '${crypto.currentPrice.toStringAsFixed(2)} \$'),
              _buildInfoText('Market Cap', '${crypto.marketCap.toStringAsFixed(2)} \$'),
              _buildInfoText('Market Cap Rank', crypto.marketCapRank.toString()),
              _buildInfoText('Total Volume', '${crypto.totalVolume.toStringAsFixed(2)} \$'),
              _buildInfoText('Highest Price In The Last 24 Hours', '${crypto.high24h.toStringAsFixed(2)} \$'),
              _buildInfoText('Lowest Price In The Last 24 Hours', '${crypto.low24h.toStringAsFixed(2)} \$'),
              _buildInfoText('Price Change In The Last 24 Hour', '${crypto.priceChange24h.toStringAsFixed(2)} \$'),
              _buildInfoText('Price Change Percentage (24h)', '${crypto.priceChangePercentage24h.toStringAsFixed(2)} %'),
              _buildInfoText('Circulating Supply', '${crypto.circulatingSupply.toStringAsFixed(2)}'),
              _buildInfoText('Total Supply', '${crypto.totalSupply.toStringAsFixed(2)}'),
              if (crypto.maxSupply != null) _buildInfoText('Max Supply', '${crypto.maxSupply!.toStringAsFixed(2)}'),
              _buildInfoText('Highest Price Overal', '${crypto.ath.toStringAsFixed(2)} \$'),
              _buildInfoText('Lowest Price Overal', '${crypto.atl.toStringAsFixed(2)} \$'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);  // Go back when the first item is tapped
          }
        },
      ),
    );
  }

  Widget _buildInfoText(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              '$value',  // Dollar sign moved to after the value in the calling code
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
