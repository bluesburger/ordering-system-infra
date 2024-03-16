# Infraestrutura Ordering System
Repositório para detalhar o banco de dados gerenciado do sistema ordering-system

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


# Comandos úteis:
> aws rds delete-db-subnet-group --db-subnet-group-name bluesburger

> aws elbv2 describe-target-groups --names TG-bluesburger

> aws elbv2 delete-target-group --target-group-arn arn:aws:elasticloadbalancing:us-east-1:637423186279:targetgroup/TG-bluesburger/082be5af6cb12ba0