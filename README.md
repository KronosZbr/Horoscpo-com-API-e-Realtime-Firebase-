# Horoscopo com API e realtime em flutter

Este é um aplicativo Flutter que busca o horóscopo diário de uma API externa e salva os dados no Firebase Realtime Database. O usuário pode selecionar seu signo e visualizar o horóscopo correspondente. **Devido à limitação da API, este projeto foi desenvolvido para funcionar apenas em dispositivos Android.**

## Funcionalidades

- **Seleção de Signo**: Escolha entre os 12 signos do zodíaco por meio de um dropdown.
- **Consulta de Horóscopo**: Realiza uma requisição GET para buscar o horóscopo diário com base no signo selecionado.
- **Armazenamento no Firebase**: Salva os horóscopos obtidos, junto com um timestamp, no Firebase Realtime Database.

## Tecnologias Utilizadas

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- [Firebase Realtime Database](https://firebase.google.com/docs/database)
- [Horoscope API](https://horoscope-app-api.vercel.app/)
- [HTTP package](https://pub.dev/packages/http)

## Requisitos

- Flutter SDK
- Conta no Firebase (com Realtime Database configurado)
- Dispositivo Android ou emulador para testes

## Configuração do Projeto

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/KronosZbr/Horoscpo-com-API-e-Realtime-Firebase-
   ```

2. **Instale as dependências:**

   Execute o comando abaixo na raiz do projeto:
   
   ```bash
   flutter pub get
   ```

3. **Configure o Firebase:**

   No arquivo `main.dart`, configure o Firebase com as suas credenciais. Substitua os valores abaixo pelos fornecidos na sua conta Firebase:
   
   ```dart
   await Firebase.initializeApp(
     options: const FirebaseOptions(
       apiKey: "SUA_API_KEY",
       appId: "SEU_APP_ID",
       messagingSenderId: "SEU_SENDER_ID",
       projectId: "SEU_PROJECT_ID",
       databaseURL: "SUA_DATABASE_URL",
     ),
   );
   ```

## Execução do Projeto

### Em Dispositivos Android

1. Conecte um dispositivo Android ou inicie um emulador.
2. Execute o comando abaixo na raiz do projeto:

   ```bash
   flutter run
   ```

> **Observação:** Devido à limitação da API, este projeto foi desenvolvido para funcionar apenas em dispositivos Android.
> 
> **Nota:** Este aplicativo utiliza uma API externa para obter os dados do horóscopo. Verifique a documentação da API para maiores informações e atualizações.
