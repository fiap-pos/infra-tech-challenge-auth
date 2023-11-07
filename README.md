# infra-db-tech-challenge-auth
Tech Challenge Auth DB - Terraform

## Rodando localmente

Tenha o Terraform instalado em seu ambiente: [Instalar terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

Tenha o AWS CLI instalado em seu ambiente: [Instalar AWS ClI](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/getting-started-install.html)

Tenha em mãos as credenciais de acesso do Atlas DB e da AWS com as permissões para criação de recursos

Exporte as variáveis de ambiente

Para configurar o acesso a AWS no seu ambiente, utiliza o AWS CLI:

```bash
# executa o AWS configure (obs: O comando vai pedir as credenciais de acesso e região da AWS)
aws configure
````

### Exemplo:
![image](https://github.com/fiap-pos/infra-db-tech-challenge-auth/assets/4777684/3985173d-e406-448c-8a17-c90a3fcaef49)


Após isso rode os comandos para iniciar o terraform e subir o ambiente
```bash
# Inicia o terraform e instala as dependências
terraform init

# Rodar o terraform plan
terraform plan

# Aplicar a plano para subir a infra
terraform apply -auto-approve

# Destruir a infra: Esse comando remove/deleta todos os recursos criados
terraform destroy -auto-approve
```

