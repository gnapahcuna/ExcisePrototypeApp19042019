
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence_description.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_manage_evidence_search_screen.dart';
import 'package:prototype_app_pang/model/choice.dart';

class ProveManageEvidenceScreenFragment extends StatefulWidget {
  ItemsEvidence ItemsEvidences;
  bool IsScientific;
  ProveManageEvidenceScreenFragment({
    Key key,
    @required this.ItemsEvidences,
    @required this.IsScientific,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<ProveManageEvidenceScreenFragment>  with TickerProviderStateMixin {
  //เมื่อบันทึกข้อมูล
  bool _onSaved = false;
  bool _onSave = false;

  //เมื่อแก้ไขข้อมูล
  bool _onEdited = false;

  //เมื่อลบข้อมูล
  bool _onDeleted = false;

  //เมื่อทำรายการเสร็จ
  bool _onFinish = false;

  ItemsEvidence ItemsMain;

  //node focus
  final FocusNode myFocusNodeProductCount = FocusNode();
  final FocusNode myFocusNodeProductCapacity = FocusNode();
  final FocusNode myFocusNodeProductVolume = FocusNode();

  //textfield
  TextEditingController editProductCount = new TextEditingController();
  TextEditingController editProductCapacity = new TextEditingController();
  TextEditingController editProductVolume = new TextEditingController();

  //nod focus มูลค่าภาษี
  final FocusNode myFocusNodeTaxValue = FocusNode();
  final FocusNode myFocusNodeTaxVolumnBy = FocusNode();
  final FocusNode myFocusNodeTaxVolumnAlcohol = FocusNode();
  final FocusNode myFocusNodeTaxVolumnSugar = FocusNode();
  final FocusNode myFocusNodeTaxVolumnCo2 = FocusNode();
  final FocusNode myFocusNodeTaxUnit = FocusNode();
  final FocusNode myFocusNodeRetailPrice = FocusNode();
  final FocusNode myFocusNodeProveValue = FocusNode();

  //textfield มูลค่าภาษี
  TextEditingController editTaxValue = new TextEditingController();
  TextEditingController editTaxVolumnBy = new TextEditingController();
  TextEditingController editTaxVolumnAlcohol = new TextEditingController();
  TextEditingController editTaxVolumnSugar = new TextEditingController();
  TextEditingController editTaxVolumnCo2 = new TextEditingController();
  TextEditingController editTaxUnit = new TextEditingController();
  TextEditingController editTaxRetailPrice = new TextEditingController();
  TextEditingController editTaxProveValue = new TextEditingController();

  //controller expandable
  ExpandableController myExpandableController = new ExpandableController();

  //nod focus ของกลางคงเหลือพิสูจน์
  final FocusNode myFocusRemainingEvidenceCount = FocusNode();
  final FocusNode myFocusRemainingEvidenceVolumn = FocusNode();
  final FocusNode myFocusRemainingEvidenceComment = FocusNode();

  //textfield ของกลางคงเหลือพิสูจน์
  TextEditingController editRemainingEvidenceCount = new TextEditingController();
  TextEditingController editRemainingEvidenceVolumn = new TextEditingController();
  TextEditingController editRemainingEvidenceComment = new TextEditingController();

  //nod focus รายละเอียดการตวรจพิสูจน์ของกลาง*
  final FocusNode myFocusProveDescription = FocusNode();

  //textfield ผลทาง Lab*
  TextEditingController editProveDescription = new TextEditingController();

  //nod focus ผลทาง Lab*
  final FocusNode myFocusLabResult = FocusNode();

  //textfield รายละเอียดการตวรจพิสูจน์ของกลาง*
  TextEditingController editLabResult = new TextEditingController();

  String dropdownValueProductUnit = "ขวด";
  String dropdownValueCapacityUnit = "มิลลิกรัม";
  String dropdownValueVolumeUnit = "มิลลิกรัม";
  List<String> dropdownItemsProductUnit = ['ขวด', 'ลัง'];
  List<String> dropdownItemsCapacityUnit = ['ลิตร', 'มิลลิกรัม'];
  List<String> dropdownItemsVolumeUnit = ['ลิตร', 'มิลลิกรัม'];

  String dropdownValueTaxUnit = "มิลลิกรัม";
  List<String> dropdownItemsTaxUnit = ['ลิตร', 'มิลลิกรัม'];

  String dropdownValueRemainingEvidenceCountUnit = "ขวด";
  String dropdownValueRemainingEvidenceVolumnUnit = "มิลลิกรัม";
  List<String> dropdownItemsRemainingEvidenceCountUnit = ['ขวด', 'ลัง'];
  List<String> dropdownItemsRemainingEvidenceVolumnUnit = ['ลิตร', 'มิลลิกรัม'];

  @override
  void initState() {
    super.initState();
    setState(() {
      ItemsMain = widget.ItemsEvidences;

      editProductCount.text = ItemsMain.Counts.toString();
      editProductCapacity.text = ItemsMain.Capacity.toString();
      editProductVolume.text = ItemsMain.Volume.toString();

      /* dropdownValueProductUnit=ItemsMain.CountsUnit;
      dropdownValueCapacityUnit=ItemsMain.ProductUnit;
      dropdownValueVolumeUnit=ItemsMain.VolumeUnit;*/
      if (ItemsMain.IsActive) {
        _onSaved = true;

        editTaxValue.text = ItemsMain.Descriptions.TaxValue.toString();
        editTaxVolumnBy.text = ItemsMain.Descriptions.TaxVolumnBy.toString();
        editTaxVolumnAlcohol.text =
            ItemsMain.Descriptions.TaxVolumnAlcohol.toString();
        editTaxVolumnSugar.text =
            ItemsMain.Descriptions.TaxVolumnSugar.toString();
        editTaxVolumnCo2.text = ItemsMain.Descriptions.TaxVolumnCo2.toString();
        editTaxUnit.text = ItemsMain.Descriptions.TaxUnit.toString();
        editTaxRetailPrice.text =
            ItemsMain.Descriptions.TaxRetailPrice.toString();
        editTaxProveValue.text =
            ItemsMain.Descriptions.TaxProveValue.toString();

        editRemainingEvidenceCount.text =
            ItemsMain.Descriptions.RemainingCount.toString();
        editRemainingEvidenceVolumn.text =
            ItemsMain.Descriptions.RemainingVolumn.toString();
        editRemainingEvidenceComment.text =
            ItemsMain.Descriptions.RemainingComment;

        editProveDescription.text = ItemsMain.Descriptions.ProveDescription;
        editLabResult.text = ItemsMain.Descriptions.LabResult;

        _arrItemsImageFile = ItemsMain.Descriptions.ItemsImageFiles;
      }
      print(ItemsMain.IsActive.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    editProductCapacity.dispose();
    editProductCount.dispose();
    editProductVolume.dispose();

    editTaxValue.dispose();
    editTaxVolumnBy.dispose();
    editTaxVolumnAlcohol.dispose();
    editTaxVolumnSugar.dispose();
    editTaxVolumnCo2.dispose();
    editTaxUnit.dispose();
    editTaxRetailPrice.dispose();
    editTaxProveValue.dispose();

    editRemainingEvidenceCount.dispose();
    editRemainingEvidenceVolumn.dispose();
    editRemainingEvidenceComment.dispose();
    //editProveDescription.dispose();
    myExpandableController.dispose();

    editProveDescription.dispose();

    editLabResult.dispose();
  }

  _navigate(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProveManageEvidenceSearchScreenFragment(
          )),
    );
    if (result.toString() != "Back") {
      ItemsMain = result;
    }
  }

  //รูปภาพ
  Future<File> _imageFile;
  List<File> _arrItemsImageFile = [];
  List<String> _arrItemsImageName = [];
  bool isImage = false;
  VoidCallback listener;

  //get file รูปภาพ
  Future getImage(ImageSource source, mContext) async {
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      List splits = image.path.split("/");
      isImage = true;
      _arrItemsImageName.add(splits[splits.length - 1]);
      _arrItemsImageFile.add(image);
    });
    Navigator.pop(mContext);
  }

  //แสดง popup ให้เลือกรูปจากกล้องหรทอแกลอรี่
  void _showDialogImagePicker() {
    showDialog(context: context,
        builder: (context) => _onTapImage(context)); // Call the Dialog.
  }

  _onTapImage(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: width / 3,
                  height: height / 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Icon(
                    Icons.camera_alt, color: Colors.blue, size: 38.0,),
                ),
                onTap: () {
                  getImage(ImageSource.camera, context);
                },
              ),
              GestureDetector(
                child: Container(
                  width: width / 3,
                  height: height / 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Icon(Icons.image, color: Colors.blue, size: 38.0,),
                ),
                onTap: () {
                  getImage(ImageSource.gallery, context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildContent() {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 80) / 100;
    TextStyle textLabelEditNonCheckStyle = TextStyle(
        fontSize: 16.0, color: Colors.red[100]);
    TextStyle textStyleLabel = TextStyle(
        fontSize: 16, color: Color(0xff087de1));
    TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black);
    TextStyle textStyleStar = TextStyle(color: Colors.red);
    EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

    Widget _buildExpanded() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: paddingLabel,
            child: Text(
              "คำนวณอัตราภาษี", style: textStyleLabel,),
          ),
          Container(
            padding: paddingLabel,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 18.0, top: 8, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      /*setState(() {
                        IsDeliveredStorage = !IsDeliveredStorage;
                      });*/
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xff3b69f3),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Color(0xff3b69f3)),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.check,
                            size: 16.0,
                            color: Colors.white,
                          )
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "ตามมูลค่า", style: textStyleLabel,),
                ),
              ],
            ),
          ),
          Container(
            padding: paddingLabel,
            child: Text("มูลค่าภาษีร้อยละ", style: textStyleLabel,),
          ),
          Padding(
            padding: paddingData,
            child: TextField(
              focusNode: myFocusNodeTaxValue,
              controller: editTaxValue,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization
                  .words,
              style: textStyleData,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 1.0,
            color: Colors.grey[300],
          ),
          Container(
            padding: paddingLabel,
            child: Text(
              "มูลค่าภาษีร้อยละ", style: textStyleLabel,),
          ),
          Container(
            padding: paddingLabel,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 18.0, top: 8, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      /*setState(() {
                        IsDeliveredStorage = !IsDeliveredStorage;
                      });*/
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xff3b69f3),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Color(0xff3b69f3)),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.check,
                            size: 16.0,
                            color: Colors.white,
                          )
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "ตามปริมาณ", style: textStyleLabel,),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text("ตามปริมาณต่อ", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        focusNode: myFocusNodeTaxVolumnBy,
                        controller: editTaxVolumnBy,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    _buildLine(),
                  ],
                ),
              ),
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text("หน่วย", style: textStyleLabel,),
                    ),
                    Container(
                      width: Width,
                      //padding: paddingInputBox,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dropdownValueTaxUnit,
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueTaxUnit = newValue;
                            });
                          },
                          items: dropdownItemsTaxUnit
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          })
                              .toList(),
                        ),
                      ),
                    ),
                    _buildLine(),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text("หน่วยละ", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: /*Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween,
                          children: <Widget>[
                            TextField(
                              focusNode: myFocusNodeTaxUnit,
                              controller: editTaxUnit,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization
                                  .words,
                              style: textStyleData,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                            Text("บาท", style: textStyleData,),
                          ],
                        )*/
                      TextField(
                        focusNode: myFocusNodeTaxUnit,
                        controller: editTaxUnit,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffix: Text('บาท'),
                        ),
                      ),
                    ),
                    _buildLine(),
                  ],
                ),
              ),
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ปริมาณแอลกอฮอล์", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        focusNode: myFocusNodeTaxVolumnAlcohol,
                        controller: editTaxVolumnAlcohol,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    _buildLine(),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text("ปริมาณน้ำตาล", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        focusNode: myFocusNodeTaxVolumnSugar,
                        controller: editTaxVolumnSugar,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    _buildLine(),
                  ],
                ),
              ),
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "อัตราการปล่อย CO2", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        focusNode: myFocusNodeTaxVolumnCo2,
                        controller: editTaxVolumnCo2,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    _buildLine(),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ราคาขายปลีกเเนะนำ", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        focusNode: myFocusNodeRetailPrice,
                        controller: editTaxRetailPrice,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffix: Text('บาท'),
                        ),
                      ),
                    ),
                    _buildLine(),
                  ],
                ),
              ),
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "มูลค่าภาษีพิสูจน์", style: textStyleLabel,),
                          Text("*", style: textStyleStar,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        focusNode: myFocusNodeProveValue,
                        controller: editTaxProveValue,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffix: Text('บาท'),
                        ),
                      ),
                    ),
                    _buildLine(),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }
    Widget _buildCollapsed() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: paddingLabel,
            child: Text(
              "คำนวณอัตราภาษี", style: textStyleLabel,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  "มูลค่าภาษีพิสูจน์", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  "บาท", style: textStyleData,),
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: size.width,
          padding: EdgeInsets.only(
              left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border(
                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text("ชื่อของกลาง", style: textStyleLabel,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: paddingData,
                    child: Text(
                      ItemsMain.ProductGroup + " / " + ItemsMain.MainBrand,
                      style: textStyleData,),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 12.0),
                      child: InkWell(
                          onTap: () {
                            _navigate(context);
                          },
                          child: Text(
                            "แก้ไข", style: textLabelEditNonCheckStyle,)
                      )
                  ),
                ],
              ),
              new IgnorePointer(
                  ignoring: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: ((size.width * 75) / 100) / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text("จำนวน", style: textStyleLabel,),
                                ),
                                Padding(
                                  padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeProductCount,
                                    controller: editProductCount,
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization
                                        .words,
                                    style: textStyleData,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                _buildLine(),
                              ],
                            ),
                          ),
                          Container(
                            width: ((size.width * 75) / 100) / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text("หน่วย", style: textStyleLabel,),
                                ),
                                Container(
                                  width: Width,
                                  //padding: paddingInputBox,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: dropdownValueProductUnit,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          dropdownValueProductUnit = newValue;
                                        });
                                      },
                                      items: dropdownItemsProductUnit
                                          .map<DropdownMenuItem<String>>((
                                          String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      })
                                          .toList(),
                                    ),
                                  ),
                                ),
                                _buildLine(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: ((size.width * 75) / 100) / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "ขนาดบรรจุ", style: textStyleLabel,),
                                ),
                                Padding(
                                  padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeProductCapacity,
                                    controller: editProductCapacity,
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization
                                        .words,
                                    style: textStyleData,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                _buildLine(),
                              ],
                            ),
                          ),
                          Container(
                            width: ((size.width * 75) / 100) / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text("หน่วย", style: textStyleLabel,),
                                ),
                                Container(
                                  width: Width,
                                  //padding: paddingInputBox,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: dropdownValueCapacityUnit,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          dropdownValueCapacityUnit = newValue;
                                        });
                                      },
                                      items: dropdownItemsCapacityUnit
                                          .map<DropdownMenuItem<String>>((
                                          String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      })
                                          .toList(),
                                    ),
                                  ),
                                ),
                                _buildLine(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: ((size.width * 75) / 100) / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "ปริมาณสุทธิ", style: textStyleLabel,),
                                ),
                                Padding(
                                  padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeProductVolume,
                                    controller: editProductVolume,
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization
                                        .words,
                                    style: textStyleData,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                _buildLine(),
                              ],
                            ),
                          ),
                          Container(
                            width: ((size.width * 75) / 100) / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text("หน่วย", style: textStyleLabel,),
                                ),
                                Container(
                                  width: Width,
                                  //padding: paddingInputBox,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: dropdownValueVolumeUnit,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          dropdownValueVolumeUnit = newValue;
                                        });
                                      },
                                      items: dropdownItemsVolumeUnit
                                          .map<DropdownMenuItem<String>>((
                                          String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      })
                                          .toList(),
                                    ),
                                  ),
                                ),
                                _buildLine(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
        new Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
            width: size.width,
            padding: EdgeInsets.only(
                left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: ExpandableNotifier(
                controller: myExpandableController,
                child: Stack(
                  children: <Widget>[
                    _onEdited ? Expandable(
                        collapsed: _buildExpanded(),
                        expanded: _buildCollapsed()
                    ) :
                    Expandable(
                        collapsed: _buildCollapsed(),
                        expanded: _buildExpanded()
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Builder(

                          builder: (context) {
                            var exp = ExpandableController.of(context);
                            return IconButton(
                              icon: _onEdited?Icon(
                                exp.expanded ? Icons.keyboard_arrow_down : Icons
                                    .keyboard_arrow_up, size: 24.0,
                                color: Colors.grey,):Icon(
                                exp.expanded ? Icons.keyboard_arrow_up : Icons
                                    .keyboard_arrow_down, size: 24.0,
                                color: Colors.grey,),
                              onPressed: () {
                                exp.toggle();
                              },
                            );
                          }
                      ),
                    )
                  ],
                )
            ),
          ),
        ),
        new Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
            width: size.width,
            padding: EdgeInsets.only(
                left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text("ของกลางคงเหลือพิสูจน์", style: textStyleLabel,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: ((size.width * 75) / 100) / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "จำนวน", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: TextField(
                              focusNode: myFocusRemainingEvidenceCount,
                              controller: editRemainingEvidenceCount,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization
                                  .words,
                              style: textStyleData,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine(),
                        ],
                      ),
                    ),
                    Container(
                      width: ((size.width * 75) / 100) / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("หน่วย", style: textStyleLabel,),
                          ),
                          Container(
                            width: Width,
                            //padding: paddingInputBox,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: dropdownValueRemainingEvidenceCountUnit,
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValueRemainingEvidenceCountUnit =
                                        newValue;
                                  });
                                },
                                items: dropdownItemsRemainingEvidenceCountUnit
                                    .map<DropdownMenuItem<String>>((
                                    String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                })
                                    .toList(),
                              ),
                            ),
                          ),
                          _buildLine(),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: ((size.width * 75) / 100) / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ปริมาณสุทธิ", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: TextField(
                              focusNode: myFocusRemainingEvidenceVolumn,
                              controller: editRemainingEvidenceVolumn,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization
                                  .words,
                              style: textStyleData,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine(),
                        ],
                      ),
                    ),
                    Container(
                      width: ((size.width * 75) / 100) / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("หน่วย", style: textStyleLabel,),
                          ),
                          Container(
                            width: Width,
                            //padding: paddingInputBox,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: dropdownValueRemainingEvidenceVolumnUnit,
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValueRemainingEvidenceVolumnUnit =
                                        newValue;
                                  });
                                },
                                items: dropdownItemsRemainingEvidenceVolumnUnit
                                    .map<DropdownMenuItem<String>>((
                                    String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                })
                                    .toList(),
                              ),
                            ),
                          ),
                          _buildLine(),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: paddingLabel,
                  child: Text("หมายเหตุ", style: textStyleLabel,),
                ),
                Padding(
                  padding: paddingData,
                  child: TextField(
                    focusNode: myFocusRemainingEvidenceComment,
                    controller: editRemainingEvidenceComment,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization
                        .words,
                    style: textStyleData,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
              width: size.width,
              padding: EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Row(
                      children: <Widget>[
                        Text("รายละเอียดการตวรจพิสูจน์ของกลาง",
                          style: textStyleLabel,),
                        Text("*", style: textStyleStar,),
                      ],
                    ),
                  ),
                  Padding(
                      padding: paddingData,
                      child: Container(
                        padding: EdgeInsets.only(top: 8.0),
                        child: TextField(
                          maxLines: 10,
                          focusNode: myFocusProveDescription,
                          controller: editProveDescription,
                          decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[500], width: 0.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[400], width: 0.5),
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              )
          ),
        ),
        widget.IsScientific ? Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
              width: size.width,
              padding: EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("ผลทาง Lab", style: textStyleLabel,),
                  ),
                  Padding(
                      padding: paddingData,
                      child: Container(
                        padding: EdgeInsets.only(top: 8.0),
                        child: TextField(
                          maxLines: 10,
                          focusNode: myFocusLabResult,
                          controller: editLabResult,
                          decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[500], width: 0.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[400], width: 0.5),
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              )
          ),
        ) : Container(),
        Container(
          width: size.width,
          padding: EdgeInsets.only(bottom: 22.0),
          child: _buildButtonImgPicker(),
        ),
        _buildDataImage(context),
      ],
    );
  }

  Widget _buildButtonImgPicker() {
    var size = MediaQuery
        .of(context)
        .size;
    Color labelColor = Color(0xff087de1);
    Color boxColor = Colors.grey[300];
    Color uploadColor = Color(0xff31517c);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: uploadColor);
    return Container(
      padding: EdgeInsets.only(left: 18.0, top: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Card(
              shape: new RoundedRectangleBorder(
                  side: new BorderSide(
                      color: boxColor, width: 1.5),
                  borderRadius: BorderRadius.circular(42.0)
              ),
              elevation: 0.0,
              child: Container(
                width: size.width / 2,
                child: MaterialButton(
                  onPressed: () {
                    _onSaved ? null : _showDialogImagePicker();
                  },
                  splashColor: Colors.grey,
                  child: Container(
                      padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.file_upload, size: 32, color: uploadColor,),
                          ),
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Text(
                              "เลือกไฟล์/รูปภาพ", style: textLabelStyle,),
                          ),

                        ],
                      )
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget _buildDataImage(BuildContext context) {
    TextStyle textInputStyleTitle = TextStyle(
        fontSize: 16.0, color: Colors.black);
    return Container(
      padding: EdgeInsets.only(bottom: 22.0),
      child: ListView.builder(
          itemCount: _arrItemsImageFile.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(top: 0.1, bottom: 0.1),
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: ListTile(
                    leading: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.white30),
                      ),
                      //margin: const EdgeInsets.only(top: 32.0, left: 16.0),
                      padding: const EdgeInsets.all(3.0),
                      child: Image.file(
                        _arrItemsImageFile[index], fit: BoxFit.cover,),
                    ),
                    title: Text(_arrItemsImageName[index],
                      style: textInputStyleTitle,),
                    trailing: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: !_onSaved?Icon(Icons.delete_outline, size: 32.0,):Icon(null),
                        onPressed: () {
                          setState(() {
                            //print(index.toString());
                            _arrItemsImageFile.removeAt(index);
                            _arrItemsImageName.removeAt(index);
                            if (_arrItemsImageFile.length == 0) {
                              isImage = false;
                            }
                          });
                        },
                      ),
                    ),
                    onTap: () {
                      //
                    }
                ),
              ),
            );
          }
      ),
    );
  }

  Widget _buildLine() {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 80) / 100;

    return Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
  }


  Widget _buildContent_saved() {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 80) / 100;
    TextStyle textLabelEditNonCheckStyle = TextStyle(
        fontSize: 16.0, color: Colors.red[100]);
    TextStyle textStyleLabel = TextStyle(
        fontSize: 16, color: Color(0xff087de1));
    TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black);
    TextStyle textStyleStar = TextStyle(color: Colors.red);
    EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

    Widget _buildExpanded() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: paddingLabel,
            child: Text(
              "คำนวณอัตราภาษี", style: textStyleLabel,),
          ),
          Container(
            padding: paddingLabel,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 18.0, top: 8, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      /*setState(() {
                        IsDeliveredStorage = !IsDeliveredStorage;
                      });*/
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xff3b69f3),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Color(0xff3b69f3)),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.check,
                            size: 16.0,
                            color: Colors.white,
                          )
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "ตามมูลค่า", style: textStyleLabel,),
                ),
              ],
            ),
          ),
          Container(
            padding: paddingLabel,
            child: Text("มูลค่าภาษีร้อยละ", style: textStyleLabel,),
          ),
          Container(
            padding: paddingData,
            child: Text(
              ItemsMain.Descriptions.TaxValue.toString(),
              style: textStyleData,),
          ),
          Container(
            padding: paddingLabel,
            child: Text(
              "มูลค่าภาษีร้อยละ", style: textStyleLabel,),
          ),
          Container(
            padding: paddingLabel,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 18.0, top: 8, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      /*setState(() {
                        IsDeliveredStorage = !IsDeliveredStorage;
                      });*/
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xff3b69f3),
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Color(0xff3b69f3)),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.check,
                            size: 16.0,
                            color: Colors.white,
                          )
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "ตามปริมาณ", style: textStyleLabel,),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text("ตามปริมาณต่อ", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        ItemsMain.Descriptions.TaxVolumnBy.toString(),
                        style: textStyleData,),
                    ),
                  ],
                ),
              ),
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text("หน่วย", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        ItemsMain.Descriptions.TaxUnit.toString(),
                        style: textStyleData,),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text("หน่วยละ", style: textStyleLabel,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.Descriptions.TaxUnitValue.toString(),
                            style: textStyleData,),
                        ),
                        Container(
                          padding: paddingData,
                          child: Text(
                            "บาท", style: textStyleData,),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ปริมาณแอลกอฮอล์", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        ItemsMain.Descriptions.TaxVolumnAlcohol.toString(),
                        style: textStyleData,),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text("ปริมาณน้ำตาล", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        ItemsMain.Descriptions.TaxVolumnSugar.toString(),
                        style: textStyleData,),
                    ),
                  ],
                ),
              ),
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "อัตราการปล่อย CO2", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        ItemsMain.Descriptions.TaxVolumnCo2.toString(),
                        style: textStyleData,),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ราคาขายปลีกเเนะนำ", style: textStyleLabel,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.Descriptions.TaxRetailPrice.toString(),
                            style: textStyleData,),
                        ),
                        Container(
                          padding: paddingData,
                          child: Text(
                            "บาท", style: textStyleData,),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: ((size.width * 75) / 100) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "มูลค่าภาษีพิสูจน์", style: textStyleLabel,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.Descriptions.TaxProveValue.toString(),
                            style: textStyleData,),
                        ),
                        Container(
                          padding: paddingData,
                          child: Text(
                            "บาท", style: textStyleData,),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }
    Widget _buildCollapsed() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: paddingLabel,
            child: Text(
              "คำนวณอัตราภาษี", style: textStyleLabel,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  "มูลค่าภาษีพิสูจน์", style: textStyleLabel,),
              ),
              Container(
                padding: paddingData,
                child: Text(
                  ItemsMain.Descriptions.TaxProveValue.toString(),
                  style: textStyleData,),
              ),
              Container(
                padding: paddingData,
                child: Text(
                  "บาท", style: textStyleData,),
              ),
            ],
          )
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: size.width,
          padding: EdgeInsets.only(
              left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border(
                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text("ชื่อของกลาง", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  ItemsMain.ProductGroup + " / " + ItemsMain.MainBrand,
                  style: textStyleData,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: ((size.width * 75) / 100) / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "จำนวน", style: textStyleLabel,),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.Counts.toString(),
                            style: textStyleData,),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: ((size.width * 75) / 100) / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text("หน่วย", style: textStyleLabel,),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.CountsUnit,
                            style: textStyleData,),
                        ),
                      ],
                    ),
                  ),
                ],
              ), Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: ((size.width * 75) / 100) / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "ขนาดบรรจุ", style: textStyleLabel,),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.Capacity.toString(),
                            style: textStyleData,),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: ((size.width * 75) / 100) / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text("หน่วย", style: textStyleLabel,),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.ProductUnit,
                            style: textStyleData,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: ((size.width * 75) / 100) / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "ปริมาณสุทธิ", style: textStyleLabel,),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.Volume.toString(),
                            style: textStyleData,),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: ((size.width * 75) / 100) / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text("หน่วย", style: textStyleLabel,),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            ItemsMain.VolumeUnit,
                            style: textStyleData,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),

        //คำนวณอัตราภาษี
        Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
            width: size.width,
            padding: EdgeInsets.only(
                left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: ExpandableNotifier(
                controller: myExpandableController,
                child: Stack(
                  children: <Widget>[
                    Expandable(
                        collapsed: _buildCollapsed(),
                        expanded: _buildExpanded()
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Builder(

                          builder: (context) {
                            var exp = ExpandableController.of(context);
                            return IconButton(
                              icon: Icon(
                                exp.expanded ? Icons.keyboard_arrow_up : Icons
                                    .keyboard_arrow_down, size: 24.0,
                                color: Colors.grey,),
                              onPressed: () {
                                exp.toggle();
                              },
                            );
                          }
                      ),
                    )
                  ],
                )
            ),
          ),
        ),

        //ของกลางคงเหลือพิสูจน์
        Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
            width: size.width,
            padding: EdgeInsets.only(
                left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ของกลางคงเหลือพิสูจน์", style: textStyleLabel,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: ((size.width * 75) / 100) / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "จำนวน", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              ItemsMain.Descriptions.RemainingCount.toString(),
                              style: textStyleData,),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: ((size.width * 75) / 100) / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("หน่วย", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              ItemsMain.Descriptions.RemainingCountsUnit,
                              style: textStyleData,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: ((size.width * 75) / 100) / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ปริมาณสุทธิ", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              ItemsMain.Descriptions.RemainingVolumn.toString(),
                              style: textStyleData,),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: ((size.width * 75) / 100) / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("หน่วย", style: textStyleLabel,),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              ItemsMain.Descriptions.RemainingVolumnUnit,
                              style: textStyleData,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: paddingLabel,
                  child: Text("หมายเหตุ", style: textStyleLabel,),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    ItemsMain.Descriptions.RemainingComment,
                    style: textStyleData,),
                ),
              ],
            ),
          ),
        ),

        //รายละเอียดการตวรจพิสูจน์ของกลาง
        Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
              width: size.width,
              padding: EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("รายละเอียดการตวรจพิสูจน์ของกลาง",
                      style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      ItemsMain.Descriptions.ProveDescription,
                      style: textStyleData,),
                  ),
                ],
              )
          ),
        ),

        //ผลทาง Lab
        widget.IsScientific?Container(
          padding: EdgeInsets.only(top: 4.0),
          child: Container(
              width: size.width,
              padding: EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("ผลทาง Lab", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(
                      ItemsMain.Descriptions.LabResult,
                      style: textStyleData,),
                  ),
                ],
              )
          ),
        ):Container(),
        Container(
          width: size.width,
          padding: EdgeInsets.only(bottom: 22.0),
          child: _buildButtonImgPicker(),
        ),
        _buildDataImage(context),
      ],
    );
  }

  void onSaved() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadAction();
    Navigator.pop(context);

    setState(() {
      _onSaved = true;
      _onFinish = true;

      //เปลี่ยนสถานะเป็น active
      ItemsMain.IsActive = true;

      ItemsMain.Descriptions = new ItemsEvidenceDescription(
          30,
          1,
          3000,
          dropdownValueTaxUnit,
          0,
          0,
          0,
          1220.0000,
          149.0001,
          22,
          dropdownValueRemainingEvidenceCountUnit,
          500,
          dropdownValueRemainingEvidenceVolumnUnit,
          editRemainingEvidenceComment.text,
          editProveDescription.text,
          editLabResult.text,
          _arrItemsImageFile
      );
    });
  }

  Future<bool> onLoadAction() async {
    await new Future.delayed(const Duration(seconds: 3));
    return true;
  }

  //เมื่อกด popup แสดงการแก้ไขหรือลบ
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onEdited = true;
      }
    });
  }

  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน cancel dialog
  CupertinoAlertDialog _createCupertinoCancelAlertDialog(mContext) {
    TextStyle TitleStyle = TextStyle(fontSize: 16.0,);
    TextStyle ButtonAcceptStyle = TextStyle(
      color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold,);
    TextStyle ButtonCancelStyle = TextStyle(
      fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.bold,);
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text("ยืนยันการยกเลิกข้อมูลทั้งหมด.",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[

          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text(
                  'ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(mContext, "Back");
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]
    );
  }

  //แสดง dialog ยกเลิกรายการ
  void _showCancelAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelAlertDialog(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStylePageName = TextStyle(color: Colors.grey[400]);
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0);
    TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: Text("รายละเอียดพิสูจน์ของกลาง",
              style: styleTextAppbar,
            ),
            actions: <Widget>[
              _onSaved ? (_onSave ? new FlatButton(
                  onPressed: () {
                    setState(() {
                      _onSaved = true;
                      _onSave = false;
                      _onEdited = false;
                    });
                    //TabScreenArrest1().createAcceptAlert(context);
                  },
                  child: Text('บันทึก', style: appBarStyle))
                  :
              PopupMenuButton<Constants>(
                onSelected: choiceAction,
                icon: Icon(Icons.more_vert, color: Colors.white,),
                itemBuilder: (BuildContext context) {
                  return constants.map((Constants contants) {
                    return PopupMenuItem<Constants>(
                      value: contants,
                      child: Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(right: 4.0),
                            child: Icon(
                              contants.icon, color: Colors.grey[400],),),
                          Padding(padding: EdgeInsets.only(left: 4.0),
                            child: Text(contants.text),)
                        ],
                      ),
                    );
                  }).toList();
                },
              )
              )
                  :
              new FlatButton(
                  onPressed: () {
                    onSaved();
                  },
                  child: Text('บันทึก', style: appBarStyle)),
            ],
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  if (_onSaved) {
                    Navigator.pop(context, ItemsMain);
                  } else {
                    _showCancelAlertDialog(context);
                  }
                }),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 34.0,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text(
                        'ILG60_B_03_00_06_00', style: textStylePageName,),
                    )
                  ],
                ),
              ),
              Expanded(
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: SingleChildScrollView(
                    child: _onSaved ? _buildContent_saved() : _buildContent(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Constants {
  const Constants({this.text, this.icon});

  final String text;
  final IconData icon;
}

const List<Constants> constants = const <Constants>[
  const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
];
