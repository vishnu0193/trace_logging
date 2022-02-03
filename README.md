# trace_logging
<img width="880" alt="Screenshot 2022-02-03 at 11 23 23 PM" src="https://user-images.githubusercontent.com/60593526/152400469-46a8d251-885c-4b1f-a177-38a2cd945f49.png">

Steps to execute this service:

1. Setup the infra using terraform and setup seperate components for client and server
2. ec2 servers are created here. For high availability and scalability we can use the autoscaling group.
3. go to infra/server folder and perform terraform plan and terraform apply and same applies to infra/client.
4. infra will be created for client and server and database will be created at the server end

App service:

1. Ansible is used to copy the source code script to the client servers by creating a seperate ansible role
2. This role copies the source code and also executes the script which inturn gives the database output i,e ssh connections grouping by nodename
3. Need to run ansible with below command:
   ansible-playbook -i inventory  play.yml -e 'ansible_user=ansible ansible_password=$ansible_password DB_PASSWORD="$DB_PASSWORD"'
   
   sample output:
   <img width="704" alt="Screenshot 2022-02-03 at 11 08 31 PM" src="https://user-images.githubusercontent.com/60593526/152402092-1640e268-4b62-4066-a5f2-1152c9168d47.png">
