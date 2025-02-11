// lib/constants/crypto_translations.dart

import 'package:flutter/material.dart';

Map<String, String> cryptoTranslations = {
  'Bitcoin': 'بيتكوين',
  'Ethereum': 'إيثريوم',
  'XRP': 'إكس آر بي',
  'Tether': 'تيثر',
  'Solana': 'سولانا',
  'BNB': 'بي ان بي',
  'USDC': 'يو اس دي سي',
  'Dogecoin': 'دوجكوين',
  'Cardano': 'كاردانو',
  'TRON': 'ترون',
  'Wrapped Bitcoin': 'بيتكوين مغلف',
  'Chainlink': 'تشين لينك',
  'Wrapped stETH': 'ست إيث مغلف',
  'Avalanche': 'أفالانش',
  'Stellar': 'ستيلار',
  'Sui': 'سوي',
  'Hedera': 'هديرا',
  'Toncoin': 'تون كوين',
  'LEO Token': 'توكن ليو',
  'Shiba Inu': 'شيبا إينو',
  'Hyperliquid': 'هايبر ليكيد',
  'Bitget Token': 'بتجيت توكن',
  'WETH': 'ويث',
  'Litecoin': 'لايتكوين',
  'Polkadot': 'بولكادوت',
  'USDS': 'يو اس دي اس',
  'Bitcoin Cash': 'بيتكوين كاش',
  'Ethena USDe': 'إيثينا يو اس ديه',
  'MANTRA': 'مانترا',
};

String getTranslatedCryptoName(String cryptoName, Locale currentLocale) {
  if (currentLocale.languageCode == 'ar') {
    return cryptoTranslations[cryptoName] ?? cryptoName;
  }
  return cryptoName;
}
// lib/constants/metal_translations.dart

Map<String, String> metalTranslations = {
  'gold': 'ذهب',
  'silver': 'فضة',
  'platinum': 'بلاتين',
  'palladium': 'بالاديوم',
  'copper': 'نحاس',
  'aluminum': 'ألومنيوم',
  'lead': 'رصاص',
  'nickel': 'نيكل',
  'zinc': 'زنك',
};

String getTranslatedMetalName(String metalName, Locale currentLocale) {
  if (currentLocale.languageCode == 'ar') {
    return metalTranslations[metalName] ?? metalName;
  }
  return metalName;
}
Map<String, String> currencyTranslations = {
  "USD": "دولار أمريكي",
  "AED": "درهم إماراتي",
  "AFN": "أفغاني",
  "ALL": "ليك ألباني",
  "AMD": "درام أرميني",
  "ANG": "جلدر أنتيلي",
  "AOA": "كوانزا أنغولي",
  "ARS": "بيزو أرجنتيني",
  "AUD": "دولار أسترالي",
  "AWG": "فلورن أروبي",
  "AZN": "منات أذربيجاني",
  "BAM": "مارك بوسني",
  "BBD": "دولار بربادوسي",
  "BDT": "تكا بنغلاديشي",
  "BGN": "ليف بلغاري",
  "BHD": "دينار بحريني",
  "BIF": "فرنك بوروندي",
  "BMD": "دولار برمودي",
  "BND": "دولار بروني",
  "BOB": "بوليفيانو بوليفي",
  "BRL": "ريال برازيلي",
  "BSD": "دولار بهامي",
  "BTN": "نوترام بوتاني",
  "BWP": "بولا بوتسواني",
  "BYN": "روبل بيلاروسي",
  "BZD": "دولار بليز",
  "CAD": "دولار كندي",
  "CDF": "فرنك كونغولي",
  "CHF": "فرنك سويسري",
  "CLP": "بيزو تشيلي",
  "CNY": "يوان صيني",
  "COP": "بيزو كولومبي",
  "CRC": "كولون كوستاريكي",
  "CUP": "بيزو كوبي",
  "CVE": "إسكودو كاب فيردي",
  "CZK": "كرونة تشيكية",
  "DJF": "فرنك جيبوتي",
  "DKK": "كرونة دنماركية",
  "DOP": "بيزو دومينيكاني",
  "DZD": "دينار جزائري",
  "EGP": "جنيه مصري",
  "ERN": "ناكفا إريتري",
  "ETB": "بر إيثيوبي",
  "EUR": "يورو",
  "FJD": "دولار فيجي",
  "FKP": "جنيه فوكلاند",
  "FOK": "كرونة فارو",
  "GBP": "جنيه إسترليني",
  "GEL": "لاري جورجي",
  "GGP": "جنيه جيرسي",
  "GHS": "سيدي غاني",
  "GIP": "جنيه جبل طارق",
  "GMD": "دالاسي غامبي",
  "GNF": "فرنك غيني",
  "GTQ": "كيتزال غواتيمالي",
  "GYD": "دولار غياني",
  "HKD": "دولار هونغ كونغ",
  "HNL": "ليمبيرة هندوراسي",
  "HRK": "كونا كرواتي",
  "HTG": "غورد هاييتي",
  "HUF": "فورينت هنغاري",
  "IDR": "روبية إندونيسية",
  "ILS": "شيكل إسرائيلي",
  "IMP": "جنيه آيل أوف مان",
  "INR": "روبية هندية",
  "IQD": "دينار عراقي",
  "IRR": "ريال إيراني",
  "ISK": "كرونة آيسلندية",
  "JOD": "دينار أردني",
  "JPY": "ين ياباني",
  "KES": "شلن كيني",
  "KGS": "سوم قيرغيزستاني",
  "KHR": "ريال كمبودي",
  "KWD": "دينار كويتي",
  "KZT": "تنغي كازاخستاني",
  "LBP": "ليرة لبنانية",
  "LKR": "روبية سريلانكية",
  "MAD": "درهم مغربي",
  "MYR": "رينغيت ماليزي",
  "OMR": "ريال عماني",
  "QAR": "ريال قطري",
  "SAR": "ريال سعودي",
  "TRY": "ليرة تركية",
  "USD": "دولار أمريكي",
  "ZAR": "راند جنوب أفريقي",
  "ZWL": "دولار زيمبابوي",
  // Add remaining currencies as needed
};

String getTranslatedCurrencyName(String currencyCode, Locale currentLocale) {
  if (currentLocale.languageCode == 'ar') {
    return currencyTranslations[currencyCode] ?? currencyCode;
  }
  return currencyCode;
}
