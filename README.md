# Newsletter App

Um aplicativo Flutter para criação e visualização de newsletters, com suporte a notificações e
operação offline-first.

## Objetivo

Facilitar o gerenciamento de newsletters, permitindo uso offline e envio de notificações em tempo
real para os dispositivos conectados.

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

## Boas Práticas

- Clean Code e SOLID.

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