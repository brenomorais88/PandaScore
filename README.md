# PandaScoreApp

**PandaScoreApp** é um aplicativo iOS que exibe partidas de CS\:GO acontecendo em diversos torneios ao redor do mundo, consumindo dados da PandaScore API.

---

## Visão Geral

* Tela de splash exibindo o logo ao iniciar o app.
* Tela principal (Matches List) com a lista de partidas a partir da data atual:

  * Partidas Scheduled, In Progress e Ended.
  * Ordenação: partidas em andamento no topo.
  * Pull-to-refresh e paginação (20 itens por página).
* Tela de detalhes (Match Detail) mostrando:

  * Nome das equipes (Team 1 x Team 2).
  * Data e hora local da partida.
  * Lista de jogadores de cada time (nome, nickname e foto).

## Tecnologias e Arquitetura

* Linguagem: Swift
* Framework UI: SwiftUI
* Arquitetura: MVVM
* Reatividade: Combine
* Testes: XCTest (unit tests)

## Requisitos

* Xcode 14.0 ou superior
* iOS 15.0 ou superior
* Swift 5.6 ou superior
* Conexão com internet para consumir a PandaScore API

## Instalação

1. Clone este repositório:

   ```bash
   git clone https://github.com/seu-usuario/PandaScoreApp.git
   ```
2. Abra o projeto no Xcode:

   ```bash
   cd PandaScoreApp
   open PandaScoreApp.xcodeproj
   ```
3. Instale as dependências via Swift Package Manager.
4. Adicione sua API Key da PandaScore em `Constants.swift`:

   ```swift
   struct Api {
       static let key = "SEU_TOKEN_AQUI"
   }
   ```

## Como Executar

1. Selecione o simulador ou dispositivo físico.
2. Pressione ⌘R para compilar e rodar o app.
3. Na primeira execução, a Splash Screen será exibida antes de carregar a lista de partidas.

## Arquitetura MVVM

1. View: SwiftUI, consome dados do ViewModel.
2. ViewModel: orquestra chamadas de rede via Services e expõe estados reativos.
3. Service: implementação do protocolo para requisições HTTP usando URLSession e Combine.
4. Model: estruturas que representam JSON da PandaScore API.

## PandaScore API

* Documentação geral: [https://developers.pandascore.co/docs/introduction](https://developers.pandascore.co/docs/introduction)
* Autenticação: [https://developers.pandascore.co/docs/authentication](https://developers.pandascore.co/docs/authentication)
* Endpoint CS\:GO: `/csgo/matches`, `/csgo/matches/{id}/players`

## Testes

* Execute todos os testes unitários no Xcode via ⌘U.
* Cobertura de testes para validação de ViewModels e Services.

## Design

Layout e especificações visuais seguem o design spec fornecido.

---
