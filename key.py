import boto3
from datetime import datetime, timedelta

# Initialize a session using AWS credentials
iam_client = boto3.client('iam', region_name='us-east-1')

def deactivate_unused_access_keys(user_name):
    # Get the list of access keys for the IAM user
    response = iam_client.list_access_keys(UserName=user_name)

    for access_key_metadata in response['AccessKeyMetadata']:
        access_key_id = access_key_metadata['AccessKeyId']
        status = access_key_metadata['Status']

        # Skip if the access key is already inactive
        if status == 'Inactive':
            print(f"Access key {access_key_id} is already inactive. Skipping...")
            continue
        
        # Get the last used information for the access key
        last_used_response = iam_client.get_access_key_last_used(AccessKeyId=access_key_id)

        last_used_date = last_used_response['AccessKeyLastUsed'].get('LastUsedDate')
        
        if last_used_date:
            # Check if the last used date is older than 1 hour and 10 minutes
            last_used_date = last_used_date.replace(tzinfo=None)
            if last_used_date < datetime.utcnow() - timedelta(minutes=5):
                print(f"Access key {access_key_id} has not been used in the last 5 minutes. Deactivating...")
                # Deactivate the access key
                iam_client.update_access_key(
                    UserName=user_name,
                    AccessKeyId=access_key_id,
                    Status='Inactive'
                )
                print(f"Access key {access_key_id} has been deactivated.")
            else:
                print(f"Access key {access_key_id} was used recently. No action needed.")
        else:
            print(f"Access key {access_key_id} has never been used. Deactivating...")
            # Deactivate the access key if it has never been used
            iam_client.update_access_key(
                UserName=user_name,
                AccessKeyId=access_key_id,
                Status='Inactive'
            )
            print(f"Access key {access_key_id} has been deactivated.")

if __name__ == '__main__':
    user_name = 'deployment'  # Specify the IAM user name
    deactivate_unused_access_keys(user_name)
