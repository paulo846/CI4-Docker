#!/bin/bash
set -e

# Verificar se CI4_GIT_REPO está definido; se não, usar o valor padrão
if [ -n "${CI4_GIT_REPO}" ]; then
    echo "Clonando repositório Git a partir de ${CI4_GIT_REPO}..."
    git clone ${CI4_GIT_REPO} /var/www/html && rm -f /var/www/html/.env || true
else
    echo "A variável CI4_GIT_REPO não está definida. Usando o valor padrão."
    git clone https://github.com/codeigniter4/CodeIgniter4.git /var/www/html && rm -f /var/www/html/.env || true
fi

# Criar um diretório vazio para o Composer
mkdir -p /var/www/composer

# Executar o composer install
echo "Executando composer update em /var/www/html..."
composer update --working-dir=/var/www/html

# verifica se é CI4
if [ -n "${TYPE}" ]; then

    echo "Intalação php comum, mas é preciso ter uma instalação de app com a pasta public..."

    chown -R www-data:www-data /var/www/html/

else
    
    echo "Executando migrations..."

    #só pra frente, qualquer roolback deve ser feito direto no container
    php spark migrate --working-dir=/var/www/html
    
    # Dar permissões de escrita ao diretório "writable"
    echo "Dando permissões de escrita ao diretório /var/www/html/writable..."
    chown -R www-data:www-data /var/www/html/writable
fi




echo "Verificando variaveis..."

# Função para criar o arquivo .env
create_env_file() {
    cat > /var/www/html/.env <<EOF
#--------------------------------------------------------------------
# ENVIRONMENT
#--------------------------------------------------------------------
EOF

    # Verificar e adicionar a variável CI_ENVIRONMENT se estiver definida
    if [ -n "${CI_ENVIRONMENT}" ]; then
        echo "CI_ENVIRONMENT=${CI_ENVIRONMENT}" >> /var/www/html/.env
    fi

    # Verificar e adicionar a variável app.baseURL se estiver definida
    if [ -n "${app_baseURL}" ]; then
        echo "app.baseURL=${app_baseURL}" >> /var/www/html/.env
    fi

    # Verificar e adicionar a variável app.forceGlobalSecureRequests se estiver definida
    if [ -n "${app_forceGlobalSecureRequests}" ]; then
        echo "app.forceGlobalSecureRequests=${app_forceGlobalSecureRequests}" >> /var/www/html/.env
    fi

    # Verificar e adicionar a variável database.default.hostname se estiver definida
    if [ -n "${database_default_hostname}" ]; then
        echo "database.default.hostname=${database_default_hostname}" >> /var/www/html/.env
    fi

    # Verificar e adicionar a variável database.default.database se estiver definida
    if [ -n "${database_default_database}" ]; then
        echo "database.default.database=${database_default_database}" >> /var/www/html/.env
    fi

    # Verificar e adicionar a variável database.default.username se estiver definida
    if [ -n "${database_default_username}" ]; then
        echo "database.default.username=${database_default_username}" >> /var/www/html/.env
    fi

    # Verificar e adicionar a variável database.default.password se estiver definida
    if [ -n "${database_default_password}" ]; then
        echo "database.default.password=${database_default_password}" >> /var/www/html/.env
    fi

    # Verificar e adicionar a variável database.default.DBDriver se estiver definida
    if [ -n "${database_default_DBDriver}" ]; then
        echo "database.default.DBDriver=${database_default_DBDriver}" >> /var/www/html/.env
    fi

    # Verificar e adicionar a variável database.default.DBPrefix se estiver definida
    if [ -n "${database_default_DBPrefix}" ]; then
        echo "database.default.DBPrefix=${database_default_DBPrefix}" >> /var/www/html/.env
    fi

    # Verificar e adicionar a variável database.default.port se estiver definida
    if [ -n "${database_default_port}" ]; then
        echo "database.default.port=${database_default_port}" >> /var/www/html/.env
    fi

    # Verificar e adicionar a variável database.tests.port se estiver definida
    if [ -n "${database_tests_port}" ]; then
        echo "database.tests.port=${database_tests_port}" >> /var/www/html/.env
    fi

    # Verificar e adicionar a variável session.driver se estiver definida
    if [ -n "${session_driver}" ]; then
        echo "session.driver=${session_driver}" >> /var/www/html/.env
    fi

    # Verificar e adicionar a variável session.cookieName se estiver definida
    if [ -n "${session_cookieName}" ]; then
        echo "session.cookieName='${session_cookieName}'" >> /var/www/html/.env
    fi

    # Verificar e adicionar a variável session.expiration se estiver definida
    if [ -n "${session_expiration}" ]; then
        echo "session.expiration=${session_expiration}" >> /var/www/html/.env
    fi

    # Verificar e adicionar a variável session.savePath se estiver definida
    if [ -n "${session_savePath}" ]; then
        echo "session.savePath='${session_savePath}'" >> /var/www/html/.env
    fi

    # Verificar e adicionar a variável session.matchIP se estiver definida
    if [ -n "${session_matchIP}" ]; then
        echo "session.matchIP=${session_matchIP}" >> /var/www/html/.env
    fi

    if [ -n "${encryption_key}" ]; then 
        echo "encryption.key=${encryption_key}" >> /var/www/html/.env
    fi

    if [ -n "${encryption_driver}" ]; then 
        echo "encryption.driver=${encryption_driver}" >> /var/www/html/.env
    fi
    
    if [ -n "${encryption_blockSize}" ]; then 
        echo "encryption.blockSize=${encryption_blockSize}" >> /var/www/html/.env
    fi
    
    if [ -n "${encryption_digest}" ]; then 
        echo "encryption.digest=${encryption_digest}" >> /var/www/html/.env
    fi
    
    if [ -n "${AWS_ACCESS_KEY_ID}" ]; then 
        echo "AWS_ACCESS_KEY_ID='${AWS_ACCESS_KEY_ID}'" >> /var/www/html/.env
    fi
    
    if [ -n "${AWS_SECRET_ACCESS_KEY}" ]; then 
        echo "AWS_SECRET_ACCESS_KEY='${AWS_SECRET_ACCESS_KEY}'" >> /var/www/html/.env
    fi
    
    if [ -n "${AWS_DEFAULT_REGION}" ]; then 
        echo "AWS_DEFAULT_REGION='${AWS_DEFAULT_REGION}'" >> /var/www/html/.env
    fi

    if [ -n "${AWS_ACCESS_KEY_ID_SES}" ]; then 
        echo "AWS_ACCESS_KEY_ID_SES='${AWS_ACCESS_KEY_ID_SES}'" >> /var/www/html/.env
    fi
    
    if [ -n "${AWS_SECRET_ACCESS_KEY_SES}" ]; then 
        echo "AWS_SECRET_ACCESS_KEY_SES='${AWS_SECRET_ACCESS_KEY_SES}'" >> /var/www/html/.env
    fi
    
    if [ -n "${AWS_DEFAULT_REGION_SES}" ]; then 
        echo "AWS_DEFAULT_REGION_SES='${AWS_DEFAULT_REGION_SES}'" >> /var/www/html/.env
    fi
    
    if [ -n "${AWS_BUCKET}" ]; then 
        echo "AWS_BUCKET='${AWS_BUCKET}'" >> /var/www/html/.env
    fi

    # Adicione outras variáveis aqui, seguindo o mesmo padrão
}

echo "Criando variaveis..."

# Executar a função para criar o arquivo .env
create_env_file

# Iniciar o serviço
echo "Iniciando o serviço..."


exec "$@"