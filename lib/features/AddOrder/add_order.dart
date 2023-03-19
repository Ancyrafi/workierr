import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import 'cubit/addorder_cubit.dart';

class AddOrderPage extends StatefulWidget {
  const AddOrderPage({super.key});

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddOrderCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dodaj zlecenie'),
        ),
        body: BlocBuilder<AddOrderCubit, bool>(
          builder: (context, isSuccess) {
            if (isSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();
              });
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Tytuł zlecenia',
                      hintText: 'Wprowadź tytuł zlecenia',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Opis zlecenia',
                      hintText: 'Wprowadź opis zlecenia',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number, // Dodaj to
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+(\.\d+)?')), // Dodaj to
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Kwota',
                      hintText: 'Wprowadź ile możesz zapłacić za zadanie!',
                      suffixText: 'zł', // Dodaj to
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AddOrderCubit>().addOrder(
                            _titleController.text,
                            _descriptionController.text,
                            _priceController.text,
                          );
                    },
                    child: const Text('Dodaj zlecenie'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
