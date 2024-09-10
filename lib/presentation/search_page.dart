import 'dart:async';
import 'package:flutter/material.dart';
import '../data/model/address.model.dart';
import '../data/service/api.service.dart';
import '../utils/dimens.dart';
import 'widgets/item_address.widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<AddressModel> _searchResults = [];
  bool _isLoading = false;
  bool _isEmptyTextField = true;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      _performSearch(_searchController.text);
    });
  }

  void _performSearch(String query) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final results = await ApiService.searchAddress(query);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsetsDirectional.fromSTEB(16, Dimens.padding.top * 2, 16, 0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                onChanged: (e) {
                  setState(() {
                    _isEmptyTextField = _searchController.text.isEmpty;
                  });
                },
                controller: _searchController,
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Enter keyword",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: _isLoading
                      ? const SizedBox(
                          width: 4,
                          height: 4,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.teal,
                          )))
                      : const Icon(Icons.search),
                  suffixIcon: _isEmptyTextField
                      ? null
                      : GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            FocusScope.of(context).unfocus();
                            setState(() {
                              _isEmptyTextField = true;
                              _searchResults = [];
                            });
                          },
                          child: const Icon(Icons.close),
                        ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ItemAddress(
                      addressModel: _searchResults[index],
                      searchQuery: _searchController.text,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                  itemCount: _searchResults.length),
            ),
          ],
        ),
      ),
    );
  }
}
