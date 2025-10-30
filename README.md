# Terraform GKE

Este projeto cria um **cluster Kubernetes (GKE)** na **Google Cloud
Platform (GCP)** utilizando **Terraform**.\
A configuração segue as práticas recomendadas de segurança, rede e
armazenamento de estado remoto.

------------------------------------------------------------------------

## Descrição

O objetivo é provisionar um **cluster GKE inicial** com uma arquitetura
simples, modular e segura.

### Arquitetura

-   **Subnet privada**: usada para os *nodes* e *pods* do cluster (sem
    IP público)
-   **Subnet pública**: usada para expor serviços externos e
    balanceadores de carga
-   **Firewall (SSH via IAP)**: libera acesso SSH apenas para o range
    oficial do IAP (`35.235.240.0/20`), garantindo acesso nos nodes
    para troubleshooting
-   **Backend remoto (Terraform)**: o estado é armazenado em um **bucket
    GCS** garantindo persistência e
    integridade
-   **Cluster Privado**: a configuração segue o modelo de cluster privado
    recomendado pela Google

------------------------------------------------------------------------

## Como aplicar o projeto

1.  **Preencher as variáveis**\
    Edite o arquivo `terraform.tfvars` com os valores desejados, os ranges de IP podem ser ajustados conforme sua topologia.

2.  **Configurar o backend remoto**\
    Insira o nome do bucket no bloco `backend "gcs"` do arquivo
    `provider.tf`

3.  **Aplicar os arquivos do Terraform**

    ``` bash
    terraform init
    terraform plan
    terraform apply
    ```

4.  **Autenticar na GCP**

    ``` bash
    gcloud auth application-default login
    ```

5.  **Coletar as credenciais do cluster e adicionar no contexto atual**

    ``` bash
    gcloud container clusters get-credentials <CLUSTER_NAME>
    ```

6.  **Testar o acesso ao cluster**

    ``` bash
    kubectl get nodes
    ```

7.  **Pronto!** Seu cluster GKE está provisionado e funcional.

------------------------------------------------------------------------
