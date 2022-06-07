import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unico_check/unico_check.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'unico check',
      theme: ThemeData(
        primaryColor: const Color(0xFF8d7ad2),
      ),
      home: MyHomePage(title: 'unico | check'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    implements UnicoListener, UnicoDocument, UnicoSelfie {
  late UnicoCheckBuilder unicoCheck;

  // Deve-se inserir o arquivo json no caminho: android/app/src/main/assets, caso não possua
  // a pasta assets, a criação dela é necessária.
  // Ao inserir o arquivo na pasta, deve-se colocar o nome do arquivo na String abaixo.
  String jsonName = "credenciais.json";

  // Configura o frame de captura
  final theme = UnicoTheme(
    colorSilhouetteSuccess: "#4ca832",
    colorSilhouetteError: "#fcdb03",
    colorBackground: "#dcdcdc",
    // colorTextMessage: "#000000",
    colorBackgroundTakePictureButton: "#8d7ad2",
    colorBackgroundButtonPopupError: "#808080",
    colorTextPopupError: "#808080",
  );

  // Para a utilização no IOS, deve substituir as informações abaixo
  // pelos dados da sua Api KEY.
  final config = UnicoConfig(
      getProjectNumber: "getProjectNumber",
      getProjectId: "getProjectId",
      getMobileSdkAppId: "getMobileSdkAppId",
      getBundleIdentifier: "getBundleIdentifier",
      getHostInfo: "getHostInfo",
      getHostKey: "getHostKey");

  @override
  void initState() {
    super.initState();
    initAcessoBio();
  }

  void initAcessoBio() {
    unicoCheck = UnicoCheck(this)
        .setTheme(unicoTheme: theme)
        .setUnicoConfig(unicoConfig: config);
  }

  void openCamera() {
    unicoCheck
        .setAutoCapture(autoCapture: true)
        .setSmartFrame(smartFrame: true)
        .build()
        .openCameraSelfie(jsonFileName: jsonName, listener: this);
  }

  void openCameraNormal() {
    unicoCheck
        .setAutoCapture(autoCapture: false)
        .setSmartFrame(smartFrame: false)
        .build()
        .openCameraSelfie(jsonFileName: jsonName, listener: this);
  }

  void openCameraDocumentCNH() {
    unicoCheck.build().openCameraDocument(
        jsonFileName: jsonName, documentType: DocumentType.CNH, listener: this);
  }

  void openCameraDocumentCNHFrente() {
    unicoCheck.build().openCameraDocument(
        jsonFileName: jsonName,
        documentType: DocumentType.CNH_FRENTE,
        listener: this);
  }

  void openCameraDocumentCNHVerso() {
    unicoCheck.build().openCameraDocument(
        jsonFileName: jsonName,
        documentType: DocumentType.CNH_VERSO,
        listener: this);
  }

  void openCameraDocumentRGFrente() {
    unicoCheck.build().openCameraDocument(
        jsonFileName: jsonName,
        documentType: DocumentType.RG_FRENTE,
        listener: this);
  }

  void openCameraDocumentRGVerso() {
    unicoCheck.build().openCameraDocument(
        jsonFileName: jsonName,
        documentType: DocumentType.RG_VERSO,
        listener: this);
  }

  void openCameraDocumentCPF() {
    unicoCheck.build().openCameraDocument(
        jsonFileName: jsonName, documentType: DocumentType.CPF, listener: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
        backgroundColor: const Color(0xFF8d7ad2),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Center(
                child: Text(
                  'Bem-vindo a poc do unico | check !',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: const Text(
                'Teste agora nossa tecnologia:',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: const Text(
                'Camera para selfie:',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: openCameraNormal,
                child: const Text('Camera normal'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: openCamera,
                child: const Text('Camera inteligente'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: const Text(
                'Camera para documentos:',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextButton(
                  onPressed: openCameraDocumentCNH,
                  child: const Text('Documentos CNH')),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: openCameraDocumentCNHFrente,
                child: const Text('Documentos CNH Frente'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: openCameraDocumentCNHVerso,
                child: const Text('Documentos CNH Verso'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: openCameraDocumentRGFrente,
                child: const Text('Documentos RG Frente'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: openCameraDocumentRGVerso,
                child: const Text('Documentos RG verso'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: openCameraDocumentCPF,
                child: const Text('Documentos CPF'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Unico callbacks
  @override
  void onErrorAcessoBio(UnicoError error) {
    showToast("Erro ao abrir a camera: ${error.description}");
  }

  @override
  void onSystemChangedTypeCameraTimeoutFaceInference() {
    showToast("Sistema trocou o tipo da camera !");
  }

  @override
  void onSystemClosedCameraTimeoutSession() {
    showToast("Sistema fechou a camera !");
  }

  @override
  void onUserClosedCameraManually() {
    showToast("Usuario fechou camera manualmente !");
  }

  ///Selfie callbacks
  @override
  void onSuccessSelfie(ResultCamera result) {
    showToast("Sucesso na captura, aqui temos o base64 e encrypted ");
  }

  @override
  void onErrorSelfie(UnicoError result) {
    showToast("Erro ao abrir a camera: ${result.description}");
  }

  ///Document callbacks
  @override
  void onSuccessDocument(ResultCamera base64) {
    showToast("Sucesso na captura, aqui temos o base64 e encrypted ");
  }

  @override
  void onErrorDocument(UnicoError error) {
    showToast("Erro ao abrir a camera: ${error.description}");
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.amber,
      fontSize: 14,
    );
  }
}
