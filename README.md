
# Cloud Run Deployment and IAM Configuration for My React App

## Overview
This documentation covers the steps to deploy a Dockerized React application to **Google Cloud Run** and how to configure **IAM policies** to allow unauthenticated access to the application.

### Deployment Process

1. **Rebuild Docker Image for Correct Architecture (x86-64)**

   Make sure to build your Docker image with the correct platform (x86-64) to avoid architecture-related issues like `exec format error`:

   ```bash
   docker build --platform linux/amd64 -t react-app .
   ```

2. **Tag the Docker Image**
   
   After successfully building the image, tag it for the correct repository in **Artifact Registry**:

   ```bash
   docker tag react-app australia-southeast2-docker.pkg.dev/sit-chameleon-website-0bc2323/react-website/react-app
   ```

3. **Push the Docker Image to Artifact Registry**
   
   Push the tagged image to **Artifact Registry**:

   ```bash
   docker push australia-southeast2-docker.pkg.dev/sit-chameleon-website-0bc2323/react-website/react-app
   ```

4. **Deploy the Image to Cloud Run**

   Once the image is successfully pushed, deploy it to **Cloud Run** using the following command:

   ```bash
   gcloud run deploy my-react-app      --image australia-southeast2-docker.pkg.dev/sit-chameleon-website-0bc2323/react-website/react-app      --platform managed      --region australia-southeast2      --allow-unauthenticated
   ```

5. **Set IAM Policy for Unauthenticated Access**

   To allow public access to your service, you need to configure the **IAM policy** by granting the `roles/run.invoker` role to `allUsers`. However, if you encounter permission issues, you may need to ask your project administrator to set it up.

   Run the following command (or request your admin to run it):

   ```bash
   gcloud run services add-iam-policy-binding my-react-app      --region=australia-southeast2      --member="allUsers"      --role="roles/run.invoker"
   ```

   If you encounter this error:
   ```
   ERROR: (gcloud.run.services.add-iam-policy-binding) PERMISSION_DENIED: Permission 'run.services.setIamPolicy' denied...
   ```
   You need to contact your **GCP project administrator** for permission or ask them to set the policy for you.

---

### Notes:
- Ensure your Docker image is built with the correct architecture to avoid `exec format errors`.
- Permissions such as `roles/run.admin` or `roles/owner` may be required to modify IAM policies for Cloud Run services.
- If permissions are restricted, request your project admin to apply the necessary changes or grant you access.

## Service URL
Once deployed, your application can be accessed via the following URL (after setting the IAM policy for unauthenticated access):
```
https://my-react-app-jxwrc3z7fq-km.a.run.app
```

## Contact
If you need further assistance with deployment or permissions, please contact the **GCP Project Administrator**.
