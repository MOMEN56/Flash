import 'package:flash/presentation/widgets/custom_app_bar.dart';
import 'package:flash/presentation/widgets/text_info_in_crypto_info_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flash/data/models/cyrpto_model.dart';
import 'package:flash/generated/l10n.dart'; // استيراد ملف الترجمة

class CryptoInfoScreen extends StatelessWidget {
  final CryptoModel crypto;

  const CryptoInfoScreen({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showSearchIcon: false, titlePaddingLeft: 50.h, rightPadding: 50,),
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
                  label: S.of(context).name, value: crypto.name),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: S.of(context).symbol, value: crypto.symbol),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: S.of(context).currentPrice,
                  value: '${crypto.currentPrice.toStringAsFixed(2)} \$'),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: S.of(context).marketCap,
                  value: '${crypto.marketCap.toStringAsFixed(2)} \$'),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: S.of(context).marketCapRank,
                  value: crypto.marketCapRank.toString()),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: S.of(context).totalVolume,
                  value: '${crypto.totalVolume.toStringAsFixed(2)} \$'),
              TextInfoTextInCryptoInfoScreenWidget(
                label: S.of(context).high24h,
                value: '${crypto.high24h.toStringAsFixed(2)} \$',
                fontSize: 9.sp,
              ),
              TextInfoTextInCryptoInfoScreenWidget(
                label: S.of(context).low24h,
                value: '${crypto.low24h.toStringAsFixed(2)} \$',
                fontSize: 9.sp,
              ),
              TextInfoTextInCryptoInfoScreenWidget(
                label: S.of(context).priceChange24h,
                value: '${crypto.priceChange24h.toStringAsFixed(2)} \$',
                fontSize: 9.sp,
              ),
              TextInfoTextInCryptoInfoScreenWidget(
                label: S.of(context).priceChangePercentage24h,
                value:
                    '${crypto.priceChangePercentage24h.toStringAsFixed(2)} %',
                fontSize: 9.sp,
              ),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: S.of(context).circulatingSupply,
                  value: crypto.circulatingSupply.toStringAsFixed(2)),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: S.of(context).totalSupply,
                  value: crypto.totalSupply.toStringAsFixed(2)),
              if (crypto.maxSupply != null)
                TextInfoTextInCryptoInfoScreenWidget(
                    label: S.of(context).maxSupply,
                    value: crypto.maxSupply!.toStringAsFixed(2)),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: S.of(context).ath,
                  value: '${crypto.ath.toStringAsFixed(2)} \$'),
              TextInfoTextInCryptoInfoScreenWidget(
                  label: S.of(context).atl,
                  value: '${crypto.atl.toStringAsFixed(2)} \$'),
            ],
          ),
        ),
      ),
    );
  }
}
