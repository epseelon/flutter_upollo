/*
 * MIT License
 *
 * Copyright (c) 2022 Epseelon OÜ
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

class PostalAddress {
  /// The schema revision of the `PostalAddress`. This must be set to 0, which is
  /// the latest revision.
  ///
  /// All new revisions **must** be backward compatible with old revisions.
  final int revision;

  /// Required. CLDR region code of the country/region of the address. This
  /// is never inferred and it is up to the user to ensure the value is
  /// correct. See http:///cldr.unicode.org/ and
  /// http:///www.unicode.org/cldr/charts/30/supplemental/territory_information.html
  /// for details. Example: "CH" for Switzerland.
  final String regionCode;

  /// Optional. BCP-47 language code of the contents of this address (if
  /// known). This is often the UI language of the input form or is expected
  /// to match one of the languages used in the address' country/region, or their
  /// transliterated equivalents.
  /// This can affect formatting in certain countries, but is not critical
  /// to the correctness of the data and will never affect any validation or
  /// other non-formatting related operations.
  ///
  /// If this value is not known, it should be omitted (rather than specifying a
  /// possibly incorrect default).
  ///
  /// Examples: "zh-Hant", "ja", "ja-Latn", "en".
  final String? languageCode;

  /// Optional. Postal code of the address. Not all countries use or require
  /// postal codes to be present, but where they are used, they may trigger
  /// additional validation with other parts of the address (e.g. state/zip
  /// validation in the U.S.A.).
  final String? postalCode;

  /// Optional. Additional, country-specific, sorting code. This is not used
  /// in most regions. Where it is used, the value is either a string like
  /// "CEDEX", optionally followed by a number (e.g. "CEDEX 7"), or just a number
  /// alone, representing the "sector code" (Jamaica), "delivery area indicator"
  /// (Malawi) or "post office indicator" (e.g. Côte d'Ivoire).
  final String? sortingCode;

  /// Optional. Highest administrative subdivision which is used for postal
  /// addresses of a country or region.
  /// For example, this can be a state, a province, an oblast, or a prefecture.
  /// Specifically, for Spain this is the province and not the autonomous
  /// community (e.g. "Barcelona" and not "Catalonia").
  /// Many countries don't use an administrative area in postal addresses. E.g.
  /// in Switzerland this should be left unpopulated.
  final String? administrativeArea;

  /// Optional. Generally refers to the city/town portion of the address.
  /// Examples: US city, IT comune, UK post town.
  /// In regions of the world where localities are not well defined or do not fit
  /// into this structure well, leave locality empty and use address_lines.
  final String? locality;

  /// Optional. Sublocality of the address.
  /// For example, this can be neighborhoods, boroughs, districts.
  final String? sublocality;

  /// Unstructured address lines describing the lower levels of an address.
  ///
  /// Because values in address_lines do not have type information and may
  /// sometimes contain multiple values in a single field (e.g.
  /// "Austin, TX"), it is important that the line order is clear. The order of
  /// address lines should be "envelope order" for the country/region of the
  /// address. In places where this can vary (e.g. Japan), address_language is
  /// used to make it explicit (e.g. "ja" for large-to-small ordering and
  /// "ja-Latn" or "en" for small-to-large). This way, the most specific line of
  /// an address can be selected based on the language.
  ///
  /// The minimum permitted structural representation of an address consists
  /// of a region_code with all remaining information placed in the
  /// address_lines. It would be possible to format such an address very
  /// approximately without geocoding, but no semantic reasoning could be
  /// made about any of the address components until it was at least
  /// partially resolved.
  ///
  /// Creating an address only containing a region_code and address_lines, and
  /// then geocoding is the recommended way to handle completely unstructured
  /// addresses (as opposed to guessing which parts of the address should be
  /// localities or administrative areas).
  final List<String> addressLines;

  /// Optional. The recipient at the address.
  /// This field may, under certain circumstances, contain multiline information.
  /// For example, it might contain "care of" information.
  final List<String>? recipients;

  /// Optional. The name of the organization at the address.
  final String? organization;

  const PostalAddress({
    required this.revision,
    required this.regionCode,
    this.languageCode,
    this.postalCode,
    this.sortingCode,
    this.administrativeArea,
    this.locality,
    this.sublocality,
    this.addressLines = const [],
    this.recipients,
    this.organization,
  });

  static PostalAddress? fromJson(dynamic json) {
    if (json == null) return null;
    return PostalAddress(
      revision: json['revision'] as int,
      regionCode: json['regionCode'] as String,
      languageCode: json['languageCode'] as String?,
      postalCode: json['postalCode'] as String?,
      sortingCode: json['sortingCode'] as String?,
      administrativeArea: json['administrativeArea'] as String?,
      locality: json['locality'] as String?,
      sublocality: json['sublocality'] as String?,
      addressLines: (json['addressLines'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      recipients: (json['recipients'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      organization: json['organization'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'revision': revision,
      'regionCode': regionCode,
      'languageCode': languageCode,
      'postalCode': postalCode,
      'sortingCode': sortingCode,
      'administrativeArea': administrativeArea,
      'locality': locality,
      'sublocality': sublocality,
      'addressLines': addressLines,
      'recipients': recipients,
      'organization': organization,
    };
  }

  @override
  String toString() {
    return 'PostalAddress{revision: $revision, regionCode: $regionCode, languageCode: $languageCode, postalCode: $postalCode, sortingCode: $sortingCode, administrativeArea: $administrativeArea, locality: $locality, sublocality: $sublocality, addressLines: $addressLines, recipients: $recipients, organization: $organization}';
  }
}
