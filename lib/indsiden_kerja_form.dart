import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InsidenDetailPage extends StatefulWidget {
  const InsidenDetailPage({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  _InsidenDetailPageState createState() => _InsidenDetailPageState();
}

class _InsidenDetailPageState extends State<InsidenDetailPage> {
  late DateTime _selectedDate;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _bagianController = TextEditingController();
  final TextEditingController _uraianController = TextEditingController();
  final TextEditingController _penyebabController = TextEditingController();
  final TextEditingController _tingkatInsidenController =
      TextEditingController();
  final TextEditingController _dayLostController = TextEditingController();
  final TextEditingController _nltiController = TextEditingController();
  final TextEditingController _tliController = TextEditingController();

  List<Karyawan> _karyawanList = [];
  Karyawan? _selectedKaryawan;
  bool _loading = true;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    fetchKaryawan().then((karyawanList) {
      setState(() {
        _karyawanList = karyawanList;
        _loading = false;
      });
    }).catchError((error) {
      setState(() {
        _error = true;
        _loading = false;
      });
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse('http://10.0.2.2/flutterapi/insert_insiden.php'),
          body: {
            'id_karyawan': _selectedKaryawan!.id.toString(),
            'tanggal': _selectedDate.toIso8601String().split('T')[0],
            'nama_karyawan': _selectedKaryawan!.nama,
            // 'nobadge': _selectedKaryawan!.nobadge.toString(),
            // 'jabatan': _selectedKaryawan!.jabatan.toString(),
            'nobadge': _selectedKaryawan?.nobadge ?? '',
            'jabatan': _selectedKaryawan?.jabatan ?? '',

            'uraian': _uraianController.text,
            'penyebab': _penyebabController.text,
            'tingkat_insiden': _tingkatInsidenController.text,
            'nlti': _nltiController.text,
            'tli': _tliController.text,
            'day_lost': _dayLostController.text,
          },
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          var responseBody = json.decode(response.body);
          if (responseBody['status'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Data berhasil ditambahkan')));
            _clearForm();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${responseBody['message']}')));
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error: Server error')));
        }
      } catch (e) {
        print('Exception: $e');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<List<Karyawan>> fetchKaryawan() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2/flutterapi/get_karyawan.php'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((karyawan) => Karyawan.fromJson(karyawan))
          .toList();
    } else {
      throw Exception('Failed to load karyawan');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error) {
      return const Scaffold(
          body: Center(child: Text('Failed to fetch data from the API')));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.subtitle,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              _buildDateField(),
              const SizedBox(height: 20),
              _buildDropdownField(),
              const SizedBox(height: 10),
              _buildFormFieldWithTitle(
                title: 'NIK',
                controller: _nikController,
              ),
              const SizedBox(height: 10),
              _buildFormFieldWithTitle(
                title: 'Uraian',
                controller: _uraianController,
                maxLines: null,
              ),
              const SizedBox(height: 10),
              _buildFormFieldWithTitle(
                title: 'Penyebab',
                controller: _penyebabController,
                maxLines: null,
              ),
              const SizedBox(height: 10),
              _buildFormFieldWithTitle(
                title: 'Tingkat Insiden',
                controller: _tingkatInsidenController,
              ),
              const SizedBox(height: 10),
              _buildFormFieldWithTitle(
                title: 'NLTI',
                controller: _nltiController,
                maxLines: null,
              ),
              const SizedBox(height: 10),
              _buildFormFieldWithTitle(
                title: 'TLI',
                controller: _tliController,
                maxLines: null,
              ),
              const SizedBox(height: 10),
              _buildFormFieldWithTitle(
                title: 'Day Lost',
                controller: _dayLostController,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tanggal Kejadian',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: TextEditingController(
                  text:
                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field ini tidak boleh kosong';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Pilih Tanggal'),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nama Karyawan',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<Karyawan>(
          value: _selectedKaryawan,
          items: _karyawanList.map((Karyawan karyawan) {
            return DropdownMenuItem<Karyawan>(
              value: karyawan,
              child: Text(karyawan.nama),
            );
          }).toList(),
          onChanged: (Karyawan? newValue) {
            setState(() {
              _selectedKaryawan = newValue;
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          validator: (value) =>
              value == null ? 'Nama karyawan wajib diisi' : null,
        ),
      ],
    );
  }

  Widget _buildFormFieldWithTitle(
      {required String title,
      required TextEditingController controller,
      int? maxLines}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field ini tidak boleh kosong';
            }
            return null;
          },
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _clearForm() {
    _selectedDate = DateTime.now();
    _selectedKaryawan = null;
    _nikController.clear();
    _bagianController.clear();
    _uraianController.clear();
    _penyebabController.clear();
    _tingkatInsidenController.clear();
    _dayLostController.clear();
    _nltiController.clear();
    _tliController.clear();
  }
}

class Karyawan {
  final int id;
  final String nama;
  final String nobadge;
  final String jabatan;

  Karyawan(
      {required this.id,
      required this.nama,
      required this.nobadge,
      required this.jabatan});

  factory Karyawan.fromJson(Map<String, dynamic> json) {
    return Karyawan(
      id: int.parse(json['id_karyawan']),
      nama: json['nama_karyawan'],
      nobadge: json['nobadge'],
      jabatan: json['jabatan'],
    );
  }
}
