// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ObservasiForm extends StatefulWidget {
  const ObservasiForm({Key? key}) : super(key: key);

  @override
  _ObservasiFormState createState() => _ObservasiFormState();
}

class _ObservasiFormState extends State<ObservasiForm> {
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _lokasiObservasiController =
      TextEditingController();
  final TextEditingController _jumlahObservasiController =
      TextEditingController();
  final TextEditingController _golonganObservasiController =
      TextEditingController();
  final TextEditingController _organisasiObservasiController =
      TextEditingController();
  final TextEditingController _perusahaanKontraktorController =
      TextEditingController();
  final TextEditingController _perilaku_selamat = TextEditingController();
  final TextEditingController _perilaku_beresiko = TextEditingController();
  final TextEditingController _ketika = TextEditingController();
  final TextEditingController _ditemukan = TextEditingController();
  final TextEditingController _sebab = TextEditingController();
  final TextEditingController _saran = TextEditingController();
  final TextEditingController _setuju_perilaku_beresiko =
      TextEditingController();
  final TextEditingController _bentuk_perilaku_selamat =
      TextEditingController();
  final TextEditingController _tindak_lanjut = TextEditingController();
  final TextEditingController _komentar = TextEditingController();

  String? _selectedIdKaryawan;
  String? _observasiDiriSendiriError;
  String? _setujuPerilakuTerjadiError;
  String? _setujuPerilakuBeresikoError;
  String? _tindakLanjutError;
  String? _selectedGolonganObservasi;

  List<Karyawan> _karyawanList = [];

  bool? _observasiDiriSendiri;
  bool? _setujuPerilakuTerjadi;
  bool? _coach;
  bool? _setujuPerilakuBeresiko;
  bool? _tindakLanjut;

  final Map<String, bool?> _observasiDetail = {
    '1.1': null,
    '1.2': null,
    '1.3': null,
    '1.4': null,
    '1.5': null,
    '2.1': null,
    '2.2': null,
    '2.3': null,
    '2.4': null,
    '3.1': null,
    '3.2': null,
    '4.1': null,
    '4.2': null,
    '4.3': null,
    '4.4': null,
    '4.5': null,
    '4.7': null,
    '5.1': null,
    '5.2': null,
    '5.3': null,
    '6.1': null,
    '6.2': null,
    '6.3': null,
    '6.4': null,
    '6.5': null,
    '6.6': null,
    '6.7': null,
    '6.8': null,
    '6.9': null,
    '6.10': null,
    '7.1': null,
    '7.2': null,
    '7.3': null,
    '8.1': null,
    '8.2': null,
    '8.3': null,
    '8.4': null,
    '8.5': null,
    '8.6': null,
    '8.7': null,
    '8.8': null,
    '8.9': null,
    '9.1': null,
    '9.2': null,
    '9.3': null,
    '9.4': null,
    '9.5': null,
    '9.6': null,
    '9.7': null,
    '9.8': null,
    '9.9': null,
    '10.1': null,
    '10.2': null,
    '10.3': null,
    '10.4': null,
    '11.0': null,
    // Tambahkan entri detail observasi lainnya di sini sesuai kebutuhan
  };
  final Map<String, String> _deskripsiObservasi = {
    '1.1': 'Menghindari "Line of Fire"',
    '1.2': 'Berjalan/bergerak dengan pandangan ke arah gerakan',
    '1.3': 'Menjaga mata pada pekerjaan',
    '1.4': 'Menjaga badan dan bagiannya diluar posisi terjepit',
    '1.5': 'Naik/turun',
    '2.1': 'Mengangkat/menurunkan/menekan/menarik',
    '2.2': 'Menghindar dari memuntir',
    '2.3': 'Menggapai dalam jangkauan',
    '2.4': 'Menanggapi resiko ergonomi industri',
    '3.1': 'Memilih dan menggunakan perkakas/peralatan',
    '3.2': 'Menggunakan pelindung/barikade/alat peringatan',
    '4.1': 'Persiapan kerja dan JHA (Job Hazard Analysis) - JSA',
    '4.2': 'Mengikuti prosedur',
    '4.3': 'Isolasi energi (Lock-Out/Tag-Out)',
    '4.4': 'Mengerjakan Hot-Work',
    '4.5': 'Memasuki area confined space',
    '4.7': 'Komunikasi ke rekan kerja',
    '5.1': 'Bekerja pada posisi seimbang',
    '5.2': 'Membersihkan/menyimpan peralatan/perkakas (h.keeping)',
    '5.3': 'Bekerja di lingkungan dengan cahaya yang cukup',
    '6.1': 'Melakukan istirahat berkala',
    '6.2': 'Postur leher dan punggung',
    '6.3': 'Postur saat menggunakan telepon',
    '6.4': 'Penyangga punggung',
    '6.5': 'Postur pundak',
    '6.6': 'Posisi pergelangan dan tangan',
    '6.7': 'Memegang/menggerakkan mouse',
    '6.8': 'Posisi Pinggang dan Kaki',
    '6.9': 'Posisi Telapak Kaki',
    '6.10': 'Mengenali dan Melaporkan ketidaknyamanan',
    '7.1': 'Pencegahan tumpahan',
    '7.2': 'Persiapan untuk pembersihan tumpahan',
    '7.3': 'Menangani sampah',
    '8.1': 'Pelindung kepala',
    '8.2': 'Pelindung mata dan wajah',
    '8.3': 'Pelindung pendengaran',
    '8.4': 'Pelindung pernafasan',
    '8.5': 'Pelindung tangan dan lengan',
    '8.6': 'Pelindung jatuh',
    '8.7': 'Pakaian pelindung',
    '8.8': 'Alat mengambang personal',
    '8.9': 'Pelindung kaki',
    '9.1': 'Perencanaan perjalanan',
    '9.2': 'Pre-Trip Inspection dan Seat Belt',
    '9.3': 'Berkendara pada kecepatan yang sesuai',
    '9.4': 'Jarak iring',
    '9.5': 'Mengerem',
    '9.6': 'Berpindah jalur',
    '9.7': 'Menjaga pandangan dan pengamatan',
    '9.8': 'Memundurkan kendaraan',
    '9.9': 'Perilaku lainnya yang tidak tersebut di defenisi driving',
    '10.1': 'Persiapan perjalanan kapal',
    '10.2': 'Menggerakkan/memundurkan kapal',
    '10.3': 'Memasuki persimpangan',
    '10.4': 'Docking',
    '11.0': 'Lain-lain',
  };

  @override
  void initState() {
    super.initState();
    _fetchKaryawanData();
  }

  Future<void> _fetchKaryawanData() async {
    try {
      final response = await http
          .get(Uri.parse('http://10.0.2.2/flutterapi/get_karyawan.php'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['data'];
        setState(() {
          _karyawanList = jsonResponse
              .map((karyawan) => Karyawan.fromJson(karyawan))
              .toList();
        });
      } else {
        throw Exception('Gagal memuat data karyawan');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _submitObservasi() async {
    if (!_isDataValid()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Peringatan"),
            content: Text("Semua field yang berbintang (*) wajib terisi."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      // _saveObservasi();
    } else {
      // Memeriksa apakah observasi detail tidak diisi
      bool observasiDetailIsEmpty = _observasiDetail.containsValue(null);

      if (observasiDetailIsEmpty) {
        // Menampilkan dialog peringatan kedua jika observasi detail tidak diisi
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Peringatan"),
              content: Text(
                  "Ada beberapa observasi detail yang belum dipilih. Lanjutkan tanpa mengisi observasi detail?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Tidak"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _saveObservasi(); // Memanggil fungsi _saveObservasi jika user memilih Ya
                  },
                  child: Text("Ya"),
                ),
              ],
            );
          },
        );
      } else {
        _saveObservasi();
      }
    }
  }

  // bool _isDataValid() {
  //   if (_tanggalController.text.isEmpty ||
  //       _lokasiObservasiController.text.isEmpty ||
  //       _jumlahObservasiController.text.isEmpty ||
  //       _golonganObservasiController.text.isEmpty ||
  //       _organisasiObservasiController.text.isEmpty ||
  //       _perusahaanKontraktorController.text.isEmpty ||
  //       _perilaku_selamat.text.isEmpty ||
  //       _perilaku_beresiko.text.isEmpty ||
  //       _ketika.text.isEmpty ||
  //       _ditemukan.text.isEmpty ||
  //       _sebab.text.isEmpty ||
  //       _saran.text.isEmpty ||
  //       _setuju_perilaku_beresiko.text.isEmpty ||
  //       _bentuk_perilaku_selamat.text.isEmpty ||
  //       _tindak_lanjut.text.isEmpty ||
  //       _komentar.text.isEmpty ||
  //       _selectedIdKaryawan == null ||
  //       _selectedGolonganObservasi == null ||
  //       _observasiDiriSendiri == null ||
  //       _observasiDiriSendiriError != null ||
  //       _coach == null ||
  //       _setujuPerilakuTerjadi == null ||
  //       _setujuPerilakuBeresiko == null ||
  //       _tindakLanjut == null) {
  //     return false;
  //   }
  //   return true;
  // }
  bool _isDataValid() {
    // Memeriksa apakah semua field yang diperlukan telah diisi
    if (_tanggalController.text.isEmpty ||
        _selectedIdKaryawan == null ||
        _observasiDiriSendiri == null ||
        _coach == null ||
        _lokasiObservasiController.text.isEmpty ||
        _jumlahObservasiController.text.isEmpty ||
        _selectedGolonganObservasi == null ||
        _organisasiObservasiController.text.isEmpty ||
        _perusahaanKontraktorController.text.isEmpty ||
        _perilaku_selamat.text.isEmpty ||
        _perilaku_beresiko.text.isEmpty ||
        _ketika.text.isEmpty ||
        _ditemukan.text.isEmpty ||
        _sebab.text.isEmpty ||
        _saran.text.isEmpty ||
        _setujuPerilakuTerjadi == null ||
        _setujuPerilakuBeresiko == null ||
        selectedValuesa == null ||
        _tindakLanjut == null ||
        _komentar.text.isEmpty) {
      return false; // Mengembalikan false jika ada field yang kosong
    }

    // Memeriksa apakah ada observasi detail yang sudah dipilih
    // if (_observasiDetail.containsValue(true)) {
    //   return true; // Mengembalikan true jika ada setidaknya satu observasi detail yang sudah dipilih
    // }

    return true; // Mengembalikan false jika tidak ada observasi detail yang dipilih
  }

  void _saveObservasi() async {
    final url = 'http://10.0.2.2/flutterapi/observasi.php';

    final Map<String, dynamic> observasiData = {
      'tanggal': _tanggalController.text,
      'id_karyawan': _selectedIdKaryawan,
      'observasi_diri_sendiri': _observasiDiriSendiri == true ? '1' : '0',
      'coach': _coach == true ? '1' : '0',
      'lokasi_observasi': _lokasiObservasiController.text,
      'jumlah_observasi': _jumlahObservasiController.text,
      'golongan_observasi': _selectedGolonganObservasi,
      'organisasi_observasi': _organisasiObservasiController.text,
      'perusahaan_kontraktor': _perusahaanKontraktorController.text,
      "perilaku_selamat": _perilaku_selamat.text,
      "perilaku_beresiko": _perilaku_beresiko.text,
      "ketika": _ketika.text,
      "ditemukan": _ditemukan.text,
      "sebab": _sebab.text,
      "saran": _saran.text,
      "setuju_perilaku_terjadi": _setujuPerilakuTerjadi == true ? '1' : '0',
      "setuju_perilaku_beresiko": _setujuPerilakuBeresiko == true ? '1' : '0',
      "bentuk_perilaku_selamat": selectedValuesa,
      "tindak_lanjut": _tindakLanjut == true ? '1' : '0',
      "komentar": _komentar.text
    };

    // Tambahkan nilai observasi ke dalam data jika tidak null
    _observasiDetail.forEach((key, value) {
      if (value != null) {
        observasiData[key] = value ? '1' : '0';
      }
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(observasiData),
      );

      if (response.statusCode == 200) {
        print('Observasi berhasil disimpan');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Data berhasil ditambahkan')));
        _clearForm();
      } else {
        print('Gagal menyimpan observasi');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Gagal menyimpan observasi')));
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _clearForm() {
    setState(() {
      _tanggalController.clear();
      _lokasiObservasiController.clear();
      _jumlahObservasiController.clear();
      _golonganObservasiController.clear();
      _organisasiObservasiController.clear();
      _perusahaanKontraktorController.clear();
      _perilaku_selamat.clear();
      _perilaku_beresiko.clear();
      _ketika.clear();
      _ditemukan.clear();
      _sebab.clear();
      _saran.clear();
      _setuju_perilaku_beresiko.clear();
      _bentuk_perilaku_selamat.clear();
      _tindak_lanjut.clear();
      _komentar.clear();

      selectedValuesa = null;
      _selectedIdKaryawan = null;
      _selectedGolonganObservasi = null;
      _observasiDiriSendiri = null;
      _observasiDiriSendiriError = null;
      _coach = null;
      _setujuPerilakuTerjadi = null;
      _setujuPerilakuBeresiko = null;
      _tindakLanjut = null;

      _observasiDetail.forEach((key, value) {
        _observasiDetail[key] = null;
      });
    });
  }

  String? selectedValuesa;
  final List<String> bentuk_perilaku_selamat_item = [
    'mungkin',
    'sukar',
    'tidak_mungkin'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Observasi'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _tanggalController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field ini tidak boleh kosong';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Tanggal *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      ).then((pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            _tanggalController.text =
                                pickedDate.toIso8601String().split('T').first;
                          });
                        }
                      });
                    },
                    child: Icon(Icons.calendar_today),
                  ),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field ini tidak boleh kosong';
                  }
                  return null;
                },
                value: _selectedIdKaryawan,
                onChanged: (newValue) {
                  setState(() {
                    _selectedIdKaryawan = newValue;
                  });
                },
                items: _karyawanList.map((karyawan) {
                  return DropdownMenuItem<String>(
                    value: karyawan.id.toString(),
                    child: Text('${karyawan.id}-${karyawan.nama} '),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'ID Karyawan *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Observasi Diri Sendiri *'),
              Row(
                children: [
                  Radio(
                    value: true,
                    groupValue: _observasiDiriSendiri,
                    onChanged: (value) {
                      setState(() {
                        _observasiDiriSendiri = value as bool?;
                        _observasiDiriSendiriError = null; // Reset error
                      });
                    },
                  ),
                  const Text('Ya'),
                  Radio(
                    value: false,
                    groupValue: _observasiDiriSendiri,
                    onChanged: (value) {
                      setState(() {
                        _observasiDiriSendiri = value as bool?;
                        _observasiDiriSendiriError = null; // Reset error
                      });
                    },
                  ),
                  const Text('Tidak'),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Coach *'),
              Row(
                children: [
                  Radio(
                    value: true,
                    groupValue: _coach,
                    onChanged: (value) {
                      setState(() {
                        _coach = value as bool?;
                      });
                    },
                  ),
                  const Text('Ya'),
                  Radio(
                    value: false,
                    groupValue: _coach,
                    onChanged: (value) {
                      setState(() {
                        _coach = value as bool?;
                      });
                    },
                  ),
                  const Text('Tidak'),
                ],
              ),
              TextFormField(
                controller: _lokasiObservasiController,
                decoration: InputDecoration(
                  labelText: 'Lokasi Observasi *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _jumlahObservasiController,
                decoration: InputDecoration(
                  labelText: 'Jumlah Observasi *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedGolonganObservasi,
                onChanged: (newValue) {
                  setState(() {
                    _selectedGolonganObservasi = newValue;
                  });
                },
                items: const [
                  DropdownMenuItem<String>(
                    value: 'karyawan',
                    child: Text('Karyawan '),
                  ),
                  DropdownMenuItem<String>(
                    value: 'kontraktor',
                    child: Text('Kontraktor'),
                  ),
                ],
                decoration: InputDecoration(
                  labelText: 'Golongan Observasi *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _organisasiObservasiController,
                decoration: InputDecoration(
                  labelText: 'Organisasi Observasi *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _perusahaanKontraktorController,
                decoration: InputDecoration(
                  labelText: 'Perusahaan Kontraktor *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Detail Observasi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ..._buildObservasiForms(),

              //tambahan
              SizedBox(height: 16),

              TextFormField(
                controller: _perilaku_selamat,
                decoration: InputDecoration(
                  labelText: 'Perilaku Selamat *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              SizedBox(height: 16),
              TextFormField(
                controller: _perilaku_beresiko,
                decoration: InputDecoration(
                  labelText: 'Perilaku Beresiko *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _ketika,
                decoration: InputDecoration(
                  labelText: 'Ketika *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _ditemukan,
                decoration: InputDecoration(
                  labelText: 'Ditemukan *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              SizedBox(height: 16),
              TextFormField(
                controller: _sebab,
                decoration: InputDecoration(
                  labelText: 'Sebab *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _saran,
                decoration: InputDecoration(
                  labelText: 'Saran *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // TextFormField(
              //   controller: _setuju_perilaku_terjadi,
              //   decoration: InputDecoration(
              //     labelText: 'Setuju Perilaku Terjadi *',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //   ),
              // ),
              const Text('Setuju Perilaku Terjadi *'),
              Row(
                children: [
                  Radio(
                    value: true,
                    groupValue: _setujuPerilakuTerjadi,
                    onChanged: (value) {
                      setState(() {
                        _setujuPerilakuTerjadi = value as bool?;
                        _setujuPerilakuTerjadiError = null; // Reset error
                      });
                    },
                  ),
                  const Text('Ya'),
                  Radio(
                    value: false,
                    groupValue: _setujuPerilakuTerjadi,
                    onChanged: (value) {
                      setState(() {
                        _setujuPerilakuTerjadi = value as bool?;
                        _setujuPerilakuTerjadiError = null; // Reset error
                      });
                    },
                  ),
                  const Text('Tidak'),
                ],
              ),

              SizedBox(height: 16),
              const Text('Setuju Perilaku Beresiko *'),
              Row(
                children: [
                  Radio(
                    value: true,
                    groupValue: _setujuPerilakuBeresiko,
                    onChanged: (value) {
                      setState(() {
                        _setujuPerilakuBeresiko = value as bool?;
                        _setujuPerilakuBeresikoError = null; // Reset error
                      });
                    },
                  ),
                  const Text('Ya'),
                  Radio(
                    value: false,
                    groupValue: _setujuPerilakuBeresiko,
                    onChanged: (value) {
                      setState(() {
                        _setujuPerilakuBeresiko = value as bool?;
                        _setujuPerilakuBeresikoError = null; // Reset error
                      });
                    },
                  ),
                  const Text('Tidak'),
                ],
              ),
              // TextFormField(
              //   controller: _setuju_perilaku_beresiko,
              //   decoration: InputDecoration(
              //     labelText: 'Setuju Perilaku Beresiko *',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //   ),
              // ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field ini tidak boleh kosong';
                  }
                  return null;
                },
                value: selectedValuesa,
                onChanged: (newValue) {
                  setState(() {
                    selectedValuesa = newValue;
                  });
                },
                items: bentuk_perilaku_selamat_item
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Bentuk Perilaku Selamat *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // TextFormField(
              //   controller: _tindak_lanjut,
              //   decoration: InputDecoration(
              //     labelText: 'Tindak Lanjut *',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //   ),
              // ),
              const Text('Tinda Lanjut *'),
              Row(
                children: [
                  Radio(
                    value: true,
                    groupValue: _tindakLanjut,
                    onChanged: (value) {
                      setState(() {
                        _tindakLanjut = value as bool?;
                        _tindakLanjutError = null; // Reset error
                      });
                    },
                  ),
                  const Text('Ya'),
                  Radio(
                    value: false,
                    groupValue: _tindakLanjut,
                    onChanged: (value) {
                      setState(() {
                        _tindakLanjut = value as bool?;
                        _tindakLanjutError = null; // Reset error
                      });
                    },
                  ),
                  const Text('Tidak'),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _komentar,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Komentar *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              // tombol

              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitObservasi,
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

  List<Widget> _buildObservasiForms() {
    List<Widget> observasiForms = [];
    _observasiDetail.forEach((key, value) {
      observasiForms.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '$key ${_deskripsiObservasi[key]}'), // Menggunakan deskripsi dari _deskripsiObservasi
            const SizedBox(height: 10),
            Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _observasiDetail[key],
                  onChanged: (value) {
                    setState(() {
                      _observasiDetail[key] = true;
                    });
                  },
                ),
                const Text('Safe'),
                const SizedBox(width: 10),
                Radio(
                  value: false,
                  groupValue: _observasiDetail[key],
                  onChanged: (value) {
                    setState(() {
                      _observasiDetail[key] = false;
                    });
                  },
                ),
                const Text('At Risk'),
              ],
            ),
          ],
        ),
      );
    });
    return observasiForms;
  }
}

class Karyawan {
  final int id;
  final String nama;
  final String nobadge;
  final String jabatan;

  Karyawan({
    required this.id,
    required this.nama,
    required this.nobadge,
    required this.jabatan,
  });

  factory Karyawan.fromJson(Map<String, dynamic> json) {
    return Karyawan(
      id: int.parse(json['id_karyawan']),
      nama: json['nama_karyawan'],
      nobadge: json['nobadge'],
      jabatan: json['jabatan'],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Observasi Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ObservasiForm(),
    );
  }
}
