import 'package:flutter/material.dart';
import 'package:nawy_search/core/constants/colors.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/custom_text.dart';
import '../../view_models/search_view_model.dart';

class BedroomsRangeSlider extends StatefulWidget {
  const BedroomsRangeSlider({super.key});

  @override
  State<BedroomsRangeSlider> createState() => _BedroomsRangeSliderState();
}

class _BedroomsRangeSliderState extends State<BedroomsRangeSlider> {
  late RangeValues _values;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<SearchViewModel>(context, listen: false);
    final min = viewModel.minBedrooms;
    final max = viewModel.maxBedrooms;

    final range = max - min;
    final defaultStart = (min + range * 0.3).round();
    final defaultEnd = (min + range * 0.7).round();

    _values = RangeValues(
      (viewModel.selectedMinBedrooms ?? defaultStart).toDouble(),
      (viewModel.selectedMaxBedrooms ?? defaultEnd).toDouble(),
    );
    viewModel.selectedMinBedrooms ??= defaultStart;
    viewModel.selectedMaxBedrooms ??= defaultEnd;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchViewModel>(context);
    final min = viewModel.minBedrooms.toDouble();
    final max = viewModel.maxBedrooms.toDouble();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: 'Rooms', fontSize: 16),
              CustomText(
                text:
                    "${_values.start.round()} ~ ${_values.end.round()}+ rooms",
                fontSize: 12,
                color: lightTextColor,
              ),
            ],
          ),
        ),
        SliderTheme(
          data: const SliderThemeData(
            trackHeight: 2,
            activeTrackColor: primaryColor,
            inactiveTrackColor: lightBlueColor,
            thumbColor: primaryColor,
          ),
          child: RangeSlider(
            values: _values,
            min: min,
            max: max,
            divisions: (max - min).toInt(),
            labels: RangeLabels(
              _values.start.round().toString(),
              _values.end.round().toString(),
            ),
            onChanged: (values) {
              setState(() => _values = values);

              // Save to ViewModel
              viewModel.selectedMinBedrooms = values.start.round();
              viewModel.selectedMaxBedrooms = values.end.round();
              viewModel.notifyListeners(); // optional
            },
          ),
        ),
      ],
    );
  }
}
