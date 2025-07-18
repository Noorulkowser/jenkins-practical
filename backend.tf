terraform {
   backend "s3" {
    bucket = "noorkows"
    key = "backend-tf-state"
    region = "us-east-2"
     
   }
}
