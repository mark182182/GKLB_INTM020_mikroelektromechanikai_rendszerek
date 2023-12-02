function check_if_env_var_exists {
  local envVar=$1
  if [[ -z $(grep -o $envVar .env) ]]; then
    echo "Environment variable '$envVar' is not defined!"
    exit 1
  fi
}

echo "------ exporting env vars --------"

if [[ -f ".env" ]]; then
  check_if_env_var_exists MYSQL_USERNAME
  check_if_env_var_exists MYSQL_PASSWORD
  check_if_env_var_exists SMTP_USER
  check_if_env_var_exists SMTP_PASSWORD
  check_if_env_var_exists FROM_ADDRESS
  check_if_env_var_exists TO_ADDRESS

  envVars="$(cat .env)"
  for envVar in $envVars;
  do
    eval "export $envVar"
  done
else
  echo "Mandatory file .env does not exist!"
  exit 1
fi

/c/Users/vsl/AppData/Local/Programs/Python/Python312/Scripts/flask run