import 'package:flash/business_logic/cubit/currencies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // استخدام BlocBuilder

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currency Rates')),
      body: BlocBuilder<CurrenciesCubit, CurrenciesState>(
        builder: (context, state) {
          if (state is CurrenciesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CurrenciesLoaded) {
            // عرض العملات بعد تحميلها
            return ListView.builder(
              itemCount: state.currencies.length,
              itemBuilder: (context, index) {
                var currency = state.currencies[index];
                return ListTile(
                  title: Text(currency.result),
                  subtitle: Text(currency.conversionRates.toString()),
                );
              },
            );
          } else if (state is CurrenciesError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
