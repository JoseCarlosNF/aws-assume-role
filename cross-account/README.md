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
