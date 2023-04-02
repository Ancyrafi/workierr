import 'package:aplikacja/features/details/extras/extras_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/repository.dart';
import 'cubit/edit_order_cubit.dart';

class EditOrderPage extends StatefulWidget {
  const EditOrderPage({required this.id, Key? key}) : super(key: key);

  final String id;

  @override
  State<EditOrderPage> createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _fullDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditOrderCubit(Repository()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edytuj swoje zlecenie'),
        ),
        body: SafeArea(
          child: BlocBuilder<EditOrderCubit, EditOrderState>(
            builder: (context, state) {
              if (state.isSucces) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop();
                });
              }

              return Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTextField(
                        labelText: 'Krótki opis zlecenia',
                        controller: _descriptionController,
                        hintText:
                            'Napisz krótki opis zlecenia, aby był widoczny na liście wyboru',
                      ),
                      _buildTextField(
                          controller: _priceController,
                          hintText:
                              'Podaj nam informacje ile jesteś wstanie zapłacić za wykonanie usługi',
                          labelText: 'Kwota',
                          keyboardType: TextInputType.number,
                          suffixText: 'Zł'),
                      _buildTextField(
                        controller: _phoneNumberController,
                        hintText: 'Podaj numer telefonu w celach kontaktowych',
                        labelText: 'Numer Kontaktowy',
                        keyboardType: TextInputType.phone,
                      ),
                      _buildTextField(
                          controller: _addressController,
                          hintText:
                              'Podaj adres, na który ma się stawić zleceniobiorca',
                          labelText: 'Adres'),
                      _buildTextField(
                        labelText:
                            'Pełny opis, Opisz dokładnie czego wymagasz.',
                        controller: _fullDescriptionController,
                        hintText: 'Pełny opis',
                        maxLength: 250,
                        maxLines: 4,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_descriptionController.text.isNotEmpty &&
                              _priceController.text.isNotEmpty &&
                              _phoneNumberController.text.isNotEmpty &&
                              _addressController.text.isNotEmpty &&
                              _fullDescriptionController.text.isNotEmpty) {
                            context.read<EditOrderCubit>().editOrder(
                                  description: _descriptionController.text,
                                  price: _priceController.text,
                                  phoneNumber: _phoneNumberController.text,
                                  adress: _addressController.text,
                                  fullDescription:
                                      _fullDescriptionController.text,
                                  id: widget.id,
                                );
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ExtrasPage(
                                      id: widget.id,
                                    )));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.black,
                                content: Text('Pola nie mogą być puste!'),
                              ),
                            );
                          }
                        },
                        child: const Text('Zapisz podane zmiany'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    int maxLines = 1,
    String? suffixText,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          counterText: '',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          suffixText: suffixText,
        ),
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _priceController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _fullDescriptionController.dispose();
    super.dispose();
  }
}
