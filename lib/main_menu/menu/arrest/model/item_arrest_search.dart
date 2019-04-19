class ItemsListArrestSearch {
  final int ARREST_ID;
  final String ARREST_CODE;
  final String OCCURRENCE_DATE;
  final String TITLE_NAME_TH;
  final String TITLE_SHORT_NAME_TH;
  final String FIRST_NAME;
  final String LAST_NAME;
  final String OFFICE_NAME;
  final String SUB_DISTRICT_NAME_TH;
  final String DISTRICT_NAME_TH;
  final String PROVINCE_NAME_TH;
  final int IS_LAWSUIT_COMPLETE;

  ItemsListArrestSearch({
    this.ARREST_ID,
    this.ARREST_CODE,
    this.OCCURRENCE_DATE,
    this.TITLE_NAME_TH,
    this.TITLE_SHORT_NAME_TH,
    this.FIRST_NAME,
    this.LAST_NAME,
    this.OFFICE_NAME,
    this.SUB_DISTRICT_NAME_TH,
    this.DISTRICT_NAME_TH,
    this.PROVINCE_NAME_TH,
    this.IS_LAWSUIT_COMPLETE
  });

  factory ItemsListArrestSearch.fromJson(Map<String, dynamic> json) {
    return ItemsListArrestSearch(
      ARREST_ID: json['ARREST_ID'],
      ARREST_CODE: json['ARREST_CODE'],
      TITLE_NAME_TH: json['TITLE_NAME_TH'],
      TITLE_SHORT_NAME_TH: json['TITLE_SHORT_NAME_TH'],
      FIRST_NAME: json['FIRST_NAME'],
      LAST_NAME: json['LAST_NAME'],
      OFFICE_NAME: json['OFFICE_NAME'],
      SUB_DISTRICT_NAME_TH: json['SUB_DISTRICT_NAME_TH'],
      DISTRICT_NAME_TH: json['DISTRICT_NAME_TH'],
      PROVINCE_NAME_TH: json['PROVINCE_NAME_TH'],
      IS_LAWSUIT_COMPLETE: json['IS_LAWSUIT_COMPLETE'],
    );
  }
}