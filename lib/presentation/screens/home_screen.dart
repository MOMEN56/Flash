import 'package:flash/business_logic/cubit/currencies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // استخدام BlocBuilder

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // التأكد من استدعاء الدالة
    context.read<CurrenciesCubit>().fetchCurrencies();

    return Scaffold(
      appBar: AppBar(title: const Text('Currency Rates')),
      body: BlocBuilder<CurrenciesCubit, CurrenciesState>(
        builder: (context, state) {
          if (state is CurrenciesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CurrenciesLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Currency',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Exchange Rate',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: state.currencies.map<DataRow>((currency) {
                    return DataRow(cells: [
                      DataCell(
                        Text(currency.result), // عرض اسم العملة
                      ),
                      DataCell(
                        Text(currency.conversionRates.toString()), // عرض السعر
                      ),
                    ]);
                  }).toList(),
                ),
              ),
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
