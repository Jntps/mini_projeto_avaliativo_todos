# TodoFlow - Gerenciador de Tarefas Inteligente

## 📖 Sobre o Projeto
O **TodoFlow** é um aplicativo mobile desenvolvido em Flutter que tem como objetivo gerenciar tarefas (TODOs) de forma eficiente, consumindo dados de uma API externa e persistindo as informações localmente. O sistema resolve o problema da perda de dados em aplicações que dependem exclusivamente de rede, garantindo que o usuário possa visualizar e interagir com suas tarefas através de um banco de dados local sincronizado.

Este projeto é a entrega final do Módulo 02 - Semana 07 (Mobile Flutter T1).

## 🛠️ Tecnologologias e Arquitetura
O projeto foi estruturado seguindo rigorosamente o padrão de arquitetura **MVVM (Model-View-ViewModel)**, garantindo a separação de responsabilidades e o desacoplamento do código.

*   **Linguagem:** Dart
*   **Framework:** Flutter
*   **Gerência de Estado:** Provider (ChangeNotifier)
*   **Persistência Local:** SQFlite (Banco de Dados) e SharedPreferences (Sessão)
*   **Consumo de API:** Pacote `http` (Integração com a DummyJSON API)
*   **Tratamento de Erros:** Padrão `Result` (Success/Failure nas chamadas de repositório)

## 🚀 Como Executar o Sistema

Para rodar este projeto na sua máquina, siga os passos abaixo:

1. Clone este repositório:
   ```bash
   git clone [https://github.com/seu-usuario/mini_projeto_avaliativo_todos.git](https://github.com/seu-usuario/mini_projeto_avaliativo_todos.git)