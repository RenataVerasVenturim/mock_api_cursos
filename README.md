# API Flutter Project

Um módulo Flutter para exibição e inscrição em atividades (cursos, palestras, congressos, oficinas, seminários) da PROEX-UFF.

## Descrição
O módulo consome a API de atividades do site da PROEX-UFF e apresenta a lista de atividades com inscrições disponíveis. Permite busca por palavras-chave, filtragem por tipo de atividade e redirecionamento para inscrição via WebView.

---

## Requisitos Funcionais (RF)

**RF01 – Listagem de atividades**  
o	O módulo deve consumir a API do site de atividades (cursos, congressos, etc) e exibir a lista de atividades com inscrições disponíveis.
o	Cada atividade deve mostrar: título, vagas disponíveis, carga horária, detalhes , coordenação, descrição resumida, link de inscrição.

**RF02 – Buscador de atividades**  
o	O usuário deve poder buscar atividades por palavras-chave (ex.: título, coordenador, tema) e filtrar por tipo de atividade  (ex: curso, palestra, congresso).
o	A busca deve ser rápida e filtrar os cursos em tempo real.


**RF03 – Detalhes da atividade**  
o	O usuário deve poder tocar em um curso para visualizar a descrição completa.
o	Exibir o link de inscrição, mas sem necessidade de armazenar status de inscrição no app.

**RF04 – Inscrição simplificada**  
o	Ao tocar no botão de inscrição, o usuário deve ser redirecionado automaticamente para o link do formulário de inscrição via WebView.
o	Minimizar ações necessárias do usuário: abrir diretamente a página de inscrição, com login/registro tratado no site externo.

**RF05 – Feedback visual**  
o	Exibir indicadores de carregamento enquanto os dados do curso ou a WebView estão sendo carregados.

**RF06 – Atualização de dados**  
o	O módulo deve atualizar a lista de cursos consumindo a API periodicamente ou sob demanda, garantindo que as vagas e cursos estejam atualizados.

**RF07 - Filtrar por tipo de atividade**
O módulo deve atualizar a lista de cursos com base em filtros de tipo de atividade.

## Requisitos Não Funcionais (RNF)

**RNF01 – Performance**  
- o	A listagem de cursos deve carregar em no máximo 3 segundos, considerando uma API externa.
o	A pesquisa dentro da lista deve ser instantânea.

**RNF02 – Confiabilidade**  
o	O módulo deve lidar com falhas da API (ex.: timeout, dados incompletos) exibindo mensagens de erro amigáveis.
o	Caso não haja conexão, exibir lista em cache ou mensagem apropriada.

**RNF03 – Usabilidade**  
o	A interação deve ser intuitiva: mínimo de toques para buscar e se inscrever.
o	Layout responsivo para diferentes tamanhos de tela mobile.

**RNF04 – Segurança**  
o	Toda comunicação com a API deve ser via HTTPS.
o	O módulo não deve armazenar dados sensíveis do usuário, já que a inscrição ocorre externamente.

**RNF05 – Compatibilidade**  
o	Suporte a diferentes versões de Android e iOS compatíveis com WebView moderna.

**RNF06 – Escalabilidade**  
o	Capacidade de lidar com centenas de cursos na lista sem degradar performance do app.

---

## Tecnologias Utilizadas
- Flutter  
- Dart  
- HTTP (package `http`)  
- WebView (package `webview_flutter`)  

---

## Estrutura do Projeto
│ main.dart
│
├───external_modules
│ ├───atividades_proex
│ │ ├───models
│ │ │ atividade.dart
│ │ │
│ │ ├───services
│ │ │ api_service.dart
│ │ │ cursos.json
│ │ │
│ │ └───ui
│ │ atividades_page.dart
│ │
│ └───webview
│ ├───bindings
│ │ webview_bindings.dart
│ │
│ ├───controller
│ │ webview_controller.dart
│ │
│ └───ui
│ webview_page.dart
│
└───utils
│ color_pallete.dart
│
└───ui_components
custom_alert_dialog.dart
custom_progress_display.dart
uri_launcher_helper.dart
---

## Observações
- O identificador único da atividade (`idAtividade`) é extraído do link de inscrição (`?curso=XXXX`).  
- O módulo não gerencia inscrições, apenas direciona para o formulário externo.

## Modelo lógico
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/5a8800bd-93b1-45a5-896e-cb2ba8b4cbe7" />

## Wireframe

<img width="778" height="649" alt="image" src="https://github.com/user-attachments/assets/4b587e9b-67aa-46c3-8158-f5da625d8636" />

## Modelo conceitual e lógico , se houver inscrição futura dentro do Mobile

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3051521e-dde3-4764-9ffc-156add6e9511" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4660d248-a108-4f04-bfc0-108ac79e8dda" />







