class CryptoModel {
  final String id;
  final String symbol;
  final String name;
  final double currentPrice;
  final double marketCap;
  final double totalVolume;
  final double high24h;
  final double low24h;
  final double priceChange24h;
  final double priceChangePercentage24h;
  final double marketCapChange24h;
  final double marketCapChangePercentage24h;
  final double circulatingSupply;
  final double totalSupply;
  final double ath; // All-time high
  final double atl; // All-time low

  CryptoModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.marketCap,
    required this.totalVolume,
    required this.high24h,
    required this.low24h,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    required this.marketCapChange24h,
    required this.marketCapChangePercentage24h,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.ath,
    required this.atl,
  });

  // Factory constructor for creating a new CryptoModel from JSON
  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      currentPrice: json['current_price'].toDouble(),
      marketCap: json['market_cap'].toDouble(),
      totalVolume: json['total_volume'].toDouble(),
      high24h: json['high_24h'].toDouble(),
      low24h: json['low_24h'].toDouble(),
      priceChange24h: json['price_change_24h'].toDouble(),
      priceChangePercentage24h: json['price_change_percentage_24h'].toDouble(),
      marketCapChange24h: json['market_cap_change_24h'].toDouble(),
      marketCapChangePercentage24h: json['market_cap_change_percentage_24h'].toDouble(),
      circulatingSupply: json['circulating_supply'].toDouble(),
      totalSupply: json['total_supply'].toDouble(),
      ath: json['ath'].toDouble(),
      atl: json['atl'].toDouble(),
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'current_price': currentPrice,
      'market_cap': marketCap,
      'total_volume': totalVolume,
      'high_24h': high24h,
      'low_24h': low24h,
      'price_change_24h': priceChange24h,
      'price_change_percentage_24h': priceChangePercentage24h,
      'market_cap_change_24h': marketCapChange24h,
      'market_cap_change_percentage_24h': marketCapChangePercentage24h,
      'circulating_supply': circulatingSupply,
      'total_supply': totalSupply,
      'ath': ath,
      'atl': atl,
    };
  }
}
