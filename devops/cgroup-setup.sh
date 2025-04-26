# #!/bin/bash

# # === Inputs ===
# PROJECT_ID=$1
# CPU_SHARES=$2     # Example: 2048 for 2 CPUs
# MEMORY_LIMIT=$3   # Example: 2G
# STORAGE_PATH=$4   # Example: /mnt/projects/user123

# # === Step 1: Create cgroup ===
# sudo cgcreate -g cpu,memory:$PROJECT_ID

# # === Step 2: Set CPU and Memory limits ===
# sudo cgset -r cpu.shares=$CPU_SHARES $PROJECT_ID
# sudo cgset -r memory.limit_in_bytes=$MEMORY_LIMIT $PROJECT_ID

# # === Step 3: Create storage directory if not exists ===
# sudo mkdir -p $STORAGE_PATH
# sudo chown $(whoami):$(whoami) $STORAGE_PATH
# sudo chmod 755 $STORAGE_PATH
# # === Step 4: Mount storage directory to cgroup ===
# sudo mount --bind $STORAGE_PATH /sys/fs/cgroup/$PROJECT_ID
# # === Step 5: Verify cgroup settings ===
# cgexec -g cpu,memory:$PROJECT_ID bash -c "echo 'Cgroup created with CPU shares: $CPU_SHARES and Memory limit: $MEMORY_LIMIT'"
# # === Step 6: Run a command in the cgroup ===
# cgexec -g cpu,memory:$PROJECT_ID bash -c "echo 'Running command in cgroup with ID: $PROJECT_ID'"
# # === Step 7: Cleanup cgroup after use ===
# sudo cgdelete cpu,memory:$PROJECT_ID
# # === Step 8: Unmount storage directory ===
# sudo umount /sys/fs/cgroup/$PROJECT_ID
# # === Step 9: Remove storage directory ===
# sudo rmdir $STORAGE_PATH
# # === Step 10: End of script ===
# echo "Cgroup $PROJECT_ID cleaned up and storage directory removed."
# # === Step 11: Exit script ===
# exit 0


#!/bin/bash

# === Inputs ===
PROJECT_NAME=$1         # Example: medium-plan
CPU_SHARES=$2           # Example: 2048 (for 2 CPUs)
MEMORY_LIMIT=$3         # Example: 2G (for 2GB)

echo "Setting up cgroup for project: $PROJECT_NAME"

# === Step 1: Create CPU and Memory cgroup ===
sudo cgcreate -g cpu,memory:$PROJECT_NAME

# === Step 2: Set resource limits ===
sudo cgset -r cpu.shares=$CPU_SHARES $PROJECT_NAME
sudo cgset -r memory.limit_in_bytes=$MEMORY_LIMIT $PROJECT_NAME

echo "Cgroup $PROJECT_NAME created with CPU=$CPU_SHARES and MEMORY=$MEMORY_LIMIT"
