import 'package:flutter/material.dart';
import 'package:zephir/services/weather_service.dart';

// champ de recherche pour l'auto completion
class CitySearchField extends StatefulWidget {
  final TextEditingController controller;
  final Function(Map<String, dynamic>) onCitySelected;
  final VoidCallback onHeartPressed;

  const CitySearchField({
    super.key,
    required this.controller,
    required this.onCitySelected,
    required this.onHeartPressed,
  });

  @override
  State<CitySearchField> createState() => _CitySearchFieldState();
}

class _CitySearchFieldState extends State<CitySearchField> {
  // je garde dans un tableau
  List<Map<String, dynamic>> _suggestions = [];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Map<String, dynamic>>(
      displayStringForOption: (option) =>
          option['name'] ?? '', // juste nom de ville
      optionsBuilder: (TextEditingValue value) async {
        if (value.text.length < 2) {
          return const Iterable<Map<String, dynamic>>.empty();
        }

        _suggestions = await WeatherService.getCitySuggestions(
          value.text,
        ); // je recupere les suggestions
        return _suggestions;
      },
      onSelected: (selection) {
        widget.onCitySelected(selection);
        widget.controller.clear(); // vide le champ une fois choisit
      },
      fieldViewBuilder: (context, textController, focusNode, onFieldSubmitted) {
        widget.controller.addListener(() {
          textController.text = widget.controller.text;
          textController.selection = TextSelection.fromPosition(
            TextPosition(offset: textController.text.length),
          );
        });

        return TextField(
          controller: widget.controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: "Nom de la ville",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.blue[50],
            suffixIcon: IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                widget.onHeartPressed();
              },
            ),
          ),
          onSubmitted: (value) async {
            if (value.trim().isEmpty) return;

            final results = await WeatherService.getCitySuggestions(value);
            if (results.isNotEmpty) {
              widget.onCitySelected(results.first);
              widget.controller.clear();
            }
          },
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return ListTile(
                    title: Text(
                      option['name'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      widget.controller.clear();
                      onSelected(option);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
