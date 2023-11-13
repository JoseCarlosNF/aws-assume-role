# cross-account

O objetivo desse laboratório é documentar uma aplicação de permissionamento
cross-account, de um `sqs`.

## A solução

Temos algumas formas de trabalhar com permissionamento na AWS. O IAM (Identity
and Access Management), como sugere o nome, é o responsável por implementar
isso.

O cenário que estou propondo é bastante comum, é principalmente apresentado
quando precisamos trabalhar com os dados de um parceiro, ou mesmo quando
possuímos uma segregação de contas por áreas, dentro de uma organização.

### Componentes

Para esse cenário utilizaremos as seguintes funcionalidades do IAM:

- _Users_: para criar o usuário que deverá acessar o SQS.
- _Policies_: para definir quais permissões serão concedidas ao usuário.
  (serei o mais pontual possível, apontando diretamente os recursos)
- _Roles_: terá anexada a policy criada, com as permissões para acesso ao SQS.

### Account A

- [ ] criar usuário IAM
- [ ] gerar credenciais de acesso via API
- [ ] anexar policy que possibilite usar o `sts:AssumeRole`

### Account B

- [ ] criar role
    - adicionar `assume_role_policy`, apontando o usuário IAM criado
- [ ] cria fila SQS
    - aplicar na fila uma policy que possibilite as ações da role. 
- [ ] criar policy
    - Deve conceder permissão de leitura e escrita na fila.

## :test_tube: Como testar

Sabendo que estamos usando as _roles_ para fazer o permissionamento necessário.
Precisaremos utilizar o `sts` (_Security Token Service_) para assumir as
permissões na conta de destino (`account b`).

Para isso, devemos gerar uma sessão a partir do usuário IAM criado na `accont
a`. Recomendo utilizar o comando a seguir, na cli da AWS. Porém isso também
pode ser feito de forma programática, através das APIs e SDKs:

```
aws sts assume-role --role-arn ARN_DA_ROLE --role-session-name NOME_DA_SESSAO --duration-seconds 900
```

De posse do `access_id`, `secret_key` e `session_token` gerado pelo comando.
Use-os como variável de ambiente de um novo terminal, com acesso a cli da AWS
(ou como se sentir mais confortável).

```
export AWS_ACCESS_KEY_ID="";
export AWS_SECRET_ACCESS_KEY="";
export AWS_SESSION_TOKEN="";
```

Para certificar-se que a role foi assumida, pode-se utilizar o comando a seguir.
Ele retorna qual perfil de acesso está sendo utilizado.

```
aws sts get-caller-identity
```

Com a role assumida, podemos tentar realizar as ações designadas na policy da
role.

```
aws sqs get-queue-url --queue-name cross-account-aws-solutions-architect
```
