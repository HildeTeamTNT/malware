for region in `aws ec2 describe-regions --output text | cut -f4`
do
  echo "Terminating region $region..."
  aws ec2 describe-instances --region $region | \
    jq -r .Reservations[].Instances[].InstanceId | \
      xargs -L 1 -I {} aws ec2 modify-instance-attribute \
        --region $region \
        --no-disable-api-termination \
        --instance-id {}
  aws ec2 describe-instances --region $region | \
    jq -r .Reservations[].Instances[].InstanceId | \
      xargs -L 1 -I {} aws ec2 terminate-instances \
        --region $region \
        --instance-id {}
done
