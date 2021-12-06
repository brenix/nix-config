# -- Terraform
if [[ $commands[terraform] ]]; then
  alias t='terraform'
  alias ta='terraform apply'
  alias taa='terraform apply -auto-approve'
  alias tf='terraform format'
  alias ti='terraform init --backend=false'
  alias tii='terraform init'
  alias tim='terraform import'
  alias to='terraform output'
  alias tp='terraform plan'
  alias ts='terraform show'
  alias tst='terraform state'
  alias tv='terraform validate'
  alias tw='terraform workspace'

  export TF_CLI_ARGS_plan="-compact-warnings"
  export TF_CLI_ARGS_apply="-compact-warnings"
fi
