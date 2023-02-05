# recycler-final
Small for-fun project named Uber Recycler, where a team of backend and frontend developers developed an application whose purpose was to allow the user to schedule recyclable garbage collection and then a driver would pick-up the bag and would get paid for it, just like Uber or other apps. In this specific project I got a lot of hands-on knowledge on both Terraform and AWS, automating the creation of the infrastructure for the application using IaC and learning about different services that would accommodate the needs of the project. There were different infrastructure propositions, the initial one had an S3 bucket serving the static content of the app using CloudFront and an Elastic Beanstalk that would be managing the backend but since the logic of the app was dockerized and the frontend had to be rendered by node we decided to separate everything in two ec2 instances, one which would serve the frontend using nginx and the other which would serve the backend using an nginx reverse proxy.
See ebs-test for the Elastic Beanstalk solution.
See ec2-test for the EC2 Instances solution.

I purposefully omitted sensitive information such as the access keys for the user.
