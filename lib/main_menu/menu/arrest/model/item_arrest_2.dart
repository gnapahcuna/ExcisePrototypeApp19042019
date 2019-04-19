class ItemsList {
  final String NOTICE_CODE;
  final String STAFF_TITLE_SHORT_NAME_TH;
  final String STAFF_FIRST_NAME;
  final String STAFF_LAST_NAME;
  final String SUSPECT_TITLE_SHORT_NAME_TH;
  final String SUSPECT_FIRST_NAME;
  final String SUSPECT_MIDDLE_NAME;
  final String SUSPECT_LAST_NAME;
  final String SUSPECT_OTHER_NAME;
  final String NOTICE_DATE;
  bool IsCheck=false;

  ItemsList({
    this.NOTICE_CODE,
    this.STAFF_TITLE_SHORT_NAME_TH,
    this.STAFF_FIRST_NAME,
    this.STAFF_LAST_NAME,
    this.SUSPECT_TITLE_SHORT_NAME_TH,
    this.SUSPECT_FIRST_NAME,
    this.SUSPECT_MIDDLE_NAME,
    this.SUSPECT_LAST_NAME,
    this.SUSPECT_OTHER_NAME,
    this.NOTICE_DATE,
    this.IsCheck
  });

  factory ItemsList.fromJson(Map<String, dynamic> json) {
    return ItemsList(
      NOTICE_CODE: json['NOTICE_CODE'],
      STAFF_TITLE_SHORT_NAME_TH: json['STAFF_TITLE_SHORT_NAME_TH'],
      STAFF_FIRST_NAME: json['STAFF_FIRST_NAME'],
      STAFF_LAST_NAME: json['STAFF_LAST_NAME'],
      SUSPECT_TITLE_SHORT_NAME_TH: json['SUSPECT_TITLE_SHORT_NAME_TH'],
      SUSPECT_FIRST_NAME: json['SUSPECT_FIRST_NAME'],
      SUSPECT_MIDDLE_NAME: json['SUSPECT_MIDDLE_NAME'],
      SUSPECT_LAST_NAME: json['SUSPECT_LAST_NAME'],
      SUSPECT_OTHER_NAME: json['SUSPECT_OTHER_NAME'],
      NOTICE_DATE: json['NOTICE_DATE'],
    );
  }
}