import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cummins/utils/colors.dart';
import 'package:flutter/rendering.dart';
import 'package:cummins/utils/helper.dart';

enum LoadCalcScreen {
  CAL,
  RES
}

class LoadCalculatorPage extends StatefulWidget {
  LoadCalculatorPage({Key key,this.title:"Load Calculator"}) : super(key: key);
  final String title;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _LoadCalculatorState createState() => _LoadCalculatorState();
}
class _LoadCalculatorState extends State<LoadCalculatorPage>  {
  final Map<int,LoadItem> items={};
  int itemCount=0;
  final Map<int,LoadResult> _form={};
  String disclaimer;
  LoadCalcScreen screen;
  num totalKVA=0;
  @override
  void initState() {
    Helper.changeStatusBar(StatusBarType.DEFAULT);
    // TODO: implement initState
    super.initState();
    screen=LoadCalcScreen.CAL;
    addItem();
    disclaimer="PLEASE NOTE THAT IS NOT TO BE USED AS FINAL VALUE FOR A GENSET PURCHASE. GENSET SIZING RECOMMENDATIONS ARE SUBEJECT TO APPROVAL BY THE POWERGEN PROJECT TEAM";
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  addItem(){
    setState(() {
      items[itemCount]=LoadItem(id:itemCount,
        onDelete: removeItem,
        onChange:(LoadResult result)=> _form[result.id]=result,
      );
      itemCount++;
    });
  }
  removeItem(int index){
    if(items.containsKey(index)){
      setState(() {
         items.remove(index);
         _form.remove(index);
      });
    }
  }
  formContent(BuildContext context) {
    return  Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListBody(
            children:items.values.toList(),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: (){
              addItem();
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.add_circle_outline,color: actionColor,),
                SizedBox(width: 4),
                Text("Add item",style: TextStyle(color: actionColor),)
              ],
            ),
          ),
          SizedBox(height: 30,),
          MaterialButton(
              padding: EdgeInsets.symmetric(vertical: 15),
              color: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(30.0,30.0),
                      bottom: Radius.elliptical(30.0,30.0)
                  ),
                  side: BorderSide(color: primarySwatch)
              ),
              child: Text("Calculate",style:TextStyle(color: primaryTextColor)),
              onPressed: () {
                switcher(LoadCalcScreen.RES);
              }
          ),
        ],
      ),
    );
  }
  bodyContent(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          formContent(context),
          SizedBox(height: 40,),
        ],
      ),
    );
  }
  switcher(LoadCalcScreen _){
    setState(() {
      screen=_;
    });
  }
  calcScreen(BuildContext context){
    return ListView(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(10),
            child: bodyContent(context)
        )
      ],
    );
  }
  resTable(List<LoadResult> results){
    TableRow f(LoadResult result){
      totalKVA+=result.toKVA();
      return TableRow(
        children: <TableCell>[
          TableCell(
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),child: Text('${result.item}'),),
          ),
          TableCell(
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),child:Text('${result.value} ${loadUnitString(result.unit)}'),),
          ),
          TableCell(
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),child: Text('${result.quantity}'),),
          )
        ]
      );
    }
    TableRow head = TableRow(
      decoration: BoxDecoration(
          color: textFillColor,
      ),
      children: <TableCell>[
        TableCell(
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),child:Text('Items'),),
        ),
        TableCell(
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),child:Text('Load value'),),
        ),
        TableCell(
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),child:Text('Quantity'),),
        )
      ]
    );
    List<TableRow> rows = results.map<TableRow>(f).toList();
    rows.insert(0, head);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom:10),
        child: Table(
          children: rows,
        ),
      ),
    );
  }
  resScreen(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(10),
      child:ListView(
        children: <Widget>[
          resTable(_form.values.toList()),
          SizedBox(height: 20,),
          Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
              child: ListBody(
                children: <Widget>[
                  Text("Generator KVA requirement",style: TextStyle(color: noteColor,fontSize: 16),textAlign: TextAlign.center,),
                  SizedBox(height: 20,),
                  Text("${totalKVA.toInt()} KVA",style: TextStyle(color: primaryColor,fontSize: 36),textAlign: TextAlign.center,),
                ],
              ),
            ),
          ),
          SizedBox(height: 70,),
          InkWell(
            onTap: (){
              _form.clear();
              items.clear();
              totalKVA=0;
              addItem();
              switcher(LoadCalcScreen.CAL);
            },
            child: Text('Make another calculation',style: TextStyle(color:actionColor,fontSize: 16),textAlign: TextAlign.center,),
          ),
          SizedBox(height: 20,),
          Text(disclaimer, style: TextStyle(color: noteColor,fontSize: 12) ,textAlign: TextAlign.justify,),
        ],
      ),
    );
  }
  buildBody(BuildContext context){
    switch(screen){
      case LoadCalcScreen.RES:
        return resScreen(context);
      case LoadCalcScreen.CAL:
      default:
        return calcScreen(context);
    }
  }
  appBar(BuildContext context){
    return AppBar(
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(25.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child:Row(
              children: <Widget>[
                IconButton(icon:Icon(Icons.arrow_back_ios,color: primaryTextColor,),onPressed: (){
                  Navigator.of(context).pop(true);
                },),
                Text(widget.title,style: TextStyle(color: primaryTextColor,fontSize: 20,fontWeight: FontWeight.w600),)
              ],
            ),
          )
      ),
      leading: Container(),
      elevation: 0,
      backgroundColor: primaryColor,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: primaryTextColor),
    );
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),// here the desired height
            child: appBar(context)
        ),
        body: buildBody(context) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class LoadItem extends StatefulWidget{
  LoadItem({Key key, @required this.id, this.result, this.onChange, this.onDelete}):super(key:key);
  final LoadResult result;
  final Function onChange;
  final Function onDelete;
  final int id;
  @override
  _LoadItem createState()=> _LoadItem();
}
class _LoadItem extends State<LoadItem>{
  List<String> units;
  List<String> items;
  List<String> values;

  String unit;
  String item;
  String value;
  int quantity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantity=1;
    units = loadUnitString('all');
    items = [
      'Air conditioner',
      'Water Heater',
      'Fridge',
      'Freezer',
      'Electric Iron',
      'Electric Kettle',
      'Microwave',
      'Pumping Machine',
      'Television',
      'Electric Oven',
      'Lighting',
      'Water Dispenser'
    ];
    values=[
      "0.01",
      "0.02",
      "0.03",
      "0.04",
      "0.05",
      "0.06",
      "0.07",
      "0.08",
      "0.09",
      "0.1",
      "0.2",
      "0.3",
      "0.4",
      "0.5",
      "0.6",
      "0.7",
      "0.8",
      "0.9",
      "1.0",
      "1.5",
      "2.0",
      "2.5",
      "3.0",
      "3.5",
      "4.0",
      "4.5",
      "5.0",
      "5.5",
      "6.0",
      "6.5",
      "7.0",
      "7.5",
      "8.0",
      "8.5",
      "9.0",
      "9.5",
      "10.0",
      "10.5",
      "11.0",
      "11.5",
      "12.0",
      "12.5",
      "13.0",
      "13.5",
      "14.0",
      "14.5",
      "15.0",
      "15.5",
      "16.0",
      "16.5",
      "17.0",
      "17.5",
      "18.0",
      "18.5",
      "19.0",
      "19.5",
      "20.0",
      "20.5",
      "21.0",
      "21.5",
      "22.0",
      "22.5",
      "23.0",
      "23.5",
      "24.0",
      "24.5",
      "25.0",
      "25.5",
      "26.0",
      "26.5",
      "27.0",
      "27.5",
      "28.0",
      "28.5",
      "29.0",
      "29.5",
      "30.0"
    ];
  }
  notify(){
    if(widget.onChange!=null && unit!=null && item!=null && value!=null)
      widget.onChange(LoadResult(id:widget.id, unit: loadUnitString(unit), item: item, value:  num.tryParse(value), quantity: quantity));
  }
  itemBtn(){
    return InputDecorator(
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.white30, fontSize: 12.0),
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      isEmpty: item == '',
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: item,
          isDense: true,
          hint: Text('Item'),
          onChanged: (String newValue) {
            setState(() {
              item = newValue;
              notify();
            });
          },
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style: TextStyle(fontSize: 12),),
            );
          }).toList(),
        ),
      ),
    );
  }
  valueBtn(){
    return InputDecorator(
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.white30, fontSize: 12.0),
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
      isEmpty: value == '',
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          hint: Text('Load'),
          onChanged: (String newValue) {
            setState(() {
              value= newValue;
              notify();
            });
          },
          items: values.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style: TextStyle(fontSize: 12),),
            );
          }).toList(),
        ),
      ),
    );
  }
  unitBtn(){
      return InputDecorator(
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.white30, fontSize: 12.0),
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          border: InputBorder.none
        ),
        isEmpty: unit == null,
        child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: unit,
          isDense: true,
          hint: Text('Unit'),
          onChanged: (String newValue) {
            setState(() {
              unit = newValue;
              notify();
            });
          },
          items: units.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style: TextStyle(fontSize: 12),),
            );
          }).toList(),
        ),
      )
      );
  }
  increment(int val){
    val = quantity + val;
    if(val>0){
      setState(() {
        quantity = val;
        notify();
      });
    }
  }
  incrementBtn(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text('Quantity'),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          buttonPadding: EdgeInsets.symmetric(horizontal: 0),
          children: <Widget>[
            IconButton(
              onPressed: ()=>increment(-1),
              icon: Icon(Icons.indeterminate_check_box,color: actionColor,),
            ),
            Container(
              padding:EdgeInsets.symmetric(horizontal: 24,vertical: 3) ,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Text("$quantity"),//Your child widget
            ),
            IconButton(
              onPressed: ()=>increment(1),
              icon: Icon(Icons.add_box,color: actionColor),
            )
          ],
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Item'),
                      itemBtn()
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Load value'),
                      valueBtn()
                    ]
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(''),
                      unitBtn(),
                    ]
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                incrementBtn(),
                Expanded(
                  child:InkWell(
                    onTap: widget.onDelete==null?null:()=>widget.onDelete(widget.id),
                    child: Text('Delete',style: TextStyle(color: rejectColor,decoration: TextDecoration.underline),textAlign: TextAlign.right,),
                  ),
                ),
                SizedBox(height: 2,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
enum LoadUnit{
  KVA,
  HP,
  AMPS,
  KW
}

loadUnitString(unit){
  if(unit is LoadUnit) {
    switch (unit) {
      case LoadUnit.HP:
        return "HP";
      case LoadUnit.KVA:
        return "KVA";
      case LoadUnit.AMPS:
        return "AMPS";
      case LoadUnit.KW:
        return "KW";
      default:
        return "";
    }
  }else{
    switch (unit) {
      case "HP":
        return LoadUnit.HP;
      case "KVA":
        return LoadUnit.KVA;
      case "AMPS":
        return LoadUnit.AMPS;
      case "KW":
        return LoadUnit.KW;
      default:
        return <String>["KVA", "HP", "AMPS", "KW"];
    }
  }
}
class LoadResult{
  LoadResult({@required this.id, @required this.unit, @required this.item, @required this.value, @required this.quantity});
  final int id;
  final LoadUnit unit;
  final String item;
  final num value;
  final int quantity;
  static convertHPtoKVA(num unit,{int quantity:1}){
    return (unit*quantity)*0.746/0.8;
  }
  static convertKWtoKVA(num unit,{int quantity:1}){
    return (unit*quantity)/0.8;
  }
  static convertAMPStoKVA(num unit,{int quantity:1}){
    return (unit*quantity)*0.23/0.8;
  }
  toHP({unit:false}){
  }
  toKVA({unit:false}){
    num res=0;
    switch(this.unit){
      case LoadUnit.HP:
       res = convertHPtoKVA(value,quantity: quantity);
       break;
      case LoadUnit.KW:
        res = convertKWtoKVA(value,quantity: quantity);
        break;
      case LoadUnit.AMPS:
        res = convertAMPStoKVA(value,quantity: quantity);
        break;
      case LoadUnit.KVA:
        res= value*quantity;
        break;
      default:
        res=0;
        break;
    }
    if(unit) return "$res ${loadUnitString(this.unit)}";
    return res;
  }
}