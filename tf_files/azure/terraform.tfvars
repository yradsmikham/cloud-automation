azure_subscription_id="7060bca0-7a3c-44bd-b54c-4bb1e9facfac"
azure_client_id="729e3acc-a626-4f8b-a6a7-d28b19edd227"
azure_client_secret="6142d4c7-1ddd-42a3-9664-0ef6142e9dd4"
azure_tenant_id="72f988bf-86f1-41af-91ab-2d7cd011db47"

# VPC name is also used for DB name, so only alphanumeric characters
vpc_name="yvonnerush"

azure_resource_group_name="yvonne-rush"

azure_region="westus"

# login_ami=""

# proxy_ami=""

# base_ami=""

db_size=10

# hostname="www.example.com"

# ssh key to be added to kube nodes
kube_ssh_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0H7CAcjIRn2XE+BxYupNgN25Zch7RagyQ8on+HErMM9KK0id3Koi/c6vTF+pZYpfwHHMSJu8z8Xsz1TgagUGqU/44U3K1wVHXeLLhAoX4xs3kl6RJcm1hQeEDEWFHqJqNxq5d9MvHX20y8+ykHJ5tlLkFZrugAPoJ/QHSnSJn7gt5Yt5VET8ob9jw+dFBPxUFUsHru7Mn9SWVv/R2ck190lJUGCn9rLi7v205Y7MTDpCAdF4kH3bzh68idIMCj+ln5I7VHrZ3F09SNDmqQnDsl3H9612bV3GjoaDIVaPTfRALm+EPB6OyJGhTeENPYMNB8bdM8SHadpfPbZorm6giG1e/NpwCipmJlHuRFYoRZ3IesNjKtf7YNVeFrow8phYSmQu5ciYfMtPSVsPmDDIPUlDRXtTT2AVaLzQ1z5lw4CGlREUvV++m5/+xaTsnKYXbmuf3pXOs/QohtnOMWlGSAxOszcyZLKKpV7OUPY65KIhIskpBTVPxUuO8L6LDztc= yvonneradsmikham@Yvonnes-MacBook-Pro-2.local"

# additional keys
# format like kube_additional_keys="- \"ssh-rsa XXXX\"\n  - \"ssh-rsa XXXX\""
# kube_additional_keys=""

# S3 bucket for storing kube states
kube_bucket="yvonnerush"

google_client_secret=""
google_client_id=""


# Following variables can be randomly generated passwords

# base64 encoded 32 alphanumeric characters
# cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1 | base64
hmac_encryption_key="57443a4c052350a44638835d64fd66822f813319"

# don't use ( ) " ' { } < > @ in password
db_password_userapi="yvonnerush"

db_password_gdcapi="yvonnerush"

db_password_indexd="yvonnerush"

# db_instance="db.t2.micro"

# password for write access to indexd
gdcapi_indexd_password="yvonnerush"
