import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nawy_search/core/constants/colors.dart';
import 'package:provider/provider.dart';

import '../../models/area.dart';
import '../../view_models/search_view_model.dart';

class AreaCompoundSearchField extends StatefulWidget {
  const AreaCompoundSearchField({super.key});

  @override
  State<AreaCompoundSearchField> createState() =>
      _AreaCompoundSearchFieldState();
}

class _AreaCompoundSearchFieldState extends State<AreaCompoundSearchField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(width: 1.0, color: lightTextColor),
          ),
          padding: const EdgeInsets.only(left: 16.0),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              labelText: 'Area, Compound',
              labelStyle: TextStyle(color: lightTextColor),
              icon: Icon(Icons.search, color: primaryColor),
              border: InputBorder.none,
            ),
            onChanged: viewModel.handleSearchInput,
          ),
        ),
        if (viewModel.suggestions.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ListView.builder(
              itemExtent: 60, // optional for performance

              shrinkWrap: true,
              itemCount: viewModel.suggestions.length > 4
                  ? 4
                  : viewModel.suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = viewModel.suggestions[index];
                return ListTile(
                  title: Text(suggestion.name),
                  leading: suggestion is Area
                      ? const Icon(Icons.location_city)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CachedNetworkImage(
                            imageUrl: suggestion.imagePath,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.image_not_supported),
                          ),
                        ),
                  onTap: () {
                    viewModel.selectSuggestion(suggestion);
                    _controller.clear();
                    viewModel.updateSuggestions('');
                    _focusNode.unfocus(); // hide keyboard
                  },
                );
              },
            ),
          ),
        const SizedBox(height: 8),
        if (viewModel.selectedArea != null)
          Text("Selected Area: ${viewModel.selectedArea!.name}"),
        if (viewModel.selectedCompound != null)
          Text("Selected Compound: ${viewModel.selectedCompound!.name}"),
      ],
    );
  }
}
