# ESLE-Project

This project has been developed to study the Scalability properties of CockroachDB.
We deploy a helm chart template into a kubernets cluster (we used minikube for the first stage of the project and we will use a kubernetes cluster on the cloud for the second stage).

Requirements before running:

    * kubectl CLI (https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
    * helm  (https://helm.sh/docs/intro/install/)
    * minikube (https://minikube.sigs.k8s.io/docs/start/)

After the requirements are installed, you can:

    * Setup the cluster with "restart_cluster.sh" script
    * Change parameters and configurations with the commands in "setup_cockroach.sh" (we do not recomend to run the script)
    * Run benchmarks with "run_benchmarks.sh"

note: You can change the resource allocation of each node in the helm file parametrs file "my-values.yaml"