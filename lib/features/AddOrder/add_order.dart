import 'package:aplikacja/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _fullDescriptionController = TextEditingController();
  int? _selectedDuration;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddOrderCubit(Repository()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dodaj zlecenie'),
        ),
        body: SafeArea(
          child: BlocBuilder<AddOrderCubit, bool>(
            builder: (context, isSucces) {
              if (isSucces) {
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
                        labelText: 'Tytuł Zlecenia',
                        controller: _titleController,
                        hintText: 'Podaj tytuł swojego zlecenia',
                      ),
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
                      DropdownButton<int>(
                        value: _selectedDuration,
                        hint: const Text('Wybierz czas trwania'),
                        onChanged: (int? newValue) {
                          setState(() {
                            _selectedDuration = newValue;
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                            value: 30,
                            child: Text('30 minut'),
                          ),
                          DropdownMenuItem(
                            value: 60,
                            child: Text('1 godzina'),
                          ),
                          DropdownMenuItem(
                            value: 180,
                            child: Text('3 godziny'),
                          ),
                          DropdownMenuItem(
                            value: 360,
                            child: Text('6 godzin'),
                          ),
                          DropdownMenuItem(
                            value: 540,
                            child: Text('9 godzin'),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Text('minuta test'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_titleController.text.isNotEmpty &&
                              _descriptionController.text.isNotEmpty &&
                              _priceController.text.isNotEmpty &&
                              _phoneNumberController.text.isNotEmpty &&
                              _addressController.text.isNotEmpty &&
                              _fullDescriptionController.text.isNotEmpty &&
                              _selectedDuration != null) {
                            context.read<AddOrderCubit>().addOrder(
                                  title: _titleController.text,
                                  description: _descriptionController.text,
                                  price: _priceController.text,
                                  phoneNumber: _phoneNumberController.text,
                                  adress: _addressController.text,
                                  fullDescription:
                                      _fullDescriptionController.text,
                                  hours: _selectedDuration ?? 30,
                                );
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.black,
                                content: Text('Pola nie mogą być puste!'),
                              ),
                            );
                          }
                        },
                        child: const Text('Dodaj zlecenie'),
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
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _fullDescriptionController.dispose();
    super.dispose();
  }
}
