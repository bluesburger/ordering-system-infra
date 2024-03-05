# Infraestrutura Ordering System
Repositório para detalhar o banco de dados gerenciado do sistema ordering-system

# AWS
1. Criar, caso não exista, uma nova VPC em modo avançado, com 3 zonas de disponibilidade
2. Colocar o ID da VPC na variável declarada no vars.tf
3. Colocar os IDs das 3 primeiras subredes públicas nas variáveis declaradas no arquivo vars.tf

Editar Trust-Policy:
> aws iam update-assume-role-policy --role-name OrderingSystemServiceRoleForECS --policy-document file://trust-policy.json

Criar Trust-Policy:
> aws iam create-role --role-name OrderingSystemServiceRoleForECS --assume-role-policy-document file://trust-policy.json

Atualizando a Role-Policy:
> aws iam put-role-policy --role-name OrderingSystemServiceRoleForECS --policy-name OrderingSystemServiceRoleForECS --policy-document file://permission-policy.json

Anexando a role com a policy "AdministratorAccess"
> aws iam attach-role-policy --role-name OrderingSystemServiceRoleForECS --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

Listando as policies anexadas a role:
> aws iam list-attached-role-policies --role-name OrderingSystemServiceRoleForECS