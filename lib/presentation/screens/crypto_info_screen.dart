import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flash/presentation/widgets/text_info_in_crypto_info_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flash/data/models/cyrpto_model.dart';
import 'package:flash/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flash/presentation/screens/crypto_rates_screen.dart';
import 'package:flash/presentation/screens/currencies_rates_screen.dart';

class CryptoInfoScreen extends StatelessWidget {
  final CryptoModel crypto;

  const CryptoInfoScreen({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
      int currentIndex = 0; // Track bottom bar index

    return Scaffold(
      appBar:
          CustomAppBar(showSearchIcon: false, titlePaddingLeft: 30.h),
      body: SingleChildScrollView(
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
              TextInfoTextInCryptoInfoScreenWidget(
                  label: 'Name', value: crypto.name),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: 'Symbol', value: crypto.symbol),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: 'Current Price',
                  value: '${crypto.currentPrice.toStringAsFixed(2)} \$'),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: 'Market Cap',
                  value: '${crypto.marketCap.toStringAsFixed(2)} \$'),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: 'Market Cap Rank',
                  value: crypto.marketCapRank.toString()),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: 'Total Volume',
                  value: '${crypto.totalVolume.toStringAsFixed(2)} \$'),
              TextInfoTextInCryptoInfoScreenWidget(
                label: 'Highest Price In The Last 24 Hours',
                value: '${crypto.high24h.toStringAsFixed(2)} \$',
                fontSize: 9.sp,
              ),
              TextInfoTextInCryptoInfoScreenWidget(
                label: 'Lowest Price In The Last 24 Hours',
                value: '${crypto.low24h.toStringAsFixed(2)} \$',
                fontSize: 9.sp,
              ),
              TextInfoTextInCryptoInfoScreenWidget(
                label: 'Price Change In The Last 24 Hour',
                value: '${crypto.priceChange24h.toStringAsFixed(2)} \$',
                fontSize: 9.sp,
              ),
              TextInfoTextInCryptoInfoScreenWidget(
                label: 'Price Change Percentage In The Last 24 Hour',
                value:
                    '${crypto.priceChangePercentage24h.toStringAsFixed(2)} %',
                fontSize: 9.sp,
              ),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: 'Circulating Supply',
                  value: crypto.circulatingSupply.toStringAsFixed(2)),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: 'Total Supply',
                  value: crypto.totalSupply.toStringAsFixed(2)),
              if (crypto.maxSupply != null)
                TextInfoTextInCryptoInfoScreenWidget(
                    label: 'Max Supply',
                    value: crypto.maxSupply!.toStringAsFixed(2)),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: 'Highest Price Overall',
                  value: '${crypto.ath.toStringAsFixed(2)} \$'),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: 'Lowest Price Overall',
                  value: '${crypto.atl.toStringAsFixed(2)} \$'),
            ],
          ),
        ),
      ),
      
    );
  }
}
