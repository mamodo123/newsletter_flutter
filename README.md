# Newsletter App

Um aplicativo Flutter para criação e visualização de newsletters, com suporte a notificações e operação offline-first.

## Objetivo

Facilitar o gerenciamento de newsletters, permitindo uso offline e envio de notificações em tempo real para os dispositivos conectados.

## Tecnologias Utilizadas

- **Flutter:** Versão 3.24.5 (Channel Stable).
- **Firebase:** Cloud Firestore, Cloud Functions, Messaging.
- **Gerenciamento de Estado:** GetX.

## Features

- **Offline-first:** Funciona mesmo sem internet, sincronizando os dados quando possível.
- **Push Notifications:** Notificações em tempo real ao criar newsletters.
- **Gerenciamento de Newsletters:** Adicionar e visualizar com título, categoria, resumo e link.
- **Filtros de Busca:** Personalização da pesquisa de newsletters.
- **Configuração Flexível:** Operação 100% remota, 100% local ou híbrida.

## Arquitetura

- **Padrão:** Clean Architecture com repositórios.
- **Repositórios:**
    - **Local Repository** (SQLite ou Mock).
    - **Remote Repository** (Firebase).
    - **Hybrid Repository:** Sincroniza local e remoto.

## Integração entre Banco Local e Remoto

A integração entre o banco local e o remoto é realizada da seguinte forma:

- O **Hybrid Repository** está sempre monitorando o banco local para atualizar a interface do usuário. Quando um dado chega na Stream do banco remoto, ele é sincronizado com o banco local, garantindo que as informações mais recentes apareçam na tela.
- Para o sincronismo **Local -> Remoto**, quando uma newsletter é adicionada e há conexão com a internet, o sincronismo ocorre imediatamente, adicionando a newsletter tanto no banco local quanto no remoto.
- Quando não há conexão com a internet, o sincronismo **Local -> Remoto** é realizado assim que a conexão de rede for restaurada, garantindo que os dados locais sejam enviados ao Firebase.

## Testes

O aplicativo conta com testes unitários abrangentes, que verificam diferentes funcionalidades e comportamentos:

- Testes de criação de newsletters **offline** e **online**, simulando a sincronização entre o banco local e o remoto.
- Testes da **interface do usuário (UI)**, garantindo que mudanças como a adição de newsletters sejam refletidas corretamente, verificando os estados como **Online**, **Synchronizing** e **Offline**, além de garantir que os cards da newsletter sejam gerados corretamente.
- Testes no **Firebase Helper**, garantindo que a integração com o **Firestore** está funcionando corretamente e que o envio de notificações via Firebase Cloud Messaging (FCM) esteja operando como esperado.

## Como Executar o Projeto

1. **Pré-requisitos:**
    - Flutter instalado.
    - Flutterfire CLI configurado.
    - Serviços Firebase ativados: Firestore, Functions, Messaging.

2. **Configuração:**
    - Execute o comando `flutterfire configure` no diretório do projeto.
    - Crie a Cloud Function `sendNotificationToTopic` no Firebase:

      ```javascript
      const functions = require("firebase-functions");
      const admin = require("firebase-admin");
      admin.initializeApp();
 
      exports.sendNotificationToTopic = functions.https.onCall(async (data, context) => {
        const topic = data.topic;
        const message = {
          notification: {
            title: data.title,
            body: data.body,
          },
          topic: topic,
        };
 
        try {
          const response = await admin.messaging().send(message);
          console.log("Notification sent successfully:", response);
          return { success: true, response };
        } catch (error) {
          console.error("Error sending notification:", error);
          return { success: false, error: error.message };
        }
      });
      ```

3. **Dependências:**
    - Execute `flutter pub get`.

4. **Execução:**
    - Rode o app em um dispositivo físico ou emulador:
      ```bash
      flutter run
      ```

## Considerações Adicionais

- O aplicativo foi testado exclusivamente em ambiente Android, devido à falta de disponibilidade de dispositivos iOS para testes. Para finalizar a configuração para iOS, é necessário concluir a configuração do **Firebase Cloud Messaging (FCM)**. Siga o tutorial completo disponível em: [FCM no Flutter](https://firebase.google.com/docs/cloud-messaging/flutter/client?hl=pt-br).
