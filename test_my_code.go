// package main
// import (
//     "testing"

//     "github.com/gruntwork-io/terratest/modules/aws"
//     "github.com/gruntwork-io/terratest/modules/terraform"
// )

// func TestMyTerraformAWSInfrastructure(t *testing.T)(error, string) {
//     t.Parallel()

//     // Initialize Terraform
//     terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
//         TerraformDir: "./src",
//     })

//     // Ensure resources are destroyed when the test finishes
//     defer terraform.Destroy(t, terraformOptions)
    
//     output := terraform.InitAndApply(t, terraformOptions)

// // Verify that the infrastructure is working as expected
// //     if output != {
// //     t.Fatalf("Failed to apply Terraform: %v", output)
// // }

//     // Infrastructure region
//     region := "us-east-1"

//     // Get the ID of the VPC
//     vpcID := terraform.Output(t, terraformOptions, "vpc_id")

//     // Check if the VPC exists
//     vpc := aws.GetVpcById(t, vpcID, region)
//     if vpc == nil {
//         t.Fatal("VPC does not exist")
//     }

//     // Get the ID of the public subnet 1 from the outputs file
//     publicSubnet1ID := terraform.Output(t, terraformOptions, "public_subnet1_id")

//     // Check if the public subnet 1 exists
//     publicSubnet1 := aws.GetSubnetsForVpc(t, publicSubnet1ID, region)
//     if publicSubnet1 == nil {
//         t.Fatal("Public subnet 1 does not exist")
//     }

//     // Get the ID of the public subnet 2 from the outputs file
//     publicSubnet2ID := terraform.Output(t, terraformOptions, "public_subnet2_id")

//     // Check if the public subnet 2 exists
//     publicSubnet2 := aws.GetSubnetsForVpc(t, publicSubnet2ID, region)
//     if publicSubnet2 == nil {
//         t.Fatal("Public subnet 2 does not exist")
//     }

//     // Get the ID of the private subnet from the outputs file
//     privateSubnetID := terraform.Output(t, terraformOptions, "private_subnet_id")

//     // Check if the private subnet exists
//     privateSubnet := aws.GetSubnetsForVpc(t, privateSubnetID, region)
//     if privateSubnet == nil {
//         t.Fatal("Private subnet does not exist")
//     }

//     // Get the ID of the EC2 instance from the outputs file
//     instanceID := terraform.Output(t, terraformOptions, "instance_id")

//     // Check if the EC2 instance exists
//     instanceExists := aws.GetInstanceIdsForAsg(t, region, instanceID)
//     if instanceExists == nil || len(instanceExists) == 0 {
//         t.Fatal("EC2 instance does not exist")
//     }
// }
