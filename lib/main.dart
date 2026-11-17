import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const KulinerMedanApp());
}

/// Widget utama aplikasi Kuliner Medan
/// Menggunakan StatefulWidget untuk mengelola themeMode (terang/gelap)
class KulinerMedanApp extends StatefulWidget {
  const KulinerMedanApp({super.key});

  @override
  State<KulinerMedanApp> createState() => _KulinerMedanAppState();
}

class _KulinerMedanAppState extends State<KulinerMedanApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else if (_themeMode == ThemeMode.dark) {
        _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.dark;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Seed color mencerminkan nuansa rempah kuliner khas Medan (Warm Ochre / Spice Brown)
    const seedColor = Color(0xFF9E2A2B);

    return MaterialApp(
      title: 'Dapoer Kuliner Deli Medan',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
      ),
      home: HalamanMenuKuliner(
        themeMode: _themeMode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

/// Halaman utama daftar menu dan informasi UMKM Kuliner Medan
/// Didesain sebagai StatelessWidget karena data halaman bersifat statis/deklaratif
class HalamanMenuKuliner extends StatelessWidget {
  const HalamanMenuKuliner({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
  });

  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuliner Khas Medan'),
        actions: [
          // Komponen Material 3: IconButton untuk berganti tema terang/gelap
          IconButton(
            tooltip: 'Ganti Tema',
            icon: Icon(
              themeMode == ThemeMode.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. BAGIAN KEPALA (Header): Banner, Nama Usaha, Deskripsi Singkat
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 180,
                width: double.infinity,
                color: skema.primaryContainer,
                child: Image.network(
                  'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800&auto=format&fit=crop&q=60',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.restaurant,
                            size: 64,
                            color: skema.onPrimaryContainer,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Dapoer Kuliner Deli Medan',
                            style: teks.titleMedium?.copyWith(
                              color: skema.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Dapoer Kuliner Deli Medan',
              style: teks.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: skema.onSurface,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Menyajikan aneka masakan autentik khas Medan dengan bumbu rempah warisan turun-temurun sejak 1998. Rasa legendaris, halal, dan higienis.',
              style: teks.bodyMedium?.copyWith(
                color: skema.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Aksi Tambahan (Komponen Material 3: FilledButton & OutlinedButton)
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Membuka formulir pemesanan online...'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                    label: const Text('Pesan Antar'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Menampilkan peta lokasi gerai Medan...'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.map_outlined),
                    label: const Text('Peta Gerai'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 2. BAGIAN KONTAK (Card + ListTile minimal 3 baris)
            Text(
              'Informasi Kontak & Lokasi',
              style: teks.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: skema.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 0,
              color: skema.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.phone_outlined,
                      color: skema.primary,
                    ),
                    title: const Text('+62 812-6543-2100'),
                    subtitle: const Text('WhatsApp Layanan Pelanggan & Katering'),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Nomor telepon disalin')),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: skema.primary,
                    ),
                    title: const Text('Jl. Teuku Cik Ditiro No. 45, Medan Kota'),
                    subtitle: const Text('Kota Medan, Sumatera Utara 20152'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(
                      Icons.access_time_outlined,
                      color: skema.primary,
                    ),
                    title: const Text('Buka Setiap Hari: 07.00 - 22.00 WIB'),
                    subtitle: const Text('Sarapan, Makan Siang, & Kuliner Malam'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(
                      Icons.language_outlined,
                      color: skema.primary,
                    ),
                    title: const Text('@kulinerdelimedan'),
                    subtitle: const Text('Instagram & Situs Resmi'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Center(
              // Komponen Material 3: TextButton
              child: TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Semua menu bersertifikasi Halal MUI'),
                    ),
                  );
                },
                icon: const Icon(Icons.verified_outlined),
                label: const Text('Informasi Sertifikasi Halal & Higienis'),
              ),
            ),
            const SizedBox(height: 20),

            // 3. BAGIAN DAFTAR MENU (Minimal 4 menu, widget KartuMenu Stateless)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daftar Menu Favorit',
                  style: teks.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: skema.onSurface,
                  ),
                ),
                Text(
                  '5 Menu Pilihan',
                  style: teks.labelLarge?.copyWith(
                    color: skema.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Menu 1
            const KartuMenu(
              nama: 'Lontong Sayur Medan Komplit',
              harga: 'Rp 25.000',
              kategori: 'Makanan Utama',
              deskripsi: 'Lontong gurih berpadu gulai tauco, rendang daging, telur balado, dan kerupuk merah.',
            ),
            const SizedBox(height: 12),

            // Menu 2
            const KartuMenu(
              nama: 'Soto Daging Sapi Kuah Santan',
              harga: 'Rp 32.000',
              kategori: 'Makanan Utama',
              deskripsi: 'Soto Medan berkuah santan kental rempah kaya rasa dengan suwiran daging empuk dan perkedel.',
            ),
            const SizedBox(height: 12),

            // Menu 3
            const KartuMenu(
              nama: 'Mie Balap Seafood Krakatau',
              harga: 'Rp 22.000',
              kategori: 'Mie & Olahan',
              deskripsi: 'Bihun goreng kuali arang khas Medan dengan udang segar, cumi, telur, dan saus cabai hijau.',
            ),
            const SizedBox(height: 12),

            // Menu 4
            const KartuMenu(
              nama: 'Bika Ambon Pandan Spesial',
              harga: 'Rp 18.000',
              kategori: 'Kudapan Tradisional',
              deskripsi: 'Kue basah bersarang sempurna beraroma pandan asli dan santan kelapa murni.',
            ),
            const SizedBox(height: 12),

            // Menu 5
            const KartuMenu(
              nama: 'Kopi Sidikalang Susu Dingin',
              harga: 'Rp 14.000',
              kategori: 'Minuman Khas',
              deskripsi: 'Kopi robusta asli Sidikalang diracik dengan susu manis segar dan es batu dingin menyegarkan.',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      // Komponen Material 3: FloatingActionButton
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Menghubungi kasir WhatsApp Dapoer Kuliner Deli...'),
            ),
          );
        },
        icon: const Icon(Icons.chat_outlined),
        label: const Text('Hubungi Kasir'),
      ),
    );
  }
}

/// Widget buatan sendiri: KartuMenu (StatelessWidget)
/// Menampilkan informasi satu menu makanan/minuman UMKM
class KartuMenu extends StatelessWidget {
  const KartuMenu({
    super.key,
    required this.nama,
    required this.harga,
    required this.kategori,
    this.deskripsi,
  });

  final String nama;
  final String harga;
  final String kategori;
  final String? deskripsi;

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: skema.outlineVariant,
          width: 0.8,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Chip kategori menu
                      Chip(
                        label: Text(
                          kategori,
                          style: teks.labelSmall?.copyWith(
                            color: skema.onSecondaryContainer,
                          ),
                        ),
                        backgroundColor: skema.secondaryContainer,
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: BorderSide.none,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        nama,
                        style: teks.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: skema.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                // Tombol Favorit (Widget Stateful kecil)
                TombolFavorit(namaMenu: nama),
              ],
            ),
            if (deskripsi != null) ...[
              const SizedBox(height: 6),
              Text(
                deskripsi!,
                style: teks.bodySmall?.copyWith(
                  color: skema.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  harga,
                  style: teks.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: skema.primary,
                  ),
                ),
                FilledButton.tonal(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$nama ditambahkan ke keranjang')),
                    );
                  },
                  child: const Text('Tambah'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget buatan sendiri: TombolFavorit (StatefulWidget kecil)
/// Menangani interaksi penandaan menu favorit dan menampilkan SnackBar
class TombolFavorit extends StatefulWidget {
  const TombolFavorit({super.key, required this.namaMenu});

  final String namaMenu;

  @override
  State<TombolFavorit> createState() => _TombolFavoritState();
}

class _TombolFavoritState extends State<TombolFavorit> {
  bool _isFavorit = false;

  void _toggleFavorit() {
    setState(() {
      _isFavorit = !_isFavorit;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorit
              ? '${widget.namaMenu} ditambahkan ke favorit'
              : '${widget.namaMenu} dihapus dari favorit',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;

    return IconButton(
      tooltip: _isFavorit ? 'Hapus favorit' : 'Tambah favorit',
      icon: Icon(
        _isFavorit ? Icons.favorite : Icons.favorite_border,
        color: _isFavorit ? skema.error : skema.onSurfaceVariant,
      ),
      onPressed: _toggleFavorit,
    );
  }
}
