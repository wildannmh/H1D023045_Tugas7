<h1>Nama: Wildan Munawwar Habib<br>
NIM: H1D023045</h1>

## Fitur Utama Aplikasi

* **Sistem Registrasi:** Pengguna tidak lagi *hardcoded* (`admin`/`admin`). Kini terdapat alur registrasi di mana pengguna dapat mendaftarkan akun baru, dan datanya disimpan dengan aman di `shared_preferences`.
* **Manajemen Sesi Otomatis:** Aplikasi secara otomatis memeriksa status login saat dibuka. Jika pengguna sudah login, mereka akan langsung diarahkan ke Halaman Home, bukan ke Halaman Login.
* **Fungsi Logout Lengkap:** Tombol logout di side menu akan membersihkan data sesi (status login) dan mengembalikan pengguna ke Halaman Login.
* **Halaman Profil Dinamis (View/Edit):**
    * Saat dibuka, halaman ini berada dalam mode "Tampil" (View-Only) yang rapi.
    * Pengguna dapat menekan tombol "Edit" di AppBar untuk masuk ke mode "Edit", di mana `Text` akan berubah menjadi `TextField` untuk memperbarui data.
    * Data profil (Nama Lengkap, Bio) juga disimpan di `shared_preferences`.
* **Halaman Pengaturan dengan Tema (Dark Mode):**
    * Halaman pengaturan terpisah untuk mengontrol preferensi aplikasi.
    * Fitur utama adalah `Switch` untuk mengganti tema aplikasi antara **Mode Terang (Light)** dan **Mode Gelap (Dark)**.
    * Pilihan tema ini **disimpan** di `shared_preferences` sehingga akan diingat saat aplikasi dibuka kembali.

## Screenshot Aplikasi

| Halaman Registrasi | Halaman Login |
| :---: | :---: |
| <img width="438" height="1014" alt="image" src="https://github.com/user-attachments/assets/cd849ad3-99c6-4ab5-a8d9-ed27239723c5" /> | <img width="440" height="1012" alt="image" src="https://github.com/user-attachments/assets/d723dea0-4293-4ef6-b18b-ec433dba59a4" /> |
| Halaman Home (Light) | Halaman Home (Dark) |
| <img width="439" height="1012" alt="image" src="https://github.com/user-attachments/assets/1fcf6f33-1b6a-4e0c-978f-7aaa172cb429" /> | <img width="442" height="1020" alt="image" src="https://github.com/user-attachments/assets/fc1b82c8-7c18-40d9-9b43-ab701a69b51d" /> |
| Halaman Profil (Mode Tampil) | Halaman Profil (Mode Edit) |
| <img width="439" height="1013" alt="image" src="https://github.com/user-attachments/assets/d48d5664-f5b2-4d7a-a4c2-16c8e580c6d7" /> | <img width="440" height="1015" alt="image" src="https://github.com/user-attachments/assets/09bb9ea4-ee97-4ddb-a230-c4e3c3e53dc3" /> |
| Halaman Pengaturan (Light) | Halaman Pengaturan (Dark) |
| <img width="444" height="1016" alt="image" src="https://github.com/user-attachments/assets/b30f9e3d-c367-48e1-a1c9-083f4b9aeefa" /> | <img width="442" height="1016" alt="image" src="https://github.com/user-attachments/assets/e41c681c-273d-46a4-a166-c7ed4e761c3c" /> |
| Side Menu (Light) | Side Menu (Dark) |
| <img width="442" height="1016" alt="image" src="https://github.com/user-attachments/assets/566a69eb-9b36-4efd-a4bf-4742559dd685" /> | <img width="440" height="1015" alt="image" src="https://github.com/user-attachments/assets/cbb986c5-3de8-4c66-b785-39ba9a7fc570" /> |

## Penjelasan Struktur & Kode

Aplikasi ini dibagi menjadi beberapa folder untuk menjaga kerapian kode (`pages` untuk layar, `widgets` untuk komponen yang dapat digunakan kembali).

### `lib/`
lib/<br>
├── pages/<br>
│   ├── auth_check_page.dart     # Pengecek sesi login saat aplikasi dibuka<br>
│   ├── home_page.dart         # Halaman utama setelah login<br>
│   ├── login_page.dart        # Halaman untuk login<br>
│   ├── profile_page.dart      # Halaman profil dinamis (tampil/edit)<br>
│   ├── registration_page.dart   # Halaman untuk daftar akun baru<br>
│   └── settings_page.dart     # Halaman pengaturan (ganti tema)<br>
├── widgets/<br>
│   └── app_side_menu.dart     # Widget side menu yang bisa dipakai ulang<br>
├── main.dart                  # File utama, titik masuk aplikasi<br>
└── theme_notifier.dart        # Notifier untuk mengelola status tema (dark/light)


### Penjelasan Tiap File

* **`main.dart`**
    * Titik masuk utama aplikasi.
    * Fungsi `main()` diubah menjadi `async` untuk `WidgetsFlutterBinding.ensureInitialized()` agar bisa membaca `shared_preferences` (untuk tema) **sebelum** aplikasi dijalankan.
    * Membungkus `MaterialApp` dengan `ValueListenableBuilder` yang mendengarkan `themeNotifier` untuk mengubah tema secara global dan instan.

* **`theme_notifier.dart`**
    * File sederhana yang berisi `ValueNotifier`. Ini bertindak sebagai "kotak" penyimpan *state* tema global. Widget (seperti `main.dart` dan `settings_page.dart`) dapat "mendengarkan" dan bereaksi terhadap perubahan nilainya.

* **`pages/auth_check_page.dart`**
    * Bertindak sebagai "pintu gerbang" aplikasi.
    * Saat dibuka, ia segera memeriksa `shared_preferences` untuk *key* `is_logged_in`.
    * Jika `true`, pengguna diarahkan ke `HomePage`.
    * Jika `false` atau `null`, pengguna diarahkan ke `LoginPage`.

* **`pages/registration_page.dart`**
    * Halaman `StatefulWidget` berisi `TextField`s untuk mendaftarkan pengguna baru.
    * Menyimpan data `registered_username` dan `registered_password` ke `shared_preferences`.

* **`pages/login_page.dart`**
    * Memvalidasi input pengguna dengan data yang disimpan saat registrasi.
    * Jika berhasil, ia akan menyimpan *session state* baru: `is_logged_in = true` ke `shared_preferences`.

* **`pages/home_page.dart`**
    * Halaman utama yang menyambut pengguna.
    * Mengambil `username` dari `shared_preferences` untuk ditampilkan.
    * Menampilkan `AppSideMenu` di `drawer`.

* **`pages/profile_page.dart`**
    * Halaman `StatefulWidget` yang paling dinamis.
    * Menggunakan `bool _isEditing` untuk mengontrol tampilan UI.
    * Jika `_isEditing == false`, memanggil `_buildDisplayMode()` yang menampilkan data sebagai `Text` dan `ListTile`.
    * Jika `_isEditing == true`, memanggil `_buildEditMode()` yang menampilkan `TextField`s.
    * Tombol di `AppBar` juga berubah secara dinamis (Edit/Simpan/Batal) tergantung *state* `_isEditing`.
    * Membaca dan menyimpan data profil (`nama_lengkap`, `bio`) ke `shared_preferences`.

* **`pages/settings_page.dart`**
    * Berisi `SwitchListTile` untuk mengontrol tema.
    * Saat di-toggle, ia melakukan dua hal:
        1.  Mengubah nilai `themeNotifier.value` (yang akan langsung didengar oleh `main.dart` untuk mengubah tema).
        2.  Menyimpan preferensi tema (`'dark'` atau `'light'`) ke `shared_preferences` agar pilihan tersimpan saat aplikasi ditutup.

* **`widgets/app_side_menu.dart`**
    * Widget `Drawer` kustom yang digunakan di semua halaman utama.
    * Berisi navigasi `ListTile` untuk berpindah antar halaman (Home, Profile, Settings).
    * Memiliki tombol **Logout** yang memanggil `_logout()`, yang menghapus *key* `is_logged_in` dan mengarahkan pengguna kembali ke `LoginPage` menggunakan `Navigator.pushAndRemoveUntil` (untuk membersihkan *history* navigasi).
