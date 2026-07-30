BUCKET_NAME = "your-bucket-name"
FILE_NAME = "app.zip"

s3 = boto3.client("s3")

s3.upload_file(FILE_NAME, BUCKET_NAME, FILE_NAME)
print("Uploaded to S3")

# ---------- HCP Terraform ----------
TF_API_TOKEN = "your_hcp_token"
WORKSPACE_ID = "ws-xxxxxxxxxxxxxxxx"

url = "https://app.terraform.io/api/v2/runs"

headers = {
    "Authorization": f"Bearer {TF_API_TOKEN}",
    "Content-Type": "application/vnd.api+json"
}

payload = {
    "data": {
        "type": "runs",
        "attributes": {
            "message": "Triggered after S3 upload"
        },
        "relationships": {
            "workspace": {
                "data": {
                    "type": "workspaces",
                    "id": WORKSPACE_ID
                }
            }
        }
    }
}

response = requests.post(url, headers=headers, json=payload)

if response.status_code == 201:
    print("HCP Terraform run started successfully.")
else:
    print("Error:", response.status_code)
    print(response.text)
