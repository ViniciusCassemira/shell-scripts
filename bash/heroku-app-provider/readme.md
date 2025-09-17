# Heroku App Provider

Esse script serve para criar apps na Heroku a partir da CLI, podendo configurar:
- Nome do projeto
- Email de colaborador (podendo inserir ou não)
- Buildpacks do projeto (podendo inserir ou não)

Para configurar o script:

_Antes de mais nada, instale a CLI da Heroku e conecte sua conta_

1. Clone o repositório e acesse:
```bash
    git clone https://github.com/ViniciusCassemira/shell-scripts.git
    cd shell-scripts/bash/heroku-app-provider
```

2. Crie um arquivo .env na raiz do projeto (ou no mesmo nível do `app.sh`)

3. Preencha o arquivo .env de acordo com as suas necessidades, usando `.env.example` como exemplo

4. Configure permissão para executar o script e o execute em seguida:
```bash
    chmod +x app.sh
    ./app.sh
```

Agora basta ver seu app sendo criado!