# Flutter UI Fundamentals — Course Explorer

Aplikasi Flutter untuk menampilkan daftar mata kuliah, melihat detail mata kuliah, dan mengelola daftar favorit. Aplikasi menggunakan Provider untuk state management dan memisahkan tanggung jawab kode ke beberapa layer.

## Arsitektur Aplikasi

Arah dependency yang digunakan:

`Screen/Widget -> Provider -> Repository -> Service/Data Source`

- **Screen/Widget** menampilkan data dan menerima interaksi pengguna.
- **Provider** mengelola state aplikasi, seperti daftar mata kuliah, status loading, error, dan favorit.
- **Repository** menjadi perantara antara Provider dan Service.
- **Service/Data Source** membaca sumber data dan mengubah JSON menjadi objek model.

UI tidak membaca file JSON secara langsung. Pembacaan aset dan proses decoding JSON ditangani oleh `CourseService`.

## Tanggung Jawab Folder

| Folder | Tanggung Jawab |
|---|---|
| `lib/models/` | Mendefinisikan model data mata kuliah dan proses konversi JSON ke objek Dart. |
| `lib/services/` | Mengakses sumber data, termasuk membaca file JSON lokal menggunakan `rootBundle` dan `jsonDecode`. |
| `lib/repositories/` | Menjadi perantara antara Provider dan Service untuk pengambilan data. |
| `lib/providers/` | Mengelola state aplikasi dan memberi tahu UI ketika state berubah menggunakan `ChangeNotifier`. |
| `lib/screens/` | Menyediakan halaman aplikasi, seperti Home, Courses, Favorites, Detail, dan Profile. |
| `lib/widgets/` | Menyediakan komponen UI yang dapat digunakan kembali, seperti kartu mata kuliah. |

## Sumber Data

Data mata kuliah disimpan dalam aset lokal `assets/data/student_data.json`. Data dibaca oleh `CourseService`, diteruskan melalui `CourseRepository`, lalu dikelola oleh `CourseProvider` sebelum ditampilkan oleh UI.

## Menjalankan Aplikasi

Pastikan Flutter SDK sudah terpasang, kemudian jalankan:

```bash
flutter pub get
flutter run
```

## Audit Architecture

Audit arsitektur dilakukan untuk memastikan bahwa:

- Screen tidak memanggil `rootBundle` atau `jsonDecode` secara langsung.
- Service tidak berisi komponen UI.
- Provider tidak menyimpan `BuildContext` sebagai state.
- Tanggung jawab setiap folder dijelaskan dalam dokumentasi.
