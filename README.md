# IAM - Assume role

O objetivo desse repositório é documentar o laboratório executado durante os
estudo para a certificação de **Arquiteto de Soluções da AWS**, sobre o tópico
de `Assume Role` do IAM.

## Atividades que devem ser executadas

- Criar 2 grupos de usuários
  - [ ] `admin_group`
  - [ ] `developer_group`

- Criar 3 usuários IAM, todos com a mesma senha.
  - [ ] `admin`
  - [ ] `dev1`
  - [ ] `dev2`

Esses usuário devem fazer partes dos respectivos grupos de acesso.

- Criar 2 buckets S3
  - [ ] `appconfig`
  - [ ] `customerdata`

- Criar 2 policies concedendo acesso aos seguintes buckets de forma
      separada.
  - [ ] `customerdata`
  - [ ] `customerdata`

- Restringir acesso aos buckets, via `AssumeRole`
  - [ ] o `developer_group` só poderá acessar o bucket `customerdata`

## Desenho da solução

![image](https://github.com/JoseCarlosNF/aws-assume-role/assets/38339200/580e19bb-5042-4d80-9631-725fadd1941d)

## Descrições adicionais

Quando se trata de acesso/comunicação entre recursos da AWS, a utilização de
roles é sempre a melhor escolha. Isso por que evitamos utilizar credências
perpétuas (os IAMs convencionais) e consequentemente diminuímos o risco de
vazamento de credências.

As roles podem ser interpretadas como crachás de acesso provisório. Isso por
que quando um recurso utilizasse de uma role para acessar outro, o seu acesso
não está sendo concedido diretamente, mas sim através da role. É como se um
filho pudesse acessar um clube por que é dependente de seus pais, e a
associação ao clube é paga pelos pais, e dessa forma o filho tem acesso ao
clube.


