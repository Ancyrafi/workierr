import 'dart:async';

import 'package:aplikacja/features/details/extras/extras_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/firebase/cos.dart';
import '../../repository/repository.dart';
import '../../widgets/textfield.dart';
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
  final addressController = TextEditingController();
  final _fullDescriptionController = TextEditingController();

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
                      buildTextField(
                        visible: false,
                        labelText: 'Krótki opis zlecenia',
                        controller: _descriptionController,
                        hintText:
                            'Napisz krótki opis zlecenia, aby był widoczny na liście wyboru',
                      ),
                      buildTextField(
                          visible: false,
                          controller: _priceController,
                          hintText:
                              'Podaj nam informacje ile jesteś wstanie zapłacić za wykonanie usługi',
                          labelText: 'Kwota',
                          keyboardType: TextInputType.number,
                          suffixText: 'Zł'),
                      TextField(
                        controller: addressController,
                        onChanged: onSearchTextChanged,
                        decoration:
                            const InputDecoration(hintText: 'Podaj Adres'),
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
                                        _debounce?.cancel();
                                        addressController.text =
                                            snapshot.data![index];
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
                        controller: _phoneNumberController,
                        hintText: 'Podaj numer telefonu w celach kontaktowych',
                        labelText: 'Numer Kontaktowy',
                        keyboardType: TextInputType.phone,
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
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_descriptionController.text.isNotEmpty &&
                              _priceController.text.isNotEmpty &&
                              _phoneNumberController.text.isNotEmpty &&
                              addressController.text.isNotEmpty &&
                              _fullDescriptionController.text.isNotEmpty) {
                            context.read<EditOrderCubit>().editOrder(
                                  description: _descriptionController.text,
                                  price: _priceController.text,
                                  phoneNumber: _phoneNumberController.text,
                                  adress: addressController.text,
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
}
