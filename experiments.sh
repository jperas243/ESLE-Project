sh build_cluster_5.sh 4GB 15% 30% 3 536870912 1 #exp1
sh delete_cluster.sh
sh build_cluster_5.sh 4GB 30% 15% 5 268435456 2 #exp5
sh delete_cluster.sh
sh build_cluster_5.sh 8GB 15% 30% 5 268435456 3 #exp3
sh delete_cluster.sh
sh build_cluster_5.sh 8GB 30% 15% 5 536870912 4 #exp7
sh delete_cluster.sh
sh build_cluster_10.sh 4GB 15% 15% 5 536870912 5 #exp2
sh delete_cluster.sh
sh build_cluster_10.sh 4GB 30% 30% 5 268435456 6 #exp6
sh delete_cluster.sh
sh build_cluster_10.sh 8GB 15% 15% 3 268435456 7 #exp4
sh delete_cluster.sh
sh build_cluster_10.sh 8GB 30% 30% 3 536870912 8 #exp8
sh delete_cluster.sh
