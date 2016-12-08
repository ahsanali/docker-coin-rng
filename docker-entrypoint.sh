#!/bin/sh
set -e
if [ ! -z "$ENV" ]
then
render_template() {
  eval "echo \"$(cat $1)\""
}

#REGION=`curl http://169.254.169.254/latest/dynamic/instance-identity/document|grep region|awk -F\" '{print $4}'`
REGION='us-west-2'
aws  s3 --region ${REGION}  cp s3://${DEVOPS_BUCKET}/secure/${ENV}/rds/${RDS_NAME}/${RDS_NAME}.sh /tmp/creds-encrypted.sh

aws  kms decrypt --region ${REGION}  --ciphertext-blob fileb:///tmp/creds-encrypted.sh --output text --query Plaintext | base64 --decode > /tmp/creds.sh

. /tmp/creds.sh

SQLALCHEMY_DATABASE_URI="mysql://${RDS_USER}:${RDS_PASSWORD}@${RDS_HOST}/${DB_NAME}"

render_template rng/env_config.tmpl > rng/env_config.py
export APPLICATION_CONFIG="rng/env_config.py"
unset SQLALCHEMY_DATABASE_URI
rm /tmp/creds.sh
rm /tmp/creds-encrypted.sh
fi

exec "$@"