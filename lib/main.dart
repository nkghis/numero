import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  //Initialise contacts.
  List<Contact> contacts = [];
  List<Contact> contactMoov = [];
  List<Contact> contactOrange = [];
  List<Contact> contactMtn = [];

  void initState(){
    super.initState();
    getAllContacts();
    //getOrangeContact();
  }

  /*getAllContacts() async{

    // Get all contacts without thumbnail (faster)
    List<Contact> _contacts = (await ContactsService.getContacts(withThumbnails: false)).toList();
    List<String> orange = ["07","08","09","47","48","49","57","58","59","67","68","69","77","78","79","87","88","89","97","98","99"];
    List<String> moov = ["01","02","03","41","42","43","51","52","53","61","62","63","71","72","73","81","82","83","91","92","93"];
    List<String> mtn = ["04","05","06","44","45","46","54","55","56","64","65","66","74","75","76","84","85","86","94","95","96"];
    List<String> other = ["+", "00"];

    List<String> all = [
      "07","08","09","47","48","49","57","58","59","67","68","69","77","78","79","87","88","89","97","98","99",
      "01","02","03","41","42","43","51","52","53","61","62","63","71","72","73","81","82","83","91","92","93",
      "04","05","06","44","45","46","54","55","56","64","65","66","74","75","76","84","85","86","94","95","96",
      "+", "00"
    ];
    for (var c in _contacts){

      String phoneNumber = c.phones.elementAt(0).value;
      String prefixe = phoneNumber.substring(0,2);
      //String otherPrefixe = phoneNumber.substring(startIndex)
      if(orange.contains(prefixe))
        {
          contactOrange.add(c);
         //c.displayName = "papa nkagou";
         c.givenName = "bauer";
         List<Item> it =[];
         Item dd = new Item();
         dd.value = "0101010598";
         it.add(dd);
         c.phones = it;
         await ContactsService.updateContact(c);
          //await ContactsService.updateContact(c);
          String pp = c.displayName;

        }
          if(moov.contains(prefixe)){
            contactMoov.add(c);
          }
            if(mtn.contains(prefixe)){
              contactMtn.add(c);
            }

              if(other.contains(prefixe)){
                String otherPrefixe00 = phoneNumber.substring(0,5);
                String otherPrefixePlus = phoneNumber.substring(0,4);
                  if(otherPrefixe00 == "00225"){
                    //get phone number and retrieve on begin 5 char.
                    //Apply Change number Method

                  }
                    if(otherPrefixePlus == "+225"){
                      //get phone number and retrieve on begin 4 char.
                      //Apply Change number Method
                    }
              }




        //contactOrange.add(c);
    }
    setState(() {
      contacts = _contacts;
    });
  }*/

  /*getOrangeContact()async{
    await contacts.forEach((Contact contact) {
      //print(contact.displayName);
      print("${contact.displayName}");
    });
  }*/
  getAllContacts() async{
    List<Contact> _contacts = (await ContactsService.getContacts(withThumbnails: false)).toList();

    for (var c in _contacts){

      //get all number of contact on List<Item>
    List<Item> allphones = c.phones.toList();

    //get new list of all number of contact on List<Item> after reformated on 10 digits
    List<Item> phones = addNumber(allphones);

    //Check if new list is not empty
    if(phones.length != 0){

      //Update Contact
      updateContact(c, phones);
    }

    }

  }

  //Method remove white space with REGEX
  String removeWhiteSpace(String s) {
    if (s == null) {
      return null;
    }

    // This pattern means "at least one space, or more"
    // \\s : space
    // +   : one or more
    final pattern = RegExp('\\s+');
    return s.replaceAll(pattern, '');
  }

changeNumber (Contact contact) async{
  String phoneNumber = removeWhiteSpace(contact.phones.elementAt(0).value);

  String phoneNumberOriginal = contact.phones.elementAt(0).value;
  String prefixe = phoneNumber.substring(0,2);
  List<Item> phones =[];
  List<String> orange = ["07","08","09","47","48","49","57","58","59","67","68","69","77","78","79","87","88","89","97","98","99"];
  List<String> moov = ["01","02","03","41","42","43","51","52","53","61","62","63","71","72","73","81","82","83","91","92","93"];
  List<String> mtn = ["04","05","06","44","45","46","54","55","56","64","65","66","74","75","76","84","85","86","94","95","96"];
  Item item = new Item();
  String p = null;

  if(phoneNumber.startsWith('+225')){
    phoneNumber = phoneNumber.substring(4);
    prefixe = phoneNumber.substring(0,2);
  }
  if(phoneNumber.startsWith('00225')){
    phoneNumber = phoneNumber.substring(5);
    prefixe = phoneNumber.substring(0,2);
  }


  if(orange.contains(prefixe)){
     p = "07";

  }

  if(moov.contains(prefixe)){
       p = "01";
  }

  if(mtn.contains(prefixe)){
    p = "05";}

  if(phoneNumberOriginal.startsWith('+225')){
    item.value = "+225 " + p + phoneNumber;
  }

  if(phoneNumberOriginal.startsWith('00225')){
    item.value = "00225 " + p +phoneNumber;
  }else{
    item.value = p + phoneNumber;
  }



  phones.add(item);
  contact.phones = phones;
  await ContactsService.updateContact(contact);
}

//Add number item on list
List<Item> addNumber(List <Item> phonesNumbers){
    List <Item> phones = [];

    for (var pn in phonesNumbers){
      //Declaration
      String phoneNumber = removeWhiteSpace(pn.value);

      Item item = new Item();
      String prefixe = "";
      String surfixe = "";


      //Check length of number
      if(phoneNumber.length==8){

        //Get prefixe with method
        prefixe = getPrefixe(phoneNumber);

        if(prefixe != null){
          item.value = prefixe + phoneNumber;
          phones.add(item);
        }


      }

      if(phoneNumber.length == 12 || phoneNumber.length == 13){
        if(phoneNumber.startsWith('+225')){
          phoneNumber = phoneNumber.substring(4);
          prefixe = getPrefixe(phoneNumber);
          surfixe = "+225";
        }
        if(phoneNumber.startsWith('00225')){
          phoneNumber = phoneNumber.substring(5);
          prefixe = getPrefixe(phoneNumber);
          surfixe = "00225";
        }

        if(prefixe != null){
          item.value = surfixe + prefixe + phoneNumber;
          phones.add(item);
        }
      }
    }
    return phones;
}

//Method Get Prefix
String getPrefixe(String phoneNumber){

    //Declaration
  List<String> orange = ["07","08","09","47","48","49","57","58","59","67","68","69","77","78","79","87","88","89","97","98","99"];
  List<String> moov = ["01","02","03","41","42","43","51","52","53","61","62","63","71","72","73","81","82","83","91","92","93"];
  List<String> mtn = ["04","05","06","44","45","46","54","55","56","64","65","66","74","75","76","84","85","86","94","95","96"];
  List<String> fixe = ["20","21","22","23","24","30","31","32","33","34","35","36"];
  String prefixe = phoneNumber.substring(0,2);
  String p = null;

  //Check if 2digits of number exist on list below
  if(orange.contains(prefixe)){
    p = "07";

  }
  if(moov.contains(prefixe)){
    p = "01";
  }

  if(mtn.contains(prefixe)){
    p = "05";
  }
  if(fixe.contains(prefixe)){
    String prefix = phoneNumber.substring(0,3);
    List<String> orangeFixe = ["202","203","212","213","215","217","224","225","234","235","243","244","245","306","316","319","327","337","347","359","368"];
    List<String> mtnFixe = ["200","210","220","230","240","300","310","320","330","340","350","360"];
    List<String> moovFixe = ["208","218","228","238"];

    //Check if 2digits of number exist on list below
    if(orangeFixe.contains(prefix)){
      p = "27";
    }
    if(mtnFixe.contains(prefix)){
      p = "25";
    }
    if(moovFixe.contains(prefix)){
      p = "21";
    }
  }
  return p;
}


String getPrefixewithFixe(String phoneNumber){

    List<String> orange = ["07","08","09","47","48","49","57","58","59","67","68","69","77","78","79","87","88","89","97","98","99"];
    List<String> moov = ["01","02","03","41","42","43","51","52","53","61","62","63","71","72","73","81","82","83","91","92","93"];
    List<String> mtn = ["04","05","06","44","45","46","54","55","56","64","65","66","74","75","76","84","85","86","94","95","96"];
    List<String> fixe = ["20","21","22","23","24","30","31","32","33","34","35","36"];
    String prefixe = phoneNumber.substring(0,2);
    String p = null;

    if(orange.contains(prefixe)){
      p = "07";

    }
    if(moov.contains(prefixe)){
      p = "01";
    }

    if(mtn.contains(prefixe)){
      p = "05";
    }
    if(fixe.contains(prefixe)){
      String prefix = phoneNumber.substring(0,3);
      List<String> orangeFixe = ["202","203","212","213","215","217","224","225","234","235","243","244","245","306","316","319","327","337","347","359","368"];
      List<String> mtnFixe = ["200","210","220","230","240","300","310","320","330","340","350","360"];
      List<String> moovFixe = ["208","218","228","238"];
      if(orangeFixe.contains(prefix)){
        p = "27";
      }
      if(mtnFixe.contains(prefix)){
        p = "25";
      }
      if(moovFixe.contains(prefix)){
        p = "21";
      }
    }

    return p;
  }

  //Update Contact
updateContact(Contact contact, List<Item> phones) async{
    //Affect contact
  contact.phones = phones;
  //Update contact
  await ContactsService.updateContact(contact);
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:'+ contacts.length.toString(),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: <Widget>[
                      Text('hi'),
                      Text('hi'),
                      Text('hi'),
                    ]
                )
            ),
            ListView.builder(
              shrinkWrap : true,
               itemCount: contacts.length,
               itemBuilder: (context, index){
                 Contact contact = contacts[index];
                 return ListTile(
                    title: Text(contact.displayName),
                    subtitle: Text(
                      contact.phones.elementAt(0).value
                    ),
                 );
               },
            )
          ],
        ),
      ),

    );
  }
}
