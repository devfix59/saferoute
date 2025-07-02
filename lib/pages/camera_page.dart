import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _imageFile;
  Position? _position;

  final ImagePicker _picker = ImagePicker();

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifie si les services de localisation sont activés
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Les services de localisation sont désactivés.');
    }

    // Demande la permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
        return Future.error('Les permissions de localisation sont refusées.');
      }
    }

    // Récupère la position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _position = position;
    });
  }

  Future<void> _takePicture() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _submitCameraData() {
    if (_imageFile == null || _position == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Prenez une photo et récupérez la localisation")),
      );
      return;
    }

    // Ici, vous pouvez envoyer les données à votre base de données ou API
    print('Image Path: ${_imageFile!.path}');
    print('Latitude: ${_position!.latitude}');
    print('Longitude: ${_position!.longitude}');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Caméra ajoutée avec succès !")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter une Caméra"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _imageFile != null
                ? Image.file(_imageFile!)
                : Placeholder(fallbackHeight: 200),

            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.camera_alt),
              label: Text("Prendre une photo"),
              onPressed: _takePicture,
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.location_on),
              label: Text("Obtenir ma position"),
              onPressed: _getCurrentLocation,
            ),
            SizedBox(height: 10),
            _position != null
                ? Text("Position : ${_position!.latitude}, ${_position!.longitude}")
                : Text("Aucune position détectée"),

            Spacer(),
            ElevatedButton(
              onPressed: _submitCameraData,
              child: Text("Soumettre la caméra"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
