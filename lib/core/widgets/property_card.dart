import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nawy_search/core/constants/colors.dart';
import '../../features/explore/models/property.dart';
import 'contact_button.dart';
import 'custom_text.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback? onTap;

  const PropertyCard({super.key, required this.property, this.onTap});

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.decimalPattern();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x081638CF),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color(0x08344214),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 174),
              child: CachedNetworkImage(
                fadeInDuration: Duration(milliseconds: 300),
                imageUrl: property.image,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
                errorWidget: (context, url, error) => SizedBox(
                  height: 174,
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              children: [
                // Property Type & Delivery Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: property.propertyTypeName ?? '',
                      color: navyTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    CustomText(
                      text: property.minReadyBy != null
                          ? "Delivery ${property.minReadyBy!.substring(0, 4)}"
                          : "",
                      color: greyTextColor,
                      fontSize: 16,
                    ),
                  ],
                ),
                // Price and Favorite Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text:
                          "${property.currency} ${numberFormat.format(property.maxPrice ?? 0)}",
                      color: orangeColor,
                      fontWeight: FontWeight.w700,
                    ),

                    InkWell(
                      onTap: onTap,
                      child: Icon(
                        property.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Color(0xFFA9C7DB),
                        size: 35,
                      ),
                    ),
                  ],
                ),
                // Installments
                if ((property.minInstallments ?? 0) > 0)
                  Row(
                    children: [
                      CustomText(
                        text:
                            "${numberFormat.format(property.minInstallments)} ${property.currency}/month over ${property.maxInstallmentYears} years",
                        color: greyTextColor,
                        fontSize: 14,
                      ),
                    ],
                  ),
                // Compound Name
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: property.compoundName ?? '',
                          color: darkGreyTextColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: property.areaName ?? '',
                          color: darkGreyTextColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Rooms, Bathrooms, Area
          Container(
            height: 45.0,
            color: const Color(0xFFFAFAFA),
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (property.numberOfBedrooms != null)
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/bed.svg',
                        height: 24,
                        width: 20,
                      ),
                      CustomText(
                        marginLeft: 4,
                        text: "${property.numberOfBedrooms}",
                        fontSize: 14,
                        color: navyTextColor,
                      ),
                    ],
                  ),
                if (property.numberOfBathrooms != null)
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/bath.svg',
                        height: 16,
                        // width: 20,
                      ),
                      CustomText(
                        marginLeft: 4,
                        text: "${property.numberOfBathrooms}",
                        fontSize: 14,
                        color: navyTextColor,
                      ),
                    ],
                  ),
                if (property.maxUnitArea != null)
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/area.svg',
                        height: 16,
                        // width: 20,
                      ),
                      CustomText(
                        marginLeft: 4,
                        text: "${property.maxUnitArea} ㎡",
                        fontSize: 14,
                        color: navyTextColor,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ContactButton(text: 'Zoom', iconPath: 'assets/icons/zoom.svg'),
              ContactButton(
                text: 'Call',
                iconPath: 'assets/icons/call.svg',
                width: 13,
                height: 13,
              ),
              ContactButton(
                text: 'Whatsapp',
                iconPath: 'assets/icons/whatsapp.svg',
                width: 17,
                height: 17,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
