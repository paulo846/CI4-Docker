### Descrição incompleta, precisa ser atualizada 
- Novas variáveis foram adicinadas

## Imagem Docker para Ambiente de Produção do CodeIgniter 4

### Descrição Geral
Esta imagem Docker é projetada para fornecer um ambiente de produção otimizado para a execução de aplicativos desenvolvidos com o framework CodeIgniter 4. Ela inclui o PHP 8.2 com Apache, juntamente com as dependências necessárias para o CodeIgniter 4.

### Especificações
- **PHP 8.2 com Apache**: A imagem é baseada no PHP 8.2 com o servidor web Apache, proporcionando um ambiente robusto para a execução de aplicativos web.
- **Dependências Instaladas**: O Dockerfile instala as seguintes dependências:
  - Extensões PHP necessárias (`intl`, `pdo_mysql`, `zip`, `gd`)
  - Composer para gerenciamento de dependências PHP
  - Módulos do Apache (`mod_rewrite`)
- **Configurações Adicionais**: Além da instalação das dependências, o Dockerfile realiza as seguintes configurações:
  - Clona a aplicação CodeIgniter 4 a partir de um repositório Git fornecido através da variável de ambiente `CI4_GIT_REPO`.
  - Define permissões adequadas para os arquivos da aplicação.
  - Configura o mapeamento do domínio para a pasta `public` da aplicação.
  - Atualiza o pacote do CodeIgniter 4 para garantir que a aplicação esteja na versão mais recente.

### Utilização
Para utilizar esta imagem Docker, você pode construir um contêiner com base no Dockerfile fornecido e fornecer as configurações necessárias através do `docker-compose.yaml` ou diretamente ao executar o contêiner.

Esta imagem é ideal para implantar aplicativos CodeIgniter 4 em ambientes de produção, proporcionando uma infraestrutura confiável e escalável para hospedar suas aplicações web.

# Variáveis de Ambiente Suportadas

## Variáveis Relacionadas ao Aplicativo

- **CI_ENVIRONMENT**: Define o ambiente de execução do aplicativo, como "development", "production" ou "testing".

- **app_baseURL**: Define a URL base do aplicativo.

- **app_forceGlobalSecureRequests**: Define se todas as solicitações devem ser forçadas para HTTPS.

- **app_CSPEnabled**: Ativa ou desativa a Política de Segurança de Conteúdo (CSP).

## Variáveis Relacionadas ao Banco de Dados

- **database_default_hostname**: O hostname do banco de dados padrão.

- **database_default_database**: O nome do banco de dados padrão.

- **database_default_username**: O nome de usuário do banco de dados padrão.

- **database_default_password**: A senha do banco de dados padrão.

- **database_default_DBDriver**: O driver de banco de dados padrão.

- **database_default_DBPrefix**: O prefixo da tabela do banco de dados padrão.

- **database_default_port**: A porta do banco de dados padrão.

## Outras Variáveis

- **logger_threshold**: Define o nível mínimo de log a ser registrado.

- **curlrequest_shareOptions**: Define se as opções CURL devem ser compartilhadas.

- **aws_access_key_id**: A ID da chave de acesso da AWS para autenticação.

- **aws_secret_access_key**: A chave de acesso secreta da AWS para autenticação.