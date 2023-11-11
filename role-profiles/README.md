# IAM - Assume role

O objetivo desse repositório é documentar o laboratório sobre o tópico de
`Assume Role` do IAM.

## Diagrama de utilização de roles

![image](https://github.com/JoseCarlosNF/aws-assume-role/assets/38339200/9a34a0be-181f-474f-be1e-a18e70ae3501)

## Atividades que devem ser executadas

- Criar 2 grupos de usuários
  - [ ] `admin_group`
  - [ ] `developer_group`

- Criar 3 usuários IAM, e mostrar suas respectivas senhas (aplicável apenas em
  ambientes de testes).
  - [ ] `admin`
  - [ ] `dev1`
  - [ ] `dev2`

Esses usuário devem fazer partes dos respectivos grupos de acesso.

- Criar 2 buckets S3
  - [ ] `appconfig`
  - [ ] `customerdata`

- Criar 2 policies concedendo acesso aos seguintes buckets de forma
      separada.
  - [ ] `appconfig`
  - [ ] `customerdata`

- Restringir acesso aos buckets, via `AssumeRole`
  - [ ] o grupo `developers` só poderá acessar o bucket `appconfig`

## Desenho da solução

![image](https://github.com/JoseCarlosNF/aws-assume-role/assets/38339200/6cabe942-f306-4686-8f29-9f5e7b895f48)

## Descrições adicionais

Quando se trata de acesso/comunicação entre recursos da AWS, a utilização de
roles é na maioria das vezes uma boa escolha. Isso por que, ao utilizar as
roles estamos evitando o uso de credências perpétuas (os IAMs convencionais,
com `AccessKey` e `SecretKey`) e consequentemente diminuímos o risco de
vazamento de credências.

As roles podem ser interpretadas como **crachás de acesso provisório**. Isso
por que, quando um recurso utiliza uma role para acessar outro, o acesso não
está sendo concedido diretamente, mas sim através da role. É como se um filho
pudesse acessar um clube por que é dependente de seus pais.

O principal caso de uso das roles é a definição de cargos e/ou permissões
temporárias.

No cenário em questão, por exemplo, os desenvolvedores só podem ter acesso aos
arquivos do bucket `appconfig` através da role específica. Ou seja, se um
desenvolvedor qualquer tentar acessar o bucket ele não conseguirá. Terá que
explicitamente, por vontade/necessidade assumir a role necessária para executar
acessar os dados do bucket. Apesar de parecer mais trabalhoso, e é, essa
abordagem diminuí os riscos de modificação acidental dos dados.
