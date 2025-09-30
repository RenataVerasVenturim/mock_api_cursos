import 'package:flutter/material.dart';
import '../models/atividade.dart';
import '../services/api_service.dart';
import '../../webview/ui/webview_page.dart';
import 'package:get/get.dart';

enum ExerciseFilter {
  todos('Todos'),
  curso('Curso'),
  oficina('Oficina'),
  congresso('Congresso'),
  palestra('Palestra'),
  grupoDeEstudo('Grupo de estudo'),
  rodaDeConversa('Roda de conversa'),
  seminario('Seminário'),
  conferencia('Conferência'),
  mesaRedonda('Mesa redonda'),
  simposio('Simpósio'),
  visitaTecnica('Visita técnica'),
  outro('Outro');

  final String label;
  const ExerciseFilter(this.label);
}

class AtividadesPage extends StatefulWidget {
  const AtividadesPage({super.key});

  @override
  State<AtividadesPage> createState() => _AtividadesPageState();
}

class _AtividadesPageState extends State<AtividadesPage> {
  List<Atividade> atividades = [];
  List<Atividade> atividadesFiltradas = [];
  bool isLoading = true;

  TextEditingController searchController = TextEditingController();
  Set<ExerciseFilter> filters = {ExerciseFilter.todos};

  @override
  void initState() {
    super.initState();
    carregarAtividades();
  }
Future<void> carregarAtividades() async {
    try {
      final fetchedAtividades = await fetchAtividades();
      setState(() {
        atividades = fetchedAtividades;
        atividadesFiltradas = fetchedAtividades;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      //print('Erro ao carregar atividades: $e');
    }
  }

  void filtrarAtividades(String query) {
    final filtered = atividades.where((atividade) {
      final matchTitulo =
          atividade.titulo.toLowerCase().contains(query.toLowerCase());
      final matchTipo = filters.contains(ExerciseFilter.todos) ||
          filters.any((f) => f.label == atividade.tipo);
      return matchTitulo && matchTipo;
    }).toList();

    setState(() => atividadesFiltradas = filtered);
  }

  void toggleFilter(ExerciseFilter filter) {
    setState(() {
      if (filter == ExerciseFilter.todos) {
        filters = {ExerciseFilter.todos};
      } else {
        filters.remove(ExerciseFilter.todos);
        if (filters.contains(filter)) {
          filters.remove(filter);
        } else {
          filters.add(filter);
        }
        if (filters.isEmpty) filters.add(ExerciseFilter.todos);
      }
      filtrarAtividades(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atividades PROEX')),
      body: SafeArea(
          child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    // Campo de busca
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Buscar atividades...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            filtrarAtividades('');
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: filtrarAtividades,
                    ),
                    const SizedBox(height: 10),
          
                    // Scroll horizontal com FilterChips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                        child:Wrap(
                          direction: Axis.horizontal,
                          runSpacing: 4.0,
                          spacing: 8.0,
                          children: <Widget>[
                          ... ExerciseFilter.values.map((filter) {
                            return FilterChipWidget(
                              filter: filter,
                              isSelected: filters.contains(filter),
                              onSelected: toggleFilter,
                            );
                          }),                
                           ],
                        ),
                      ),
                              
                    // Lista de atividades filtradas usando o Card customizado
                    Expanded(
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: atividadesFiltradas.length,
                              itemBuilder: (context, index) {
                                final atividade = atividadesFiltradas[index];
                                return _SampleCard(
                                  titulo: atividade.titulo,
                                  detalhes: atividade.detalhes,
                                  extra:
                                      'Carga horária: ${atividade.cargaHoraria ?? 'N/A'}\nCoordenação: ${atividade.coordenacao ?? 'N/A'}\nDescrição: ${atividade.descricaoResumida ?? 'N/A'}',
                                  linkInscricao: atividade.linkInscricao,
                                );
                              },
                            ),
                    ),
          
                  ],
                  
                ),
              ),
        ),
    );
  }
}
//filterchip class
class FilterChipWidget extends StatelessWidget {
  final ExerciseFilter filter;
  final bool isSelected;
  final Function(ExerciseFilter) onSelected;

  const FilterChipWidget({
    required this.filter,
    required this.isSelected,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        filter.label,

      ),
      selected: isSelected,
      onSelected: (_) => onSelected(filter),
      backgroundColor: Colors.grey[200],
    );
  }
}

// Card customizado com expansão
class _SampleCard extends StatefulWidget {
  const _SampleCard({
    required this.titulo,
    this.detalhes,
    this.extra = '',
    required this.linkInscricao, // ADICIONADO
    Key? key,
  }) : super(key: key);

  final String titulo;
  final String? detalhes;
  final String extra;
  final String linkInscricao; // ADICIONADO

  @override
  State<_SampleCard> createState() => _SampleCardState();
}


class _SampleCardState extends State<_SampleCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.titulo,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          if (widget.detalhes != null) 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.detalhes!),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: Icon(
                    isExpanded
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                  ),
                  label: Text(isExpanded ? 'Esconder' : 'Ver detalhes'),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () {
                    Get.to(
                      () => const ActivityWebViewPage(),
                      arguments: {
                        'url': widget.linkInscricao,
                        'title': widget.titulo,
                      },
                    );
                  },
                  child: const Text('Inscrever-se'),
                ),
              ],
            ),
          ),
          if (isExpanded && widget.extra.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
            color: const Color.fromARGB(255, 218, 199, 230),
            borderRadius: BorderRadius.circular(12), // define o raio
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.3), // cor da sombra
                offset: Offset(4, 4), // deslocamento da sombra
                blurRadius: 6, // intensidade do desfoque
              ),
            ],
            ),
            child: Text(widget.extra),
          ),
      
        ],
      ),
    );
  }
}
