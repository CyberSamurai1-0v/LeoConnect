import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFFFD700), // Gold
              Color(0xFF000000), // Black
            ],
            stops: [0.0, 0.5],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button and title
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      // Centered title
                      Center(
                        child: const Text(
                          'Contact Us',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      // Back button
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Email field
                  _buildTextField('Email'),
                  const SizedBox(height: 16),

                  // Phone Number field
                  _buildTextField('Phone Number'),
                  const SizedBox(height: 16),

                  // District field
                  _buildTextField('District'),
                  const SizedBox(height: 24),

                  // Message label
                  const Text(
                    'What is your Message ?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Message input field
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Expanded(
                          child: TextField(
                            maxLines: null,
                            expands: true,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type your message here...',
                              hintStyle: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Selected files
                        if (selectedFiles.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Wrap(
                            children: selectedFiles
                                .map((file) => _buildFileChip(file))
                                .toList(),
                          ),
                          const SizedBox(height: 8),
                        ],
                        // Attachment button with popup menu
                        Align(
                          alignment: Alignment.centerRight,
                          child: PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.attach_file,
                              color: Color.fromARGB(255, 124, 89, 9),
                              size: 30,
                            ),
                            onSelected: _pickFiles,
                            itemBuilder: (BuildContext context) {
                              return [
                                const PopupMenuItem(
                                  value: 'Documents',
                                  child: Row(
                                    children: [
                                      Icon(Icons.insert_drive_file, size: 20),
                                      SizedBox(width: 8),
                                      Text('Documents'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'Images',
                                  child: Row(
                                    children: [
                                      Icon(Icons.image, size: 20),
                                      SizedBox(width: 8),
                                      Text('Images'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'Zip',
                                  child: Row(
                                    children: [
                                      Icon(Icons.folder_zip, size: 20),
                                      SizedBox(width: 8),
                                      Text('Zip Files'),
                                    ],
                                  ),
                                ),
                              ];
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Send button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD700),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        'Send',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Hotline text
                  const Center(
                    child: Text(
                      'Hotline - 07x xxx xxxx',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return TextField(
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
    );
  }

  List<File> selectedFiles = [];
  bool showAttachmentOptions = false;

  Future<void> _pickFiles(String type) async {
    FilePickerResult? result;

    switch (type) {
      case 'Documents':
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
          allowMultiple: true,
        );
        break;
      case 'Images':
        result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: true,
        );
        break;
      case 'Zip':
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['zip', 'rar'],
          allowMultiple: true,
        );
        break;
    }

    if (result != null) {
      setState(() {
        selectedFiles.addAll(result!.paths.map((path) => File(path!)).toList());
        showAttachmentOptions = false;
      });
    }
  }

  Widget _buildFileChip(File file) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            file.path.split('/').last,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedFiles.remove(file);
              });
            },
            child: const Icon(Icons.close, size: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
