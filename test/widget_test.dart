// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:api_flutter_project/external_modules/atividades_proex/ui/atividades_page.dart';
import 'package:api_flutter_project/external_modules/atividades_proex/models/atividade.dart';
void main() {
  testWidgets('Testar busca, filtros e scroll em AtividadesPage', (WidgetTester tester) async {
    // Monta o widget
    await tester.pumpWidget(
      GetMaterialApp(
        home: AtividadesPage(
          fetchFunction: () async => [
            Atividade(
              titulo: 'Curso Flutter',
              tipo: 'Curso',
              cargaHoraria: 2,
              coordenacao: 'Coord A',
              descricaoResumida: 'Descrição A',
              linkInscricao: 'https://flutter.dev', idAtividade: '157249',
            ),
            Atividade(
              titulo: 'Oficina Dart',
              tipo: 'Oficina',
              cargaHoraria: 1,
              coordenacao: 'Coord B',
              descricaoResumida: 'Descrição B',
              linkInscricao: 'https://dart.dev', idAtividade: '157250',
            ),
          ],
        ),
      ),
    );

    // Aguarda o carregamento inicial
    await tester.pumpAndSettle();

    // ===== Teste do campo de busca =====
    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);
    await tester.enterText(searchField, 'Flutter');
    await tester.pumpAndSettle();
    expect(find.text('Curso Flutter'), findsOneWidget);
    expect(find.text('Oficina Dart'), findsNothing);
    await tester.tap(find.byIcon(Icons.clear));
    await tester.pumpAndSettle();
    expect(find.text('Curso Flutter'), findsOneWidget);
    expect(find.text('Oficina Dart'), findsOneWidget);

    // ===== Teste dos filtros =====
    final cursoChip = find.widgetWithText(FilterChip, 'Curso');
    final oficinaChip = find.widgetWithText(FilterChip, 'Oficina');
    await tester.tap(cursoChip);
    await tester.pumpAndSettle();
    expect(find.text('Curso Flutter'), findsOneWidget);
    expect(find.text('Oficina Dart'), findsNothing);
    await tester.tap(oficinaChip);
    await tester.pumpAndSettle();
    expect(find.text('Curso Flutter'), findsOneWidget);
    expect(find.text('Oficina Dart'), findsOneWidget);

    // ===== Teste do scroll horizontal dos FilterChips =====
    final chipsScroll = find.byType(SingleChildScrollView).first;
    expect(chipsScroll, findsOneWidget);

    // Arrastar para a esquerda
    await tester.drag(chipsScroll, const Offset(-200.0, 0.0));
    await tester.pumpAndSettle();

    // Arrastar para a direita
    await tester.drag(chipsScroll, const Offset(200.0, 0.0));
    await tester.pumpAndSettle();
  });
}
