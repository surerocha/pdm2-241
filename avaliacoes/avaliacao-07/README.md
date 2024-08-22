# Avaliação-07

*Segue a Avaliação 07 da disciplina Programação de Dispositivos Móveis 2*

* Estudante: Sure Rocha Bezerra 

* Professor: Ricardo Duarte Taveira

* Data de Entrega: 22/08/2024
 
### ***Dupla:** [Anderson Maia Santos](https://github.com/TheAnders007) e [Sure Rocha Bezerra](https://github.com/surerocha)*

*Comando da avaliação:*
- Executar o codelab em https://docs.flutter.dev/get-started/codelab
- Filmar a execução do Programa.
- Dar o seu nome(dupla) à barra da aplicação. 
- Criar no repositório do Github o código e o filme. 
- Postar o link no Google Classroom.

*Clique aqui para acessar o vídeo no youtube ⭢ https://youtu.be/6_2Sn8fDw6g*


# Tutorial: Criar um Projeto Flutter e Abrir no VS Code

Este guia passo a passo mostra como criar um novo projeto Flutter, executar o codelab, e abrir o projeto no Visual Studio Code (VS Code).

## Pré-requisitos

1. **Flutter SDK**: Certifique-se de ter o Flutter SDK instalado em seu sistema. Você pode baixá-lo [aqui](https://flutter.dev/docs/get-started/install).

2. **Visual Studio Code**: Instale o Visual Studio Code, disponível [aqui](https://code.visualstudio.com/).

3. **Extensão Flutter para VS Code**: Instale a extensão Flutter para o VS Code. Você pode encontrá-la na [loja de extensões do VS Code](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter).

## Passos para Criar e Abrir um Projeto Flutter

### 1. Configurar o Ambiente

1. Abra o terminal (ou Prompt de Comando no Windows).

2. Verifique se o Flutter está corretamente instalado executando:
    ```sh
    flutter --version
    ```
   Isso deve exibir a versão do Flutter instalada.

3. Se ainda não configurou o `flutter` no PATH, siga as instruções na [documentação oficial](https://flutter.dev/docs/get-started/install).

### 2. Criar um Novo Projeto Flutter

1. No terminal, navegue até o diretório onde deseja criar o projeto. Por exemplo:
    ```sh
    cd ~/meus-projetos
    ```

2. Crie um novo projeto Flutter usando o comando:
    ```sh
    flutter create nome_do_projeto
    ```
   Substitua `nome_do_projeto` pelo nome desejado para o seu projeto.

3. Navegue para o diretório do projeto:
    ```sh
    cd nome_do_projeto
    ```

### 3. Executar o Codelab

1. Acesse o codelab em [https://docs.flutter.dev/get-started/codelab](https://docs.flutter.dev/get-started/codelab).

2. Siga as instruções do codelab para completar o tutorial e criar um aplicativo Flutter básico.


### 4. Abrir o Projeto no VS Code

1. No terminal, dentro do diretório do projeto, execute o comando:
    ```sh
    code .
    ```
   Este comando abrirá o Visual Studio Code na pasta do projeto atual.

2. Se preferir, você também pode abrir o VS Code manualmente e usar o menu:
    - Vá para `File` > `Open Folder...` e selecione a pasta do seu projeto Flutter.

### 5. Executar o Projeto

1. No VS Code, certifique-se de que a extensão Flutter está ativada. Você verá uma barra de status na parte inferior que indica que o Flutter está configurado.

2. Para rodar o projeto, abra o terminal integrado no VS Code (`Terminal` > `New Terminal`) e execute:
    ```sh
    flutter run
    ```
   Isso irá compilar e executar o aplicativo no emulador ou dispositivo conectado.

### 6. Subir o Projeto para o GitHub

1. Crie um novo repositório no [GitHub](https://github.com/).

2. No terminal, inicialize um novo repositório Git no diretório do projeto:
    ```sh
    git init
    ```

3. Adicione todos os arquivos ao repositório:
    ```sh
    git add .
    ```

4. Faça um commit inicial:
    ```sh
    git commit -m "Commit inicial do projeto Flutter"
    ```

5. Adicione o repositório remoto e faça o push:
    ```sh
    git remote add origin https://github.com/usuario/nome_do_repositorio.git
    git push -u origin master
    ```

## Recursos Adicionais

- [Lab: Escreva seu primeiro aplicativo Flutter](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Exemplos úteis de Flutter](https://docs.flutter.dev/cookbook)
- [Documentação Oficial do Flutter](https://docs.flutter.dev/)

Siga estes passos para iniciar rapidamente com o Flutter e o Visual Studio Code, executar o codelab e enviar o projeto conforme solicitado. Se tiver dúvidas ou problemas, consulte a documentação ou busque ajuda nas comunidades online de Flutter.

