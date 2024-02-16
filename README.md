### A melhor imagem docker para Codeigniter 4 em produção
#### Seu projeto CI4 do git direto no seu container

**Descrição Geral:**

Este é um contêiner Docker configurado para PHP 8.2 com Apache, projetado para aplicações baseadas no CodeIgniter 4 (CI4). Inclui diversas extensões e dependências essenciais para o desenvolvimento e execução de aplicações web. Além disso, há um script de inicialização que realiza a clonagem de um repositório Git específico ou utiliza um repositório padrão se a variável `CI4_GIT_REPO` não estiver definida.

**Especificações:**

- **Imagem Base:** `php:8.2-apache`
- **Extensões PHP Instaladas:** `intl`, `pdo_mysql`, `zip`, `gd`, `mysqli`, `redis`
- **Dependências Adicionadas:** `libicu-dev`, `libzip-dev`, `zip`, `unzip`, `git`, `libpng-dev`, `libgd-dev`, `libfreetype6-dev`, `libjpeg-dev`, `libmagickwand-dev`
- **Ferramentas Adicionadas:** `Composer`

**Utilização:**

1. Clone este repositório.
2. Construa a imagem do Docker usando o Dockerfile fornecido.
3. Execute o contêiner com as variáveis de ambiente necessárias.

**Uso das Variáveis:**

O script `docker-entrypoint.sh` é responsável por configurar e inicializar o ambiente. Ele verifica a existência da variável `CI4_GIT_REPO`. Se definida, o repositório é clonado; caso contrário, um repositório padrão é utilizado.

Variáveis de ambiente relevantes (pode adicionar outras conforme necessário):

- `CI_ENVIRONMENT`: Ambiente do CodeIgniter (desenvolvimento, produção, etc.).
- `app.baseURL`: URL base da aplicação.
- `database_default_*`: Configurações do banco de dados.
- `session_*`: Configurações de sessão.
- `encryption_*`: Configurações de criptografia.
- `AWS_*`: Credenciais e configurações para integração com a AWS.

          - CI4_GIT_REPO=    #https://github.com/codeigniter4/CodeIgniter4.git
          - CI_ENVIRONMENT=  #development #production #testing
          - app_baseURL=
          - app_forceGlobalSecureRequests=
          - database_default_hostname=
          - database_default_database=
          - database_default_username=
          - database_default_password=
          - database_default_DBDriver=
          - database_default_DBPrefix=
          - database_default_port=3306
          - session_driver=
          - session_cookieName=
          - session_expiration=
          - session_savePath=
          - session_matchIP=
          - session_timeToUpdate=
          - session_regenerateDestroy=
          - AWS_ACCESS_KEY_ID=
          - AWS_SECRET_ACCESS_KEY=
          - AWS_DEFAULT_REGION=
          - AWS_ACCESS_KEY_ID_SES=
          - AWS_SECRET_ACCESS_KEY_SES=
          - AWS_DEFAULT_REGION_SES=
          - AWS_BUCKET=

**Observações:**

- O Composer é instalado, e as dependências são atualizadas durante a construção.
- O Apache é configurado para usar o diretório `/var/www/html/public` como DocumentRoot.
- O script de entrada (`docker-entrypoint.sh`) automatiza tarefas comuns, como migrações do CodeIgniter e ajustes de permissões.

**Instruções de Execução local:**

    docker build -t nome-da-imagem .
    docker run -e CI4_GIT_REPO=URL-do-seu-repositorio -p 8080:80 nome-da-imagem

## Avisos
- Certifique-se de ajustar as variáveis de ambiente conforme necessário.
- Este contêiner é destinado principalmente a fins de desenvolvimento.
- Licença: GNU GPL (consulte o arquivo LICENSE).

Sinta-se à vontade para ajustar conforme necessário!