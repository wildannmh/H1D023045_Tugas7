import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:h1d023045_tugas7/widgets/app_side_menu.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  String _username = "Memuat...";
  String _namaLengkap = "";
  String _bio = "";

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? "Tidak Ditemukan";
      _namaLengkap = prefs.getString('nama_lengkap') ?? "Belum diatur";
      _bio = prefs.getString('bio') ?? "Belum ada bio";

      _namaLengkapController.text = _namaLengkap;
      _bioController.text = _bio;
    });
  }

  void _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama_lengkap', _namaLengkapController.text);
    await prefs.setString('bio', _bioController.text);

    setState(() {
      _namaLengkap = _namaLengkapController.text;
      _bio = _bioController.text;
      _isEditing = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Profil berhasil diperbarui!')));
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;

      if (!_isEditing) {
        _namaLengkapController.text = _namaLengkap;
        _bioController.text = _bio;
      }
    });
  }

  Widget _buildDisplayMode() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.teal.shade100,
          child: Icon(Icons.person, size: 60, color: Colors.teal.shade800),
        ),
        SizedBox(height: 16),
        Center(
          child: Text(
            '@$_username',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.grey.shade600),
          ),
        ),
        SizedBox(height: 32),
        ListTile(
          leading: Icon(Icons.badge_outlined),
          title: Text('Nama Lengkap'),
          subtitle: Text(
            _namaLengkap.isEmpty ? "Belum diatur" : _namaLengkap,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('Bio'),
          subtitle: Text(
            _bio.isEmpty ? "Belum ada bio" : _bio,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildEditMode() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Edit Profil @$_username',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 24),
          TextField(
            controller: _namaLengkapController,
            decoration: InputDecoration(
              labelText: 'Nama Lengkap',
              border: OutlineInputBorder(),
              icon: Icon(Icons.badge),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _bioController,
            decoration: InputDecoration(
              labelText: 'Bio',
              border: OutlineInputBorder(),
              icon: Icon(Icons.info_outline),
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          _isEditing
              ? IconButton(
                  icon: Icon(Icons.save),
                  onPressed: _saveProfileData,
                  tooltip: 'Simpan',
                )
              : IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: _toggleEditMode,
                  tooltip: 'Edit Profil',
                ),

          if (_isEditing)
            IconButton(
              icon: Icon(Icons.close),
              onPressed: _toggleEditMode,
              tooltip: 'Batal',
            ),
        ],
      ),
      drawer: const AppSideMenu(),
      body: _isEditing ? _buildEditMode() : _buildDisplayMode(),
    );
  }
}
