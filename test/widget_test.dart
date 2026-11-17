import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pm_tugas_05/main.dart';

void main() {
  testWidgets('Menekan tombol favorit mengubah ikon dan menampilkan SnackBar',
      (WidgetTester tester) async {
    // 1. Render aplikasi ke layar tes
    await tester.pumpWidget(const KulinerMedanApp());

    // 2. Verifikasi identitas usaha dan menu awal tampil
    expect(find.text('Dapoer Kuliner Deli Medan'), findsWidgets);
    expect(find.text('Lontong Sayur Medan Komplit'), findsOneWidget);

    // 3. Pastikan awalnya ada ikon favorite_border
    final tombolFavoritPertama = find.byIcon(Icons.favorite_border).first;
    expect(tombolFavoritPertama, findsWidgets);

    // Pastikan tombol favorit terlihat di layar
    await tester.ensureVisible(tombolFavoritPertama);
    await tester.pumpAndSettle();

    // 4. Tekan tombol favorit pada menu pertama
    await tester.tap(tombolFavoritPertama);
    await tester.pump();

    // 5. Verifikasi bahwa ikon berubah menjadi Icons.favorite (Spesifikasi 6)
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // 6. Verifikasi SnackBar teks notifikasi muncul
    await tester.pump(const Duration(milliseconds: 500));
    expect(
      find.text('Lontong Sayur Medan Komplit ditambahkan ke favorit'),
      findsOneWidget,
    );
  });

  testWidgets('Tombol ganti tema berfungsi dengan baik',
      (WidgetTester tester) async {
    await tester.pumpWidget(const KulinerMedanApp());

    // Verifikasi tombol toggle tema ada di AppBar
    final toggleButton = find.byTooltip('Ganti Tema');
    expect(toggleButton, findsOneWidget);

    // Tekan tombol ganti tema
    await tester.tap(toggleButton);
    await tester.pumpAndSettle();

    // Verifikasi ikon tema berubah ke mode terang
    expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
  });
}
