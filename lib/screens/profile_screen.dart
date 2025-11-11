import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController skillController = TextEditingController();
  final TextEditingController resumeController = TextEditingController();
 File ? educationFile;
 File ? resumeFile;
String ? selectedlanguage;
List <String> languages = ['English','Hindi'];

Future <void> pickFile(bool isEducation )async {
  final result = await FilePicker.platform.pickFiles(
    type : FileType.custom,
    allowedExtensions: ['jpg','jpeg'],
  );

  if(result!= null && result.files.single.path!=null){
    setState (() {
final file =File(result.files.single.path!);
if(isEducation) {
  educationFile =file;
} else {
  resumeFile= file;
}
    });
  }
}
 


  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(

    ),
     body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Add Experience", experienceController),
            const SizedBox(height: 16),

            // Education section
            _buildTextField("Add Education Details", educationController),
            const SizedBox(height: 8),
            if (educationFile != null)
              Image.file(educationFile!, height: 120, width: double.infinity, fit: BoxFit.cover),
            ElevatedButton.icon(
              onPressed: () => pickFile(true),
              icon: const Icon(Icons.attach_file),
              label: const Text("Upload Education Image(JPEG)"),
            ),
            const SizedBox(height: 16),

            // Skills section
            _buildTextField("Add Skills", skillController),
            const SizedBox(height: 16),

            // Language dropdown
            DropdownButtonFormField<String>(
              value: selectedlanguage,
              decoration: InputDecoration(
                labelText: "Choose Language",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: languages
                  .map((lang){
                    return DropdownMenuItem(value: lang, child: Text(lang));
                     })
                  .toList(),
              onChanged: (value) {
                setState(() =>
                  selectedlanguage = value);
                },
            ),
           
            const SizedBox(height: 16),

            // Resume 
            _buildTextField("Add Resume Text", resumeController),
            const SizedBox(height: 8),
            if (resumeFile != null)
              Image.file(resumeFile!, height: 120, width: double.infinity, fit: BoxFit.cover),
            ElevatedButton.icon(
              onPressed: () => pickFile(false),
              icon: const Icon(Icons.upload_file),
              label: const Text("Upload Resume/CV (JPEG)"),
            ),
            const SizedBox(height: 24),

            // Save button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 4, 50, 132),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: const [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 8),
          Text("Success"),
        ],
      ),
      content: const Text("Profile Saved Successfully!"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ],
    ),
  );
},

                child: const Text("Save Profile", 
                style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),



    );
  }
}
    
    
 