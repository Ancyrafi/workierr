import 'dart:async';

import 'package:aplikacja/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/firebase/cos.dart';
import '../../widgets/textfield.dart';
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
  final _cityController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  var addressController = TextEditingController();
  final _fullDescriptionController = TextEditingController();
  int? _selectedDuration;

  bool closeSearch = false;

  final StreamController<List<String>?> _sugestionAdres =
      StreamController<List<String>?>();
  Timer? _debounce;

  void onSearchTextChanged(String searchText) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    if (searchText.isEmpty) {
      setState(() {
        closeSearch = false;
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      List<String> suggestions = await getPlaceSuggestions(searchText);
      _sugestionAdres.add(suggestions);
      setState(() {
        closeSearch = true;
      });
    });
  }

  @override
  void dispose() {
    addressController.dispose();
    _sugestionAdres.close();
    _debounce?.cancel();
    super.dispose();
  }

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
                      buildTextField(
                        visible: false,
                        labelText: 'Tytuł Zlecenia',
                        controller: _titleController,
                        hintText: 'Podaj tytuł swojego zlecenia',
                        maxLength: 15,
                      ),
                      buildTextField(
                        visible: false,
                        labelText: 'Krótki opis zlecenia',
                        controller: _descriptionController,
                        hintText:
                            'Napisz krótki opis zlecenia, aby był widoczny na liście wyboru',
                        maxLength: 15,
                      ),
                      TextField(
                        controller: addressController,
                        onChanged: onSearchTextChanged,
                        decoration: InputDecoration(
                          hintText: 'Podaj Adres',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                        ),
                      ),
                      TextField(
                        controller: _cityController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'Wpisz miasto.'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder(
                          stream: _sugestionAdres.stream,
                          builder: (context, snapshot) {
                            if (!closeSearch || !snapshot.hasData) {
                              return Container();
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(snapshot.data![index]),
                                    onTap: () {
                                      setState(() {
                                        List<String> city =
                                            snapshot.data![index].split(', ');
                                        if (city.length > 1) {
                                          city.removeAt(0);
                                          city.removeLast();
                                        }
                                        String citys = city[0];
                                        _debounce?.cancel();
                                        addressController.text =
                                            snapshot.data![index];
                                        _cityController.text = citys;
                                        closeSearch = false;
                                      });
                                    },
                                  );
                                },
                              );
                            }
                          }),
                      buildTextField(
                          visible: false,
                          controller: _priceController,
                          hintText:
                              'Podaj nam informacje ile jesteś wstanie zapłacić za wykonanie usługi',
                          labelText: 'Kwota',
                          keyboardType: TextInputType.number,
                          suffixText: 'Zł',
                          maxLength: 5),
                      buildTextField(
                        visible: false,
                        controller: _phoneNumberController,
                        hintText: 'Podaj numer telefonu w celach kontaktowych',
                        labelText: 'Numer Kontaktowy',
                        keyboardType: TextInputType.phone,
                        maxLength: 12,
                      ),
                      buildTextField(
                        visible: false,
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
                              addressController.text.isNotEmpty &&
                              _fullDescriptionController.text.isNotEmpty &&
                              _selectedDuration != null) {
                            context.read<AddOrderCubit>().addOrder(
                                  city: _cityController.text,
                                  title: _titleController.text,
                                  description: _descriptionController.text,
                                  price: _priceController.text,
                                  phoneNumber: _phoneNumberController.text,
                                  adress: addressController.text,
                                  fullDescription:
                                      _fullDescriptionController.text,
                                  minutes: _selectedDuration ?? 30,
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
}
