
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_%20suspect.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_case_information.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence.dart';
import 'package:prototype_app_pang/main_menu/prove/model/evidence_description.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_manage_evidence_search_screen.dart';
import 'package:prototype_app_pang/model/choice.dart';

class CompareDetailFineScreenFragment extends StatefulWidget {
  ItemsCompareCaseInformation ItemsInformations;
  ItemsCompareSuspect ItemsSuspect;
  CompareDetailFineScreenFragment({
    Key key,
    @required this.ItemsInformations,
    @required this.ItemsSuspect,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}
class _FragmentState extends State<CompareDetailFineScreenFragment>  with TickerProviderStateMixin {
  //เมื่อบันทึกข้อมูล
  bool _onSaved = false;
  bool _onSave = false;
  //เมื่อแก้ไขข้อมูล
  bool _onEdited = false;
  //เมื่อลบข้อมูล
  bool _onDeleted = false;
  //เมื่อทำรายการเสร็จ
  bool _onFinish = false;

  ItemsCompareCaseInformation ItemsMain;
  ItemsCompareSuspect ItemsSuspect;

  //ยอดชำระสุทธิ
  double _totalPayment;

  @override
  void initState() {
    super.initState();
    setState(() {
      ItemsMain=widget.ItemsInformations;
      ItemsSuspect=widget.ItemsSuspect;

      _totalPayment =0.0;
      ItemsMain.Evidenses.forEach((item){
        FocusNode myFocusNodeFineValueDouble= FocusNode();
        TextEditingController editFineValueDouble = new TextEditingController();
        ExpandableController expController = new ExpandableController();

        TextEditingController editTaxValue= new TextEditingController();
        TextEditingController editFineValue = new TextEditingController();
        TextEditingController editPayment = new TextEditingController();

        item.EvidenceTaxValues.expController=expController;
        item.EvidenceTaxValues.myFocusNodeTaxValueDouble=myFocusNodeFineValueDouble;
        item.EvidenceTaxValues.editTaxValueDouble=editFineValueDouble;
        item.EvidenceTaxValues.editTaxValue=editTaxValue;
        item.EvidenceTaxValues.editFineValue=editFineValue;
        item.EvidenceTaxValues.editPayment=editPayment;

        setInitDataTextField(item,"1");

        _totalPayment += item.EvidenceTaxValues.Payment;

      });

    });
  }

  setInitDataTextField(ItemsCompareEvidence item,String text){
    //ค่าปรับสุทธิ
    item.EvidenceTaxValues.FineValue=
        item.EvidenceTaxValues.TaxValue*double.parse(text);
    //ยอดชำระ
    item.EvidenceTaxValues.Payment=
        item.EvidenceTaxValues.TaxValue*double.parse(text);

    //set text
    item.EvidenceTaxValues.editTaxValue.text=
        item.EvidenceTaxValues.TaxValue.toString();
    item.EvidenceTaxValues.editFineValue.text=
        item.EvidenceTaxValues.FineValue.toString();
    item.EvidenceTaxValues.editPayment.text=
        item.EvidenceTaxValues.Payment.toString();
  }

  @override
  void dispose() {
    super.dispose();
    ItemsMain.Evidenses.forEach((item){
      item.EvidenceTaxValues.expController.dispose();
      item.EvidenceTaxValues.editTaxValueDouble.dispose();
    });

  }

  Widget _buildContent() {
    var size = MediaQuery
        .of(context)
        .size;
    TextStyle textStyleLabel = TextStyle(
        fontSize: 16, color: Color(0xff087de1));
    TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black);
    EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: ItemsMain.Evidenses.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  width: size.width,
                  padding: EdgeInsets.all(22.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        bottom: BorderSide(
                            color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child:Stack(
                    children: <Widget>[
                      _buildExpandableContent(index),
                    ],
                  )
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 4.0,bottom: 44.0),
          child: Container(
              width: size.width,
              padding: EdgeInsets.all(22.0),
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
                    child: Text("รวมยอดชำระ", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(_totalPayment.toString()+"\t\t\t\t\tบาท", style: textStyleData,),
                  ),
                ],
              )
          ),
        ),
      ],
    );
  }
  Widget _buildExpandableContent(int index) {
    var size = MediaQuery
        .of(context)
        .size;
    final double Width = (size.width * 80) / 100;
    TextStyle textStyleLabel = TextStyle(
        fontSize: 16, color: Color(0xff087de1));
    TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black);
    EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
    Widget _buildExpanded(index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  "ของกลางลำดับ" + (index + 1).toString(),
                  style: textStyleLabel,),
              ),
            ],
          ),
          Container(
            padding: paddingData,
            child: Text(
              "หมวดสินค้า : " + ItemsMain.Evidenses[index].ProductGroup,
              style: textStyleData,),
          ),
          Container(
            padding: paddingData,
            child: Text(
              "ยี่ห้อ : " + ItemsMain.Evidenses[index].MainBrand + " / " +
                  ItemsMain.Evidenses[index].ProductModel,
              style: textStyleData,),
          ),
          Container(
            padding: paddingLabel,
            child: Text(
              "ฐานความผิดมาตรา",
              style: textStyleLabel,),
          ),
          Container(
            padding: paddingData,
            child: Text(
              ItemsMain.MistakeNumber, style: textStyleData,),
          ),
          Container(
            padding: paddingLabel,
            child: Text(
              "อัตราโทษ",
              style: textStyleLabel,),
          ),
          Container(
            padding: paddingData,
            child: Text(
              ItemsMain.PenaltyRate, style: textStyleData,),
          ),
          Container(
            padding: paddingLabel,
            child: Text(
              "จำนวครั้งกระทำผิด",
              style: textStyleLabel,),
          ),
          Container(
            padding: paddingData,
            child: Text(
              ItemsSuspect.Offenses.length.toString(), style: textStyleData,),
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
                        "มูลค่าภาษี", style: textStyleLabel,),
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: Padding(
                        padding: paddingData,
                        child: TextField(
                          controller: ItemsMain.Evidenses[index].EvidenceTaxValues.editTaxValue,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization
                              .words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
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
                      child: Text("จำนวนค่าปรับเท่า", style: textStyleLabel,),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        focusNode: ItemsMain.Evidenses[index].EvidenceTaxValues.myFocusNodeTaxValueDouble,
                        controller: ItemsMain.Evidenses[index].EvidenceTaxValues.editTaxValueDouble,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization
                            .words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (String text){
                          if (text.isEmpty) {
                            setState(() {
                              setInitDataTextField(ItemsMain.Evidenses[index],"1");
                              // set ยอดรวมสุทธิ
                              _totalPayment +=
                                  ItemsMain.Evidenses[index].EvidenceTaxValues
                                      .Payment;
                            });
                            return;
                          }
                          setState(() {
                            setInitDataTextField(ItemsMain.Evidenses[index],text);
                            // set ยอดรวมสุทธิ
                            _totalPayment += ItemsMain.Evidenses[index].EvidenceTaxValues.Payment;
                          });

                        },
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
                        "ค่าปรับสุทธิ", style: textStyleLabel,),
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: Padding(
                        padding: paddingData,
                        child: TextField(
                          controller: ItemsMain.Evidenses[index].EvidenceTaxValues.editFineValue,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization
                              .words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
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
                      child: Text("ยอดชำระ", style: textStyleLabel,),
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: Padding(
                        padding: paddingData,
                        child: TextField(
                          controller: ItemsMain.Evidenses[index].EvidenceTaxValues.editPayment,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization
                              .words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }
    Widget _buildCollapsed(int index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  "ของกลางลำดับ" + (index + 1).toString(),
                  style: textStyleLabel,),
              ),
            ],
          ),
          Container(
            padding: paddingData,
            child: Text(
              "หมวดสินค้า : " + ItemsMain.Evidenses[index].ProductGroup,
              style: textStyleData,),
          ),
          Container(
            padding: paddingData,
            child: Text(
              "ยี่ห้อ : " + ItemsMain.Evidenses[index].MainBrand + " / " +
                  ItemsMain.Evidenses[index].ProductModel,
              style: textStyleData,),
          ),
          Container(
            padding: paddingLabel,
            child: Text(
              "ยอดชำระ",
              style: textStyleLabel,),
          ),
          Container(
            padding: paddingData,
            child: Text(
              ItemsMain.Evidenses[index].EvidenceTaxValues.Payment.toString(),
              style: textStyleData,),
          ),
        ],
      );
    }

    return ExpandableNotifier(
      controller: ItemsMain.Evidenses[index].EvidenceTaxValues.expController,
      child: Stack(
        children: <Widget>[
          Expandable(
              collapsed: _buildCollapsed(index),
              expanded: _buildExpanded(index)
          ),
          Align(
            alignment: Alignment.topRight,
            child: Builder(

                builder: (context) {
                  var exp = ExpandableController.of(context);
                  return IconButton(
                    icon: Icon(
                      exp.expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 18.0,
                      color: Colors.grey,),
                    onPressed: () {
                      exp.toggle();
                    },
                  );
                }
            ),
          )
        ],
      ),
    );
  }
  Widget _buildLine(){
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: ItemsMain.Evidenses.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  width: size.width,
                  padding: EdgeInsets.all(22.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        bottom: BorderSide(
                            color: Colors.grey[300], width: 1.0),
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "ของกลางลำดับ" + (index + 1).toString(),
                                  style: textStyleLabel,),
                              ),
                            ],
                          ),
                          Container(
                            padding: paddingData,
                            child: Text(
                              "หมวดสินค้า : " +
                                  ItemsMain.Evidenses[index].ProductGroup,
                              style: textStyleData,),
                          ),
                          Container(
                            padding: paddingData,
                            child: Text(
                              "ยี่ห้อ : " +
                                  ItemsMain.Evidenses[index].MainBrand + " / " +
                                  ItemsMain.Evidenses[index].ProductModel,
                              style: textStyleData,),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ยอดชำระ",
                              style: textStyleLabel,),
                          ),
                          Container(
                            padding: paddingData,
                            child: Text(
                              ItemsMain.Evidenses[index].EvidenceTaxValues
                                  .Payment.toString(),
                              style: textStyleData,),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Builder(
                            builder: (context) {
                              return IconButton(
                                icon: Icon(Icons.keyboard_arrow_down, size: 32.0,
                                  color: Colors.grey,),
                              );
                            }
                        ),
                      )
                    ],
                  )
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 4.0, bottom: 44.0),
          child: Container(
              width: size.width,
              padding: EdgeInsets.all(22.0),
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
                    child: Text("รวมยอดชำระ", style: textStyleLabel,),
                  ),
                  Padding(
                    padding: paddingData,
                    child: Text(_totalPayment.toString() + "\t\t\t\t\tบาท",
                      style: textStyleData,),
                  ),
                ],
              )
          ),
        ),
      ],
    );
  }

  void onSaved()async {
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
      /*ItemsMain.IsActive=true;

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
      );*/
    });
  }
  Future<bool> onLoadAction() async {
    await new Future.delayed(const Duration(seconds: 3));
    return true;
  }

  //เมื่อกด popup แสดงการแก้ไขหรือลบ
  void choiceAction(Constants constants) {
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
                Navigator.pop(mContext,"Back");
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
            title: Text("รายละเอียดค่าปรับ",
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
                  if(_onSaved) {
                    Navigator.pop(context, ItemsMain);
                  }else{
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
                        'ILG60_B_04_00_06_00', style: textStylePageName,),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _onSaved?_buildContent_saved():_buildContent(),
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
